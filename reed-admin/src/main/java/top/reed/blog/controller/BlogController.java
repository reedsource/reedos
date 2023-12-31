package top.reed.blog.controller;


import cn.hutool.cache.Cache;
import cn.hutool.cache.CacheUtil;
import cn.hutool.core.collection.CollectionUtil;
import com.github.pagehelper.PageInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import top.reed.cms.domain.*;
import top.reed.cms.service.*;
import top.reed.cms.util.CmsConstants;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.common.exception.ServiceException;
import top.reed.common.utils.IpUtils;
import top.reed.system.service.ISysConfigService;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 博客blog界面跳转后端
 *
 * @author reedsource
 */
@SuppressWarnings("SpringMVCViewInspection")
@Controller
@RequestMapping("/blog")
public class BlogController extends BaseController {

    // 请求路径
    private static final String PREFIX = "blog/theme/";
    private static final String KEY_LINK_TYPE_LIST = "linkTypeList";
    private static final String KEY_LINK_LIST = "linkList_";
    private static final Cache<String, Integer> articleViewCache = CacheUtil.newLRUCache(1000, 1000 * 60 * 60);
    private static final Cache<String, Integer> articleUpVoteCache = CacheUtil.newLRUCache(1000, 1000 * 60 * 60);
    private static final Cache<String, Integer> commentUpVoteCache = CacheUtil.newLRUCache(1000, 1000 * 60 * 60);
    private static final Cache<String, Map> bannerCache = CacheUtil.newTimedCache(1000 * 60 * 60);
    private static final Cache<String, Object> blogCache = CacheUtil.newTimedCache(1000 * 60 * 60 * 3);
    @Autowired
    private IArticleService articleService;
    @Autowired
    private IAlbumService albumService;
    @Autowired
    private ICommentService commentService;
    @Autowired
    private ITagsService tagsService;
    @Autowired
    private ICategoryService categoryService;
    @Autowired
    private IResourceService resourceService;
    @Autowired
    private ISysConfigService configService;
    @Autowired
    private ILinkTypeService linkTypeService;
    @Autowired
    private ILinkService linkService;
    @Autowired
    private IBlogThemeService blogThemeService;

    /**
     * @return 查询博客模板信息
     */
    private String getTheme() {
        return configService.selectConfigByKey(CmsConstants.KEY_BLOG_THEME);
    }

    /**
     * 首页
     *
     * @param model model
     */
    @GetMapping({"/", "", "/index"})
    public String index(Model model) {
        model.addAttribute("pageUrl", "blog/index");
        model.addAttribute("categoryId", "index");

        Article form = new Article();
        startPage();
        List<Article> articles = articleService.selectArticlesRegionNotNull(form);
        model.addAttribute("pageNo", new PageInfo(articles).getPageNum());
        model.addAttribute("pageSize", new PageInfo(articles).getPageSize());
        model.addAttribute("totalPages", new PageInfo(articles).getPages());
        model.addAttribute("articleList", articles);
        return PREFIX + getTheme() + "/index";
    }

    /**
     * 获取一个专辑以及其关联的素材
     */
    @PostMapping("/getIndexBanner")
    @ResponseBody
    public AjaxResult getAlbum(String code) {
        if (StringUtils.isEmpty(code)) {
            return AjaxResult.error("参数code不能为空!");
        }
        Map data = bannerCache.get(code, false);
        if (data == null) {
            data = albumService.getAlbum(code);
            bannerCache.put(code, data);
        }
        return AjaxResult.success(data);
    }

    /**
     * 文章详情
     *
     * @param model     model
     * @param articleId 文章id
     */
    @GetMapping("/article/{articleId}")
    public String article(HttpServletRequest request, Model model, @PathVariable("articleId") String articleId) {
        Article article = articleService.selectArticleById(articleId);
        if (article == null) {
            throw new ServiceException("该文章不存在!");
        }
        model.addAttribute("article", article);
        model.addAttribute("categoryId", article.getCategoryId());
        return PREFIX + getTheme() + "/article";
    }

