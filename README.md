<p style="text-align: center;">
	<img alt="logo" style="width:100px;height:100px;" src="reed-admin/src/main/resources/static/favicon.ico">
</p>
<h1 style="text-align: center;" >ReedOS v0.0.1</h1>
<h4 style="text-align: center;">敬未来 一切皆有可能</h4>

## 一 系统说明

不知不觉，已经写了很久的代码了。代码，是一个可以拥有无限可能的东西，那么，这一次的代码，为自己而写。

## 二 功能模块

功能模块分类以实际代码归属模块为准

- reed-admin 后台管理部分 项目网页web集中管理
    - 系统监控:
        - 数据监控：连接池监视，监视当前系统数据库连接池状态，可进行分析SQL找出系统性能瓶颈。
        - 服务监控：监视当前系统服务器CPU、内存、磁盘、堆栈等相关信息。
        - 缓存监控：对系统的缓存查询，删除、清空等操作。
            - 缓存使用 shiro.cache.ehcache
    - 系统工具:
        - 系统接口：根据业务代码自动生成相关的api接口文档。
            - Swagger3
    - web框架
        - aj-captcha实现滑块验证码
    - 博客ui管理
- reed-cms 信息管理模块 展现信息后端管理
    - 主要用于对外展示内容的后端管理
        - 个人博客:个人博客后端
- reed-common common通用工具
    - mybatis-plus
- reed-core 核心模块 信息获取及处理,智能核心
    - 定时任务：在线（添加、修改、删除)任务调度包含执行结果日志
    - 自动化任务: 以流程图的形式,构建自动化任务
        - 自定义函数: 自构建自动化任务可用的函数
        - 数据源管理: 自动化过程中的数据库连接
- reed-framework framework框架核心-系统框架相关配置
    - 集成依赖关系注入、事件、资源、i18n、验证、数据绑定、类型转换、SpEL、AOP
    - websocket
- reed-generator generator代码生成
    - 代码生成：前后端代码的生成（java、html、xml、sql）支持CRUD下载。
        - 代码生成模版文件
        - 代码生成默认配置
    - 表单构建: 在线构建器，拖动表单元素生成相应的HTML代码。
- reed-system system系统模块
    - 用户管理：用户是系统操作者，该功能主要完成系统用户配置。
    - 用户监控:
        - 在线用户：当前系统中活跃用户状态监控。
    - 角色管理：角色菜单权限分配、设置角色按机构进行数据范围权限划分。
    - 菜单管理：配置系统菜单，操作权限，按钮权限标识等。
    - 部门管理：配置系统组织机构（公司、部门、小组），树结构展现支持数据权限。
    - 岗位管理：配置系统用户所属担任职务。
    - 字典管理：对系统中经常使用的一些较为固定的数据进行维护。
    - 参数管理：对系统动态配置常用参数。
    - 通知公告：系统通知公告信息发布维护。
    - 日志管理:
        - 操作日志：系统正常操作日志记录和查询；系统异常信息日志记录和查询。
        - 登录日志：系统登录日志记录查询包含登录异常。


## 三 代码要求

1. 自写代码除必须情况,在保证安全的情况下sonar扫描规范
2. 注释比例不得低于代码数量30%,以任何时间查看可第一时间理解为目标
3. 项目以功能实现以及可维护为主，必须保证代码的可理解，可维护性
4. 对所有新提交代码完全掌握
5. 全局使用UTF-8, 支持中文命名

## 四 版本管理方案

1. master为规则设定,以及终版分支
2. master分支只接收规则设定提交和版本分支合并
3. 版本以功能实现为阶段划分
4. 提交描述规则
    - 定义 项目规则定义变更
    - 立项 新的知识模块第一次构建提交
    - 添加 模块下新的信息进行提交
    - 更新 原模块内容添加更新
    - 修复 功能bug修复
    - 删除 原模块文件删除
    - 安全更新 对项目漏洞的修复性更新
    - 重要更新 对原有模块重大重构或技术更新
      案例 更新 模块 描述更新问题点

## 五 功能实现及目标日志
- 20221021 在完成了一系列功能后有些迷茫, 翻了一下gitee上面的开源项目, 看了最新项目使用的技术, 大多使用了前后端分离模式,vue技术等。莫名有些躁动，是否ReedOS也也应该尝试新的流行趋势。
  - 我想到了开始这个项目的原因，为自己而写,做自己想做的事,做自己的助手,朋友,辅助
  - 长期稳定可维护是第一要求,而维护的时间是长久的,我需要在10年,20年当我老去的时候,项目依然可以维护,很多很多新的技术是有寿命的。
  - 对于项目引入的包及相关技术,有效,精简,稳定是目标,ReedOS不是技术的试验地。
- 20221021
  - [20221021完成]完善的后台管理模块
  - [20221021完成]完善的可用爬虫模块
  - [20230330完成]完善的博客cms模块
  - [20230330完成]可用的websocket网页通信模块
- 待完成
  - []socket跨平台通信模块
  - []族谱管理模块

## 六 环境部署

- 环境要求
    - jdk17
    - apache-maven-3.8.6

## 七 特别感谢

RuoYi权限管理系统[https://gitee.com/y_project/RuoYi]