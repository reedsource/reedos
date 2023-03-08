/*
*
*
*/
$(function () {
    brandInit();
});
var brandInit = function () {
    var brandArray = [
        {
            img: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
            url: "https://www.baidu.com/"
        },
        {
            img: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png",
            url: "https://www.baidu.com/"
        },
    ];
    var _brand = parseInt(Math.random() * (brandArray.length));
    var currentBrand = brandArray[_brand];
    var brandHtml = '<a href="' + currentBrand.url + '" target="_blank"><img class="img" src="' + currentBrand.img + '"></a>';
    $("#brandGrid").html(brandHtml);
}
var toreply = function (obj) {
    if ($("#rep_" + obj).css("display") == "none") {
        $("#rep_" + obj).css("display", "block");
    } else {
        $("#rep_" + obj).css("display", "none");
    }
};
var check_comm = function (obj) {
    var content = obj.content.value;
    if (content === '') {
        layer.msg('哎呀，你好像忘记写评论了？');
        return false;
    }
    return true;
};
var check_rep = function (obj) {
    var content = obj.content.value;
    if (content === '') {
        layer.msg('哎呀，你好像忘记写评论了？');
        return false;
    }
    return true;
};