    /**
     * 分类列表
     *
     * @param model model
     */
    @GetMapping("/category")
    public String category(Model model) {
        model.addAttribute("categoryId", "category");
        Article form = new Article();
        startPage();
        List<Article> articles = articleService.selectArticleList(form);
        PageInfo pageInfo = new PageInfo(articles);
        model.addAttribute("total", pageInfo.getTotal());
        model.addAttribute("pageNo", pageInfo.getPageNum());
        model.addAttribute("pageSize", pageInfo.getPageSize());
        model.addAttribute("totalPages", pageInfo.getPages());
        model.addAttribute("hasPrevious", pageInfo.isHasPreviousPage());
        model.addAttribute("hasNext", pageInfo.isHasNextPage());
        model.addAttribute("currentPage", pageInfo.getPageNum());
        model.addAttribute("prePage", pageInfo.getPrePage());
        model.addAttribute("nextPage", pageInfo.getNextPage());
        model.addAttribute("navNums", pageInfo.getNavigatepageNums());
        model.addAttribute("articleList", articles);
        return PREFIX + getTheme() + "/category_article";
    }

    /**
     * 分类列表
     *
     * @param categoryId 分类id
     * @param model      model
     */
    @GetMapping("/category/{categoryId}")
    public String categoryBy(@PathVariable("categoryId") String categoryId, Model model) {
        Category category = categoryService.selectCategoryById(Long.valueOf(categoryId));
        if (category != null) {
            model.addAttribute("categoryName", category.getCategoryName());
        }
        Article form = new Article();
        form.setCategoryId(categoryId);
        model.addAttribute("categoryId", categoryId);
        startPage();
        List<Article> articles = articleService.selectArticleList(form);
        PageInfo pageInfo = new PageInfo(articles);
        model.addAttribute("total", pageInfo.getTotal());
        model.addAttribute("pageNo", pageInfo.getPageNum());
        model.addAttribute("pageSize", pageInfo.getPageSize());
        model.addAttribute("totalPages", pageInfo.getPages());
        model.addAttribute("hasPrevious", pageInfo.isHasPreviousPage());
        model.addAttribute("hasNext", pageInfo.isHasNextPage());
        model.addAttribute("currentPage", pageInfo.getPageNum());
        model.addAttribute("prePage", pageInfo.getPrePage());
        model.addAttribute("nextPage", pageInfo.getNextPage());
        model.addAttribute("navNums", pageInfo.getNavigatepageNums());
        model.addAttribute("articleList", articles);
        return PREFIX + getTheme() + "/category";
    }

    /**
     * 分类列表
     *
     * @param model model
     */
    @GetMapping("/resource/list")
    public String resourceList(Model model) {
        model.addAttribute("categoryId", "resource");
        Resource form = new Resource();
        form.setStatus(CmsConstants.STATUS_NORMAL);
        form.setAuditState(CmsConstants.AUDIT_STATE_AGREE.toString());
        startPage();
        List<Resource> resources = resourceService.selectResourceList(form);
        PageInfo pageInfo = new PageInfo(resources);
        model.addAttribute("total", pageInfo.getTotal());
        model.addAttribute("pageNo", pageInfo.getPageNum());
        model.addAttribute("pageSize", pageInfo.getPageSize());
        model.addAttribute("totalPages", pageInfo.getPages());
        model.addAttribute("hasPrevious", pageInfo.isHasPreviousPage());
        model.addAttribute("hasNext", pageInfo.isHasNextPage());
        model.addAttribute("currentPage", pageInfo.getPageNum());
        model.addAttribute("prePage", pageInfo.getPrePage());
        model.addAttribute("nextPage", pageInfo.getNextPage());
        model.addAttribute("navNums", pageInfo.getNavigatepageNums());
        model.addAttribute("resourceList", resources);
        return PREFIX + getTheme() + "/list_resource";
    }

