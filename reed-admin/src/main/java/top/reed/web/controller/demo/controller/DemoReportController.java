package top.reed.web.controller.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 报表
 *
 * @author reedsource
 */
@Controller
@RequestMapping("/demo/report")
public class DemoReportController {
    private String prefix = "demo/report" ;

    /**
     * 百度ECharts
     */
    @GetMapping("/echarts")
    public String echarts() {
        return "demo/report/echarts" ;
    }

    /**
     * 图表插件
     */
    @GetMapping("/peity")
    public String peity() {
        return "demo/report/peity" ;
    }

    /**
     * 线状图插件
     */
    @GetMapping("/sparkline")
    public String sparkline() {
        return "demo/report/sparkline" ;
    }

    /**
     * 图表组合
     */
    @GetMapping("/metrics")
    public String metrics() {
        return "demo/report/metrics" ;
    }
}
