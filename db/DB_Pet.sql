/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : DB_Pet

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'name',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'content',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'time',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'img',
  `num` int DEFAULT '0' COMMENT 'num',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'address',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of activity
-- ----------------------------
BEGIN;
INSERT INTO `activity` VALUES (6, 'Caring Pets | Share the Moment',
'Dear dog lovers, we warmly invite you to join our Joyful Dog Carnival! This will be an event filled with fun and laughter, where your dogs can enjoy an unforgettable time.\n\nOn the day of the event, your dogs will join many adorable friends in a variety of games and challenges. We’ll have a dedicated play area where dogs can showcase their intelligence, agility, and teamwork. There will also be vibrant food stalls offering a range of dog-friendly treats.\n\nIn addition, we have prepared fantastic performances, including dog talent shows and fashion runway shows. You’ll have the chance to demonstrate the unique bond and special skills you share with your dog.\n\nThis day will be full of joy and friendship. We believe that through this event, you and your dog will strengthen your bond and meet many more people who love dogs.',
'2024-06-04 13:05:34', '/file/8efa20e95cbe40c59ec804531a21ebc5.jpg', 15, 'NYC USA');
COMMIT;

-- ----------------------------
-- Table structure for adopt
-- ----------------------------
DROP TABLE IF EXISTS `adopt`;
CREATE TABLE `adopt` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `animal_id` int NOT NULL COMMENT 'stray animal id',
  `adopt_status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci NOT NULL COMMENT 'adoption status',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of adopt
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for animal
-- ----------------------------
DROP TABLE IF EXISTS `animal`;
CREATE TABLE `animal` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `nickname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'nickname',
  `sex` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'sex',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'type',
  `age` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'age',
  `img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'img',
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'address',
  `status` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'status',
  `sterilization` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'sterilization',
  `vaccine` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'vaccine',
  `adopt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'adopt',
  `information` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'information',
  `is_adopt` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'isAdopt',
  `praise` int DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of animal
-- ----------------------------
BEGIN;
INSERT INTO `animal` VALUES (1, 'Cat', 'Male', 'Cat', '2 years', '/file/933d720ff1a34d338f1129a51554337c.png', 'Indoor', 'Good', 'Yes', 'Vaccinated', 'Available for Adoption', 'Gentle temperament', 'No', 1);
INSERT INTO `animal` VALUES (2, 'Shiba Inu', 'Male', 'Dog', '12 months', '/file/4df52f51f9dc42179181d6ce2d5f312c.jpg', 'Outdoor, Indoor', 'Healthy', 'No', 'Not Vaccinated', 'Not Available for Adoption', 'Adorable Shiba Inu', 'Yes', 2);
INSERT INTO `animal` VALUES (3, 'Silly Husky', 'Male', 'Husky', '12 months', '/file/44b86dcc15e84babb2e949ccb54af193.jpg', 'Indoor, Outdoor', 'Healthy', 'No', 'Vaccinated', 'Available for Adoption', 'A bit silly', 'No', 0);
INSERT INTO `animal` VALUES (4, 'Chubby British Shorthair', 'Female', 'British Shorthair', '6 months', '/file/76722e96859c4f3e843e506598acf65c.jpg', 'Indoor', 'Healthy', 'No', 'Vaccinated', 'Available for Adoption', 'Cute little kitten', 'No', 0);
COMMIT;