    /**
     * 资源详情
     *
     * @param model model
     */
    @GetMapping("/resource/{id}")
    public String resource(HttpServletRequest request, Model model, @PathVariable("id") String id) {
        Resource resource = resourceService.selectResourceById(id);
        if (resource == null) {
            throw new ServiceException("该资源不存在!");
        }
        model.addAttribute("resource", resource);
        model.addAttribute("categoryId", "resource");
        return PREFIX + getTheme() + "/resource";
    }

    /**
     * 搜索内容
     * 目前仅支持文章标题模糊搜索
     *
     * @param model model
     */
    @GetMapping("/search")
    public String search(String content, Model model) {
        model.addAttribute("content", content);
        Article form = new Article();
        form.setTitle(content.trim());
        startPage();
        List<Article> articles = articleService.selectArticleList(form);
        PageInfo pageInfo = new PageInfo(articles);
        model.addAttribute("total", pageInfo.getTotal());
        model.addAttribute("pageNo", pageInfo.getPageNum());
        model.addAttribute("pageSize", pageInfo.getPageSize());
        model.addAttribute("totalPages", pageInfo.getPages());
        model.addAttribute("hasPrevious", pageInfo.isHasPreviousPage());
        model.addAttribute("hasNext", pageInfo.isHasNextPage());
        model.addAttribute("currentPage", pageInfo.getPageNum());
        model.addAttribute("prePage", pageInfo.getPrePage());
        model.addAttribute("nextPage", pageInfo.getNextPage());
        model.addAttribute("navNums", pageInfo.getNavigatepageNums());
        model.addAttribute("articleList", articles);
        return PREFIX + getTheme() + "/search";
    }

    /**
     * 标签列表
     *
     * @param model model
     */
    @GetMapping("/tag/{tagId}")
    public String tag(@PathVariable("tagId") String tagId, Model model) {
        model.addAttribute("tagId", tagId);
        Tags tag = tagsService.selectTagsById(Long.valueOf(tagId));
        if (tag != null) {
            model.addAttribute("tagName", tag.getTagName());
        }
        Article form = new Article();
        form.setTag(tagId);
        model.addAttribute("pageUrl", "blog/tag/" + tagId);
        startPage();
        List<Article> articles = articleService.selectArticleList(form);
        PageInfo pageInfo = new PageInfo(articles);
        model.addAttribute("total", pageInfo.getTotal());
        model.addAttribute("pageNo", pageInfo.getPageNum());
        model.addAttribute("pageSize", pageInfo.getPageSize());
        model.addAttribute("totalPages", pageInfo.getPages());
        model.addAttribute("hasPrevious", pageInfo.isHasPreviousPage());
        model.addAttribute("hasNext", pageInfo.isHasNextPage());
        model.addAttribute("currentPage", pageInfo.getPageNum());
        model.addAttribute("prePage", pageInfo.getPrePage());
        model.addAttribute("nextPage", pageInfo.getNextPage());
        model.addAttribute("navNums", pageInfo.getNavigatepageNums());
        model.addAttribute("articleList", articles);
        return PREFIX + getTheme() + "/tag";
    }

    /**
     * 留言
     *
     * @param model model
     */
    @GetMapping("/siteMsg")
    public String comment(Model model) {
        model.addAttribute("categoryId", "siteMsg");
        return PREFIX + getTheme() + "/siteMsg";
    }

    @PostMapping("/article/view")
    @ResponseBody
    public AjaxResult articleView(HttpServletRequest request, String articleId) {
        if (StringUtils.isEmpty(articleId)) {
            return AjaxResult.error("系统错误!");
        }
        String ip = IpUtils.getIpAddr(request);
        Integer n = articleViewCache.get(ip + "|" + articleId);
        if (n == null || n == 0) {
            articleService.articleLook(articleId);
            articleViewCache.put(ip + "|" + articleId, 1);
            return AjaxResult.success("浏览数+1");
        } else {
            articleViewCache.put(ip + "|" + articleId, n + 1);
            return AjaxResult.error("系统错误!");
        }
    }

