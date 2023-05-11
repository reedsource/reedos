package top.reed.core.executor.function.extension;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Component;
import top.reed.core.annotation.Comment;
import top.reed.core.annotation.Example;
import top.reed.core.annotation.Return;
import top.reed.core.executor.FunctionExtension;
import top.reed.core.io.AutomationResponse;
import top.reed.core.utils.ExtractUtils;

import java.util.List;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Component
public class ResponseFunctionExtension implements FunctionExtension {

    @Comment("将请求结果转为Element对象")
    @Example("${resp.element()}")
    public static Element element(AutomationResponse response) {
        return Jsoup.parse(response.getHtml(), response.getUrl());
    }

    @Comment("根据xpath在请求结果中查找")
    @Example("${resp.xpath('//title/text()')}")
    @Return({Element.class, String.class})
    public static String xpath(AutomationResponse response, String xpath) {
        return ExtractUtils.getValueByXPath(element(response), xpath);
    }

    @Comment("根据xpath在请求结果中查找")
    @Example("${resp.xpaths('//a/@href')}")
    public static List<String> xpaths(AutomationResponse response, String xpath) {
        return ExtractUtils.getValuesByXPath(element(response), xpath);
    }

    @Comment("根据正则表达式提取请求结果中的内容")
    @Example("${resp.regx('<title>(.*?)</title>')}")
    public static String regx(AutomationResponse response, String pattern) {
        return ExtractUtils.getFirstMatcher(response.getHtml(), pattern, true);
    }

    @Comment("根据正则表达式提取请求结果中的内容")
    @Example("${resp.regx('<title>(.*?)</title>',1)}")
    public static String regx(AutomationResponse response, String pattern, int groupIndex) {
        return ExtractUtils.getFirstMatcher(response.getHtml(), pattern, groupIndex);
    }

    @Comment("根据正则表达式提取请求结果中的内容")
    @Example("${resp.regx('<a href=\"(.*?)\">(.*?)</a>',[1,2])}")
    public static List<String> regx(AutomationResponse response, String pattern, List<Integer> groups) {
        return ExtractUtils.getFirstMatcher(response.getHtml(), pattern, groups);
    }

    @Comment("根据正则表达式提取请求结果中的内容")
    @Example("${resp.regxs('<h2>(.*?)</h2>')}")
    public static List<String> regxs(AutomationResponse response, String pattern) {
        return ExtractUtils.getMatchers(response.getHtml(), pattern, true);
    }

    @Comment("根据正则表达式提取请求结果中的内容")
    @Example("${resp.regxs('<h2>(.*?)</h2>',1)}")
    public static List<String> regxs(AutomationResponse response, String pattern, int groupIndex) {
        return ExtractUtils.getMatchers(response.getHtml(), pattern, groupIndex);
    }

    @Comment("根据正则表达式提取请求结果中的内容")
    @Example("${resp.regxs('<a href=\"(.*?)\">(.*?)</a>',[1,2])}")
    public static List<List<String>> regxs(AutomationResponse response, String pattern, List<Integer> groups) {
        return ExtractUtils.getMatchers(response.getHtml(), pattern, groups);
    }

    @Comment("根据css选择器提取请求结果")
    @Example("${resp.selector('div > a')}")
    public static Element selector(AutomationResponse response, String selector) {
        return ElementFunctionExtension.selector(element(response), selector);
    }

    @Comment("根据css选择器提取请求结果")
    @Example("${resp.selectors('div > a')}")
    public static Elements selectors(AutomationResponse response, String selector) {
        return ElementFunctionExtension.selectors(element(response), selector);
    }

    @Comment("根据jsonpath提取请求结果")
    @Example("${resp.jsonpath('$.code')}")
    public static Object jsonpath(AutomationResponse response, String path) {
        return ExtractUtils.getValueByJsonPath(response.getJson(), path);
    }

    @Comment("获取页面上的链接")
    @Example("${resp.links()}")
    public static List<String> links(AutomationResponse response) {
        return ExtractUtils.getAttrBySelector(element(response), "a", "abs:href")
                .stream()
                .filter(link -> StringUtils.isNotBlank(link))
                .collect(Collectors.toList());
    }

    @Comment("获取页面上的链接")
    @Example("${resp.links('https://www\\.xxx\\.com/xxxx/(.*?)')}")
    public static List<String> links(AutomationResponse response, String regx) {
        Pattern pattern = Pattern.compile(regx);
        return links(response)
                .stream()
                .filter(link -> pattern.matcher(link).matches())
                .collect(Collectors.toList());
    }

    @Comment("获取当前页面所有图片链接")
    @Example("${resp.images()}")
    public static List<String> images(AutomationResponse response) {
        return ExtractUtils.getAttrBySelector(element(response), "img", "src")
                .stream()
                .filter(link -> StringUtils.isNotBlank(link))
                .collect(Collectors.toList());
    }

    @Override
    public Class<?> support() {
        return AutomationResponse.class;
    }
}