-- ----------------------------
-- Table structure for applcation
-- ----------------------------
DROP TABLE IF EXISTS `applcation`;
CREATE TABLE `applcation` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'name',
  `sex` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'sex',
  `age` int DEFAULT NULL COMMENT 'age',
  `experience` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'experience',
  `pet` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'pet',
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'phone',
  `married` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'married',
  `income` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'income',
  `profession` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'profession',
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'address',
  `reason` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'reason',
  `state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT 'under review' COMMENT 'state',
  `animal_id` int DEFAULT NULL COMMENT 'animalId',
  `user_id` int DEFAULT NULL COMMENT 'userId',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of applcation
-- ----------------------------
BEGIN;
INSERT INTO `applcation` VALUES (1, 'Zhang Sheng', 'Male', 29, 'No experience', NULL, '15877777777', 'Single', '5000+', 'Programmer', 'Guangzhou', 'Likes', 'Review Failed', 2, 2);
INSERT INTO `applcation` VALUES (2, 'Wang Er', 'Male', 29, 'Experienced', NULL, '15877777777', 'Married', '9000+', 'Private Sector Employee', 'Guangzhou', 'Likes', 'Review Passed', 2, 3);
COMMIT;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `user_id` int DEFAULT NULL,
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of article
-- ----------------------------
BEGIN;
INSERT INTO `article` VALUES (8, 'Come see how cute my dog is', '![01.jpg](http://localhost:9311/file/dd2cfa5daa7a4ca2b82593d21a31b655.jpg)', 1, '2023-11-25 23:11:31', 'Admin');
COMMIT;

-- ----------------------------
-- Table structure for article_kp
-- ----------------------------
DROP TABLE IF EXISTS `article_kp`;
CREATE TABLE `article_kp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'name',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'content',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'time',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'img',
  `read1` int DEFAULT '0' COMMENT 'read1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of article_kp
-- ----------------------------
BEGIN;
INSERT INTO `article_kp` VALUES (7, 'Dogs: Humanity’s Most Loyal Friends',
'Dogs are one of the most popular pets among humans and are often celebrated as our most loyal friends. They come in a variety of breeds, from small to large, with appearances ranging from long-haired, short-haired, or even hairless, and with many different colors and patterns.',
'2023-12-04 13:17:51', '/file/26ffa20a68bc42c4bb5bfc7dea74c8d0.jpg', 13);
COMMIT;


-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'content',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'user',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'time',
  `pid` int DEFAULT NULL ,
  `article_id` int DEFAULT NULL ,
  `type` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
INSERT INTO `comment` VALUES (9, 'cute', 'user', '2023-11-25 23:17:01', NULL, 8, 2);
INSERT INTO `comment` VALUES (10, 'nice', 'admin', '2024-01-09 18:34:12', NULL, 4, 1);
COMMIT;

-- ----------------------------
-- Table structure for donate
-- ----------------------------
DROP TABLE IF EXISTS `donate`;
CREATE TABLE `donate` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `goods` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `time` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of donate
-- ----------------------------
BEGIN;
INSERT INTO `donate` VALUES (1, 'Tom', 'milk', '2023-11-25 22:56:46');
COMMIT;

-- ----------------------------
-- Table structure for feed
-- ----------------------------
DROP TABLE IF EXISTS `feed`;
CREATE TABLE `feed` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `img2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `img3` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `information` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of feed
-- ----------------------------
BEGIN;
INSERT INTO `feed` VALUES (1, '/file/85875c69618f4c24ae6ac709ee8ed7ed.png', '/file/9be7a2f2b42d4501a622b6b4cf4e0323.jpg', '/file/474325240ccf406da71e080cb804f6d0.jpg', 'LA USA', 'feed spot');
COMMIT;

-- ----------------------------
-- Table structure for lost
-- ----------------------------
DROP TABLE IF EXISTS `lost`;
CREATE TABLE `lost` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `nickname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `sex` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `person` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `status1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `status2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of lost
-- ----------------------------
BEGIN;
INSERT INTO `lost` VALUES (1, 'jiji', 'dog', 'male', 'sixi', '15877777777', 'lost', 'not found');
INSERT INTO `lost` VALUES (2, 'mi', 'cat', 'female', 'ming', '15877777777', 'lost', 'not found');
COMMIT;

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `content` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
BEGIN;
INSERT INTO `notice` VALUES (3, 'A Message for Pet Lovers',
'Dear pet lovers, thank you for your ongoing support and attention to our pet management system! Through this announcement, we want to share some important information with you.\n\nIf you are looking for a loyal dog, a graceful cat, or a small companion like a bird or a rabbit, we are here to help you find the perfect match.',
'2023-11-25 00:00:00');

