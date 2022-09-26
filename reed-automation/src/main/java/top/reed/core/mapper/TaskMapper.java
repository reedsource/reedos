package top.reed.core.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import top.reed.core.model.Task;

@Mapper
public interface TaskMapper extends BaseMapper<Task> {
}
