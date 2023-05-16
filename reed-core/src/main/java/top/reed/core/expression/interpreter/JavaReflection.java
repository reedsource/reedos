package top.reed.core.expression.interpreter;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

public class JavaReflection extends Reflection {
    private final Map<Class<?>, Map<String, Field>> fieldCache = new ConcurrentHashMap<>();
    private final Map<Class<?>, Map<MethodSignature, Method>> methodCache = new ConcurrentHashMap<>();
    private final Map<Class<?>, Map<String, List<Method>>> extensionmethodCache = new ConcurrentHashMap<>();

    /**
     * 返回函数接口的apply（）方法
     **/
    private static Method findApply(Class<?> cls) {
        for (Method method : cls.getDeclaredMethods()) {
            if (method.getName().equals("apply")) return method;
        }
        return null;
    }

    private static Method findMethod(List<Method> methods, Class<?>[] parameterTypes) {
        Method foundMethod = null;
        int foundScore = 0;
        for (Method method : methods) {
            // Check if the types match.
            Class<?>[] otherTypes = method.getParameterTypes();
            if (parameterTypes.length != otherTypes.length) {
                continue;
            }
            boolean match = true;
            int score = 0;
            for (int ii = 0, nn = parameterTypes.length; ii < nn; ii++) {
                Class<?> type = parameterTypes[ii];
                Class<?> otherType = otherTypes[ii];

                if (!otherType.isAssignableFrom(type)) {
                    score++;
                    if (!isPrimitiveAssignableFrom(type, otherType)) {
                        score++;
                        if (!isCoercible(type, otherType)) {
                            match = false;
                            break;
                        } else {
                            score++;
                        }
                    }
                }
            }
            if (match) {
                if (foundMethod == null) {
                    foundMethod = method;
                    foundScore = score;
                } else {
                    if (score < foundScore) {
                        foundScore = score;
                        foundMethod = method;
                    }
                }
            }
        }
        return foundMethod;
    }

    /**
     * 返回与给定签名（包括类型强制或null）最匹配的方法
     **/
    private static Method findMethod(Class<?> cls, String name, Class<?>[] parameterTypes) {
        Method[] methods = cls.getDeclaredMethods();
        List<Method> methodList = new ArrayList<>();
        for (Method method : methods) {
            // if neither name or parameter list size match, bail on this method
            if (!method.getName().equals(name)) continue;
            if (method.getParameterTypes().length != parameterTypes.length) continue;
            methodList.add(method);
        }
        return findMethod(methodList, parameterTypes);
    }

    /**
     * 返回from类型是否可以分配给to类型，假设其中一个类型是（带框的）基元类型。我们可以稍微放松类型约束，因为我们将通过反射调用一个方法。
     * 这意味着from类型将始终被装箱，因为Method.ioke（Object，Object…）方法接受对象。
     **/
    private static boolean isPrimitiveAssignableFrom(Class<?> from, Class<?> to) {
        if ((from == Boolean.class || from == boolean.class) && (to == boolean.class || to == Boolean.class))
            return true;
        if ((from == Integer.class || from == int.class) && (to == int.class || to == Integer.class)) return true;
        if ((from == Float.class || from == float.class) && (to == float.class || to == Float.class)) return true;
        if ((from == Double.class || from == double.class) && (to == double.class || to == Double.class)) return true;
        if ((from == Byte.class || from == byte.class) && (to == byte.class || to == Byte.class)) return true;
        if ((from == Short.class || from == short.class) && (to == short.class || to == Short.class)) return true;
        if ((from == Long.class || from == long.class) && (to == long.class || to == Long.class)) return true;
        return (from == Character.class || from == char.class) && (to == char.class || to == Character.class);
    }

    public static String[] getStringTypes(Object[] objects) {
        String[] parameterTypes = new String[objects == null ? 0 : objects.length];
        if (objects != null) {
            for (int i = 0, len = objects.length; i < len; i++) {
                Object value = objects[i];
                parameterTypes[i] = value == null ? "null" : value.getClass().getSimpleName();
            }
        }
        return parameterTypes;
    }

