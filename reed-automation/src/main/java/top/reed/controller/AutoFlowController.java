package top.reed.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import top.reed.api.Grammerable;
import top.reed.api.annotation.Comment;
import top.reed.api.executor.FunctionExecutor;
import top.reed.api.executor.FunctionExtension;
import top.reed.api.executor.PluginConfig;
import top.reed.api.model.Grammer;
import top.reed.api.model.JsonBean;
import top.reed.api.model.Plugin;
import top.reed.api.model.Shape;
import top.reed.automation.domain.AutoFlow;
import top.reed.automation.service.AutooFlowService;
import top.reed.core.service.AutoFlowService;
import top.reed.core.utils.ExecutorsUtils;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 自动化任务Controller
 * @author reedsource
 *
 */
@RestController
@RequestMapping("/spider")
public class AutoFlowController {
	
	@Autowired
	private List<FunctionExecutor> functionExecutors;
	
	@Autowired
	private List<FunctionExtension> functionExtensions;
	
	@Autowired
	private List<Grammerable> grammerables;
	
	@Autowired
	private AutoFlowService autoFlowService;
	
	@Autowired(required = false)
	private List<PluginConfig> pluginConfigs;

	@Autowired
	private AutooFlowService autooFlowService;
	
	@Value("${spider.workspace}")
	private String workspace;
	
	private final List<Grammer> grammers = new ArrayList<Grammer>();
	
	private static Logger logger = LoggerFactory.getLogger(AutoFlowController.class);
	
	@PostConstruct
	private void init(){
		for (FunctionExecutor executor : functionExecutors) {
			String function = executor.getFunctionPrefix();
			grammers.addAll(Grammer.findGrammers(executor.getClass(),function,function,true));
			Comment comment = executor.getClass().getAnnotation(Comment.class);
			Grammer grammer = new Grammer();
			if(comment!= null){
				grammer.setComment(comment.value());
			}
			grammer.setFunction(function);
			grammers.add(grammer);
		}
		
		for (FunctionExtension extension : functionExtensions) {
			String owner = extension.support().getSimpleName();
			grammers.addAll(Grammer.findGrammers(extension.getClass(),null,owner,true));
		}
		for (Grammerable grammerable : grammerables) {
			grammers.addAll(grammerable.grammers());
		}
	}
	
	/**
	 * 自动化任务列表
	 * @param page 页数
	 * @param size 每页显示条数
	 * @return Page<AutoFlow> 所有自动化任务的列表页
	 */
	@RequestMapping("/list")
	public IPage<AutoFlow> list(@RequestParam(name = "page", defaultValue = "1") Integer page, @RequestParam(name = "limit", defaultValue = "1") Integer size, @RequestParam(name = "name", defaultValue = "") String name) {
		return autoFlowService.selectSpiderPage(new Page<>(page, size), name);
	}
	
	@RequestMapping("/save")
	public String save(AutoFlow autoFlow){
		return String.valueOf(autooFlowService.saveAutoFlow(autoFlow));
	}

	@RequestMapping("/history")
	public JsonBean<?> history(String id,String timestamp){
		if(StringUtils.isNotBlank(timestamp)){
			return new JsonBean<>(autoFlowService.readHistory(id,timestamp));
		}else{
			return new JsonBean<>(autoFlowService.historyList(id));
		}
	}
	
	@RequestMapping("/get")
	public AutoFlow get(String id){
		return autoFlowService.getById(id);
	}
	
	@RequestMapping("/other")
	public List<AutoFlow> other(String id){
		if(StringUtils.isBlank(id)){
			return autoFlowService.selectFlows();
		}
		return autoFlowService.selectOtherFlows(id);
	}
	
	@RequestMapping("/remove")
	public void remove(String id){
		autoFlowService.remove(id);
	}

	@RequestMapping("/start")
	public void start(String id){
		autoFlowService.start(id);
	}

	@RequestMapping("/stop")
	public void stop(String id){
		autoFlowService.stop(id);
	}
	
	@RequestMapping("/run")
	public void run(String id){
		autoFlowService.run(id);
	}
	
	@RequestMapping("/xml")
	public String xml(String id){
		return autooFlowService.selectAutoFlowById(Long.valueOf(id)).getXml();
	}
	@RequestMapping("/shapes")
	public List<Shape> shapes(){
		return ExecutorsUtils.shapes();
	}
	
	@RequestMapping("/pluginConfigs")
	public List<Plugin> pluginConfigs(){
		return null == pluginConfigs ? Collections.emptyList() : pluginConfigs.stream().filter(e-> e.plugin() != null).map(plugin -> plugin.plugin()).collect(Collectors.toList());
	}
	
	@RequestMapping("/grammers")
	public JsonBean<List<Grammer>> grammers(){
		return new JsonBean<>(this.grammers);
	}

	@GetMapping("/recent5TriggerTime")
	public List<String> getRecent5TriggerTime(String cron){
		return autoFlowService.getRecentTriggerTime(cron,5);
	}
}
