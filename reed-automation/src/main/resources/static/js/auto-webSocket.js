/**
 * 创建Web套接字
 * @param options
 * @returns {WebSocket}
 */
function createWebSocket(options) {
    options = options || {};
    //连接WebSocket对象
    const socket = new WebSocket(options.url || (location.origin.replace("http", 'ws') + '/ws'));
    //WebSocket.onopen属性是当WebSocket连接的readyState更改为1时调用的事件处理程序；这表明连接已准备好发送和接收数据。它与事件一起调用。
    socket.onopen = options.onopen;
    //WebSocket.onmessage属性是从服务器接收消息时调用的事件处理程序。使用MessageEvent调用它
    socket.onmessage = options.onmessage;
    //WebSocket接口的onerror事件处理程序属性是一个函数，当WebSocket上发生错误时将调用该函数。 您还可以使用addEventListener（）添加错误事件处理程序
    socket.onerror = options.onerror || function () {
        layer.layer.msg('WebSocket错误');
    }
    return socket;
}