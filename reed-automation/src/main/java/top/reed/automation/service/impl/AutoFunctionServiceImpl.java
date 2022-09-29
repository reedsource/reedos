package top.reed.automation.service.impl;

import org.springframework.stereotype.Service;
import top.reed.automation.domain.AutoFunction;
import top.reed.automation.mapper.AutoFunctionMapper;
import top.reed.automation.service.AutoFunctionService;
import top.reed.common.core.text.Convert;
import top.reed.core.script.ScriptManager;

import javax.annotation.PostConstruct;
import javax.script.ScriptEngine;
import java.util.List;

/**
 * 自定义函数Service业务层处理
 *
 * @author reedsource
 * date 2022-09-29
 */
@Service
public class AutoFunctionServiceImpl implements AutoFunctionService {

	private final AutoFunctionMapper autoFunctionMapper;

	public AutoFunctionServiceImpl(AutoFunctionMapper autoFunctionMapper) {
		this.autoFunctionMapper = autoFunctionMapper;
	}


	/**
	 * 启动时初始化/重置自定义函数
	 * <p>
	 * 注册自定义函数
	 */
	@PostConstruct
	private void autoFunctionInit() {
		try {
			ScriptManager.lock();
			ScriptManager.clearFunctions();
			ScriptEngine engine = ScriptManager.createEngine();
			//读取全部已有自定义函数,逐一注册
			List<AutoFunction> list = selectAutoFunctionList(new AutoFunction());
			for (AutoFunction autoFunction : list) {
				ScriptManager.registerFunction(engine, autoFunction.getName(), autoFunction.getParameter(), autoFunction.getScript());
			}
			ScriptManager.setScriptEngine(engine);
		} finally {
			ScriptManager.unlock();
		}
	}


	/**
	 * 查询自定义函数
	 *
	 * @param id 自定义函数主键
	 * @return 自定义函数
	 */
	@Override
	public AutoFunction selectAutoFunctionById(Long id) {
		return autoFunctionMapper.selectAutoFunctionById(id);
	}

	/**
	 * 查询自定义函数列表
	 *
	 * @param autoFunction 自定义函数
	 * @return 自定义函数
	 */
	@Override
	public List<AutoFunction> selectAutoFunctionList(AutoFunction autoFunction) {
		return autoFunctionMapper.selectAutoFunctionList(autoFunction);
	}

	/**
	 * 新增自定义函数
	 *
	 * @param autoFunction 自定义函数
	 * @return 结果
	 */
	@Override
	public int insertAutoFunction(AutoFunction autoFunction) {
		try {
			//校验新添加的脚本是否符合规则
			ScriptManager.validScript(autoFunction.getName(), autoFunction.getParameter(), autoFunction.getScript());
			//重置自定义函数
			autoFunctionInit();
			return autoFunctionMapper.insertAutoFunction(autoFunction);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 修改自定义函数
	 *
	 * @param autoFunction 自定义函数
	 * @return 结果
	 */
	@Override
	public int updateAutoFunction(AutoFunction autoFunction) {
		try {
			//校验新添加的脚本是否符合规则
			ScriptManager.validScript(autoFunction.getName(), autoFunction.getParameter(), autoFunction.getScript());
			//重置自定义函数
			autoFunctionInit();
			return autoFunctionMapper.updateAutoFunction(autoFunction);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * 批量删除自定义函数
	 *
	 * @param ids 需要删除的自定义函数主键
	 * @return 结果
	 */
	@Override
	public int deleteAutoFunctionByIds(String ids) {
		int a = autoFunctionMapper.deleteAutoFunctionByIds(Convert.toStrArray(ids));
		//重置自定义函数
		autoFunctionInit();
		return a;
	}

	/**
	 * 删除自定义函数信息
	 *
	 * @param id 自定义函数主键
	 * @return 结果
	 */
	@Override
	public int deleteAutoFunctionById(Long id) {
		int a = autoFunctionMapper.deleteAutoFunctionById(id);
		//重置自定义函数
		autoFunctionInit();
		return a;
	}
}
