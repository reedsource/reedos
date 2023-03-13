package top.reed.cms.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import top.reed.cms.domain.Article;
import top.reed.cms.domain.ArticleModel;
import top.reed.cms.domain.Tags;
import top.reed.cms.service.IArticleService;
import top.reed.cms.service.ITagsService;
import top.reed.common.annotation.Log;
import top.reed.common.config.ReedConfig;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.core.page.TableDataInfo;
import top.reed.common.core.text.Convert;
import top.reed.common.enums.BusinessType;
import top.reed.common.exception.ServiceException;
import top.reed.common.utils.RStringUtils;
import top.reed.common.utils.file.FileUploadUtils;
import top.reed.common.utils.file.MimeTypeUtils;
import top.reed.common.utils.poi.ExcelUtil;
import top.reed.system.service.ISysConfigService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 文章管理Controller
 *
 * @author reedsource
 * date 2022/9/12
 */
@Controller
@RequestMapping("/cms/article")
public class ArticleController extends BaseController {
    private final String prefix = "cms/article";

    @Autowired
    private IArticleService articleService;
    @Autowired
    private ITagsService tagsService;

    @Autowired
    private ISysConfigService configService;

    @RequiresPermissions("cms:article:view")
    @GetMapping()
    public String article() {
        return prefix + "/article";
    }

    /**
     * 查询文章管理列表
     */
    @RequiresPermissions("cms:article:list")
    @PostMapping("/list")
    @ResponseBody
    public TableDataInfo list(Article article) {
        startPage();
        List<Article> list = articleService.selectArticleList(article);
        return getDataTable(list);
    }

    /**
     * 导出文章管理列表
     */
    @RequiresPermissions("cms:article:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(Article article) {
        List<Article> list = articleService.selectArticleList(article);
        ExcelUtil<Article> util = new ExcelUtil<>(Article.class);
        return util.exportExcel(list, "article");
    }

    /**
     * 新增文章管理
     */
    @GetMapping("/add")
    public String add(ModelMap mmap) {
        List<Tags> tags = tagsService.selectTagsAll();
        mmap.put("tags", tags);
        return prefix + "/add";
    }

    /**
     * 新增保存文章管理
     */
    @RequiresPermissions("cms:article:add")
    @Log(title = "文章管理", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    @ResponseBody
    public AjaxResult addSave(Article article) {
        return toAjax(articleService.insertArticle(article));
    }

    /**
     * 修改文章管理
     */
    @GetMapping("/edit/{id}")
    public String edit(@PathVariable("id") String id, ModelMap mmap) {
        Article article = articleService.selectArticleById(id);
        mmap.put("article", article);
        String tagIds = article.getTags();
        List<Tags> tags = tagsService.selectSelectedTagsAll(tagIds);
        mmap.put("tags", tags);
        return prefix + "/edit";
    }

    /**
     * 修改保存文章管理
     */
    @RequiresPermissions("cms:article:edit")
    @Log(title = "文章管理", businessType = BusinessType.UPDATE)
    @PostMapping("/edit")
    @ResponseBody
    public AjaxResult editSave(Article article) {
        return toAjax(articleService.updateArticle(article));
    }

    /**
     * 删除文章管理
     */
    @RequiresPermissions("cms:article:remove")
    @Log(title = "文章管理", businessType = BusinessType.DELETE)
    @PostMapping("/remove")
    @ResponseBody
    public AjaxResult remove(String ids) {
        return toAjax(articleService.deleteArticleByIds(ids));
    }

    @RequestMapping("/detail/{id}")
    public String article_detail(@PathVariable String id, Model model) {

        Article article = articleService.selectArticleById(id);
        if (article == null) {
            throw new ServiceException("您要访问的文章不存在!");
        }
        String article_model = article.getArticleModel();//文章模型
        if (ArticleModel.DUOGUYU.getVal().equals(article_model)) {
            List<Tags> fullTabs = tagsService.selectBlogTabs();
            model.addAttribute("fullTabs", fullTabs);
            String tagIds = article.getTags();
            if (RStringUtils.isNotEmpty(tagIds)) {
                String[] arr = Convert.toStrArray(tagIds);
                List<Tags> tagsList = new ArrayList<>();
                Tags tmp = null;
                for (String tid : arr) {
                    //检测每个标签再数据库cms_tag表中是否存在（根据名称），如果存在记下id，不存在则新增并记下id
                    tmp = tagsService.selectTagsById(Long.valueOf(tid));
                    if (tmp != null) {
                        tagsList.add(tmp);
                    }
                }
                model.addAttribute("tagsList", tagsList);//这个值用于输出模板文件的标签
            }
            Map dataMap = JSONObject.parseObject(JSON.toJSONString(article), Map.class);
            model.addAllAttributes(dataMap);

        } else {

        }
        return prefix + "/article-duoguyu";

    }


    /**
     * 上传图片(markdown编辑器上传图片使用)
     */
    @PostMapping("/uploadImage")
    @ResponseBody
    public Object uploadImage(@RequestParam("editormd-image-file") MultipartFile file) {
        try {
            /*// 上传的后台只需要返回一个 JSON 数据，结构如下：
                 {
                 success : 0 | 1,           // 0 表示上传失败，1 表示上传成功
                 message : "提示的信息，上传成功或上传失败及错误信息等。",
                 url     : "图片地址"        // 上传成功时才返回
                 }
                 */

            // 上传图片并返回新文件名称
            String path = FileUploadUtils.upload(ReedConfig.getUploadPath(), file, MimeTypeUtils.IMAGE_EXTENSION);
            Map map = new HashMap();
            map.put("success", 1);
            map.put("url", path);
            map.put("message", "上传成功!");
            return map;
        } catch (Exception e) {
            Map map = new HashMap();
            map.put("success", 0);
            map.put("url", "");
            map.put("message", "上传失败!" + e.getMessage());
            return map;
        }
    }

}
