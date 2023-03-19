$(function () {
    validateKickout();
    validateRule();
    refreshCode();
});

$.validator.setDefaults({
    submitHandler: function () {
        showVerfyImage();
    }
});

//显示验证码
function showVerfyImage() {
    $("#verfyImg").find(".mask").css("display", "block");
}

//登录
function postLogin(data) {
    $.modal.loading($("#btnSubmit").data("loading"));
    $.ajax({
        type: "post", url: ctx + "login", data: data, success: function (r) {
            if (r.code === web_status.SUCCESS) {
                location.href = ctx + 'index';
            } else {
                $.modal.closeLoading();
                $.modal.msg(r.msg);
            }
        }
    });
}

// 刷新验证码
function refreshCode() {
    /** 初始化验证码  弹出式 */
    $('#verfyImg').slideVerify({
        baseUrl: ctx, mode: 'pop', success: function (params) {
            var username = $.common.trim($("input[name='username']").val());
            var password = $.common.trim($("input[name='password']").val());
            var rememberMe = $("input[name='rememberme']").is(':checked');
            var data = {
                "username": username, "password": encrypt(password), "rememberMe": rememberMe
            };
            data = $.extend(data, params);
            postLogin(data);
        }, error: function () {
        }
    });
}

//验证规则
function validateRule() {
    var icon = "<i class='fa fa-times-circle'></i> ";
    $("#signupForm").validate({
        rules: {
            username: {
                required: true
            }, password: {
                required: true
            }
        }, messages: {
            username: {
                required: icon + "请输入您的用户名",
            }, password: {
                required: icon + "请输入您的密码",
            }
        }
    })
}

//验证限位
function validateKickout() {
    if (getParam("kickout") === "1") {
        layer.alert("<span style='color: red; '>您已在别处登录，请您修改密码或重新登录</span>", {
            icon: 0, title: "系统提示"
        }, function (index) {
            //关闭弹窗
            layer.close(index);
            if (top !== self) {
                top.location = self.location;
            } else {
                var url = location.search;
                if (url) {
                    var oldUrl = window.location.href;
                    self.location = oldUrl.substring(0, oldUrl.indexOf('?'));
                }
            }
        });
    }
}

//获取参数
function getParam(paramName) {
    var reg = new RegExp("(^|&)" + paramName + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURI(r[2]);
    return null;
}

// 密钥对生成 http://web.chacuo.net/netrsakeypair
const publicKey = 'MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAKoR8mX0rGKLqzcWmOzbfj64K8ZIgOdH\n' +
    'nzkXSOVOZbFu/TJhZ7rFAN+eaGkl3C4buccQd/EjEsj9ir7ijT7h96MCAwEAAQ=='

// 加密
function encrypt(txt) {
    const encryptor = new JSEncrypt()
    encryptor.setPublicKey(publicKey) // 设置公钥
    return encryptor.encrypt(txt) // 对数据进行加密
}
