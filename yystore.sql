/*
SQLyog Enterprise v12.09 (64 bit)
MySQL - 5.0.22-community-nt : Database - store_yh
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`store_yh` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `store_yh`;

/*Table structure for table `tb_door` */

CREATE TABLE `tb_door` (
  `id` int(11) NOT NULL auto_increment,
  `door_name` varchar(200) default NULL,
  `tel` varchar(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tb_door` */

insert  into `tb_door`(`id`,`door_name`,`tel`) values (1,'永和大王1店','4008-000000'),(2,'永和大王2店','888'),(3,'永和大王3店','90909090'),(4,'永和大王4店','80908090');

/*Table structure for table `tb_food` */

CREATE TABLE `tb_food` (
  `id` int(11) NOT NULL auto_increment COMMENT 'id',
  `name` varchar(50) default NULL COMMENT '菜名',
  `price` double default NULL COMMENT '单价',
  `status` tinyint(4) default '1' COMMENT '食物状态，1-正常，2-下架',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tb_food` */

insert  into `tb_food`(`id`,`name`,`price`,`status`) values (1,'玉米肉松蛋饼',600,1),(2,'豆浆油条',1000,1),(3,'肠粉',500,1),(4,'姜撞奶',1500,1),(5,'小笼包',400,1),(6,'韭菜炒蛋',1200,1),(7,'白辣椒炒腊肉',1300,1),(8,'酸辣鸡杂',1300,1),(9,'茄子豆角炒肉',1300,1),(10,'凉瓜肉丝',1300,1),(11,'酸菜肉丝',1300,1),(12,'莴笋炒腊肉',1350,1),(13,'鱼香肉丝',2000,1),(14,'宫保鸡丁',1200,1),(15,'醋溜土豆丝',500,1),(16,'炖水饺',600,1);