INSERT INTO `notice` VALUES (4, 'Words on Adopting a Pet',
'Whether you are seeking companionship or wanting to extend your love to a life in need, we welcome you to join our pet adoption family! If you have any questions or suggestions about using the system, the adoption process, or anything else, please feel free to reach out to our customer service team. We are here to help.\n\nThank you once again for your support and care! Let us work together to protect and cherish every pet!',
'2023-11-25 00:00:00');

INSERT INTO `notice` VALUES (5, 'If You Wish to Donate Supplies for Pets',
'If you would like to donate supplies to stray pets, please contact the person in charge: Zhang San, contact number: 010-65998877.', NULL);

COMMIT;

-- ----------------------------
-- Table structure for rescue
-- ----------------------------
DROP TABLE IF EXISTS `rescue`;
CREATE TABLE `rescue` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `addres` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `person` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `information` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of rescue
-- ----------------------------
BEGIN;
INSERT INTO `rescue` VALUES (1, '1', 'pet help center', '/file/6f31365a6b7d4b54a7191070671540b0.jpg', 'wuwu', '15877777777', 'help center');
COMMIT;

-- ----------------------------
-- Table structure for salvation
-- ----------------------------
DROP TABLE IF EXISTS `salvation`;
CREATE TABLE `salvation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `information` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `img` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `time` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `person` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT 'unsolved' ,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of salvation
-- ----------------------------
BEGIN;
INSERT INTO `salvation` VALUES (1, 'A suspected lost house cat found', '/file/85875c69618f4c24ae6ac709ee8ed7ed.png', 'People’s Square, Haidian District', '2023-11-25 22:50:28', 'Zhang San', '15977777777', 'Unresolved');
INSERT INTO `salvation` VALUES (2, 'A stray puppy found in the wild', '/file/a1b72fa413254627b8b5a4be39a1989b.png', 'Museum, Haidian District', '2023-11-25 22:50:58', 'Li Si', '13088888888', 'Unresolved');
COMMIT;

-- ----------------------------
-- Table structure for sterilization
-- ----------------------------
DROP TABLE IF EXISTS `sterilization`;
CREATE TABLE `sterilization` (
  `id` int NOT NULL AUTO_INCREMENT ,
  `animal_id` int DEFAULT NULL ,
  `catch1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `sterilization` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `release1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `vaccine` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL ,
  `animal_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sterilization
-- ----------------------------
BEGIN;
INSERT INTO `sterilization` VALUES (2, 1, 'captured', 'yes', 'not released', 'vaccined', 'kitten');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict` VALUES ('add', 'iconfont icon-r-add', 'icon');
INSERT INTO `sys_dict` VALUES ('edit', 'iconfont icon-r-edit', 'icon');
INSERT INTO `sys_dict` VALUES ('delete', 'iconfont icon-r-delete', 'icon');
INSERT INTO `sys_dict` VALUES ('find', 'iconfont icon-r-find', 'icon');
INSERT INTO `sys_dict` VALUES ('user1', 'iconfont icon-r-user1', 'icon');
INSERT INTO `sys_dict` VALUES ('user2', 'iconfont icon-r-user2', 'icon');
INSERT INTO `sys_dict` VALUES ('user3', 'iconfont icon-r-user3', 'icon');
INSERT INTO `sys_dict` VALUES ('team', 'iconfont icon-r-team', 'icon');
INSERT INTO `sys_dict` VALUES ('home', 'iconfont icon-r-home', 'icon');
INSERT INTO `sys_dict` VALUES ('buildin', 'iconfont icon-r-building', 'icon');
INSERT INTO `sys_dict` VALUES ('mark1', 'iconfont icon-r-mark1', 'icon');
INSERT INTO `sys_dict` VALUES ('mark2', 'iconfont icon-r-mark2', 'icon');
INSERT INTO `sys_dict` VALUES ('mark3', 'iconfont icon-r-mark3', 'icon');
INSERT INTO `sys_dict` VALUES ('shield', 'iconfont icon-r-shield', 'icon');
INSERT INTO `sys_dict` VALUES ('refresh', 'iconfont icon-r-refresh', 'icon');
INSERT INTO `sys_dict` VALUES ('love', 'iconfont icon-r-love', 'icon');
INSERT INTO `sys_dict` VALUES ('yes', 'iconfont icon-r-yes', 'icon');
INSERT INTO `sys_dict` VALUES ('no', 'iconfont icon-r-no', 'icon');
INSERT INTO `sys_dict` VALUES ('paper', 'iconfont icon-r-paper', 'icon');
INSERT INTO `sys_dict` VALUES ('list', 'iconfont icon-r-list', 'icon');
INSERT INTO `sys_dict` VALUES ('setting', 'iconfont icon-r-setting', 'icon');
COMMIT;

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `size` bigint DEFAULT NULL ,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `md5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `is_delete` tinyint(1) DEFAULT '0' ,
  `enable` tinyint(1) DEFAULT '1' ,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