    /**
     * 返回是否可以将from类型强制转换为to类型。强制规则遵循Java的规则。
     **/
    private static boolean isCoercible(Class<?> from, Class<?> to) {
        if (from == Integer.class || from == int.class) {
            return to == float.class || to == Float.class || to == double.class || to == Double.class || to == long.class || to == Long.class;
        }

        if (from == Float.class || from == float.class) {
            return to == double.class || to == Double.class;
        }

        if (from == Double.class || from == double.class) {
            return false;
        }

        if (from == Character.class || from == char.class) {
            return to == int.class || to == Integer.class || to == float.class || to == Float.class || to == double.class || to == Double.class || to == long.class
                    || to == Long.class;
        }

        if (from == Byte.class || from == byte.class) {
            return to == int.class || to == Integer.class || to == float.class || to == Float.class || to == double.class || to == Double.class || to == long.class
                    || to == Long.class || to == short.class || to == Short.class;
        }

        if (from == Short.class || from == short.class) {
            return to == int.class || to == Integer.class || to == float.class || to == Float.class || to == double.class || to == Double.class || to == long.class
                    || to == Long.class;
        }

        if (from == Long.class || from == long.class) {
            return to == float.class || to == Float.class || to == double.class || to == Double.class;
        }

        if (from == int[].class || from == Integer[].class) {
            return to == Object[].class || to == float[].class || to == Float[].class || to == double[].class || to == Double[].class || to == long[].class || to == Long[].class;
        }

        return false;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public Object getField(Object obj, String name) {
        Class cls = obj instanceof Class ? (Class) obj : obj.getClass();
        Map<String, Field> fields = fieldCache.get(cls);
        if (fields == null) {
            fields = new ConcurrentHashMap<>();
            fieldCache.put(cls, fields);
        }

        Field field = fields.get(name);
        if (field == null) {
            try {
                field = cls.getDeclaredField(name);
                field.setAccessible(true);
                fields.put(name, field);
            } catch (Throwable t) {
                //  空 不处理, try super classes
            }

            if (field == null) {
                Class parentClass = cls.getSuperclass();
                while (parentClass != Object.class && parentClass != null) {
                    try {
                        field = parentClass.getDeclaredField(name);
                        field.setAccessible(true);
                        fields.put(name, field);
                    } catch (NoSuchFieldException e) {
                        //  空 不处理
                    }
                    parentClass = parentClass.getSuperclass();
                }
            }
        }

        return field;
    }

    @Override
    public Object getFieldValue(Object obj, Object field) {
        Field javaField = (Field) field;
        try {
            return javaField.get(obj);
        } catch (Throwable e) {
            throw new RuntimeException("Couldn't get value of field '" + javaField.getName() + "' from object of type '" + obj.getClass().getSimpleName() + "'");
        }
    }

    @Override
    public void registerExtensionClass(Class<?> target, Class<?> clazz) {
        Method[] methods = clazz.getDeclaredMethods();
        Map<String, List<Method>> cachedMethodMap = extensionmethodCache.get(target);
        if (cachedMethodMap == null) {
            cachedMethodMap = new HashMap<>();
            extensionmethodCache.put(target, cachedMethodMap);
        }
        for (Method method : methods) {
            if (Modifier.isStatic(method.getModifiers()) && method.getParameterCount() > 0) {
                List<Method> cachedList = cachedMethodMap.get(method.getName());
                if (cachedList == null) {
                    cachedList = new ArrayList<>();
                    cachedMethodMap.put(method.getName(), cachedList);
                }
                cachedList.add(method);
            }
        }
    }

    @Override
    public Object getExtensionMethod(Object obj, String name, Object... arguments) {
        Class<?> cls = obj instanceof Class ? (Class<?>) obj : obj.getClass();
        if (cls.isArray()) {
            cls = Object[].class;
        }
        return getExtensionMethod(cls, name, arguments);
    }

    private Object getExtensionMethod(Class<?> cls, String name, Object... arguments) {
        if (cls == null) {
            cls = Object.class;
        }
        Map<String, List<Method>> methodMap = extensionmethodCache.get(cls);
        if (methodMap != null) {
            List<Method> methodList = methodMap.get(name);
            if (methodList != null) {
                Class<?>[] parameterTypes = new Class[arguments.length + 1];
                parameterTypes[0] = cls;
                for (int i = 0; i < arguments.length; i++) {
                    parameterTypes[i + 1] = arguments[i] == null ? null : arguments[i].getClass();
                }
                return findMethod(methodList, parameterTypes);
            }
        }
        if (cls != Object.class) {
            Class<?>[] interfaces = cls.getInterfaces();
            for (Class<?> clazz : interfaces) {
                Object method = getExtensionMethod(clazz, name, arguments);
                if (method != null) {
                    return method;
                }
            }
            return getExtensionMethod(cls.getSuperclass(), name, arguments);
        }
        return null;
    }

    @Override
    public Object getMethod(Object obj, String name, Object... arguments) {
        Class<?> cls = obj instanceof Class ? (Class<?>) obj : obj.getClass();
        Map<MethodSignature, Method> methods = methodCache.get(cls);
        if (methods == null) {
            methods = new ConcurrentHashMap<>();
            methodCache.put(cls, methods);
        }

        Class<?>[] parameterTypes = new Class[arguments.length];
        for (int i = 0; i < arguments.length; i++) {
            parameterTypes[i] = arguments[i] == null ? null : arguments[i].getClass();
        }

        MethodSignature signature = new MethodSignature(name, parameterTypes);
        Method method = methods.get(signature);

        if (method == null) {
            try {
                if (name == null) {
                    method = findApply(cls);
                } else {
                    method = findMethod(cls, name, parameterTypes);
                    if (method == null) {
                        method = findMethod(cls, name, new Class<?>[]{Object[].class});
                    }
                }
                method.setAccessible(true);
                methods.put(signature, method);
            } catch (Throwable e) {
                //  空 不处理
            }

            if (method == null) {
                Class<?> parentClass = cls.getSuperclass();
                while (parentClass != Object.class && parentClass != null) {
                    try {
                        if (name == null)
                            method = findApply(parentClass);
                        else {
                            method = findMethod(parentClass, name, parameterTypes);
                        }
                        method.setAccessible(true);
                        methods.put(signature, method);
                    } catch (Throwable e) {
                        //  空 不处理
                    }
                    parentClass = parentClass.getSuperclass();
                }
            }
        }

        return method;
    }

    @Override
    public Object callMethod(Object obj, Object method, Object... arguments) {
        Method javaMethod = (Method) method;
        try {
            return javaMethod.invoke(obj, arguments);
        } catch (Throwable t) {
            throw new RuntimeException("Couldn't call method '" + javaMethod.getName() + "' with arguments '" + Arrays.toString(arguments)
                    + "' on object of type '" + obj.getClass().getSimpleName() + "'.", t);
        }
    }

    private static class MethodSignature {
        private final String name;
        @SuppressWarnings("rawtypes")
        private final Class[] parameters;
        private final int hashCode;

        @SuppressWarnings("rawtypes")
        public MethodSignature(String name, Class[] parameters) {
            this.name = name;
            this.parameters = parameters;
            final int prime = 31;
            int hash = 1;
            hash = prime * hash + ((name == null) ? 0 : name.hashCode());
            hash = prime * hash + Arrays.hashCode(parameters);
            hashCode = hash;
        }

        @Override
        public int hashCode() {
            return hashCode;
        }

        @Override
        public boolean equals(Object obj) {
            if (this == obj) return true;
            if (obj == null) return false;
            if (getClass() != obj.getClass()) return false;
            MethodSignature other = (MethodSignature) obj;
            if (name == null) {
                if (other.name != null) return false;
            } else if (!name.equals(other.name)) return false;
            return Arrays.equals(parameters, other.parameters);
        }
    }
}
