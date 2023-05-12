package top.reed.web.controller.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 模态窗口
 *
 * @author reedsource
 */
@Controller
@RequestMapping("/demo/modal")
public class DemoDialogController {

    /**
     * 模态窗口
     */
    @GetMapping("/dialog")
    public String dialog() {
        return "demo/modal/dialog" ;
    }

    /**
     * 弹层组件
     */
    @GetMapping("/layer")
    public String layer() {
        return "demo/modal/layer" ;
    }

    /**
     * 表单
     */
    @GetMapping("/form")
    public String form() {
        return "demo/modal/form" ;
    }

    /**
     * 表格
     */
    @GetMapping("/table")
    public String table() {
        return "demo/modal/table" ;
    }

    /**
     * 表格check
     */
    @GetMapping("/check")
    public String check() {
        return "demo/modal/table/check" ;
    }

    /**
     * 表格radio
     */
    @GetMapping("/radio")
    public String radio() {
        return "demo/modal/table/radio" ;
    }

    /**
     * 表格回传父窗体
     */
    @GetMapping("/parent")
    public String parent() {
        return "demo/modal/table/parent" ;
    }

    /**
     * 多层窗口frame1
     */
    @GetMapping("/frame1")
    public String frame1() {
        return "demo/modal/table/frame1" ;
    }

    /**
     * 多层窗口frame2
     */
    @GetMapping("/frame2")
    public String frame2() {
        return "demo/modal/table/frame2" ;
    }
}
