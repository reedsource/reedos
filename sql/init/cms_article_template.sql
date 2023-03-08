drop table if exists reedos.cms_article_template;
create table reedos.cms_article_template
(
    id           int auto_increment comment 'ID'
        primary key,
    name         varchar(255) null comment '文章模板名称',
    tags         varchar(255) null comment '标签',
    user_id      varchar(50)  null comment '用户ID',
    user_name    varchar(50)  null comment '用户名称',
    content      text         null comment '内容',
    share_type   varchar(50)  null comment '共享类型',
    weight       int          null comment '权重',
    hot_falg     smallint     null comment '最热',
    new_flag     smallint     null comment '最新',
    create_time  datetime     null comment '创建时间',
    audit        smallint     null comment '审核标志',
    audit_time   datetime     null comment '审核时间',
    audit_by     varchar(50)  null comment '审核人',
    audit_name   varchar(50)  null comment '审核人名称',
    audit_reason varchar(255) null comment '原因'
);

INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (1, '1', '48', '1', 'ry', '<fieldset  style="font-family: sans-serif; border: 0px none;">
    <section style="margin:10px 0px;border-radius:4px;padding:50px 0px;color:#ffffff;text-align:center;border-color:#ff8124;background-color:#6b4d40;">
        <span  data-brushtype="text" style="border-radius:4px;border:1px solid #fbfbfb;color:inherit;font-size:18px;line-height:42px;padding:10px 15px;">微信+编辑器</span>
        <section  style="color:inherit;margin-top:30px;">
            <p style="color:inherit;">
                秒刷，最易用的图文排版工具
            </p>
            <p style="color:inherit;">
                <span style="font-family:微软雅黑;font-size:14px;line-height:22.3999996185303px;">http://www.wxyxpt.com</span>
            </p>
        </section>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:18:21', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (2, '2', '48', '1', 'markbro', '<fieldset  style="font-family: sans-serif; border: 0px none;">
    <fieldset style="border:0px;margin:5px 0px;box-sizing:border-box;padding:0px;">
        <section style="box-sizing:border-box;">
            <section style="height:16px;width:1.5em;float:left;border-top-width:0.4em;border-top-style:solid;border-color:#f96e57;border-left-width:0.4em;border-left-style:solid;box-sizing:border-box;"></section>
            <section style="height:16px;width:1.5em;float:right;border-top-width:0.4em;border-top-style:solid;border-color:#f96e57;border-right-width:0.4em;border-right-style:solid;box-sizing:border-box;"></section>
            <section style="display:inline-block;color:transparent;clear:both;box-sizing:border-box;"></section>
        </section>
        <section style="margin:-0.8em 0.1em -0.8em 0.2em;padding:0.8em;border:1px solid #f96e57;border-radius:0.3em;box-sizing:border-box;">
            <section placeholder="四角宽边框的样式"  style="color:#333333;font-size:1em;line-height:1.4;word-break:break-all;word-wrap:break-word;">
                四角宽边框的样式
            </section>
        </section>
        <section style="box-sizing:border-box;">
            <section style="height:16px;width:1.5em;float:left;border-bottom-width:0.4em;border-bottom-style:solid;border-color:#f96e57;border-left-width:0.4em;border-left-style:solid;box-sizing:border-box;"></section>
            <section style="height:16px;width:1.5em;float:right;border-bottom-width:0.4em;border-bottom-style:solid;border-color:#f96e57;border-right-width:0.4em;border-right-style:solid;box-sizing:border-box;"></section>
        </section>
    </fieldset>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (3, '3', '48,49', '1', 'markbro', '<fieldset style="font-family: sans-serif; border: 0px none;"><h2 style="margin:8px 0px 0px;padding:0px;font-size:16px;line-height:28px;max-width:100%;color:#0070c0;min-height:32px;border-bottom-width:2px;border-bottom-style:solid;border-bottom-color:#0070c0;text-align:justify;"><span class="autonum" placeholder="1" style="border-radius:80% 100% 90% 20%;color:#ffffff;display:block;float:left;line-height:20px;margin:0px 8px 0px 0px;max-width:100%;padding:4px 10px;word-wrap:break-word !important;background-color:#0070c0;">1</span><strong data-brushtype="text">第一标题sd</strong>
 &nbsp; &nbsp;</h2></fieldset><fieldset style="font-family: sans-serif; border: 0px none;"><blockquote style="border-width:1px 1px 1px 5px;border-style:solid;border-color:#eeeeee #eeeeee #eeeeee #9f887f;border-radius:3px;padding:10px;margin:10px 0px;"><h4 style="color:#9f887f;font-size:18px;margin:5px 0px;border-color:#9f887f;">标题文字</h4><section data-style="color:inherit;font-size:14px;" style="color:inherit;font-size:14px;line-height:20px;"><p>内容描述.</p></section></blockquote></fieldset>', 'public', 1, 0, 0, '2019-12-31 10:38:25', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (4, '4', '48,49', '1', 'markbro', '<fieldset style="font-family: sans-serif; border: 0px none;"><section style="color:inherit;padding:5px 10px 0px 35px;border-left-width:2px;border-left-style:dotted;border-left-color:#e4e4e4;margin-left:27px;"><section class="autonum" style="width:32px;height:32px;color:#cafbd7;text-align:center;line-height:32px;border-radius:16px;background:#0eb83a;margin-left:-53px;margin-top:23px;">1</section><section style="color:inherit;padding-bottom:10px;margin-top:-30px;"><p style="clear:both;line-height:1.5em;font-size:14px;color:inherit;"><span style="color:inherit;font-size:16px;"><strong class="135title" style="color:inherit;">如何进入【微信+编辑器】？</strong></span>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p><p style="clear:both;line-height:1.5em;font-size:14px;color:inherit;">网页搜索“微信+编辑器”，点击第一条搜索结果即可进入编辑器页面</p></section></section></fieldset>', 'public', 1, 0, 0, '2019-12-31 10:38:25', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (5, '5', '48,49', '1', 'markbro', '<fieldset style="font-family:sans-serif;border:0px none;"><fieldset style="margin:2em 1em 1em;padding:0px;border:0px #ffb3a7;border-image-source:none;max-width:100%;box-sizing:border-box;color:#3e3e3e;line-height:25px;word-wrap:break-word !important;"><section style="max-width:100%;box-sizing:border-box;line-height:1.4;word-wrap:break-word !important;margin-left:-0.5em;"><section style="max-width:100%;box-sizing:border-box;border-color:#000000;padding:3px 8px;border-radius:4px;color:#a71700;font-size:1em;display:inline-block;-webkit-transform:rotatez(-10deg);transform:rotate(-10deg);transform-origin:left center 0px;-webkit-transform-origin:0% 100% 0px;word-wrap:break-word !important;background-color:#ffb3a7;"><span data-brushtype="text" style="color:#ffffff;">微信+编辑器</span>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</section></section><section data-style="line-height:24px;color:rgb(89, 89, 89); font-size:14px" style="max-width:100%;box-sizing:border-box;padding:22px 16px 16px;border:1px solid #ffb3a7;color:#000000;font-size:14px;margin-top:-24px;"><p style="line-height:24px;"><span style="color:#595959;">微信+编辑器提供非常好用的微信图文编辑器。可以随心所欲的变换颜色调整格式，更有神奇的自动配色方案。</span>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p></section></fieldset></fieldset>', 'public', 1, 0, 0, '2019-12-31 10:38:25', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (6, '6', '48,49', '1', 'markbro', '<fieldset style="font-family:sans-serif;border:0px none;"><fieldset style="margin:0px;padding:5px;border:1px solid #cccccc;max-width:100%;color:#3e3e3e;line-height:24px;text-align:justify;box-shadow:#a5a5a5 5px 5px 2px;background-color:#fafafa;"><legend style="margin:0px 0px 0px 20px;padding:0px;text-align:left;width:auto;"><strong><strong style="color:#666666;line-height:20px;background-color:#fffff5;"><span data-brushtype="text" style="border-radius:0.5em 4em 3em 1em 0.5em 2em;box-shadow:#a5a5a5 4px 4px 2px;color:white;max-width:100%;padding:4px 10px;text-align:justify;background-color:red;">公告通知</span></strong></strong>
 &nbsp; &nbsp; &nbsp; &nbsp;</legend><section data-style="margin-top:2px; margin-bottom:0px; padding:0px; max-width:100%; min-height:1.5em; line-height:2em;font-weight:bold;"><p style="padding:0px;max-width:100%;min-height:1.5em;line-height:2em;margin-top:0px;margin-bottom:0px;">各位小伙伴们，微信图文美化编辑器正式上线了，欢迎大家多使用多提供反馈意见。使用<span style="color:inherit;"><strong>谷歌与火狐浏览器</strong></span>，可获得与手机端一致的显示效果。ie内核的低版本浏览器可能有不兼容的情况</p></section></fieldset></fieldset>', 'public', 1, 0, 0, '2019-12-31 10:38:25', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (7, '7', '48', '1', 'markbro', '

<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="border:1px solid #dbdbdb;margin:5px 5px 5px 5px;background-color:#ffffff;padding:5px;">
        <img border="0" src="/public/static/images/editor/img01.jpg" vspace="0" style="max-width:100%;"/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <h2  data-brushtype="text" style="margin:10px 0px;font-size:20px;padding:3px 10px 2px;">
            图片标题
        </h2>
        <section  style="padding:3px 10px 15px;">
            <p>
                图片内容描述，支持多段落。
            </p>
        </section>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:38:25', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (8, '8', '48', '1', 'markbro', '
<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="width:92px;margin-bottom:0px;">
        <p style="text-align:center;color:inherit;line-height:2em;">
            <span style="border-color:#ff8124;color:#ff8124;"><strong style="border-color:#ff8124;color:inherit;">编辑器</strong></span>
        </p>
    </section>
    <fieldset style="padding:0px 5px;line-height:10px;color:inherit;border:1px solid #ff8124;margin-top:0px;">
        <section style="padding:0px;color:inherit;height:8px;margin:-8px 0px 0px 60px;width:80px;background-color:#fefefe;">
            <section style="width:8px;height:8px;border-radius:100%;line-height:1;box-sizing:border-box;font-size:18px;text-decoration:inherit;border-color:#ff8124;display:inline-block;margin:0px;color:inherit;background-color:#ff8124;"></section>
        </section>
        <section  data-style="text-indent:2em;" style="padding:0px;line-height:2em;color:#3e3e3e;font-size:14px;margin:15px;">
            <p style="text-indent:2em;color:inherit;">
                微信+编辑器是一个在线图文编辑工具，大量节省您排版的时间，让工作更轻松高效。
            </p>
        </section>
        <section style="padding:0px;color:inherit;text-align:right;height:10px;margin:0px 0px -4px 25px;width:100px;background-color:#fefefe;">
            <section style="margin:0px auto 1px;border-radius:100%;line-height:1;box-sizing:border-box;text-decoration:inherit;border-color:#ff8124;display:inline-block;height:8px;width:8px;color:inherit;background-color:#ff8124;"></section>
        </section>
    </fieldset>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:38:25', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (9, '9', '48', '1', 'markbro', '
<fieldset  style="font-family:sans-serif;border:0px none;">
    <h2  placeholder="请输入标题" style="font-size:16px;margin:10px 0px;padding:10px;max-width:100%;border-top-style:solid;border-top-width:2px;border-left-width:0px;border-bottom-style:solid;border-bottom-width:2px;line-height:25px;color:#6d97c8;text-align:center;">
        请输入标题
    </h2>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (10, '10', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="border:3px solid #ff8124;padding:5px;">
        <section data-bcless="lighten" style="border:1px solid #ff9e57;padding:15px;text-align:center;color:inherit;">
            <p class="135title" style="color:inherit;font-size:12px;">
                <span style="font-family:arial;">微信+编辑器</span>
            </p>
            <p style="color:inherit;">
                <strong style="color:inherit;"><span  style="color:inherit;font-size:18px;">操作方便才是硬道理</span></strong>
            </p>
        </section>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (11, '11', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="margin:2px 0.8em 1em 0px;text-align:center;font-size:1em;vertical-align:middle;">
        <section style="height:0px;border-top-width:1.5em;border-top-style:solid;border-bottom-width:1.5em;border-bottom-style:solid;border-color:#47c1a8;border-left-width:1.5em !important;border-left-style:solid !important;border-right-width:1.5em !important;border-right-style:solid !important;"></section>
        <section style="height:0px;margin:-2.75em 1.65em;border-width:1.3em;border-style:solid;border-color:#ffffff transparent;"></section>
        <section style="height:0px;margin:0.45em 2.1em;vertical-align:middle;border-top-width:1.1em;border-top-style:solid;border-bottom-width:1.1em;border-bottom-style:solid;border-color:#47c1a8;border-left-width:1.1em !important;border-left-style:solid !important;border-right-width:1.1em !important;border-right-style:solid !important;">
            <section  data-ct="fix" placeholder="一行短标题" style="max-padding:0px;color:#fefffd;font-size:1.2em;line-overflow:hidden;margin-top:-0.5em;">
                一行短标题
            </section>
        </section>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (12, '12', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="box-sizing:border-box;padding:0px;margin:0px;">
        <section style="display:inline-block;line-height:20px;vertical-align:top;text-align:center;color:inherit;box-sizing:border-box;padding:0px;margin-top:0.5em;">
            <img src="/public/static/images/editor/img06.jpg" style="box-sizing:border-box;color:inherit;margin:0px;padding:0px;vertical-align:top;width:40px;"/>
            <p  data-brushtype="text" placeholder="微信+编辑器" style="box-sizing:border-box;color:inherit;font-size:12px;line-height:30px;padding:0px;margin-top:0px;margin-bottom:0px;">
                微信+编辑器
            </p>
        </section>
        <section style="display:inline-block;vertical-align:top;width:20px;color:inherit;box-sizing:border-box;padding-top:10px;padding-bottom:10px;margin-top:1.2em;">
            <section style="border-right-width:20px;border-left-width:0px;border-right-style:solid;border-right-color:#fee4c6;border-left-color:#fee4c6;display:inline-block;height:15px;width:15px;vertical-align:top;float:left;color:inherit;box-sizing:border-box;padding:0px;margin:0px;border-bottom-width:12px !important;border-top-style:solid !important;border-bottom-style:solid !important;border-top-color:transparent !important;border-bottom-color:transparent !important;"></section>
        </section>
        <section  style="display:inline-block;width:295.09375px;padding:1em;border-radius:1em;font-size:1em;color:#c26903;border-color:#ffd8ac;box-sizing:border-box;background-color:#fee4c6;margin-top:0.7em;margin-left:-0.4em;">
            <p style="color:inherit;border-color:#fee4c6;box-sizing:border-box;padding:0px;margin-top:0px;margin-bottom:0px;">
                <span style="color:#000000;">请输入对话</span>
            </p>
        </section>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (13, '13', '48', '1', 'markbro', '
<fieldset  style="font-family:sans-serif;border:0px none;">
    <fieldset style="clear:both;padding:0px;border:0px none;margin:1em 0px 0.5em;">
        <section style="border-top-width:2px;border-top-style:solid;border-color:#8ec965;font-size:1em;font-weight:inherit;text-decoration:inherit;color:#ffffff;box-sizing:border-box;">
            <section  data-brushtype="text" style="padding:0px 0.5em;display:inline-block;background-color:#8ec965;">
                微信+编辑器 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            </section>
        </section>
    </fieldset>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (14, '14', '48', '1', 'markbro', '<fieldset  style="font-family: sans-serif; border: 0px none;">
    <section style="max-width:100%;margin:2px;padding:0px;">
        <section style="max-width:100%;line-height:1.4em;margin-left:1em;">
            <span style="font-size:14px;"><strong style="color:#3e3e3e;line-height:32px;"><span  data-brushtype="text" data-mce-style="color:#a5a5a5;" placeholder="关于微信+编辑器" style="border-radius:5px;color:#ffffff;padding:4px 10px;background-color:#569f08;">关于微信+编辑器</span></strong></span>
        </section>
        <section  data-style="color:rgb(89, 89, 89); font-size:14px; line-height:28px" style="font-size:1em;max-width:100%;padding:10px 1em;border:1px solid #c0c8d1;border-radius:0.4em;color:#333333;background-color:#efefef;margin-top:-0.7em;">
            <p>
                <span placeholder="提供非常好用的微信文章编辑工具。">非常好用的在线图文编辑工具，欢迎将微信+推荐给您的朋友，将他/她从痛苦的编辑中解脱出来。</span>
            </p>
            <p>
                <br/>
            </p>
            <p style="text-align:center;">
                <img src="/public/static/images/editor/weixin.png" style="max-width:100%;"/>
            </p>
        </section>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (15, '15', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="margin:0.3em 0px;font-size:14px;font-weight:bold;text-align:center;text-decoration:inherit;box-sizing:border-box;padding-bottom:1.5em;">
        <img src="/public/static/images/editor/img02.jpg" style="border-radius:50%;color:inherit;vertical-align:middle;width:112px;height:112px !important;margin-right:10px;"/> 
        <section style="border-left-width:1px;border-left-style:solid;border-color:#d3ac9c;text-align:left;display:inline-block;height:6em;vertical-align:top;color:#d3ac9c;padding-left:1em;margin-top:1em;">
            <h2  data-brushtype="text" style="width:90px;overflow:hidden;height:42px;border-color:#d3ac9c;color:inherit;margin-top:-0.15em;margin-bottom:0.5em;">
                计划
            </h2>
            <section  data-style="font-size:16px;" style="font-size:16px;border-color:#d3ac9c;color:inherit;">
                <p>
                    =Planning=
                </p>
            </section>
        </section>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (16, '16', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <blockquote  style="orphans:2;widows:2;font-size:14px;line-height:22.39px;margin:10px 0px;padding:15px 20px 15px 45px;outline:0px;border:0px currentcolor;color:#3e3e3e;vertical-align:baseline;background-image:url(/public/static/images/editor/left_quote.jpg);background-color:#f1f1f1;background-position:1% 5px;background-repeat:no-repeat;">
        这里插入分号引用样式的内容。
    </blockquote>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (17, '17', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <fieldset style="border:none;margin:0.8em 0px 0.3em;box-sizing:border-box;padding:0px;">
        <section style="line-height:0;box-sizing:border-box;">
            <img src="/public/static/images/editor/img03.jpg" style="border:0px;box-sizing:border-box;display:inline-block;max-width:100%;height:auto !important;"/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        </section>
        <section data-width="30%" style="width:136.1875px;display:inline-block;float:left;text-align:right;margin:15px 0px 0px;padding:0px;box-sizing:border-box;">
            <section style="float:right;text-align:center;box-sizing:border-box;margin-top:-15px;">
                <section style="width:1px;height:1.2em;box-sizing:border-box;background-color:#666666;margin-left:13px;"></section>
                <section style="width:2em;height:2em;border:1px solid #666666;border-radius:50%;line-height:2em;font-size:1em;font-weight:inherit;text-decoration:inherit;box-sizing:border-box;">
                    <section  data-brushtype="text" style="box-sizing:border-box;">
                        简
                    </section>
                </section>
                <section style="width:2em;height:2em;border:1px solid #666666;border-radius:50%;line-height:2em;font-size:1em;font-weight:inherit;text-decoration:inherit;box-sizing:border-box;margin-top:2px;">
                    <section  data-brushtype="text" style="box-sizing:border-box;">
                        单
                    </section>
                </section>
            </section>
        </section>
        <section data-width="65%" style="width:295.09375px;float:left;line-height:1.5em;font-size:1em;font-weight:inherit;text-decoration:inherit;color:#272c33;box-sizing:border-box;padding-left:20px;margin-top:20px;">
            <section style="box-sizing:border-box;">
                <section  data-brushtype="text" style="box-sizing:border-box;font-size:28px;margin:5px 0px;">
                    Cafe
                </section>
                <section  data-brushtype="text" style="box-sizing:border-box;">
                    伟提尼亚记忆
                </section>
            </section>
        </section>
    </fieldset>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (18, '18', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <fieldset style="margin:0.5em 0px;padding:0px;max-width:100%;box-sizing:border-box;color:#3e3e3e;line-height:25px;border:0px #eedeb0;word-wrap:break-word !important;">
        <section style="margin:0px;padding:0px;width:100%;box-sizing:border-box;display:inline-block;text-align:center;word-wrap:break-word !important;">
            <img src="/public/static/images/editor/bg03.png" style="box-sizing:border-box;color:inherit;height:65px;margin:0px auto;padding:0px;width:60px;visibility:visible !important;word-wrap:break-word !important;"/>
        </section>
        <section style="margin:-2.3em 0px 0px;padding:2em 0px 0px;max-width:100%;box-sizing:border-box;min-height:15em;font-size:1em;font-weight:inherit;text-decoration:inherit;color:#83681c;border-color:#eedeb0;word-wrap:break-word !important;background-image:url(/public/static/images/editor/bg05.png);background-color:#eedeb0;background-repeat:repeat;">
            <section style="margin:0.3em auto;padding:0.5em;max-width:100%;box-sizing:border-box;width:7em;height:3.5em;line-height:2em;overflow:hidden;-webkit-transform:rotate(-5deg);font-size:32px;font-weight:inherit;text-align:center;text-decoration:inherit;color:inherit;word-wrap:break-word !important;background-image:url(/public/static/images/editor/bg04.png);background-size:contain;background-repeat:no-repeat;">
                <section style="margin:0px;padding:0px;max-width:100%;box-sizing:border-box;word-wrap:break-word !important;">
                    <span  data-brushtype="text" style="box-sizing:border-box;color:inherit;margin:0px;max-width:100%;padding:0px;word-wrap:break-word !important;">公告</span>
                </section>
            </section>
            <section style="margin:0px;padding:1em;max-width:100%;box-sizing:border-box;word-wrap:break-word !important;">
                <section  style="margin:0px;padding:0px;max-width:100%;box-sizing:border-box;color:inherit;word-wrap:break-word !important;">
                    <p>
                        本背景可以换色哦~
                    </p>
                </section>
            </section>
        </section>
    </fieldset>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (19, '19', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="width:100%;text-align:center;">
        <section style="width:100%;padding:0px;border-top-width:2px;border-top-style:solid;border-top-color:#ac1d10;border-bottom-width:2px;border-bottom-style:solid;border-bottom-color:#ac1d10;color:inherit;font-size:14px;margin:15px 0px;display:inline-block;background-color:#ffffff;">
            <section  data-style="line-height:24px;color:rgb(89, 89, 89); font-size:20px;" style="padding:30px;margin:-15px 15px;border-right-width:2px;border-right-style:solid;border-right-color:#ac1d10;border-left-width:2px;border-left-style:solid;border-left-color:#ac1d10;color:inherit;">
                <p style="line-height:24px;color:#ac1d10;border-color:#ac1d10;">
                    <span style="color:#0c0c0c;font-size:16px;"><strong style="color:inherit;">请输入内容</strong></span>
                </p>
            </section>
        </section>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (20, '20', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="max-width:100%;margin:0px;border-radius:2em;height:2.5em;line-height:2.5em;color:#ffffff;font-size:13.33px;word-wrap:break-word !important;box-sizing:border-box !important;background-color:#bddd22;">
        <img src="/public/static/images/editor/bg02.jpg" style="border:0px #bddd22;float:left;margin:5px 10px;vertical-align:top;box-sizing:border-box !important;height:auto !important;visibility:visible !important;width:auto !important;word-wrap:break-word !important;"/>
        <p  data-brushtype="text" style="max-width:100%;color:inherit;display:inline-block;font-size:16px;">
            关注一下又不会怀孕！
        </p>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (21, '21', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="border-color:transparent transparent #0070c0;border-style:solid;border-width:12px;float:none;font-size:medium;height:0px;margin:-12px auto 0px 90px;orphans:2;text-align:-webkit-auto;width:0px;"></section>
    <p  data-brushtype="text" style="orphans:2;widows:2;min-height:30px;visibility:visible;height:30px;line-height:30px;color:#ffffff;border-radius:3px;box-shadow:1px 1px 3px;text-align:center;font-size:14px;font-weight:bold;background-color:#0070c0;margin-top:-1px;margin-bottom:0px;">
        点击标题下「蓝色微信名」可快速关注
    </p>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (22, '22', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <fieldset style="border:none;margin:0.8em 22.6875px 0.3em;">
        <section  data-brushtype="text" style="color:#ff6450;font-size:20px;letter-spacing:3px;padding:9px 4px 14px;text-align:center;margin:0px auto;border:4px solid #ff6450;border-radius:8px;">
            理念<span  data-brushtype="text" style="display:block;font-size:10px;line-height:12px;">PHILOSOPHY</span>
        </section>
        <section style="width:0px;border-top-width:0.6em;border-top-style:solid;border-bottom-color:#ff6450;border-top-color:#ff6450;height:10px;border-left-width:0.7em !important;border-left-style:solid !important;border-left-color:transparent !important;border-right-width:0.7em !important;border-right-style:solid !important;border-right-color:transparent !important;margin-right:auto;margin-left:auto;"></section>
    </fieldset>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (23, '23', '48', '1', 'markbro', '
<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="margin:0.8em 0px 0.5em;line-height:32px;font-weight:bold;">
        <section style="display:inline-block;float:left;width:32px;height:32px;vertical-align:top;text-align:center;">
            <section style="display:table;width:36px;color:inherit;border-color:#48c0a3;">
                <section style="display:table-cell;vertical-align:middle;color:#ffffff;border-color:#48c0a3;">
                    <span  data-brushtype="text" style="color:#c6c6c7;font-size:50px;">1</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                </section>
                <section style="width:18px;height:70px;border-left-width:1px;border-left-style:solid;border-left-color:#c6c6c7;box-sizing:border-box;-webkit-transform:rotate(35deg);transform:rotate(35deg);background-color:#fefefe;margin-left:-8px;margin-top:5px;"></section>
            </section>
        </section>
        <section style="font-size:30px;color:#737373;border-color:#48c0a3;padding-top:18px;margin-left:40px;">
            <span  data-brushtype="text" style="font-size:20px;">请输入标题</span>
        </section>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (24, '24', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="font-size:1em;margin:1em 0px 0.8em;text-align:center;vertical-align:middle;">
        <section style="height:0px;margin:0px 1em;border-width:1.5em;border-style:solid;border-top-color:#ffca00;border-bottom-color:#ffca00;border-left-color:transparent !important;border-right-color:transparent !important;"></section>
        <section style="height:0px;margin:-2.75em 1.65em;border-width:1.3em;border-style:solid;border-color:#ffffff transparent;"></section>
        <section style="height:0px;margin:0.45em 2.1em;vertical-align:middle;border-width:1.1em;border-style:solid;border-top-color:#ffca00;border-bottom-color:#ffca00;border-left-color:transparent !important;border-right-color:transparent !important;">
            <section  data-brushtype="text" placeholder="一行短标题" style="max-padding:0px;color:#ffffff;font-size:1.2em;line-overflow:hidden;margin-top:-0.5em;">
                一行短标题
            </section>
        </section>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (25, '25', '48', '1', 'markbro', '
<fieldset  style="font-family:sans-serif;border:0px none;">
    <fieldset style="border:0px;text-align:center;box-sizing:border-box;padding:0px;">
        <section style="display:inline-block;box-sizing:border-box;color:inherit;">
            <section  data-brushtype="text" style="margin:0.2em 0px 0px;padding:0px 0.5em 5px;max-width:100%;color:#6b4d40;font-size:1.8em;line-height:1;border-bottom-width:1px;border-bottom-style:solid;border-color:#6b4d40;">
                微信+编辑器 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            </section>
            <section  data-brushtype="text" style="margin:5px 1em;font-size:1em;line-height:1;color:#6b4d40;box-sizing:border-box;border-color:#6b4d40;">
                做最易用的编辑器
            </section>
        </section>
    </fieldset>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (26, '26', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section data-bcless="true" style="font-size:20px;border:0px none;padding:0px;margin:0px;background:#dff0cb;">
        <span  data-brushtype="text" style="color:#96ce54;display:inline-block;padding:0px 15px 0px 0px;background:#ffffff;">微信+编辑器</span> <span style="color:#ffffff;display:inline-block;background:#ffffff;margin-left:5px;">-</span> <span style="color:#ffffff;display:inline-block;background:#ffffff;margin-left:5px;">-</span> <span style="color:#ffffff;display:inline-block;background:#ffffff;margin-left:5px;">-</span>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (27, '27', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section  placeholder="上下渐变格式内容" style="padding:8px 30px;font-weight:bold;max-width:100%;min-height:1.5em;line-height:2em;color:#74b90b;border-color:#e5f3d0;background-image:-webkit-linear-gradient(top, #e6f9ca, #cfe9a7);background-color:#ffffdc;">
        <p>
            上下渐变格式内容
        </p>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (28, '28', '48', '1', 'markbro', '
<fieldset  style="font-family:sans-serif;border:0px none;">
    <p  placeholder="请输入标题" style="max-width:100%;min-line-height:25px;font-size:20px;text-shadow:#00bbec 1px 0px 4px, #00bbec 0px 1px 4px, #00bbec 0px -1px 4px, #00bbec -1px 0px 4px;color:#ffffff;font-weight:bold;box-sizing:border-box !important;word-wrap:break-word !important;">
        请输入标题
    </p>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (29, '29', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <blockquote style="margin:0px;padding:12px 15px;border:0px solid #d0dafe;color:#002dcf;min-text-align:justify;background-image:-webkit-linear-gradient(left, #cfd9ff, #9eb3fd, #cfd9ff);background-color:#fffff0;">
        <section  style="border-color:#d0dafe;color:inherit;">
            <p style="border-color:#d0dafe;color:inherit;">
                渐变背景内容
            </p>
        </section>
    </blockquote>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (30, '30', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="margin:3px;box-shadow:0px 1px 3px;background-color:#ffffff;">
        <img src="/public/static/images/editor/img04.jpg" style="max-width:100%;"/> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        <section  data-type="main">
            <p style="line-height:1.35em;overflow:hidden;padding:0px 16px;word-wrap:break-word;margin-top:10px;">
                <span style="line-height:1.35em;">微信+原创，图文样式排版。</span>
            </p>
            <p style="line-height:1.35em;overflow:hidden;padding:0px 16px;word-wrap:break-word;margin-top:10px;">
                底下为作者信息
            </p>
        </section>
        <section style="border-top-width:1px;border-top-style:solid;border-top-color:#f2f2f2;color:#999999;padding:16px;background:none 0px 0px repeat scroll #fafafa;">
            <img src="/public/static/images/editor/img05.jpg" style="float:left;height:34px;width:34px;margin-right:10px;"/>
            <section  data-style="clear:none;line-height:17px;padding:0 0;font-size:12px;">
                <p style="clear:none;font-size:12px;line-height:17px;padding:0px;margin-top:0px;margin-bottom:0px;">
                    <strong>简单易用的才是最好的</strong>
                </p>
                <p style="clear:none;font-size:12px;line-height:17px;padding:0px;margin-top:0px;margin-bottom:0px;">
                    微信+编辑器
                </p>
            </section>
        </section>
    </section>
    <p>
        <br/>
    </p>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (31, '31', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <p  data-brushtype="text" placeholder="请输入标题" style="max-width:100%;line-height:24px;font-weight:bold;color:#ffffff;border-radius:45%;text-align:center;padding:10px 15px;background-color:#f49c04;margin-top:10px;margin-bottom:10px;">
        请输入标题
    </p>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (32, '32', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="-webkit-box-reflect:below 0px -webkit-gradient(linear, 0% 0%, 0% 100%, from(transparent), color-stop(0.2, transparent), to());line-height:20px;margin-top:15px;">
        <p style="text-align:center;">
            <span style="font-family:微软雅黑;font-size:30px;"><strong>文字倒影效果样式</strong></span>
        </p>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (33, '33', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <h2  data-brushtype="text" style="border-bottom-width:1px;border-bottom-style:solid;border-bottom-color:#eeeeee;font-weight:500;line-height:1.1;font-size:22px;padding-bottom:9px;margin-bottom:10px;">
        极简标题
    </h2>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (34, '34', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <blockquote class="135bg" style="max-width:100%;padding:5px 15px;border:none #ff8124;word-wrap:break-word !important;box-sizing:border-box !important;background-image:url(/public/static/images/editor/img07.gif);background-size:cover;">
        <section  style="color:#ffffff;">
            <p style="text-align:center;color:inherit;">
                <br/>
            </p>
            <p style="max-width:100%;word-wrap:normal;min-line-height:1.75em;text-align:center;box-sizing:border-box !important;margin-top:0px;margin-bottom:0px;">
                <span style="font-size:18px;"><strong>雪花动态背景样式，请输入文字</strong></span>
            </p>
        </section>
    </blockquote>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (35, '35', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <p>
        <span style="border-color:#1e9be8;color:#1e9be8;font-size:4em;font-weight:bolder;line-vertical-align:middle;">“</span> <span  data-brushtype="text" style="color:inherit;font-size:2em;line-height:1.2em;vertical-align:middle;">标题</span> <span  data-brushtype="text" style="border-color:#1e9be8;color:#1e9be8;font-size:2em;line-height:1.2em;vertical-align:middle;">标题</span> <span style="border-color:#1e9be8;color:#1e9be8;font-size:4em;font-weight:bolder;line-vertical-align:middle;">”</span>
    </p>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (36, '36', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <fieldset style="padding:5px;border:1px solid #cccccc;line-height:24px;color:inherit;">
        <legend style="margin:0px 0px 0px 15px;padding:0px;width:auto;color:inherit;">
            <span style="color:inherit;margin:0px;padding:0px;"><strong style="color:#666666;margin:15px 8px 0px 0px;"><span  data-brushtype="text" style="border-color:#91a8fc;border-radius:5px;color:#ffffff;padding:4px 10px;background-color:#91a8fc;">微信+编辑器</span> &nbsp;</strong><span  data-brushtype="text" style="border-color:#91a8fc;color:#91a8fc;margin:0px;padding:0px;">ID:wxj &nbsp;</span></span>
        </legend>
        <section  data-style="text-indent:2em;;" style="padding:0px;line-height:2em;color:#3e3e3e;font-size:14px;margin:15px;">
            <p style="text-indent:2em;color:inherit;">
                微信+编辑器是一个在线图文编辑工具，大量节省您排版的时间，让工作更轻松高效。
            </p>
        </section>
    </fieldset>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (37, '37', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="padding:0px 8px;border-left-width:3px;border-left-style:solid;border-color:;font-size:22px;font-weight:inherit;text-align:inherit;text-decoration:inherit;box-sizing:border-box;">
        <section style="line-height:1.4;box-sizing:border-box;color:inherit;">
            <section  data-brushtype="text" style="border-color:#757576;color:#757576;font-size:20px;">
                标题
            </section>
        </section>
        <section  data-style="border-color:rgb(117, 117, 118); color:inherit; font-size:12px;" style="color:#757576;line-height:1.4;font-size:14px;font-weight:inherit;text-align:inherit;text-decoration:inherit;box-sizing:border-box;border-color:#757576;padding-left:3px;margin-top:5px;">
            <p style="border-color:#757576;color:inherit;font-size:12px;">
                内容描述
            </p>
        </section>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (38, '38', '48', '1', 'markbro', '
<fieldset  style="font-family: sans-serif; border: 0px none;">
    <section style="border-style:solid;border-width:1px 1px 1px 60px;border-color:#a40000;color:#a40000;padding-left:20px;padding-top:10px;">
        <section style="border-bottom-width:2px;border-bottom-style:solid;border-bottom-color:#a40000;clear:both;float:left;">
            <section  data-brushtype="text" style="font-size:24px;font-weight:bold;float:left;">
                New /<br/>Spring
            </section>
            <section  data-brushtype="text" style="font-size:20px;font-weight:bold;float:left;margin-left:45px;margin-top:5px;">
                春.<br/>新年快乐2015 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            </section>
        </section>
        <p style="clear:both;">
            <br/>
        </p>
        <p >
            提子微信+ &nbsp; &nbsp;HAPPY NEW YEAR <em>!!!</em>
        </p>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (39, '39', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <fieldset style="border:0px #6b4d40;text-align:center;margin:0.8em 0px 0.5em;box-sizing:border-box;padding:0px;">
        <section style="color:#6b4d40;display:inline-block;width:1em;font-size:2.5em;font-weight:inherit;line-vertical-align:top;text-align:inherit;text-decoration:inherit;box-sizing:border-box;border-color:#6b4d40;">
            <section  data-brushtype="text" style="box-sizing:border-box;color:inherit;border-color:#6b4d40;">
                两字
            </section>
        </section>
        <section class="135title" style="display:inline-block;text-align:left;box-sizing:border-box;color:inherit;margin-left:0.5em;margin-top:0.2em;">
            <section style="box-sizing:border-box;color:inherit;">
                <section  data-brushtype="text" style="border-color:#6b4d40;box-sizing:border-box;color:#e0d1ca;display:inline-block;font-size:2em;font-weight:inherit;line-height:1;padding:0.1em;text-align:inherit;text-decoration:inherit;background-color:#6b4d40;">
                    副标题1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                </section>
            </section>
            <section style="color:#6b4d40;margin:0.5em 0px;font-size:1.5em;line-font-weight:inherit;text-align:inherit;text-decoration:inherit;box-sizing:border-box;border-color:#6b4d40;">
                <section  data-brushtype="text" style="box-sizing:border-box;color:inherit;border-color:#6b4d40;">
                    副标题2
                </section>
            </section>
        </section>
    </fieldset>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (40, '40', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <p  style="font-size:15.5555562973022px;padding:0px;max-width:100%;min-height:1.5em;line-height:2em;word-wrap:break-word;word-break:normal;border-radius:5px;color:#ffffff;text-align:center;background-color:#5996eb;margin-top:0px;margin-bottom:0px;">
        ↓↓↓ 点击&quot;阅读原文&quot; 【查看更多信息】 &nbsp;
    </p>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (41, '41', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="margin:10px 0px;border:1px solid #c9c9c9;text-align:center;">
        <section style="border:0.1em solid #ffca00;margin:1em auto;width:12em;height:12em;border-radius:6em;">
            <section style="display:table;max-height:11em;border-radius:5.5em;height:11em;width:11em;margin:0.5em;background-color:#ffca00;">
                <section  data-brushtype="text" style="display:table-cell;vertical-align:middle;max-height:11em;margin:1em;padding:1em;color:#ffffff;font-size:1.5em;line-height:1.2em;">
                    微信+<br/>编辑器
                </section>
            </section>
        </section>
        <section  data-style="font-size:1em;" style="display:inline-block;color:white;line-border-radius:1em;margin:1em 1em 2em;max-width:100%;padding:0.5em 1em;font-size:1em;background-color:#ffca00;">
            <p>
                微信+编辑器，您的微信文章可以更精彩！
            </p>
        </section>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (42, '42', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <fieldset style="margin:0.5em 0px;padding:0px;max-width:100%;box-sizing:border-box;color:#3e3e3e;font-family:inherit;font-size:medium;line-height:25px;border:none #fefdfe;word-wrap:break-word !important;">
        <section style="margin:0px;padding:3.8em 0px;max-width:100%;box-sizing:border-box;width:12.5em;height:12.5em;float:right;text-align:center;word-wrap:break-word !important;background-image:url(/public/static/images/editor/bg06.png);background-size:cover;">
            <section data-width="140px" style="margin:0px 0px 0px 16px;padding:0px;max-width:100%;box-sizing:border-box;width:140px;overflow:hidden;-webkit-transform:rotate(-13deg);font-size:22px;font-family:inherit;font-weight:inherit;text-decoration:inherit;color:#666666;word-wrap:break-word !important;">
                <section  data-brushtype="text" style="margin:0px;padding:0px;max-width:100%;box-sizing:border-box;color:inherit;word-wrap:break-word !important;">
                    Tips
                </section>
            </section>
            <section data-width=" 150px" style="margin:10px 20px;padding:0px;max-width:100%;box-sizing:border-box;width:150px;overflow:hidden;-webkit-transform:rotate(-15deg);font-size:14px;font-family:inherit;font-weight:inherit;text-decoration:inherit;color:#666666;word-wrap:break-word !important;">
                <section  style="margin:0px;padding:0px;max-width:100%;box-sizing:border-box;color:inherit;word-wrap:break-word !important;">
                    <p>
                        我是图片不能换色哦
                    </p>
                </section>
            </section>
        </section>
    </fieldset>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (43, '43', '48', '1', 'markbro', '<fieldset  style="font-family:sans-serif;border:0px none;">
    <section style="margin-top:5px;">
        <section style="width:227px;display:inline-block;float:left;padding-right:10px;">
            <section style="padding:20px 25px;border:1px solid #e7e7e7;text-align:center;">
                <p>
                    <img src="/public/static/images/editor/pt_blog_logo.png" style="height:50px;margin-bottom:15px;"/>
                </p>
                <h3  data-brushtype="text" style="font-size:16px;margin:0px 0px 10px;">
                    微信+编辑器
                </h3>
                <section  data-style="clear:none;">
                    <p style="clear:none;line-height:1.5em;margin-top:0px;margin-bottom:0px;">
                        生而排版
                    </p>
                    <p style="clear:none;line-height:1.5em;margin-top:0px;margin-bottom:0px;">
                        为你而美
                    </p>
                </section>
            </section>
        </section>
        <section style="width:227px;display:inline-block;text-align:center;padding-left:10px;">
            <section style="padding:20px 25px;border:1px solid #e7e7e7;">
                <p>
                    <img src="/public/static/images/editor/pt_blog_logo.png" style="height:50px;margin-bottom:15px;"/>
                </p>
                <h3  data-brushtype="text" style="font-size:16px;margin:0px 0px 10px;">
                    秒刷
                </h3>
                <section  data-style="clear:none;margin:0 0;line-height:1.5em;">
                    <p style="clear:none;line-height:1.5em;margin-top:0px;margin-bottom:0px;">
                        一键排版
                    </p>
                    <p style="clear:none;line-height:1.5em;margin-top:0px;margin-bottom:0px;">
                        珍惜生命
                    </p>
                </section>
            </section>
        </section>
    </section>
</fieldset>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
INSERT INTO reedos.cms_article_template (id, name, tags, user_id, user_name, content, share_type, weight, hot_falg, new_flag, create_time, audit, audit_time, audit_by, audit_name, audit_reason) VALUES (44, '44', '48', '1', 'markbro', '
<fieldset  style="font-family:sans-serif;border:0px none;">
    <fieldset style="border:none;margin:0.8em 0px 0.3em;box-sizing:border-box;padding:0px;">
        <section  data-brushtype="text" style="width:2.5em;height:2.5em;margin:0px auto 1px;border-radius:100%;line-height:2.5em;box-sizing:border-box;overflow:hidden;font-size:40px;text-align:center;text-decoration:inherit;color:#ffffff;border-color:#c3272b;background-color:#c3272b;">
            微信+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        </section>
        <section style="font-size:1em;font-weight:bold;text-align:center;text-decoration:inherit;color:#ffffff;border-color:#c3272b;box-sizing:border-box;">
            <section style="width:0px;margin:0px auto;border-bottom-width:0.5em;border-bottom-style:solid;border-bottom-color:#c3272b;border-top-color:#c3272b;box-sizing:border-box;height:10px;border-left-width:1em !important;border-left-style:solid !important;border-left-color:transparent !important;border-right-width:1em !important;border-right-style:solid !important;border-right-color:transparent !important;"></section>
            <section  data-brushtype="text" style="padding:0.5em;line-height:1.2em;font-size:1em;box-sizing:border-box;background-color:#c3272b;">
                做最好用的编辑器
            </section>
        </section>
    </fieldset>
</fieldset>
<p style="color: red;">
    <br/>
</p>', 'public', 1, 0, 0, '2019-12-31 10:37:56', 0, null, null, null, null);
