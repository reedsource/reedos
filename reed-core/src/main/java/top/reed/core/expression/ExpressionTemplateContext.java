package top.reed.core.expression;

import java.util.*;


/**
 *
 * 表达式模板上下文
 * <p>
 * 模板上下文存储从变量名称到用户提供的变量值的映射。
 * A ExpressionTemplate 被赋予一个用于呈现的上下文，以解析它在模板表达式中引用的变量值。
 * 在内部，模板上下文是这些映射的堆栈，类似于编程语言中的范围，并由 .AstInterpreter
 */
public class ExpressionTemplateContext {
    private final static ThreadLocal<ExpressionTemplateContext> CONTEXT_THREAD_LOCAL = new ThreadLocal<>();
    private final List<Map<String, Object>> scopes = new ArrayList<>();
    /**
     * Keeps track of previously allocated, unused scopes. New scopes are first tried to be retrieved from this pool to avoid
     * generating garbage.
     **/
    private final List<Map<String, Object>> freeScopes = new ArrayList<>();

    public ExpressionTemplateContext() {
        push();
    }

    public ExpressionTemplateContext(Map<String, Object> variables) {
        this();
        if (variables != null) {
            variables.forEach(this::set);
        }
    }

    public static ExpressionTemplateContext get() {
        return CONTEXT_THREAD_LOCAL.get();
    }

    public static void remove() {
        CONTEXT_THREAD_LOCAL.remove();
    }

    public static void set(ExpressionTemplateContext context) {
        CONTEXT_THREAD_LOCAL.set(context);
    }

    /**
     * Sets the value of the variable with the given name. If the variable already exists in one of the scopes, that variable is
     * set. Otherwise the variable is set on the last pushed scope.
     */
    public ExpressionTemplateContext set(String name, Object value) {
        for (int i = scopes.size() - 1; i >= 0; i--) {
            Map<String, Object> ctx = scopes.get(i);
            if (ctx.isEmpty()) continue;
            if (ctx.containsKey(name)) {
                ctx.put(name, value);
                return this;
            }
        }

        scopes.get(scopes.size() - 1).put(name, value);
        return this;
    }

    /**
     * Sets the value of the variable with the given name on the last pushed scope
     **/
    public ExpressionTemplateContext setOnCurrentScope(String name, Object value) {
        scopes.get(scopes.size() - 1).put(name, value);
        return this;
    }

    /**
     * Internal. Returns the value of the variable with the given name, walking the scope stack from top to bottom, similar to how
     * scopes in programming languages are searched for variables.
     */
    public Object get(String name) {
        for (int i = scopes.size() - 1; i >= 0; i--) {
            Map<String, Object> ctx = scopes.get(i);
            if (ctx.isEmpty()) continue;
            Object value = ctx.get(name);
            if (value != null) return value;
        }
        return null;
    }

    /**
     * Internal. Returns all variables currently defined in this context.
     */
    public Set<String> getVariables() {
        Set<String> variables = new HashSet<>();
        for (Map<String, Object> scope : scopes) {
            variables.addAll(scope.keySet());
        }
        return variables;
    }

    /**
     * Internal. Pushes a new "scope" onto the stack.
     **/
    public void push() {
        Map<String, Object> newScope = freeScopes.size() > 0 ? freeScopes.remove(freeScopes.size() - 1) : new HashMap<>();
        scopes.add(newScope);
    }

    /**
     * Internal. Pops the top of the "scope" stack.
     **/
    public void pop() {
        Map<String, Object> oldScope = scopes.remove(scopes.size() - 1);
        oldScope.clear();
        freeScopes.add(oldScope);
    }
}
