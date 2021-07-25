/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50710
Source Host           : localhost:3306
Source Database       : student

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2021-07-26 16:43:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for class
-- ----------------------------
DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `cid` bigint(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `number` int(11) NOT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of class
-- ----------------------------

-- ----------------------------
-- Table structure for curriculum
-- ----------------------------
DROP TABLE IF EXISTS `curriculum`;
CREATE TABLE `curriculum` (
  `cid` bigint(20) NOT NULL,
  `number` varchar(50) NOT NULL COMMENT '课程编码',
  `name` varchar(50) NOT NULL,
  `state` int(11) DEFAULT NULL,
  `remarks` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of curriculum
-- ----------------------------

-- ----------------------------
-- Table structure for examination_score
-- ----------------------------
DROP TABLE IF EXISTS `examination_score`;
CREATE TABLE `examination_score` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sid` bigint(20) DEFAULT NULL,
  `cid` bigint(20) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `remarks` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_EXAMINAT_REFERENCE_STUDENT` (`sid`),
  KEY `FK_EXAMINAT_REFERENCE_CURRICUL` (`cid`),
  CONSTRAINT `FK_EXAMINAT_REFERENCE_CURRICUL` FOREIGN KEY (`cid`) REFERENCES `curriculum` (`cid`),
  CONSTRAINT `FK_EXAMINAT_REFERENCE_STUDENT` FOREIGN KEY (`sid`) REFERENCES `student` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of examination_score
-- ----------------------------

-- ----------------------------
-- Table structure for member_family
-- ----------------------------
DROP TABLE IF EXISTS `member_family`;
CREATE TABLE `member_family` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sid` bigint(20) DEFAULT NULL,
  `member_type` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `gender` int(11) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `id_card` varchar(50) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `remarks` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_MEMBER_F_REFERENCE_STUDENT` (`sid`),
  CONSTRAINT `FK_MEMBER_F_REFERENCE_STUDENT` FOREIGN KEY (`sid`) REFERENCES `student` (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of member_family
-- ----------------------------

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `sid` bigint(20) NOT NULL,
  `sno` int(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `gender` int(11) DEFAULT NULL COMMENT '1：女      2：男',
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `id_card` varchar(50) DEFAULT NULL,
  `contacts` varchar(50) DEFAULT NULL COMMENT '联系人',
  `contacts_phone` varchar(50) DEFAULT NULL,
  `home_address` varchar(50) DEFAULT NULL,
  `father_name` varchar(50) DEFAULT NULL,
  `father_phone` varchar(50) DEFAULT NULL,
  `mother_name` varchar(50) DEFAULT NULL,
  `mother_phone` varchar(50) DEFAULT NULL,
  `state` int(11) DEFAULT '1' COMMENT '1：在读   2：毕业  3：退学',
  `remarks` varchar(2000) DEFAULT NULL COMMENT '备注',
  `cid` bigint(20) DEFAULT NULL COMMENT '班级编码',
  PRIMARY KEY (`sid`,`sno`),
  KEY `FK_STUDENT_REFERENCE_CLASS` (`cid`),
  CONSTRAINT `FK_STUDENT_REFERENCE_CLASS` FOREIGN KEY (`cid`) REFERENCES `class` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', '10001', '小陈', '1', '13060', '1234586@qq.com', '2021-05-10', '445', '小小陈', '11123', '广东', '小陈', '123456', '大陈', '456789', '1', '无', null);

-- ----------------------------
-- Table structure for system_code
-- ----------------------------
DROP TABLE IF EXISTS `system_code`;
CREATE TABLE `system_code` (
  `code_id` bigint(20) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `desciption` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system_code
-- ----------------------------
INSERT INTO `system_code` VALUES ('1', 'sex', '性别');
INSERT INTO `system_code` VALUES ('2', 'state', '学生的状态');
INSERT INTO `system_code` VALUES ('4', 'semester', '学期');
INSERT INTO `system_code` VALUES ('5', 'education_background', '学历');
INSERT INTO `system_code` VALUES ('6', 'academic_degree', '学位');

-- ----------------------------
-- Table structure for system_code_detail
-- ----------------------------
DROP TABLE IF EXISTS `system_code_detail`;
CREATE TABLE `system_code_detail` (
  `detail_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code_id` bigint(20) DEFAULT NULL,
  `code_value` int(11) DEFAULT NULL,
  `code_desciption` varchar(50) DEFAULT NULL,
  `state` int(2) DEFAULT '1' COMMENT '1：启用  2：禁用',
  PRIMARY KEY (`detail_id`),
  KEY `code_id` (`code_id`),
  CONSTRAINT `system_code_detail_ibfk_1` FOREIGN KEY (`code_id`) REFERENCES `system_code` (`code_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system_code_detail
-- ----------------------------
INSERT INTO `system_code_detail` VALUES ('1', '1', '1', '女', null);
INSERT INTO `system_code_detail` VALUES ('2', '1', '2', '男', null);
INSERT INTO `system_code_detail` VALUES ('3', '2', '1', '在读', null);
INSERT INTO `system_code_detail` VALUES ('4', '2', '2', '毕业', null);
INSERT INTO `system_code_detail` VALUES ('5', '2', '3', '退学', null);
INSERT INTO `system_code_detail` VALUES ('6', '2', '4', '就职', null);
INSERT INTO `system_code_detail` VALUES ('7', '2', '5', '离职', null);
INSERT INTO `system_code_detail` VALUES ('8', '4', '1', '上学期', null);
INSERT INTO `system_code_detail` VALUES ('9', '4', '2', '下学期', null);
INSERT INTO `system_code_detail` VALUES ('10', '5', '1', '小学', null);
INSERT INTO `system_code_detail` VALUES ('11', '5', '2', '初中', null);
INSERT INTO `system_code_detail` VALUES ('12', '5', '3', '高中', null);
INSERT INTO `system_code_detail` VALUES ('13', '5', '4', '大专', null);
INSERT INTO `system_code_detail` VALUES ('14', '5', '5', '本科', null);
INSERT INTO `system_code_detail` VALUES ('15', '5', '6', '硕士研究生', null);
INSERT INTO `system_code_detail` VALUES ('16', '5', '7', '博士研究生', null);
INSERT INTO `system_code_detail` VALUES ('20', '6', '1', '学士', null);
INSERT INTO `system_code_detail` VALUES ('21', '6', '2', '硕士', null);
INSERT INTO `system_code_detail` VALUES ('22', '6', '3', '博士', null);

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `tid` bigint(20) NOT NULL,
  `tno` int(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `gender` int(11) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `id_card` varchar(50) DEFAULT NULL,
  `graduate_school` varchar(50) DEFAULT NULL,
  `graduate_year` int(11) DEFAULT NULL,
  `education_background` int(11) DEFAULT NULL COMMENT '学历',
  `academic_degree` int(11) DEFAULT NULL COMMENT '学位',
  `major` varchar(50) DEFAULT NULL COMMENT '所学专业',
  `state` int(11) DEFAULT NULL COMMENT '1：就职   2：离职',
  `remarks` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('1', '20001', '张sir', '1', '12356', '161@qq.com', '1991-07-26', '15156', '广大', '2021', '1', '1', '软件', '1', null);

-- ----------------------------
-- Table structure for teacher_curriculum
-- ----------------------------
DROP TABLE IF EXISTS `teacher_curriculum`;
CREATE TABLE `teacher_curriculum` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tid` bigint(20) NOT NULL,
  `cid` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_TEACHER__REFERENCE_TEACHER` (`tid`),
  KEY `FK_TEACHER__REFERENCE_CURRICUL` (`cid`),
  CONSTRAINT `FK_TEACHER__REFERENCE_CURRICUL` FOREIGN KEY (`cid`) REFERENCES `curriculum` (`cid`),
  CONSTRAINT `FK_TEACHER__REFERENCE_TEACHER` FOREIGN KEY (`tid`) REFERENCES `teacher` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher_curriculum
-- ----------------------------

-- ----------------------------
-- Table structure for teaching
-- ----------------------------
DROP TABLE IF EXISTS `teaching`;
CREATE TABLE `teaching` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cid` bigint(20) DEFAULT NULL,
  `tid` bigint(20) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `remarks` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_TEACHING_REFERENCE_CLASS` (`cid`),
  KEY `FK_TEACHING_REFERENCE_TEACHER` (`tid`),
  CONSTRAINT `FK_TEACHING_REFERENCE_CLASS` FOREIGN KEY (`cid`) REFERENCES `class` (`cid`),
  CONSTRAINT `FK_TEACHING_REFERENCE_TEACHER` FOREIGN KEY (`tid`) REFERENCES `teacher` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teaching
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `identity` varchar(50) NOT NULL,
  `deleted` int(2) NOT NULL DEFAULT '1' COMMENT '1：正常   2：禁用',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '123456789', '管理员', '1');
INSERT INTO `user` VALUES ('2', '10001', '123456', '学生', '1');
INSERT INTO `user` VALUES ('3', '20001', '123456', '老师', '2');
