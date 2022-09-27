package top.reed.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import top.reed.core.model.AutoFunction;
import top.reed.core.service.FunctionService;

@RestController
@RequestMapping("/function")
public class FunctionController {

    @Autowired
    private FunctionService functionService;

    @RequestMapping("/list")
    public IPage<AutoFunction> list(@RequestParam(name = "page",defaultValue = "1")Integer page, @RequestParam(name = "limit",defaultValue = "1")Integer size, String name) {
        QueryWrapper<AutoFunction> select = new QueryWrapper<AutoFunction>().select("id", "name", "parameter", "create_date");
        if(StringUtils.isNotBlank(name)){
            select.like("name",name);
        }
        select.orderByDesc("create_date");
        return functionService.page(new Page<AutoFunction>(page, size), select);
    }

    @RequestMapping("/save")
    public String save(AutoFunction autoFunction){
        return functionService.saveFunction(autoFunction);
    }

    @RequestMapping("/get")
    public AutoFunction get(String id){
        return functionService.getById(id);
    }

    @RequestMapping("/remove")
    public void remove(String id){
        functionService.removeById(id);
    }
}
