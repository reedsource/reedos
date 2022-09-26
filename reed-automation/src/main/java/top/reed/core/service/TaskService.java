package top.reed.core.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.reed.core.mapper.TaskMapper;
import top.reed.core.model.Task;

@Service
public class TaskService extends ServiceImpl<TaskMapper, Task> {

}
