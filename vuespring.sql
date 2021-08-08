/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 50730
Source Host           : localhost:3306
Source Database       : vuespring

Target Server Type    : MYSQL
Target Server Version : 50730
File Encoding         : 65001

Date: 2021-08-08 23:33:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `achievement`
-- ----------------------------
DROP TABLE IF EXISTS `achievement`;
CREATE TABLE `achievement` (
  `a_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '成绩标识',
  `s_id` bigint(20) DEFAULT NULL COMMENT '学生标识',
  `c_id` bigint(20) DEFAULT NULL COMMENT '课程标识',
  `a_years` int(11) DEFAULT NULL COMMENT '年份',
  `a_semester` int(11) DEFAULT NULL COMMENT '学期',
  `a_score` int(11) DEFAULT NULL COMMENT '成绩',
  `a_remark` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`a_id`),
  KEY `s_id` (`s_id`),
  KEY `c_id` (`c_id`),
  CONSTRAINT `achievement_ibfk_1` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `achievement_ibfk_2` FOREIGN KEY (`c_id`) REFERENCES `course` (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of achievement
-- ----------------------------
INSERT INTO `achievement` VALUES ('1', '1', '1', '2021', '1', '80', null);
INSERT INTO `achievement` VALUES ('2', '4', '1', '2021', '1', '85', null);
INSERT INTO `achievement` VALUES ('3', '2', '1', '2021', '1', '85', null);
INSERT INTO `achievement` VALUES ('4', '5', '1', '2021', '1', '85', null);

-- ----------------------------
-- Table structure for `code`
-- ----------------------------
DROP TABLE IF EXISTS `code`;
CREATE TABLE `code` (
  `id` bigint(20) NOT NULL,
  `describe` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of code
-- ----------------------------
INSERT INTO `code` VALUES ('1', 'gender');
INSERT INTO `code` VALUES ('2', 'fettle');

-- ----------------------------
-- Table structure for `codedetails`
-- ----------------------------
DROP TABLE IF EXISTS `codedetails`;
CREATE TABLE `codedetails` (
  `cd_id` bigint(20) NOT NULL COMMENT '编码明细标识',
  `cd_mark` bigint(20) DEFAULT NULL COMMENT '编码标识',
  `cd_value` int(11) DEFAULT NULL COMMENT '编码值',
  `cd_describe` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '编码值描述',
  PRIMARY KEY (`cd_id`),
  KEY `cd_mark` (`cd_mark`),
  CONSTRAINT `codedetails_ibfk_1` FOREIGN KEY (`cd_mark`) REFERENCES `code` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of codedetails
-- ----------------------------
INSERT INTO `codedetails` VALUES ('1', '1', '0', '女');
INSERT INTO `codedetails` VALUES ('2', '1', '1', '男');
INSERT INTO `codedetails` VALUES ('3', '2', '1', '在读');
INSERT INTO `codedetails` VALUES ('4', '2', '2', '休学');
INSERT INTO `codedetails` VALUES ('5', '2', '3', '退学');

-- ----------------------------
-- Table structure for `course`
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `c_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '课程标识',
  `t_id` bigint(20) DEFAULT NULL,
  `c_no` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '课程编号',
  `c_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '课程名称',
  `c_fettle` int(11) DEFAULT NULL COMMENT '状态',
  `c_remark` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`c_id`),
  KEY `t_id` (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', null, '10002', '计算机', '0', null);
INSERT INTO `course` VALUES ('2', null, '10003', 'java', '0', '');
INSERT INTO `course` VALUES ('3', null, '10004', '大学英语', '0', '');
INSERT INTO `course` VALUES ('4', null, '10005', '高等数学', '0', '');
INSERT INTO `course` VALUES ('5', null, '10006', '军事理论', '0', '');
INSERT INTO `course` VALUES ('6', null, '10007', '毛泽东思想', '0', '');
INSERT INTO `course` VALUES ('7', null, '10008', '体育与健康', '0', '');
INSERT INTO `course` VALUES ('8', null, '10009', '马克思主义理论', '0', '');
INSERT INTO `course` VALUES ('9', null, '10010', '数据结构', '0', '');
INSERT INTO `course` VALUES ('10', null, '10011', '概率论', '0', null);

-- ----------------------------
-- Table structure for `education`
-- ----------------------------
DROP TABLE IF EXISTS `education`;
CREATE TABLE `education` (
  `e_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '教学标识',
  `c_id` bigint(20) DEFAULT NULL COMMENT '班级标识',
  `t_id` bigint(20) DEFAULT NULL COMMENT '老师标识',
  `e_year` int(11) DEFAULT NULL COMMENT '年份',
  `e_semester` int(11) DEFAULT NULL COMMENT '学期',
  `e_fettle` int(11) DEFAULT NULL COMMENT '状态',
  `e_remark` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注',
  `course_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`e_id`),
  KEY `t_id` (`t_id`),
  KEY `c_id` (`c_id`) USING BTREE,
  CONSTRAINT `education_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `fclass` (`c_id`),
  CONSTRAINT `education_ibfk_2` FOREIGN KEY (`t_id`) REFERENCES `teacher` (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of education
-- ----------------------------
INSERT INTO `education` VALUES ('1', '1', '1', '2020', '2', '0', null, '1');
INSERT INTO `education` VALUES ('2', '2', '1', '2021', '1', '0', null, '1');
INSERT INTO `education` VALUES ('3', '4', '2', '2021', '1', '0', null, '7');
INSERT INTO `education` VALUES ('4', '3', '2', '2021', '1', '0', null, '7');
INSERT INTO `education` VALUES ('5', '3', '1', '2021', '1', '0', null, '1');
INSERT INTO `education` VALUES ('6', '4', '1', '2021', '1', '0', null, '1');
INSERT INTO `education` VALUES ('7', '6', '5', '2021', '2', '0', null, '4');
INSERT INTO `education` VALUES ('8', '1', '2', '2021', '1', '0', null, '7');
INSERT INTO `education` VALUES ('9', '6', '4', '2021', '1', '0', null, '8');

-- ----------------------------
-- Table structure for `fclass`
-- ----------------------------
DROP TABLE IF EXISTS `fclass`;
CREATE TABLE `fclass` (
  `c_id` bigint(20) NOT NULL COMMENT '班级标识',
  `classname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '班级名称',
  `c_number` int(11) DEFAULT NULL COMMENT '班级人数',
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of fclass
-- ----------------------------
INSERT INTO `fclass` VALUES ('1', '计算机科学与技术171', '30');
INSERT INTO `fclass` VALUES ('2', '计算机科学与技术172', '35');
INSERT INTO `fclass` VALUES ('3', '软件工程171', '30');
INSERT INTO `fclass` VALUES ('4', '软件工程172', '26');
INSERT INTO `fclass` VALUES ('5', '物联网信息工程171', '24');
INSERT INTO `fclass` VALUES ('6', '物联网信息工程172', '22');

-- ----------------------------
-- Table structure for `household`
-- ----------------------------
DROP TABLE IF EXISTS `household`;
CREATE TABLE `household` (
  `h_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '家庭标识',
  `s_id` bigint(20) NOT NULL COMMENT '学生标识',
  `genre` int(11) DEFAULT NULL COMMENT '成员类型',
  `h_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '家庭成员姓名',
  `h_gender` int(11) DEFAULT NULL COMMENT '性别',
  `h_phone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联系方式',
  `h_birthday` date DEFAULT NULL COMMENT '生日',
  `h_card` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '身份证',
  `h_fettle` int(11) DEFAULT NULL COMMENT '状态',
  `h_remark` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`h_id`),
  KEY `s_id` (`s_id`),
  CONSTRAINT `household_ibfk_1` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of household
-- ----------------------------
INSERT INTO `household` VALUES ('1', '1', '4', '令佩', '1', '18172141742', '2021-08-02', '458888888888888888', '2', null);

-- ----------------------------
-- Table structure for `student`
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `s_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '标识',
  `s_no` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '学号',
  `s_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '姓名',
  `gender` int(11) DEFAULT NULL COMMENT '性别',
  `s_phone` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '电话号码',
  `email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '电子邮箱',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `id_card` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '身份证号码',
  `contact` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联系人',
  `contactphone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联系人电话',
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '家庭地址',
  `postcode` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '邮编',
  `situation` text COLLATE utf8_unicode_ci COMMENT '家庭状况',
  `father` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '父亲',
  `fatherphone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '父亲电话',
  `mather` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '母亲',
  `matherphone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '母亲电话',
  `fettle` int(11) DEFAULT NULL COMMENT '学生状态',
  `remark` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注',
  `c_id` bigint(20) DEFAULT NULL COMMENT '班级id',
  PRIMARY KEY (`s_id`),
  KEY `c_id` (`c_id`),
  KEY `s_no` (`s_no`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`c_id`) REFERENCES `fclass` (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', '20170001', '令狐冲', '1', '18172141742', '1614545@qq.com', '2021-08-02', '458888888888888888', '令狐冲', '18172141742', '广州番禺区', '163555', null, null, null, null, null, '1', null, '1');
INSERT INTO `student` VALUES ('2', '20170002', '袁姗姗', '0', '18172141742', '1227522054@qq.com', '1999-08-05', '450902199901316542', '袁姗姗', '18172141742', '广州花都区', '157123', '正常', null, null, null, null, '1', null, '2');
INSERT INTO `student` VALUES ('3', '20170003', '岳不群', '1', '18172141742', '1227522054@qq.com', '2021-07-26', '450902199901316542', '岳不群', '18172141742', '广州花都区', '157123', null, null, null, null, null, '1', null, '1');
INSERT INTO `student` VALUES ('4', '20170004', '任盈盈', '0', '18158911742', '1227525894@qq.com', '1999-08-26', '450902199901316548', '任盈盈', '18172581742', '广州花都区', '159523', null, null, null, null, null, '1', null, '1');
INSERT INTO `student` VALUES ('5', '20170005', '任我行', '1', '18165161642', '1589525894@qq.com', '1996-10-24', '450902199901316531', '任我行', '18172589942', '广州黄埔区', '159583', null, null, null, null, null, '1', null, '1');
INSERT INTO `student` VALUES ('6', '20170006', '左冷禅', '1', '18175757572', '1589525794@qq.com', '1995-10-16', '450902199510165311', '左冷禅', '18172454742', '广州黄埔区', '159523', '正常', null, null, null, null, '1', null, '1');
INSERT INTO `student` VALUES ('7', '20170007', '余沧海', '1', '18158911742', '1589522694@qq.com', '1999-02-28', '450902199902286532', '余沧海', '18172589942', '广州番禺区', '159583', '正常', null, null, null, null, '1', null, '2');
INSERT INTO `student` VALUES ('8', '20170008', '岳灵珊', '0', '18165161642', '1227525894@qq.com', '1999-04-21', '450902199901316548', '岳灵珊', '18172589942', '广州番禺区', '159523', '正常', null, null, null, null, '1', null, '4');
INSERT INTO `student` VALUES ('9', '20170009', '宁中则', '0', '18158911742', '1227522054@qq.com', '2021-04-09', '450902199901316548', '宁中则', '18172581742', '广州花都区', '159523', '正常', null, null, null, null, '1', null, '4');
INSERT INTO `student` VALUES ('10', '20170010', '仪琳', '0', '18158911742', '1589525894@qq.com', '1999-08-11', '450902199510165311', '仪琳', '18172454742', '广州番禺区', '159523', '正常', null, null, null, null, '1', null, '2');
INSERT INTO `student` VALUES ('11', '20170011', '田伯光', '1', '18158911742', '1227525894@qq.com', '2021-08-03', '450902199901316547', '田伯光', '18172589942', '广州花都区', '159523', null, null, null, null, null, '1', null, '1');
INSERT INTO `student` VALUES ('12', '20170012', '蒙奇·D·路飞', '1', '18172141742', '1227525894@qq.com', '1998-08-08', '450902199510165311', '蒙奇·D·路飞', '18172589942', '广州番禺区', '157123', null, null, null, null, null, '1', null, '3');
INSERT INTO `student` VALUES ('13', '20170013', '索隆', '1', '18158911742', '1227525894@qq.com', '2003-08-07', '450902199901316531', '索隆', '18172454742', '广州番禺区', '157123', null, null, null, null, null, '1', null, '4');
INSERT INTO `student` VALUES ('14', '20170014', '貂蝉', '0', '18165161642', '1589525794@qq.com', '2003-08-01', '450902199902286532', '貂蝉', '18172454742', '广州番禺区', '157123', '正常', null, null, null, null, '2', null, '2');

-- ----------------------------
-- Table structure for `teacher`
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `t_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '老师标识',
  `t_no` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '老师编号',
  `t_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '姓名',
  `t_gender` int(11) DEFAULT NULL COMMENT '性别',
  `t_phone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '联系电话',
  `t_email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `t_birthday` date DEFAULT NULL COMMENT '生日',
  `t_card` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '身份证',
  `t_school` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '毕业学校',
  `t_year` int(11) DEFAULT NULL COMMENT '毕业年份',
  `t_education` int(11) DEFAULT NULL COMMENT '学历',
  `t_degree` int(11) DEFAULT NULL COMMENT '学位',
  `t_major` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '专业',
  `t_fettle` int(11) DEFAULT NULL COMMENT '状态',
  `t_remark` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`t_id`),
  KEY `t_no` (`t_no`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('1', '20210001', '多佛朗', '1', '18815423036', '165656@163.com', '2021-08-02', '455555555555555', '广东工业大学', '2017', '2', '1', '数学应用', '0', null);
INSERT INTO `teacher` VALUES ('2', '20210002', '树先生', '1', '18172141742', '163@163.com', '2021-08-04', '458888888888888888', '华南理工大学', '2018', '2', '1', '英语', '0', null);
INSERT INTO `teacher` VALUES ('3', '20210003', '成龙', '1', '18172141742', '163@163.com', '2021-08-02', '458888888888888888', '华南理工大学', '2018', '2', '2', '数学应用', '1', null);
INSERT INTO `teacher` VALUES ('4', '20210004', '李珊珊', '0', '18172141742', '163@163.com', '1999-08-03', '458888888888888888', '复旦大学', '2018', '3', '2', '英语', '0', null);
INSERT INTO `teacher` VALUES ('5', '20210005', '刘予曦', '0', '18172141742', '163@163.com', '2007-08-22', '458888888888888888', '复旦大学', '2018', '1', '0', '土木工程', '0', null);

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `account` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '账号',
  `password` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '密码',
  `identity` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '身份',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '123123', '0');
INSERT INTO `user` VALUES ('2', '20170001', '123456', '1');
INSERT INTO `user` VALUES ('3', '20210001', '123456', '2');
INSERT INTO `user` VALUES ('4', '20170002', '123456', '1');
INSERT INTO `user` VALUES ('5', '20170003', '123456', '1');
INSERT INTO `user` VALUES ('6', '20170004', '123456', '1');
INSERT INTO `user` VALUES ('7', '20170005', '123456', '1');
INSERT INTO `user` VALUES ('8', '20170006', '123456', '1');
INSERT INTO `user` VALUES ('9', '20170007', '123456', '1');
INSERT INTO `user` VALUES ('10', '20170008', '123456', '1');
INSERT INTO `user` VALUES ('11', '20170009', '123456', '1');
INSERT INTO `user` VALUES ('12', '20170010', '123456', '1');
INSERT INTO `user` VALUES ('13', '20170011', '123456', '1');
INSERT INTO `user` VALUES ('14', '20170012', '123456', '1');
INSERT INTO `user` VALUES ('15', '20170013', '123456', '1');
INSERT INTO `user` VALUES ('16', '20170014', '123456', '1');
INSERT INTO `user` VALUES ('17', '20170014', '123456', '1');
INSERT INTO `user` VALUES ('18', '20210002', '123456', '2');
INSERT INTO `user` VALUES ('19', '20210003', '123456', '2');
INSERT INTO `user` VALUES ('20', '20210004', '123456', '2');
INSERT INTO `user` VALUES ('21', '20210005', '123456', '2');
