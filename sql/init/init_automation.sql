-- 切换到数据库
USE reedos;

-- 一级菜单
insert into sys_menu values('5', '自动化管理', '0', '5', '#', '', 'M', '0', '1', '', 'fa fa-refresh', 'admin', sysdate(), '', null, '自动化工具目录');
-- 二级菜单
insert into sys_menu values('110',  '定时任务', '5', '1', '/quartz/job', '', 'C', '0', '1', 'quartz:job:view', 'fa fa-tasks', 'admin', sysdate(), '', null, '定时任务菜单');
-- 三级菜单
INSERT INTO sys_menu VALUES (200, '自动化任务', 5, 2, '/automation/autoflow', '', 'C', '0', '1', 'automation:autoflow:view', '#', 'admin', sysdate(), '', null, '自动化任务菜单');
INSERT INTO sys_menu VALUES (201, '自定义函数', 5, 3, '/automation/autofunction', '', 'C', '0', '1', 'automation:autofunction:view', '#', 'admin', sysdate(), '', null, '自定义函数菜单');
INSERT INTO sys_menu VALUES (202, '自动化数据源', 5, 4, '/automation/autodatasource', '', 'C', '0', '1', 'automation:autodatasource:view', '#', 'admin', sysdate(), '', null, '自动化数据源菜单');
INSERT INTO sys_menu VALUES (203, 'WebSocket', 5, 4, '/automation/notice', '', 'C', '0', '1', '', '#', 'admin', sysdate(), '', null, 'WebSocket');
-- 定时任务按钮
insert into sys_menu values('1050', '任务查询', '110', '1',  '#', '',  'F', '0', '1', 'quartz:job:list',                '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1051', '任务新增', '110', '2',  '#', '',  'F', '0', '1', 'quartz:job:add',                 '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1052', '任务修改', '110', '3',  '#', '',  'F', '0', '1', 'quartz:job:edit',                '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1053', '任务删除', '110', '4',  '#', '',  'F', '0', '1', 'quartz:job:remove',              '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1054', '状态修改', '110', '5',  '#', '',  'F', '0', '1', 'quartz:job:changeStatus',        '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1055', '任务详细', '110', '6',  '#', '',  'F', '0', '1', 'quartz:job:detail',              '#', 'admin', sysdate(), '', null, '');
insert into sys_menu values('1056', '任务导出', '110', '7',  '#', '',  'F', '0', '1', 'quartz:job:export',              '#', 'admin', sysdate(), '', null, '');
-- 自动化任务按钮
INSERT INTO sys_menu VALUES (2001, '自动化任务查询', 200, 1, '#', '', 'F', '0', '1', 'automation:autoflow:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2002, '自动化任务新增', 200, 2, '#', '', 'F', '0', '1', 'automation:autoflow:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2003, '自动化任务修改', 200, 3, '#', '', 'F', '0', '1', 'automation:autoflow:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2004, '自动化任务删除', 200, 4, '#', '', 'F', '0', '1', 'automation:autoflow:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2005, '自动化任务导出', 200, 5, '#', '', 'F', '0', '1', 'automation:autoflow:export', '#', 'admin', sysdate(), '', null, '');
-- 自动化自定义函数按钮
INSERT INTO sys_menu VALUES (2011, '自定义函数查询', 201, 1, '#', '', 'F', '0', '1', 'automation:autofunction:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2012, '自定义函数新增', 201, 2, '#', '', 'F', '0', '1', 'automation:autofunction:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2013, '自定义函数修改', 201, 3, '#', '', 'F', '0', '1', 'automation:autofunction:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2014, '自定义函数删除', 201, 4, '#', '', 'F', '0', '1', 'automation:autofunction:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu VALUES (2015, '自定义函数导出', 201, 5, '#', '', 'F', '0', '1', 'automation:autofunction:export', '#', 'admin', sysdate(), '', null, '');
-- 自动化数据源按钮
INSERT INTO sys_menu  VALUES (2021, '自动化数据源查询', 202, 1, '#', '', 'F', '0', '1', 'automation:autodatasource:list', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu  VALUES (2022, '自动化数据源新增', 202, 2, '#', '', 'F', '0', '1', 'automation:autodatasource:add', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu  VALUES (2023, '自动化数据源修改', 202, 3, '#', '', 'F', '0', '1', 'automation:autodatasource:edit', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu  VALUES (2024, '自动化数据源删除', 202, 4, '#', '', 'F', '0', '1', 'automation:autodatasource:remove', '#', 'admin', sysdate(), '', null, '');
INSERT INTO sys_menu  VALUES (2025, '自动化数据源导出', 202, 5, '#', '', 'F', '0', '1', 'automation:autodatasource:export', '#', 'admin', sysdate(), '', null, '');

-- 数据字典
insert into sys_dict_type values (9,  '任务状态',    'auto_job_status',             '0', 'admin', sysdate(), '', null, '任务状态列表');
insert into sys_dict_type values (10, '任务分组',    'auto_job_group',              '0', 'admin', sysdate(), '', null, '任务分组列表');
INSERT INTO sys_dict_type VALUES (11, '数据源驱动',   'auto_datasource_driver',     '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_type VALUES (12, '任务类型',    'auto_job_type',               '0', 'admin', sysdate(), '', null, '定时任务类型');
-- 字典数据表
insert into sys_dict_data values (26,  1,  '正常',          '0',                         'auto_job_status',           '',   'primary', 'Y', '0', 'admin', sysdate(), '', null, '正常状态');
insert into sys_dict_data values (27,  2,  '暂停',          '1',                         'auto_job_status',           '',   'danger',  'N', '0', 'admin', sysdate(), '', null, '停用状态');
insert into sys_dict_data values (28,  1,  '默认',          'DEFAULT',                   'auto_job_group',            '',   '',        'Y', '0', 'admin', sysdate(), '', null, '默认分组');
insert into sys_dict_data values (29,  2,  '系统',          'SYSTEM',                    'auto_job_group',            '',   '',        'N', '0', 'admin', sysdate(), '', null, '系统分组');
INSERT INTO sys_dict_data VALUES (30,  1,  'mysql',        'com.mysql.cj.jdbc.Driver',  'auto_datasource_driver',    null, null,      'Y', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (31,  1,  '自动化任务',     '0',                         'auto_job_type',             null, null,      'Y', '0', 'admin', sysdate(), '', null, null);
INSERT INTO sys_dict_data VALUES (32,  2,  '已注册类方法调用','1',                         'auto_job_type',             null, null,      'Y', '0', 'admin', sysdate(), '', null, null);

-- ----------------------------
-- 1、自动化任务表
-- ----------------------------
DROP TABLE IF EXISTS auto_flow;
create table auto_flow (
    id                bigint(20)                         not null auto_increment comment 'ID',
    name              varchar(64)                        null comment '任务名字',
    xml               longtext                           null comment 'xml表达式',
    status            char     default '0'               null comment '任务状态（0正常 1停用）',
    create_date       datetime default CURRENT_TIMESTAMP null comment '创建时间',
    primary key (id)
) comment '自动化任务表';

INSERT INTO auto_flow VALUES ('1', '爬取码云GVP', '<mxGraphModel>\n  <root>\n    <mxCell id=\"0\">\n      <JsonProperty as=\"data\">\n        {&quot;spiderName&quot;:&quot;爬取码云GVP&quot;,&quot;threadCount&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"1\" parent=\"0\"/>\n    <mxCell id=\"2\" value=\"开始\" style=\"start\" parent=\"1\" vertex=\"1\">\n      <mxGeometry x=\"80\" y=\"80\" width=\"24\" height=\"24\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;shape&quot;:&quot;start&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"5\" value=\"抓取首页\" style=\"request\" parent=\"1\" vertex=\"1\">\n      <mxGeometry x=\"180\" y=\"80\" width=\"24\" height=\"24\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;抓取首页&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;https://gitee.com/gvp/all&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:[&quot;&quot;],&quot;follow-redirect&quot;:&quot;1&quot;,&quot;shape&quot;:&quot;request&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"6\" value=\"\" parent=\"1\" source=\"2\" target=\"5\" edge=\"1\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"7\" value=\"提取项目名、地址\" style=\"variable\" parent=\"1\" vertex=\"1\">\n      <mxGeometry x=\"330\" y=\"80\" width=\"24\" height=\"24\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;提取项目名、地址&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;projectUrls&quot;,&quot;projectNames&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${extract.selectors(resp.html,&#39;.categorical-project-card a&#39;,&#39;attr&#39;,&#39;href&#39;)}&quot;,&quot;${extract.selectors(resp.html,&#39;.project-name&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"8\" value=\"\" parent=\"1\" source=\"5\" target=\"7\" edge=\"1\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"9\" value=\"抓取详情页\" style=\"request\" parent=\"1\" vertex=\"1\">\n      <mxGeometry x=\"450.16668701171875\" y=\"80\" width=\"24\" height=\"24\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;抓取详情页&quot;,&quot;loopVariableName&quot;:&quot;projectIndex&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;10&quot;,&quot;url&quot;:&quot;https://gitee.com/${projectUrls[projectIndex]}&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:[&quot;&quot;],&quot;follow-redirect&quot;:&quot;1&quot;,&quot;shape&quot;:&quot;request&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"10\" value=\"\" parent=\"1\" source=\"7\" target=\"9\" edge=\"1\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"12\" value=\"提取项目描述\" style=\"variable\" parent=\"1\" vertex=\"1\">\n      <mxGeometry x=\"550\" y=\"80\" width=\"24\" height=\"24\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;提取项目描述&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;projectDesc&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${extract.selector(resp.html,&#39;.git-project-desc-text&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"13\" value=\"\" parent=\"1\" source=\"9\" target=\"12\" edge=\"1\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"14\" value=\"输出\" style=\"output\" parent=\"1\" vertex=\"1\">\n      <mxGeometry x=\"660.1666870117188\" y=\"80\" width=\"24\" height=\"24\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;输出&quot;,&quot;output-name&quot;:[&quot;项目名&quot;,&quot;项目地址&quot;,&quot;项目描述&quot;],&quot;output-value&quot;:[&quot;${projectNames[projectIndex]}&quot;,&quot;https://gitee.com${projectUrls[projectIndex]}&quot;,&quot;${projectDesc}&quot;],&quot;shape&quot;:&quot;output&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"15\" value=\"\" parent=\"1\" source=\"12\" target=\"14\" edge=\"1\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n  </root>\n</mxGraphModel>\n', '0', '2019-08-22 13:46:54');
INSERT INTO auto_flow VALUES ('2', '抓取每日菜价', '<mxGraphModel>\n  <root>\n    <mxCell id=\"0\">\n      <JsonProperty as=\"data\">\n        {&quot;spiderName&quot;:&quot;抓取每日菜价&quot;,&quot;threadCount&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"1\" parent=\"0\"/>\n    <mxCell id=\"2\" value=\"开始\" style=\"start\" parent=\"1\" vertex=\"1\">\n      <mxGeometry x=\"80\" y=\"80\" width=\"24\" height=\"24\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;shape&quot;:&quot;start&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"3\" value=\"开始抓取\" style=\"request\" parent=\"1\" vertex=\"1\">\n      <mxGeometry x=\"219.83334350585938\" y=\"80\" width=\"24\" height=\"24\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;http://www.beijingprice.cn:8086/price/priceToday/PageLoad/LoadPrice?jsoncallback=1&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:[&quot;&quot;],&quot;follow-redirect&quot;:&quot;1&quot;,&quot;shape&quot;:&quot;request&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"4\" value=\"\" parent=\"1\" source=\"2\" target=\"3\" edge=\"1\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"5\" value=\"解析JSON\" style=\"variable\" parent=\"1\" vertex=\"1\">\n      <mxGeometry x=\"350\" y=\"80\" width=\"24\" height=\"24\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;解析JSON&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;jsonstr&quot;,&quot;jsondata&quot;,&quot;data&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${string.substring(resp.html,2,resp.html.length()-1)}&quot;,&quot;${json.parse(jsonstr)}&quot;,&quot;${extract.jsonpath(jsondata[0],&#39;data&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"6\" value=\"\" parent=\"1\" source=\"3\" target=\"5\" edge=\"1\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"7\" value=\"输出\" style=\"output\" parent=\"1\" vertex=\"1\">\n      <mxGeometry x=\"480.16668701171875\" y=\"80\" width=\"24\" height=\"24\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;i&quot;,&quot;output-name&quot;:[&quot;菜名&quot;,&quot;菜价&quot;,&quot;单位&quot;],&quot;loopCount&quot;:&quot;${list.length(data)}&quot;,&quot;output-value&quot;:[&quot;${data[i].ItemName}&quot;,&quot;${data[i].Price04}&quot;,&quot;${data[i].ItemUnit}&quot;],&quot;shape&quot;:&quot;output&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"8\" value=\"\" parent=\"1\" source=\"5\" target=\"7\" edge=\"1\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n  </root>\n</mxGraphModel>\n', '0', '2019-08-22 13:48:22');
INSERT INTO auto_flow VALUES ('3', '爬取开源中国动弹', '<mxGraphModel>\n  <root>\n    <mxCell id=\"0\">\n      <JsonProperty as=\"data\">\n        {&quot;spiderName&quot;:&quot;爬取开源中国动弹&quot;,&quot;threadCount&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"1\" parent=\"0\"/>\n    <mxCell id=\"2\" value=\"开始\" style=\"start\" vertex=\"1\" parent=\"1\">\n      <mxGeometry x=\"80\" y=\"80\" width=\"32\" height=\"32\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;shape&quot;:&quot;start&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"3\" value=\"爬取动弹\" style=\"request\" vertex=\"1\" parent=\"1\">\n      <mxGeometry x=\"220\" y=\"80\" width=\"32\" height=\"32\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;爬取动弹&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;parameter-name&quot;:[&quot;type&quot;,&quot;lastLogId&quot;],&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;https://www.oschina.net/tweets/widgets/_tweet_index_list &quot;,&quot;proxy&quot;:&quot;&quot;,&quot;parameter-value&quot;:[&quot;ajax&quot;,&quot;${lastLogId}&quot;],&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;shape&quot;:&quot;request&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"4\" value=\"\" edge=\"1\" parent=\"1\" source=\"2\" target=\"3\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"5\" value=\"提取lastLogId以及tweets\" style=\"variable\" vertex=\"1\" parent=\"1\">\n      <mxGeometry x=\"340\" y=\"80\" width=\"32\" height=\"32\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;提取lastLogId以及tweets&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;lastLogId&quot;,&quot;tweets&quot;,&quot;fetchCount&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.selector(&#39;.tweet-item:last-child&#39;).attr(&#39;data-tweet-id&#39;)}&quot;,&quot;${resp.selectors(&#39;.tweet-item[data-tweet-id]&#39;)}&quot;,&quot;${fetchCount == null ? 0 : fetchCount + 1}&quot;],&quot;shape&quot;:&quot;variable&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"6\" value=\"\" edge=\"1\" parent=\"1\" source=\"3\" target=\"5\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"7\" value=\"循环\" style=\"loop\" vertex=\"1\" parent=\"1\">\n      <mxGeometry x=\"340\" y=\"250\" width=\"32\" height=\"32\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;循环&quot;,&quot;loopVariableName&quot;:&quot;index&quot;,&quot;loopCount&quot;:&quot;${list.length(tweets)}&quot;,&quot;shape&quot;:&quot;loop&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"8\" value=\"\" edge=\"1\" parent=\"1\" source=\"5\" target=\"7\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"9\" value=\"提取详细信息\" style=\"variable\" vertex=\"1\" parent=\"1\">\n      <mxGeometry x=\"340\" y=\"340\" width=\"32\" height=\"32\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;提取详细信息&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;content&quot;,&quot;author&quot;,&quot;like&quot;,&quot;reply&quot;,&quot;publishTime&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${tweets[index].selector(&#39;.text&#39;).text()}&quot;,&quot;${tweets[index].selector(&#39;.user&#39;).text()}&quot;,&quot;${tweets[index].selector(&#39;.like span&#39;).text()}&quot;,&quot;${tweets[index].selector(&#39;.reply span&#39;).text()}&quot;,&quot;${tweets[index].selector(&#39;.date&#39;).regx(&#39;(.*?)&amp;nbsp&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"10\" value=\"\" edge=\"1\" parent=\"1\" source=\"7\" target=\"9\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"11\" value=\"输出\" style=\"output\" vertex=\"1\" parent=\"1\">\n      <mxGeometry x=\"340\" y=\"430\" width=\"32\" height=\"32\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;output-name&quot;:[&quot;作者&quot;,&quot;内容&quot;,&quot;点赞数&quot;,&quot;评论数&quot;,&quot;发布时间&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;output-value&quot;:[&quot;${author}&quot;,&quot;${content}&quot;,&quot;${like}&quot;,&quot;${reply}&quot;,&quot;${publishTime}&quot;],&quot;shape&quot;:&quot;output&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"12\" value=\"\" edge=\"1\" parent=\"1\" source=\"9\" target=\"11\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"13\" value=\"爬取3页\" edge=\"1\" parent=\"1\" source=\"5\" target=\"3\">\n      <mxGeometry x=\"-0.0312\" y=\"-20\" relative=\"1\" as=\"geometry\">\n        <Array as=\"points\">\n          <mxPoint x=\"356\" y=\"180\"/>\n          <mxPoint x=\"236\" y=\"180\"/>\n        </Array>\n        <mxPoint as=\"offset\"/>\n      </mxGeometry>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;爬取5页&quot;,&quot;condition&quot;:&quot;${fetchCount &lt; 3}&quot;}\n      </JsonProperty>\n    </mxCell>\n  </root>\n</mxGraphModel>\n',  '0', '2019-11-03 17:02:49');
INSERT INTO auto_flow VALUES ('4', '百度热点', '<mxGraphModel>\n  <root>\n    <mxCell id=\"0\">\n      <JsonProperty as=\"data\">\n        {&quot;spiderName&quot;:&quot;百度热点&quot;,&quot;threadCount&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"1\" parent=\"0\"/>\n    <mxCell id=\"2\" value=\"开始\" style=\"start\" parent=\"1\" vertex=\"1\">\n      <mxGeometry x=\"80\" y=\"80\" width=\"32\" height=\"32\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;shape&quot;:&quot;start&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"3\" value=\"开始抓取\" style=\"request\" parent=\"1\" vertex=\"1\">\n      <mxGeometry x=\"220\" y=\"80\" width=\"32\" height=\"32\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;开始抓取&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;sleep&quot;:&quot;&quot;,&quot;timeout&quot;:&quot;&quot;,&quot;response-charset&quot;:&quot;gbk&quot;,&quot;method&quot;:&quot;GET&quot;,&quot;body-type&quot;:&quot;none&quot;,&quot;body-content-type&quot;:&quot;text/plain&quot;,&quot;loopCount&quot;:&quot;&quot;,&quot;url&quot;:&quot;https://top.baidu.com/buzz?b=1&amp;fr=topindex&quot;,&quot;proxy&quot;:&quot;&quot;,&quot;request-body&quot;:&quot;&quot;,&quot;follow-redirect&quot;:&quot;1&quot;,&quot;tls-validate&quot;:&quot;1&quot;,&quot;shape&quot;:&quot;request&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"4\" value=\"定义变量\" style=\"variable\" parent=\"1\" vertex=\"1\">\n      <mxGeometry x=\"360\" y=\"80\" width=\"32\" height=\"32\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;定义变量&quot;,&quot;loopVariableName&quot;:&quot;&quot;,&quot;variable-name&quot;:[&quot;elementbd&quot;],&quot;loopCount&quot;:&quot;&quot;,&quot;variable-value&quot;:[&quot;${resp.xpaths(&#39;//*[@id=\\&quot;main\\&quot;]/div[2]/div/table/tbody/tr&#39;)}&quot;],&quot;shape&quot;:&quot;variable&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"5\" value=\"输出\" style=\"output\" parent=\"1\" vertex=\"1\">\n      <mxGeometry x=\"480\" y=\"80\" width=\"32\" height=\"32\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;输出&quot;,&quot;loopVariableName&quot;:&quot;i&quot;,&quot;output-name&quot;:[&quot;名称&quot;,&quot;地址&quot;,&quot;百度指数&quot;,&quot;2&quot;],&quot;loopCount&quot;:&quot;${elementbd.size()-1}&quot;,&quot;output-value&quot;:[&quot;${elementbd[i+1].xpath(&#39;//td[2]/a[1]/text()&#39;)}&quot;,&quot;${elementbd[i+1].xpath(&#39;//td[2]/a[1]/@href&#39;)}&quot;,&quot;${elementbd[i+1].xpath(&#39;//td[4]/span/text()&#39;)}&quot;,&quot;${elementbd[i+1].xpath(&#39;//td[3]/a[2]/text()&#39;)}&quot;],&quot;shape&quot;:&quot;output&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"6\" value=\"\" parent=\"1\" source=\"2\" target=\"3\" edge=\"1\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"7\" value=\"\" parent=\"1\" source=\"3\" target=\"4\" edge=\"1\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n    <mxCell id=\"8\" value=\"\" parent=\"1\" source=\"4\" target=\"5\" edge=\"1\">\n      <mxGeometry relative=\"1\" as=\"geometry\"/>\n      <JsonProperty as=\"data\">\n        {&quot;value&quot;:&quot;&quot;,&quot;condition&quot;:&quot;&quot;}\n      </JsonProperty>\n    </mxCell>\n  </root>\n</mxGraphModel>\n',  '1', '2019-10-20 17:24:21');

-- ----------------------------
-- 2、自动化数据源表
-- ----------------------------
DROP TABLE IF EXISTS auto_datasource;
create table auto_datasource (
    id                bigint(20)                         not null auto_increment comment 'ID',
    name              varchar(255)                       null comment '数据源名称',
    driver_class_name varchar(255)                       null comment '驱动名称',
    jdbc_url          varchar(255)                       null comment '链接',
    username          varchar(64)                        null comment '账号',
    password          varchar(32)                        null comment '密码',
    create_date       datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    primary key (id)
) comment '自动化数据源表';

-- ----------------------------
-- 3、自动化自定义函数表
-- ----------------------------
DROP TABLE IF EXISTS auto_function;
create table auto_function (
    id          bigint(20)                         not null auto_increment comment 'ID',
    name        varchar(255)                       null comment '函数名',
    parameter   varchar(512)                       null comment '参数',
    script      text                               null comment 'js脚本',
    create_date datetime default CURRENT_TIMESTAMP null comment '创建时间',
    primary key (id)
) comment '自定义函数表';


-- ----------------------------
-- 4、定时任务调度表
-- ----------------------------
drop table if exists auto_job;
create table auto_job (
                         job_id              bigint(20)    not null auto_increment    comment '任务ID',
                         job_name            varchar(64)   default ''                 comment '任务名称',
                         job_group           varchar(64)   default 'DEFAULT'          comment '任务组名',
                         job_type            char(64)      default '0'                comment '任务类型 0自动化任务 1已注册类方法调用',
                         invoke_target       varchar(500)  not null                   comment '任务调用目标',
                         cron_expression     varchar(255)  default ''                 comment 'cron执行表达式',
                         misfire_policy      varchar(20)   default '3'                comment '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
                         concurrent          char(1)       default '1'                comment '是否并发执行（0允许 1禁止）',
                         status              char(1)       default '0'                comment '状态（0正常 1暂停）',
                         create_by           varchar(64)   default ''                 comment '创建者',
                         create_time         datetime                                 comment '创建时间',
                         update_by           varchar(64)   default ''                 comment '更新者',
                         update_time         datetime                                 comment '更新时间',
                         remark              varchar(500)  default ''                 comment '备注信息',
                         primary key (job_id, job_name, job_group)
) engine=innodb auto_increment=100 comment = '定时任务调度表';

insert into auto_job values(1, '系统默认（无参）', 'DEFAULT', '1', 'ryTask.ryNoParams',        '0/10 * * * * ?', '3', '1', '1', 'admin', sysdate(), '', null, '');
insert into auto_job values(2, '系统默认（有参）', 'DEFAULT', '1', 'ryTask.ryParams(\'ry\')',  '0/15 * * * * ?', '3', '1', '1', 'admin', sysdate(), '', null, '');
insert into auto_job values(3, '系统默认（多参）', 'DEFAULT', '1', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)',  '0/20 * * * * ?', '3', '1', '1', 'admin', sysdate(), '', null, '');


-- ----------------------------
-- 5、定时任务调度日志表
-- ----------------------------
drop table if exists auto_job_log;
create table auto_job_log (
                             job_log_id          bigint(20)     not null auto_increment    comment '任务日志ID',
                             job_name            varchar(64)    not null                   comment '任务名称',
                             job_group           varchar(64)    not null                   comment '任务组名',
                             job_type            char(64)      default '0'                 comment '任务类型 0自动化任务 1已注册类方法调用',
                             invoke_target       varchar(500)   not null                   comment '调用目标字符串',
                             job_message         varchar(500)                              comment '日志信息',
                             status              char(1)        default '0'                comment '执行状态（0正常 1失败）',
                             exception_info      varchar(2000)  default ''                 comment '异常信息',
                             create_time         datetime                                  comment '创建时间',
                             primary key (job_log_id)
) engine=innodb comment = '定时任务调度日志表';




create table wujia
(
    id   int auto_increment comment 'id' primary key,
    菜名 varchar(50)  null comment '名称',
    菜价 varchar(150) null comment '价格',
    单位 varchar(50)  null comment '单位'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT '菜价表';

INSERT INTO wujia
    (菜名, 单位, 菜价)
VALUES ('1', '2', '3');