    @PostMapping("/article/upVote")
    @ResponseBody
    public AjaxResult articleUpVote(HttpServletRequest request, String articleId) {
        if (StringUtils.isEmpty(articleId)) {
            return AjaxResult.error("系统错误!");
        }
        String ip = IpUtils.getIpAddr(request);
        Integer n = articleUpVoteCache.get(ip + "|" + articleId);
        if (n == null || n == 0) {
            articleService.upVote(articleId);
            articleUpVoteCache.put(ip + "|" + articleId, 1);
            return AjaxResult.success("点赞数+1");
        } else {
            articleUpVoteCache.put(ip + "|" + articleId, n + 1);
            return AjaxResult.error("系统错误!");
        }
    }

    @PostMapping("/resource/view")
    @ResponseBody
    public AjaxResult resourceView(HttpServletRequest request, String id) {
        if (StringUtils.isEmpty(id)) {
            return AjaxResult.error("系统错误!");
        }
        String ip = IpUtils.getIpAddr(request);
        Integer n = articleViewCache.get(ip + "|" + id);
        if (n == null || n == 0) {
            resourceService.resourceLook(id);
            articleViewCache.put(ip + "|" + id, 1);
            return AjaxResult.success("浏览数+1");
        } else {
            articleViewCache.put(ip + "|" + id, n + 1);
            return AjaxResult.error("系统错误!");
        }
    }

    @PostMapping("/resource/upVote")
    @ResponseBody
    public AjaxResult resourceUpVote(HttpServletRequest request, String id) {
        if (StringUtils.isEmpty(id)) {
            return AjaxResult.error("系统错误!");
        }
        String ip = IpUtils.getIpAddr(request);
        Integer n = articleUpVoteCache.get(ip + "|" + id);
        if (n == null || n == 0) {
            resourceService.upVote(id);
            articleUpVoteCache.put(ip + "|" + id, 1);
            return AjaxResult.success("点赞数+1");
        } else {
            articleUpVoteCache.put(ip + "|" + id, n + 1);
            return AjaxResult.error("系统错误!");
        }
    }

    @PostMapping("/comments")
    @ResponseBody
    public AjaxResult comments(String tid, String type) {
        if (StringUtils.isEmpty(tid) || StringUtils.isEmpty(type)) {
            return AjaxResult.error("参数错误!");
        }
        Comment form = new Comment();
        form.setTid(tid);
        form.setType(type);
        startPage();
        List<Comment> list = commentService.selectComments(form);
        Map<String, Object> data = new HashMap<>();
        data.put("total", new PageInfo(list).getTotal());
        data.put("rows", list);
        data.put("hasNextPage", new PageInfo(list).isHasNextPage());
        data.put("nextPage", new PageInfo(list).getNextPage());
        return AjaxResult.success(data);
    }

    @PostMapping("/comments/save")
    @ResponseBody
    public AjaxResult saveComments(HttpServletRequest request, Comment comment) {
        if (StringUtils.isEmpty(comment.getUserName())) {
            return AjaxResult.error("请输入昵称!");
        }
        if (StringUtils.isEmpty(comment.getQq())) {
            return AjaxResult.error("请输入QQ!");
        }
        if (!comment.getQq().matches("[1-9][0-9]{4,11}")) {
            return AjaxResult.error("QQ格式不合法!");
        }
        comment.setIp(IpUtils.getIpAddr(request));
        comment.setCreateTime(new Date());
        comment.setStatus(0);//无需审核即可显示
        comment.setAvatar("http://q1.qlogo.cn/g?b=qq&nk=" + comment.getQq() + "&s=100");
        int n = commentService.insertComment(comment);
        if (n > 0) {
            return AjaxResult.success(comment);
        } else {
            return AjaxResult.error("评论失败!");
        }

    }

