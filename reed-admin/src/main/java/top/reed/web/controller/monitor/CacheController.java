package top.reed.web.controller.monitor;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import top.reed.common.core.controller.BaseController;
import top.reed.common.core.domain.AjaxResult;
import top.reed.framework.web.service.CacheService;

/**
 * 缓存监控
 * 缓存使用 shiro.cache.ehcache
 *
 * @author reedsource
 */
@Controller
@RequestMapping("/monitor/cache")
public class CacheController extends BaseController {

    @Autowired
    private CacheService cacheService;

    @RequiresPermissions("monitor:cache:view")
    @GetMapping()
    public String cache(ModelMap modelMap) {
        modelMap.put("cacheNames", cacheService.getCacheNames());
        return "monitor/cache/cache";
    }

    @RequiresPermissions("monitor:cache:view")
    @PostMapping("/getNames")
    public String getCacheNames(String fragment, ModelMap modelMap) {
        modelMap.put("cacheNames", cacheService.getCacheNames());
        return "monitor/cache/cache::" + fragment;
    }

    @RequiresPermissions("monitor:cache:view")
    @PostMapping("/getKeys")
    public String getCacheKeys(String fragment, String cacheName, ModelMap modelMap) {
        modelMap.put("cacheName", cacheName);
        modelMap.put("cacheKeys", cacheService.getCacheKeys(cacheName));
        return "monitor/cache/cache::" + fragment;
    }

    @RequiresPermissions("monitor:cache:view")
    @PostMapping("/getValue")
    public String getCacheValue(String fragment, String cacheName, String cacheKey, ModelMap modelMap) {
        modelMap.put("cacheName", cacheName);
        modelMap.put("cacheKey", cacheKey);
        modelMap.put("cacheValue", cacheService.getCacheValue(cacheName, cacheKey));
        return "monitor/cache/cache::" + fragment;
    }

    @RequiresPermissions("monitor:cache:view")
    @PostMapping("/clearCacheName")
    @ResponseBody
    public AjaxResult clearCacheName(String cacheName, ModelMap modelMap) {
        cacheService.clearCacheName(cacheName);
        return AjaxResult.success();
    }

    @RequiresPermissions("monitor:cache:view")
    @PostMapping("/clearCacheKey")
    @ResponseBody
    public AjaxResult clearCacheKey(String cacheName, String cacheKey, ModelMap modelMap) {
        cacheService.clearCacheKey(cacheName, cacheKey);
        return AjaxResult.success();
    }

    @RequiresPermissions("monitor:cache:view")
    @GetMapping("/clearAll")
    @ResponseBody
    public AjaxResult clearAll(ModelMap modelMap) {
        cacheService.clearAll();
        return AjaxResult.success();
    }
}