BEGIN;
INSERT INTO `sys_file` VALUES (90, 'logo2.jpg', 'jpg', 635, '/file/d0f1c679738d4481a1aeb5fd45446982.jpg', '96564de9ed610acff96bc60b5d98e375', 0, 1);
INSERT INTO `sys_file` VALUES (91, '04.jpg', 'jpg', 616, '/file/bb7940b20bb54131a9e3e50cc25c34a4.jpg', '09ea457b9b65cb136584e58579859d4d', 0, 1);
INSERT INTO `sys_file` VALUES (92, '03.jpg', 'jpg', 444, '/file/76b04f48e4a64758b33ecb2fb2f5dcac.jpg', '75e3957bd425eb50fb6976614fb71aa5', 0, 1);
INSERT INTO `sys_file` VALUES (93, '03.jpg', 'jpg', 459, '/file/1c6b1cb486894bd1a91d37b359f97017.jpg', '7c1ef6b581f147cdbbff672cc7c4bd3b', 0, 1);
INSERT INTO `sys_file` VALUES (94, '03.jpg', 'jpg', 631, '/file/baf9051740e9477f986d9a9c7b990911.jpg', '02a0c9cdcb7bb5e5869ef70f5b4a2f30', 0, 1);
INSERT INTO `sys_file` VALUES (95, '10.jpg', 'jpg', 382, '/file/453d3c84562d4f6c968c3ebff42fcd99.jpg', 'b80d6f23dee70c86a744238b84a2711b', 0, 1);
INSERT INTO `sys_file` VALUES (96, '01.jpg', 'jpg', 574, '/file/dd2cfa5daa7a4ca2b82593d21a31b655.jpg', '90dd30ec3c6f0165c14a3dcb203f4093', 0, 1);
INSERT INTO `sys_file` VALUES (97, '05.jpg', 'jpg', 472, '/file/adf6d0a863ca4cf8bf8ac40595b83c93.jpg', '0ea6f890816f6df043f6b9f3e0baf93b', 0, 1);
INSERT INTO `sys_file` VALUES (98, '02.jpg', 'jpg', 540, '/file/32f5b5f61910408aa97acdbc056e2d10.jpg', 'd9a02baae4f4ffc9beda40a6419413df', 0, 1);
INSERT INTO `sys_file` VALUES (99, '06.jpg', 'jpg', 583, '/file/ee49442a3317454a9da737629d1c8895.jpg', 'b95d7cd6ef41116f9769cf8ff6c24aef', 0, 1);
INSERT INTO `sys_file` VALUES (100, '03.jpg', 'jpg', 631, '/file/baf9051740e9477f986d9a9c7b990911.jpg', '02a0c9cdcb7bb5e5869ef70f5b4a2f30', 0, 1);
INSERT INTO `sys_file` VALUES (101, '01.jpg', 'jpg', 574, '/file/dd2cfa5daa7a4ca2b82593d21a31b655.jpg', '90dd30ec3c6f0165c14a3dcb203f4093', 0, 1);
INSERT INTO `sys_file` VALUES (102, '02.jpg', 'jpg', 540, '/file/32f5b5f61910408aa97acdbc056e2d10.jpg', 'd9a02baae4f4ffc9beda40a6419413df', 0, 1);
INSERT INTO `sys_file` VALUES (103, '01.jpg', 'jpg', 574, '/file/dd2cfa5daa7a4ca2b82593d21a31b655.jpg', '90dd30ec3c6f0165c14a3dcb203f4093', 0, 1);
INSERT INTO `sys_file` VALUES (104, '01.jpg', 'jpg', 574, '/file/dd2cfa5daa7a4ca2b82593d21a31b655.jpg', '90dd30ec3c6f0165c14a3dcb203f4093', 0, 1);
INSERT INTO `sys_file` VALUES (105, '01.jpg', 'jpg', 574, '/file/dd2cfa5daa7a4ca2b82593d21a31b655.jpg', '90dd30ec3c6f0165c14a3dcb203f4093', 0, 1);
INSERT INTO `sys_file` VALUES (106, '01.jpg', 'jpg', 574, '/file/dd2cfa5daa7a4ca2b82593d21a31b655.jpg', '90dd30ec3c6f0165c14a3dcb203f4093', 0, 1);
INSERT INTO `sys_file` VALUES (107, '01.jpg', 'jpg', 146, '/file/a0455b12998a4d32b280e5f5542bbcc6.jpg', '5c072037e4e9662831fe448e28795770', 0, 1);
INSERT INTO `sys_file` VALUES (108, '01.jpg', 'jpg', 146, '/file/a0455b12998a4d32b280e5f5542bbcc6.jpg', '5c072037e4e9662831fe448e28795770', 0, 1);
INSERT INTO `sys_file` VALUES (109, '01.jpg', 'jpg', 146, '/file/a0455b12998a4d32b280e5f5542bbcc6.jpg', '5c072037e4e9662831fe448e28795770', 0, 1);
INSERT INTO `sys_file` VALUES (110, 'Music.jpg', 'jpg', 816, '/file/76722e96859c4f3e843e506598acf65c.jpg', '8b9faeb1e1ef2eb8878ee78319fbfd91', 0, 1);
INSERT INTO `sys_file` VALUES (111, 'Community.jpg', 'jpg', 686, '/file/44b86dcc15e84babb2e949ccb54af193.jpg', '6625230db6cbed9e87ce5f142cce5fe9', 0, 1);
INSERT INTO `sys_file` VALUES (112, 'Exam.jpg', 'jpg', 488, '/file/4df52f51f9dc42179181d6ce2d5f312c.jpg', '5ebe9b4337ca94be4055ae2b353325fa', 0, 1);
INSERT INTO `sys_file` VALUES (113, 'Secondhand Market.png', 'png', 2380, '/file/933d720ff1a34d338f1129a51554337c.png', '9aa1b9cc10f315681203f99791651c74', 0, 1);
INSERT INTO `sys_file` VALUES (114, 'Library.png', 'png', 2085, '/file/a1b72fa413254627b8b5a4be39a1989b.png', '142fba75fb510a7451dbfd405d64d10b', 0, 1);
INSERT INTO `sys_file` VALUES (115, 'School Dormitory.png', 'png', 1543, '/file/85875c69618f4c24ae6ac709ee8ed7ed.png', 'd7162ad518d2e42f27300595b8593c36', 0, 1);
INSERT INTO `sys_file` VALUES (116, 'School Dormitory.png', 'png', 1543, '/file/85875c69618f4c24ae6ac709ee8ed7ed.png', 'd7162ad518d2e42f27300595b8593c36', 0, 1);
INSERT INTO `sys_file` VALUES (117, 'Mall (1).jpg', 'jpg', 396, '/file/c87079e161fe4d3c8756a8188207ba0a.jpg', 'b39e93876e5e2e2de9e232956c3df4f9', 0, 1);
INSERT INTO `sys_file` VALUES (118, 'Hospital.jpg', 'jpg', 375, '/file/474325240ccf406da71e080cb804f6d0.jpg', '05230c5681a85c4252f8b002d12772bc', 0, 1);
INSERT INTO `sys_file` VALUES (119, 'Mall.jpg', 'jpg', 421, '/file/9be7a2f2b42d4501a622b6b4cf4e0323.jpg', 'af3e3d03dae1f1cc76511b64b8913a2b', 0, 1);
INSERT INTO `sys_file` VALUES (120, 'Movie.jpg', 'jpg', 194, '/file/6f31365a6b7d4b54a7191070671540b0.jpg', 'ace809e49a65a46e4de8115538a77724', 0, 1);
INSERT INTO `sys_file` VALUES (121, 'Personal Blog.jpg', 'jpg', 409, '/file/26ffa20a68bc42c4bb5bfc7dea74c8d0.jpg', '9e9b0c1507cec6752e905c6394917fdf', 0, 1);
INSERT INTO `sys_file` VALUES (122, 'Parking Lot.jpg', 'jpg', 859, '/file/8efa20e95cbe40c59ec804531a21ebc5.jpg', 'cba1f42ea01b2b71f44c9d76e8ccc2b5', 0, 1);
INSERT INTO `sys_file` VALUES (123, '2.png', 'png', 33, '/file/ff35233e8e244a3e8c28a5031b1364d1.png', '356dce87fd32545dd8e929eb9b069308', 0, 1);
INSERT INTO `sys_file` VALUES (124, '1.png', 'png', 47, '/file/36112d2125d5478cb956385e44d86640.png', 'b8b1242cb02994c3a6e4cd39fd11e8e2', 0, 1);
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `pid` int DEFAULT NULL ,
  `page_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `sort_num` int DEFAULT NULL ,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` VALUES (4, 'System Management', NULL, 'iconfont icon-r-setting', NULL, NULL, NULL, 300);
