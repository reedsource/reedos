//关闭选项卡
function closeTab(dataId) {
    var topWindow = $(window.parent.document);
    // 根据dataId关闭指定选项卡
    $('.menuTab[data-id="' + dataId + '"]', topWindow).remove();
    // 移除相应tab对应的内容区
    $('.mainContent .RuoYi_iframe[data-id="' + dataId + '"]', topWindow).remove();
    //跳转到新的选项卡
    panelUrl="/automation/autoflow";

    //关闭选项卡
    $('.menuTab[data-id="' + panelUrl + '"]', topWindow).addClass('active').siblings('.menuTab').removeClass('active');
    $('.mainContent .RuoYi_iframe', topWindow).each(function() {
        if ($(this).data('id') == panelUrl) {
            $(this).show().siblings('.RuoYi_iframe').hide();
            return false;
        }
    });

    //刷新目标选项卡
    var currentId = $('.page-tabs-content', topWindow).find('.active').attr('data-id');
    var target = $('.RuoYi_iframe[data-id="' + currentId + '"]', topWindow);
    var url = target.attr('src');
    target.attr('src', url).ready();
}