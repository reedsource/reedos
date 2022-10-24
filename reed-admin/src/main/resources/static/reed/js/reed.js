/*
* 自定义全局js
*
* 20221019
*   全局websocket
*   //toastr 通知提示框架
* */

//服务
const baseMotheds = function () {
    const websocket = function () {
        if ($.websocket) {
            let host = window.location.host;
            host = "ws://" + host + "/websocket/test";
            $.websocket.open({
                host: host, reconnect: true, callback: function (result) {
                    console.log("接收到服务器端推送的消息：==" + result);
                    const resultJson = JSON.parse(result);
                    //toastr 通知提示
                    if (resultJson["type"] === "default") {
                        $.toastr.msg(decodeURIComponent(resultJson["msg"]));
                    } else {
                        $.toastr.success(decodeURIComponent(resultJson["msg"]));
                    }
                }
            });
        }
    };
    return {
        init: function () {
            websocket();
        }
    }
}();
//初始化运行
$(function () {
    baseMotheds.init();
});

(function ($) {
    $.extend({
        websocket: {
            _this: null, _initialized: false, init: function (options) {
                if (!this.isSupported()) {
                    // console.error('Not support websocket');
                    return;
                }
                const op = $.extend({
                    callback: function () {
                    }, host: null, reconnect: false
                }, options);
                if (!op.host) {
                    // console.error("初始化WebSocket失败，无效的请求地址");
                    return;
                }
                try {
                    this._this = new WebSocket(op.host);
                } catch (error) {
                    return;
                }
                this._initialized = true;
                //连接发生错误的回调方法
                this._this.onerror = function () {
                    // console.log("与服务器连接失败...");
                };

                //连接成功建立的回调方法
                this._this.onopen = function () {
                    // console.log("与服务器连接成功...");
                };

                //接收到消息的回调方法
                this._this.onmessage = function (event) {
                    op.callback(event.data);
                    // console.log("接收到服务器端推送的消息：" + event.data);
                };

                //连接关闭的回调方法
                this._this.onclose = function () {
                    $.websocket._initialized = false;
                    console.log("已关闭当前链接");
                    if (op.reconnect) {
                        // 自动重连
                        setTimeout(function () {
                            $.websocket.open(op);
                        }, 5000);
                    }
                }
            }, open: function (options) {
                if (this._initialized) {
                    this.close();
                }
                this.init(options);
                //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
                window.onbeforeunload = function () {
                    console.log("窗口关闭了");
                    $.websocket.close();
                }
            }, isSupported: function () {
                return 'WebSocket' in window;
            }, send: function (message) {
                if (!this._this) {
                    return;
                }
                this._this.send(message);
            }, close: function () {
                if (!this._this) {
                    return;
                }
                this._this.close();
            }
        }, //toastr 通知提示框插件配置
        toastr: {
            //通用全局设置
            config: {
                "closeButton": true,  //是否显示关闭按钮
                "debug": false, //是否使用debug模式
                "newestOnTop": false, //最新消息
                "progressBar": false,//是否显示进度条，当为false时候不显示；当为true时候，显示进度条，当进度条缩短到0时候，消息通知弹窗消失
                //设置toastr显示位置的class
                "positionClass": "toast-top-right-60",//顶端右边
                "preventDuplicates": false,//防止重复
                "onclick": null, "showDuration": "300", //显示的动画时间
                "hideDuration": "1000", //消失的动画时间
                "timeOut": "5000", //展现时间
                "extendedTimeOut": "1000", //加长展示时间
                "showEasing": "swing", //显示时的动画缓冲方式
                "hideEasing": "linear", //消失时的动画缓冲方式
                "showMethod": "fadeIn", //显示时的动画方式
                "hideMethod": "fadeOut" //消失时的动画方式
            },//自定义设置
            msgConfig: {
                "closeButton": true,  //是否显示关闭按钮
                "debug": false, //是否使用debug模式
                "newestOnTop": false, //最新消息
                "progressBar": true,//是否显示进度条，当为false时候不显示；当为true时候，显示进度条，当进度条缩短到0时候，消息通知弹窗消失
                "positionClass": "toast-top-right-60",//设置toastr显示位置的class
                "preventDuplicates": false,//防止重复
                "onclick": null, "showDuration": "300", //显示的动画时间
                "hideDuration": "1000", //消失的动画时间
                "timeOut": "30000", //展现时间
                "extendedTimeOut": "1000", //加长展示时间
                "showEasing": "swing", //显示时的动画缓冲方式
                "hideEasing": "linear", //消失时的动画缓冲方式
                "showMethod": "fadeIn", //显示时的动画方式
                "hideMethod": "fadeOut" //消失时的动画方式
            },

            info: function (msg, title) {
                toastr.options = $.toastr.config;
                //普通提示 蓝
                toastr.info(msg, title);
            },
            success: function (msg, title) {
                toastr.options = $.toastr.config;
                //成功提示 绿
                toastr.success(msg, title);
            },
            warning: function (msg, title) {
                toastr.options = $.toastr.config;
                //警告提示 橘黄
                toastr.warning(msg, title);
            },
            error: function (msg, title) {
                toastr.options = $.toastr.config;
                //错误提示 红
                toastr.error(msg, title);
            },//自定义消息
            msg: function (msg, title) {
                toastr.options = $.toastr.msgConfig;
                //成功提示 绿
                toastr.success(msg, title);
            }
        }
    });
})(jQuery);