INSERT INTO `sys_menu` VALUES (5, 'User Management', '/user', 'iconfont icon-r-user2', NULL, 4, 'User', 301);
INSERT INTO `sys_menu` VALUES (6, 'Role Management', '/role', 'iconfont icon-r-user3', NULL, 4, 'Role', 302);
INSERT INTO `sys_menu` VALUES (7, 'Menu Management', '/menu', 'iconfont icon-r-setting', NULL, 4, 'Menu', 303);
INSERT INTO `sys_menu` VALUES (8, 'File Management', '/file', 'iconfont icon-r-paper', NULL, 4, 'File', 304);
INSERT INTO `sys_menu` VALUES (10, 'Home', '/home', 'iconfont icon-r-home', NULL, NULL, 'Home', 0);
INSERT INTO `sys_menu` VALUES (11, 'Stray Animal Management', '/animal', 'iconfont icon-r-love', NULL, 25, 'Animal', 401);
INSERT INTO `sys_menu` VALUES (12, 'Pet Sterilization Management', '/sterilization', 'iconfont icon-r-refresh', NULL, 25, 'Sterilization', 402);
INSERT INTO `sys_menu` VALUES (13, 'Adoption Application Management', '/applcation', 'iconfont icon-r-add', NULL, 25, 'Application', 407);
INSERT INTO `sys_menu` VALUES (14, 'Comment Management', '/comment', 'iconfont icon-r-team', NULL, 26, 'Comment', 501);
INSERT INTO `sys_menu` VALUES (15, 'Stray Animal Rescue', '/salvation', 'iconfont icon-r-love', NULL, 25, 'Salvation', 403);
INSERT INTO `sys_menu` VALUES (16, 'Feeding Point Management', '/feed', 'iconfont icon-r-building', NULL, 25, 'Feed', 405);
INSERT INTO `sys_menu` VALUES (18, 'Lost Pet Management', '/lost', 'iconfont icon-r-no', NULL, 25, 'Lost', 404);
INSERT INTO `sys_menu` VALUES (19, 'Rescue Center Management', '/rescue', 'iconfont icon-r-building', NULL, 25, 'Rescue', 406);
INSERT INTO `sys_menu` VALUES (20, 'Post Management', '/article', 'iconfont icon-r-edit', NULL, 26, 'Article', 502);
INSERT INTO `sys_menu` VALUES (21, 'Donation Management', '/donate', 'iconfont icon-r-yes', NULL, 26, 'Donate', 503);
INSERT INTO `sys_menu` VALUES (22, 'Notice Management', '/notice', 'iconfont icon-r-edit', NULL, 4, 'Notice', 305);
INSERT INTO `sys_menu` VALUES (23, 'Popular Science Article Management', '/articleKp', 'iconfont icon-r-edit', NULL, 26, 'ArticleKp', 504);
INSERT INTO `sys_menu` VALUES (24, 'Event Management', '/activity', 'iconfont icon-r-mark1', NULL, 26, 'Activity', 505);
INSERT INTO `sys_menu` VALUES (25, 'Pet Management', NULL, 'iconfont icon-r-love', NULL, NULL, NULL, 400);
INSERT INTO `sys_menu` VALUES (26, 'Other Management', NULL, 'iconfont icon-r-list', NULL, NULL, NULL, 500);
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `flag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES (1, 'admin', 'admin', 'ROLE_ADMIN');
INSERT INTO `sys_role` VALUES (2, 'user', 'user', 'ROLE_USER');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` int NOT NULL,
  `menu_id` int NOT NULL ,
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` VALUES (1, 4);
INSERT INTO `sys_role_menu` VALUES (1, 5);
INSERT INTO `sys_role_menu` VALUES (1, 6);
INSERT INTO `sys_role_menu` VALUES (1, 7);
INSERT INTO `sys_role_menu` VALUES (1, 8);
INSERT INTO `sys_role_menu` VALUES (1, 10);
INSERT INTO `sys_role_menu` VALUES (1, 11);
INSERT INTO `sys_role_menu` VALUES (1, 12);
INSERT INTO `sys_role_menu` VALUES (1, 13);
INSERT INTO `sys_role_menu` VALUES (1, 14);
INSERT INTO `sys_role_menu` VALUES (1, 15);
INSERT INTO `sys_role_menu` VALUES (1, 16);
INSERT INTO `sys_role_menu` VALUES (1, 18);
INSERT INTO `sys_role_menu` VALUES (1, 19);
INSERT INTO `sys_role_menu` VALUES (1, 20);
INSERT INTO `sys_role_menu` VALUES (1, 21);
INSERT INTO `sys_role_menu` VALUES (1, 22);
INSERT INTO `sys_role_menu` VALUES (1, 23);
INSERT INTO `sys_role_menu` VALUES (1, 24);
INSERT INTO `sys_role_menu` VALUES (1, 25);
INSERT INTO `sys_role_menu` VALUES (1, 26);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 8);
INSERT INTO `sys_role_menu` VALUES (2, 10);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ,
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  `birth` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL ,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES (1, 'admin', '123456', 'admin', '123@qq.com', '18677888888', 'LA', '2023-06-22 21:10:27', '/file/ff35233e8e244a3e8c28a5031b1364d1.png', 'ROLE_ADMIN', 'male', '1999-07-01');
INSERT INTO `sys_user` VALUES (4, 'user', '123456', 'eta', '155@qq.com', '18677777777', 'Boston', '2023-11-25 22:31:12', '/file/36112d2125d5478cb956385e44d86640.png', 'ROLE_USER', 'male', '2023-11-25');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
