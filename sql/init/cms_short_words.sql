drop table if exists reedos.cms_short_words;
create table reedos.cms_short_words
(
    id          int auto_increment
        primary key,
    short_words varchar(255) default '' null comment '短语',
    tagIds      varchar(100)            null comment '标签',
    user_id     varchar(20)             null comment '用户ID',
    words_count int                     null comment '字数',
    weight      int          default 0  null comment '权重',
    audit_state smallint                null comment '审核状态'
);

INSERT INTO reedos.cms_short_words (id, short_words, tagIds, user_id, words_count, weight, audit_state) VALUES (2, '不求与人相比，但求超越自己，要哭就哭出激动的泪水，要笑就笑出成长的性格。', null, '1', 36, 1, 1);
INSERT INTO reedos.cms_short_words (id, short_words, tagIds, user_id, words_count, weight, audit_state) VALUES (3, '与其用泪水悔恨今天，不如用汗水拼搏今天。', null, '1', 20, 1, 1);
INSERT INTO reedos.cms_short_words (id, short_words, tagIds, user_id, words_count, weight, audit_state) VALUES (4, '当眼泪流尽的时候，留下的应该是坚强。', null, '1', 18, 1, 0);
INSERT INTO reedos.cms_short_words (id, short_words, tagIds, user_id, words_count, weight, audit_state) VALUES (5, '人生就像一杯没有加糖的咖啡，喝起来是苦涩的，回味起来却有久久不会退去的余香。', null, '1', 38, 1, 1);
INSERT INTO reedos.cms_short_words (id, short_words, tagIds, user_id, words_count, weight, audit_state) VALUES (6, '有一种缘，放手后成为风景，有一颗心，坚持中方现真诚。', null, '1', 26, 1, 1);
INSERT INTO reedos.cms_short_words (id, short_words, tagIds, user_id, words_count, weight, audit_state) VALUES (7, '选择自己所爱的，爱自己所选择的。', null, '1', 16, 1, 1);
