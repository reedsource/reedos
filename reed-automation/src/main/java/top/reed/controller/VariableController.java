package top.reed.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import top.reed.api.common.CURDController;
import top.reed.core.mapper.VariableMapper;
import top.reed.core.model.Variable;
import top.reed.core.service.VariableService;

@RestController
@RequestMapping("/variable")
public class VariableController extends CURDController<VariableService, VariableMapper, Variable> {
}
