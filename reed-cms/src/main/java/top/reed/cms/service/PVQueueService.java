package top.reed.cms.service;

import cn.hutool.core.collection.CollectionUtil;
import com.google.common.collect.Queues;
import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import top.reed.cms.domain.Pv;
import top.reed.common.utils.IpUtils;
import top.reed.common.utils.http.UserAgent;

import javax.annotation.PreDestroy;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

@Component("pvQueueService")
public class PVQueueService implements InitializingBean {

    private static final Logger logger = LogManager.getLogger(PVQueueService.class);
    private static final BlockingQueue<Pv> blockingQueue = new ArrayBlockingQueue<>(1000000);
    //创建一个可重用固定线程数的线程池
    private final ExecutorService pool = Executors.newFixedThreadPool(1);
    @Autowired
    IPvService pvService;
    //线程活动
    private volatile boolean threadActivity = true;

    @Override
    public void afterPropertiesSet() {
        pool.execute(() -> {
            while (threadActivity) { //如果系统关闭，则不再运行
                try {
                    List<Pv> data = new ArrayList<>();
                    //每次到1000条数据才进行入库，或者等待1分钟，没达到100条也继续入库

                    //作为BlockingQueue.drainTo(Collection, int)排空队列，但如果请求的numElements元素不可用，它将等待它们直到指定的超时。
                    //参数：
                    //q - 要排空的阻塞队列
                    //buffer - 添加传输元素的位置
                    //numElements - 要等待的元素数
                    //timeout - 在放弃之前等待多长时间，以 unit 为unit
                    //unit - 确定如何解释超时参数的时间单位
                    //回报：
                    //转移的元素数量
                    //抛出：
                    //InterruptedException  - 如果在等待时被中断
                    Queues.drain(blockingQueue, data, 50, 1, TimeUnit.MINUTES);
                    if (CollectionUtil.isNotEmpty(data)) {
                        pvService.insertPvBatch(data);
                    }

                } catch (InterruptedException e) {
                    //    e.printStackTrace();
                    if (logger.isErrorEnabled()) {
                        logger.error("访问量消费队列错误", e);
                    }
                }
            }
        });
    }

    public void pushPvQueue(HttpServletRequest request, Pv pv) {

        pv.setIp(IpUtils.getIpAddr(request));
        if (StringUtils.isEmpty(pv.getReferer())) {
            pv.setReferer(request.getHeader("referer"));
        }
        //获取用户User-Agent并解析为userAgent对象
        UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
        // 获取客户端浏览器
        String browser = userAgent.getBrowser();
        pv.setBrowser(browser);
        String deviceType = userAgent.getOperatingSystem();
        ;//客户端操作系统
        pv.setDeviceType(deviceType);

        //add(anObject):添加元素到队列里，添加成功返回true，容量满了添加失败会抛出IllegalStateException异常
        //offer(anObject):表示如果可能的话,将anObject加到BlockingQueue里,即如果BlockingQueue可以容纳,则返回true,否则返回false.（本方法不阻塞当前执行方法的线程）
        //offer(E o, long timeout, TimeUnit unit),可以设定等待的时间，如果在指定的时间内，还不能往队列中加入BlockingQueue，则返回失败。
        //put(anObject):把anObject加到BlockingQueue里,如果BlockQueue没有空间,则调用此方法的线程被阻断直到BlockingQueue里面有空间再继续.
        blockingQueue.offer(pv);//添加一个元素并返回true 如果队列已满，则返回false
    }

    @PreDestroy
    public void destroy() {
        threadActivity = false;
        pool.shutdownNow();
    }
}