    @PostMapping("/comments/upVote")
    @ResponseBody
    public AjaxResult commentsUpVote(HttpServletRequest request, String commentId) {
        if (StringUtils.isEmpty(commentId)) {
            return AjaxResult.error("系统错误!");
        }
        String ip = IpUtils.getIpAddr(request);
        Integer n = commentUpVoteCache.get(ip + "|" + commentId);
        if (n == null || n == 0) {
            commentService.upVote(commentId);
            commentUpVoteCache.put(ip + "|" + commentId, 1);
            return AjaxResult.success("支持数+1");
        } else {
            commentUpVoteCache.put(ip + "|" + commentId, n + 1);
            return AjaxResult.error("系统错误!");
        }
    }

    /**
     * 导航
     *
     * @param model model
     */
    @GetMapping("/nav")
    public String nav(Model model) {
        model.addAttribute("categoryId", "nav");
        List<LinkType> linkTypeList = (List<LinkType>) blogCache.get(KEY_LINK_TYPE_LIST);
        if (CollectionUtil.isEmpty(linkTypeList)) {
            LinkType form = new LinkType();
            form.setStatus(CmsConstants.STATUS_NORMAL);
            linkTypeList = linkTypeService.selectLinkTypeList(form);
            blogCache.put(KEY_LINK_TYPE_LIST, linkTypeList);
        }
        for (LinkType type : linkTypeList) {
            List<Link> tempList = (List<Link>) blogCache.get(KEY_LINK_LIST + type.getLinkType());
            if (CollectionUtil.isEmpty(tempList)) {
                Link tempForm = new Link();
                tempForm.setAuditState(CmsConstants.AUDIT_STATE_AGREE);
                tempForm.setLinkType(type.getLinkType());
                tempForm.setStatus(CmsConstants.STATUS_NORMAL);
                tempList = linkService.selectLinkList(tempForm);
                blogCache.put(KEY_LINK_LIST + type.getLinkType(), tempList);
            }
            tempList = tempList.stream().limit(3).collect(Collectors.toList());
            type.setChildren(tempList);
        }
        model.addAttribute("linkTypeList", linkTypeList);

        return PREFIX + getTheme() + "/navAll";
    }

    /**
     * 导航
     *
     * @param model model
     */
    @GetMapping("/nav/{type}")
    public String navByType(@PathVariable("type") String type, Model model) {
        model.addAttribute("categoryId", "nav");
        LinkType linkType = linkTypeService.selectLinkTypeByType(type);
        if (linkType == null) {
            throw new ServiceException("不存在的分类!");
        }
        model.addAttribute("linkType", linkType);

        List<LinkType> linkTypeList = (List<LinkType>) blogCache.get(KEY_LINK_TYPE_LIST);
        if (CollectionUtil.isEmpty(linkTypeList)) {
            LinkType form = new LinkType();
            form.setStatus(CmsConstants.STATUS_NORMAL);
            linkTypeList = linkTypeService.selectLinkTypeList(form);
            blogCache.put(KEY_LINK_TYPE_LIST, linkTypeList);
        }
        model.addAttribute("linkTypeList", linkTypeList);


        Link form = new Link();
        form.setAuditState(CmsConstants.AUDIT_STATE_AGREE);
        form.setLinkType(type);
        form.setStatus(CmsConstants.STATUS_NORMAL);
        startPage();
        List<Link> linkList = linkService.selectLinkList(form);
        PageInfo pageInfo = new PageInfo(linkList);
        model.addAttribute("total", pageInfo.getTotal());
        model.addAttribute("pageNo", pageInfo.getPageNum());
        model.addAttribute("pageSize", pageInfo.getPageSize());
        model.addAttribute("totalPages", pageInfo.getPages());
        model.addAttribute("hasPrevious", pageInfo.isHasPreviousPage());
        model.addAttribute("hasNext", pageInfo.isHasNextPage());
        model.addAttribute("currentPage", pageInfo.getPageNum());
        model.addAttribute("prePage", pageInfo.getPrePage());
        model.addAttribute("nextPage", pageInfo.getNextPage());
        model.addAttribute("navNums", pageInfo.getNavigatepageNums());
        model.addAttribute("linkList", linkList);

        return PREFIX + getTheme() + "/list_nav";
    }
}