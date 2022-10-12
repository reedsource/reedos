//验证数据源是否可以正常连接上
function datasourceTest() {
    if ($.validate.form()) {
        $.ajax({
            type: "post",
            url: prefix + "/test",
            data: {
                "driverClassName": $("#driverClassName").val(),
                "jdbcUrl": $("#jdbcUrl").val(),
                "username": $("#username").val(),
                "password": $("#password").val(),
            },
            success: function (data) {
                if (data.code === 0) {
                    $.modal.alertSuccess('数据源测试连接成功')
                } else {
                    $.modal.alertError(data.msg)
                }
            }
        });
    }
}