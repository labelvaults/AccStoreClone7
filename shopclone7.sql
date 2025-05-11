-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 11, 2025 at 02:43 AM
-- Server version: 8.0.30
-- PHP Version: 8.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shopv7`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_request_logs`
--

CREATE TABLE `admin_request_logs` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `request_url` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `request_method` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `request_params` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `ip` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `user_agent` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_role`
--

CREATE TABLE `admin_role` (
  `id` int NOT NULL,
  `name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `role` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL
) ;

--
-- Dumping data for table `admin_role`
--

INSERT INTO `admin_role` (`id`, `name`, `role`, `create_gettime`, `update_gettime`) VALUES
(1, 'Super Admin', '[\"view_license\",\"view_statistical\",\"view_recent_transactions\",\"view_logs\",\"view_transactions\",\"view_block_ip\",\"edit_block_ip\",\"view_automations\",\"edit_automations\",\"view_user\",\"edit_user\",\"login_user\",\"view_role\",\"edit_role\",\"view_recharge\",\"edit_recharge\",\"view_affiliate\",\"view_withdraw_affiliate\",\"edit_withdraw_affiliate\",\"edit_affiliate\",\"view_email_campaigns\",\"edit_email_campaigns\",\"view_coupon\",\"edit_coupon\",\"view_promotion\",\"edit_promotion\",\"view_blog\",\"edit_blog\",\"view_product\",\"edit_product\",\"edit_stock_product\",\"view_orders_product\",\"refund_orders_product\",\"view_order_product\",\"delete_order_product\",\"manager_suppliers\",\"view_sold_product\",\"view_menu\",\"edit_menu\",\"view_lang\",\"edit_lang\",\"view_currency\",\"edit_currency\",\"edit_theme\",\"edit_setting\"]', '2023-11-16 20:28:54', '2024-08-10 12:57:40'),
(2, 'Sales', '[\"view_logs\",\"view_transactions\",\"view_user\",\"view_affiliate\",\"view_withdraw_affiliate\",\"view_coupon\"]', '2023-11-16 20:41:10', '2023-11-16 20:53:56');

-- --------------------------------------------------------

--
-- Table structure for table `aff_log`
--

CREATE TABLE `aff_log` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `reason` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `sotientruoc` float NOT NULL DEFAULT '0',
  `sotienthaydoi` float NOT NULL DEFAULT '0',
  `sotienhientai` float NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `aff_withdraw`
--

CREATE TABLE `aff_withdraw` (
  `id` int NOT NULL,
  `trans_id` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `user_id` int NOT NULL DEFAULT '0',
  `bank` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `stk` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `amount` float NOT NULL DEFAULT '0',
  `status` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'pending',
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `reason` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `automations`
--

CREATE TABLE `automations` (
  `id` int NOT NULL,
  `name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `type` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `product_id` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `schedule` int NOT NULL DEFAULT '0',
  `other` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `banks`
--

CREATE TABLE `banks` (
  `id` int NOT NULL,
  `short_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `accountName` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `accountNumber` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `password` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `token` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `block_ip`
--

CREATE TABLE `block_ip` (
  `id` int NOT NULL,
  `ip` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `attempts` int NOT NULL DEFAULT '0',
  `banned` int NOT NULL DEFAULT '0',
  `reason` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE `cards` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `trans_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `telco` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `amount` int NOT NULL DEFAULT '0',
  `price` int NOT NULL DEFAULT '0',
  `serial` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `pin` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'pending',
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `reason` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `parent_id` int NOT NULL DEFAULT '0',
  `id_api` int NOT NULL DEFAULT '0',
  `supplier_id` int NOT NULL DEFAULT '0',
  `stt` int NOT NULL DEFAULT '0',
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `title` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `keywords` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status` int NOT NULL DEFAULT '1',
  `create_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `id_api`, `supplier_id`, `stt`, `icon`, `name`, `title`, `description`, `keywords`, `slug`, `content`, `status`, `create_date`) VALUES
(1, 0, 0, 0, 0, 'assets/storage/images/categoryI610.png', 'Email', NULL, '', NULL, 'email', NULL, 1, '2025-05-10 01:51:49'),
(2, 0, 0, 0, 1, 'assets/storage/images/iconBT5W.png', 'Facebook', NULL, '', NULL, 'facebook', NULL, 1, '2025-05-10 01:53:05'),
(3, 1, 0, 0, 0, 'assets/storage/images/iconSJ14.png', 'Tài khoản email live 2 ngày', NULL, '', NULL, 'tai-khoan-email-live-2-ngay', NULL, 1, '2025-05-10 01:54:54');

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int NOT NULL,
  `code` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `product_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `amount` int NOT NULL DEFAULT '0',
  `used` int NOT NULL DEFAULT '0',
  `discount` float NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `min` int NOT NULL DEFAULT '1000',
  `max` int NOT NULL DEFAULT '10000000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupon_used`
--

CREATE TABLE `coupon_used` (
  `id` int NOT NULL,
  `coupon_id` int NOT NULL DEFAULT '0',
  `user_id` int NOT NULL DEFAULT '0',
  `trans_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` int NOT NULL,
  `name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `code` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `rate` float NOT NULL DEFAULT '0',
  `symbol_left` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `symbol_right` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `seperator` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `display` int NOT NULL DEFAULT '1',
  `default_currency` int NOT NULL DEFAULT '0',
  `decimal_currency` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `code`, `rate`, `symbol_left`, `symbol_right`, `seperator`, `display`, `default_currency`, `decimal_currency`) VALUES
(3, 'Đồng', 'VND', 1, '', 'đ', 'dot', 0, 0, 0),
(4, 'Dollar', 'USD', 24000, '$', '', 'dot', 1, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `deposit_log`
--

CREATE TABLE `deposit_log` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `method` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `amount` float NOT NULL DEFAULT '0',
  `received` float NOT NULL DEFAULT '0',
  `create_time` int DEFAULT '0',
  `is_virtual` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dongtien`
--

CREATE TABLE `dongtien` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `sotientruoc` float NOT NULL DEFAULT '0',
  `sotienthaydoi` float NOT NULL DEFAULT '0',
  `sotiensau` float NOT NULL DEFAULT '0',
  `thoigian` datetime NOT NULL,
  `noidung` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `transid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `dongtien`
--

INSERT INTO `dongtien` (`id`, `user_id`, `sotientruoc`, `sotienthaydoi`, `sotiensau`, `thoigian`, `noidung`, `transid`) VALUES
(1, 1, 100000000, 60, 99999900, '2025-05-10 02:03:03', 'Thanh toán đơn hàng mua tài khoản <b>email 01</b> - #R6N3681e51671be90', 'ORDER_R6N3681e51671be90'),
(2, 1, 99999900, 300000, 99699900, '2025-05-10 02:08:23', 'Thanh toán đơn hàng mua tài khoản <b>email 02</b> - #8WJF681e52a79956b', 'ORDER_8WJF681e52a79956b'),
(3, 1, 99699900, 300000, 99999900, '2025-05-10 02:13:18', 'Hoàn tiền đơn hàng #8WJF681e52a79956b', 'REFUND_ORDER_8WJF681e52a79956b');

-- --------------------------------------------------------

--
-- Table structure for table `email_campaigns`
--

CREATE TABLE `email_campaigns` (
  `id` int NOT NULL,
  `name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `subject` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `cc` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `bcc` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `content` longblob,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `status` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_sending`
--

CREATE TABLE `email_sending` (
  `id` int NOT NULL,
  `camp_id` int DEFAULT '0',
  `user_id` int NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `response` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_attempts`
--

CREATE TABLE `failed_attempts` (
  `id` int NOT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `attempts` int NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL,
  `type` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `failed_attempts`
--

INSERT INTO `failed_attempts` (`id`, `ip_address`, `attempts`, `create_gettime`, `type`) VALUES
(1, '127.0.0.1', 1, '2025-05-10 14:10:35', 'Login');

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `product_id` int NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int NOT NULL,
  `lang` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `code` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `icon` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `lang_default` int NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `lang`, `code`, `icon`, `lang_default`, `status`) VALUES
(1, 'Vietnamese', 'vi', 'assets/storage/flags/flag_Vietnamese.png', 0, 1),
(2, 'English', 'en', 'assets/storage/flags/flag_English.png', 1, 1),
(20, 'Chinese', 'zh', 'assets/storage/flags/flag_Chinese.png', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `ip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `device` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `createdate` datetime NOT NULL,
  `action` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `user_id`, `ip`, `device`, `createdate`, `action`) VALUES
(1, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 01:23:12', 'Create an account'),
(2, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 01:29:50', 'Set mặc định tiền tệ (Dollar ID 4)'),
(3, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 01:30:16', 'Set default language (English ID 2)'),
(4, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 01:38:00', 'Thay đổi thông tin trong trang cài đặt'),
(5, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 01:51:49', 'Add Category (Email).'),
(6, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 01:53:05', 'Add Category (Facebook).'),
(7, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 01:54:04', 'Edit Category (Email ID 1).'),
(8, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 01:54:54', 'Add Category (Tài khoản email live 2 ngày).'),
(9, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 01:57:41', 'Add Product (email 01).'),
(10, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 01:58:15', 'Edit Category (Tài khoản email live 2 ngày ID 3).'),
(11, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 01:59:50', 'Import tài khoản vào kho hàng 681e4f934ea85'),
(12, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:00:10', 'Import tài khoản vào kho hàng 681e4f934ea85'),
(13, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:00:55', 'Delete Account Stock (12)'),
(14, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:00:55', 'Delete Account Stock (12)'),
(15, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:00:55', 'Delete Account Stock (12)'),
(16, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:00:55', 'Delete Account Stock (12)'),
(17, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:01:35', 'Add Product (email 02).'),
(18, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:03:53', 'Update Status Product (ID 2)'),
(19, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:03:54', 'Update Status Product (ID 2)'),
(20, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:04:01', 'Xoá sản phẩm (email 02 ID 2)'),
(21, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:04:38', 'Add Product (email 02).'),
(22, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:05:19', 'Edit Product (email 02 ID 3).'),
(23, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:05:45', 'Import tài khoản vào kho hàng 681e51a2d9871'),
(24, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:08:38', 'Delete order (R6N3681e51671be90)'),
(25, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:08:56', 'Delete order (8WJF681e52a79956b)'),
(26, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:09:19', 'View order (8WJF681e52a79956b)'),
(27, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:09:48', 'View order (8WJF681e52a79956b)'),
(28, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:13:00', 'Download order (8WJF681e52a79956b)'),
(29, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:13:09', 'View order (8WJF681e52a79956b)'),
(30, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:13:18', 'Hoàn tiền đơn hàng (8WJF681e52a79956b)'),
(31, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:23:14', 'Xoá ngôn ngữ (Thailand ID 19)'),
(32, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:23:25', 'Chỉnh sửa ngôn ngữ (1).'),
(33, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:23:35', 'Chỉnh sửa ngôn ngữ (20).'),
(34, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:23:46', 'Chỉnh sửa tiền tệ (Đồng).'),
(35, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:29:04', 'Thay đổi thông tin trong trang cài đặt'),
(36, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:31:06', 'Thay đổi thông tin trong trang cài đặt'),
(37, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:32:51', 'Thay đổi thông tin trong trang cài đặt'),
(38, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 02:33:55', 'Thay đổi thông tin trong trang cài đặt'),
(39, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 14:10:40', '[Warning] Thực hiện đăng nhập vào website'),
(40, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 14:16:10', 'Thay đổi thông tin trong trang cài đặt'),
(41, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 22:09:42', 'Chỉnh sửa ngôn ngữ (1).'),
(42, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 22:16:54', 'Thay đổi thông tin trong trang cài đặt'),
(43, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 22:19:31', 'Thay đổi thông tin trong trang cài đặt'),
(44, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 22:25:15', 'Thay đổi thông tin trong trang cài đặt'),
(45, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 22:25:24', 'Thay đổi thông tin trong trang cài đặt'),
(46, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 22:32:03', 'Thay đổi thông tin trong trang cài đặt'),
(47, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 22:35:21', 'Thay đổi thông tin trong trang cài đặt'),
(48, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 22:37:32', 'Thay đổi thông tin trong trang cài đặt'),
(49, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 22:38:00', 'View order (8WJF681e52a79956b)'),
(50, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 22:39:30', 'Thay đổi thông tin trong trang cài đặt'),
(51, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-10 22:39:49', 'Thay đổi thông tin trong trang cài đặt'),
(52, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 00:39:38', 'Thay đổi thông tin trong trang cài đặt'),
(53, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 01:02:31', 'Set default language (Vietnamese ID 1)'),
(54, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 01:02:34', 'Set default language (English ID 2)'),
(55, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 01:08:09', 'Add Translate (test).'),
(56, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 01:08:47', 'Xoá nội dung ngôn ngữ (test)'),
(57, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 01:08:58', 'Add Translate (test).'),
(58, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 01:09:39', 'Add Translate (test).'),
(59, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 01:10:01', 'Xoá nội dung ngôn ngữ (test:)'),
(60, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 01:10:03', 'Xoá nội dung ngôn ngữ (test)'),
(61, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 08:45:53', '[Warning] Thực hiện đăng nhập vào website'),
(62, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 08:52:36', 'Thay đổi thông tin trong trang cài đặt'),
(63, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 08:56:59', 'Thay đổi thông tin trong trang cài đặt'),
(64, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 08:57:22', 'Crypto Deposit Configuration'),
(65, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 09:21:06', 'Cấu hình nạp tiền Flutterwave'),
(66, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 09:21:16', 'Cấu hình nạp tiền Ngân Hàng'),
(67, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 09:22:12', 'Cấu hình nạp tiền Squadco'),
(68, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 09:22:21', 'Cấu hình nạp tiền Toyyibpay'),
(69, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 09:23:25', 'Cấu hình nạp thẻ cào'),
(70, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 09:23:45', 'Cấu hình nạp MOMO'),
(71, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 09:26:27', 'Tạo trang thanh toán thủ công (Thanh Toán qua Stripe).'),
(72, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', '2025-05-11 09:32:13', 'Cập nhật trang thanh toán thủ công (Stripe).');

-- --------------------------------------------------------

--
-- Table structure for table `log_bank_auto`
--

CREATE TABLE `log_bank_auto` (
  `id` int NOT NULL,
  `tid` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `method` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `type` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `amount` float NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `log_ref`
--

CREATE TABLE `log_ref` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `reason` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `sotientruoc` float NOT NULL DEFAULT '0',
  `sotienthaydoi` float NOT NULL DEFAULT '0',
  `sotienhientai` float NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` int NOT NULL,
  `parent_id` int NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `slug` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `icon` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `href` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status` int NOT NULL DEFAULT '0',
  `target` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `position` int NOT NULL DEFAULT '3',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `momo`
--

CREATE TABLE `momo` (
  `id` int NOT NULL,
  `request_id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `tranId` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `partnerId` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `partnerName` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `amount` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `received` int NOT NULL DEFAULT '0',
  `comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `time` datetime DEFAULT NULL,
  `user_id` int DEFAULT '0',
  `status` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT 'xuly'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `order_log`
--

CREATE TABLE `order_log` (
  `id` int NOT NULL,
  `buyer` int NOT NULL,
  `product_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `pay` float NOT NULL DEFAULT '0',
  `amount` int NOT NULL DEFAULT '0',
  `create_time` int NOT NULL,
  `is_virtual` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `order_log`
--

INSERT INTO `order_log` (`id`, `buyer`, `product_name`, `pay`, `amount`, `create_time`, `is_virtual`) VALUES
(1, 1, 'email 01', 60, 3, 1746817383, 0),
(2, 1, 'email 02', 300000, 3, 1746817703, 0);

-- --------------------------------------------------------

--
-- Table structure for table `payment_bank`
--

CREATE TABLE `payment_bank` (
  `id` int NOT NULL,
  `method` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `tid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `amount` int DEFAULT '0',
  `received` int DEFAULT '0',
  `create_gettime` datetime DEFAULT NULL,
  `create_time` int DEFAULT '0',
  `user_id` int DEFAULT '0',
  `notication` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `payment_crypto`
--

CREATE TABLE `payment_crypto` (
  `id` int NOT NULL,
  `trans_id` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `request_id` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `amount` decimal(18,4) NOT NULL DEFAULT '0.0000',
  `received` float NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `status` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'waiting',
  `msg` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `url_payment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_flutterwave`
--

CREATE TABLE `payment_flutterwave` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `tx_ref` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `amount` float NOT NULL DEFAULT '0',
  `price` float NOT NULL DEFAULT '0',
  `currency` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `status` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_manual`
--

CREATE TABLE `payment_manual` (
  `id` int NOT NULL,
  `icon` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `title` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `slug` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `display` int NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `payment_manual`
--

INSERT INTO `payment_manual` (`id`, `icon`, `title`, `slug`, `description`, `content`, `display`, `create_gettime`, `update_gettime`) VALUES
(1, 'assets/storage/images/icon_gatewayXZN7.png', 'Stripe', 'stripe', '', '', 1, '2025-05-11 09:26:27', '2025-05-11 09:32:13');

-- --------------------------------------------------------

--
-- Table structure for table `payment_momo`
--

CREATE TABLE `payment_momo` (
  `id` int NOT NULL,
  `method` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `tid` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `amount` int DEFAULT '0',
  `received` int DEFAULT '0',
  `create_gettime` datetime DEFAULT NULL,
  `create_time` int DEFAULT '0',
  `user_id` int DEFAULT '0',
  `notication` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `payment_paypal`
--

CREATE TABLE `payment_paypal` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `trans_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `amount` float NOT NULL DEFAULT '0',
  `price` int NOT NULL DEFAULT '0',
  `create_date` datetime NOT NULL,
  `create_time` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_pm`
--

CREATE TABLE `payment_pm` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `payment_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `amount` int NOT NULL DEFAULT '0',
  `price` int NOT NULL DEFAULT '0',
  `create_date` datetime NOT NULL,
  `create_time` int NOT NULL DEFAULT '0',
  `update_date` datetime NOT NULL,
  `update_time` int NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_squadco`
--

CREATE TABLE `payment_squadco` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `transaction_ref` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `amount` float NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL,
  `price` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_thesieure`
--

CREATE TABLE `payment_thesieure` (
  `id` int NOT NULL,
  `method` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `tid` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `amount` int NOT NULL DEFAULT '0',
  `received` int NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL,
  `create_time` int NOT NULL DEFAULT '0',
  `user_id` int NOT NULL DEFAULT '0',
  `notication` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_toyyibpay`
--

CREATE TABLE `payment_toyyibpay` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `trans_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `billName` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `amount` float NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `BillCode` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `reason` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_xipay`
--

CREATE TABLE `payment_xipay` (
  `id` int NOT NULL,
  `out_trade_no` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `transaction_id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT 'Mã giao dịch do Xipay trả về',
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT 'Phương thức thanh toán (alipay, wxpay...)',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Số tiền thực nhận',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'Số tiền thanh toán',
  `param` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT 'Tham số mở rộng',
  `product_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL COMMENT 'Tên sản phẩm/dịch vụ',
  `status` tinyint DEFAULT '0' COMMENT 'Trạng thái giao dịch: 0=pending,1=success,2=fail...',
  `notify_data` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci COMMENT 'Lưu dữ liệu notify (nếu cần)',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL COMMENT 'ID user trong hệ thống (nếu có)',
  `notication` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int NOT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `stt` int NOT NULL DEFAULT '0',
  `category_id` int NOT NULL DEFAULT '0',
  `title` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `image` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status` int NOT NULL DEFAULT '0',
  `view` int NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_category`
--

CREATE TABLE `post_category` (
  `id` int NOT NULL,
  `name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `slug` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `icon` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status` int NOT NULL DEFAULT '1',
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `stt` int NOT NULL DEFAULT '0',
  `code` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `user_id` int NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `short_desc` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `images` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `description` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `price` float NOT NULL DEFAULT '0',
  `cost` float NOT NULL DEFAULT '0',
  `discount` float NOT NULL DEFAULT '0',
  `min` int NOT NULL DEFAULT '1',
  `max` int NOT NULL DEFAULT '1000000',
  `flag` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `sold` int NOT NULL DEFAULT '0',
  `category_id` int NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '1',
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `check_live` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT 'None',
  `supplier_id` int NOT NULL DEFAULT '0',
  `api_id` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `api_name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `api_stock` int NOT NULL DEFAULT '0',
  `api_time_update` int NOT NULL DEFAULT '0',
  `text_txt` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `order_by` int NOT NULL DEFAULT '1',
  `allow_api` int NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `stt`, `code`, `user_id`, `name`, `slug`, `short_desc`, `images`, `description`, `note`, `price`, `cost`, `discount`, `min`, `max`, `flag`, `sold`, `category_id`, `status`, `create_gettime`, `update_gettime`, `check_live`, `supplier_id`, `api_id`, `api_name`, `api_stock`, `api_time_update`, `text_txt`, `order_by`, `allow_api`) VALUES
(1, 0, '681e4f934ea85', 1, 'email 01', 'email-01', 'test short', '', 'PHA+dGVzdCBsb25nPC9wPg0K', 'PHA+dGVzdCBkZXRhaWw8L3A+DQo=', 20, 15, 0, 1, 10, 'us', 3, 3, 1, '2025-05-10 01:57:41', '2025-05-10 01:57:41', 'None', 0, NULL, NULL, 0, 0, '123|234\r\n123|1213', 1, 1),
(3, 0, '681e51a2d9871', 1, 'email 02', 'email-02', '', '', '', '', 100000, 100000, 0, 1, 1000000, '', 3, 3, 1, '2025-05-10 02:04:38', '2025-05-10 02:05:19', 'None', 0, NULL, NULL, 0, 0, '', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_die`
--

CREATE TABLE `product_die` (
  `id` int NOT NULL,
  `product_code` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `seller` int NOT NULL DEFAULT '0',
  `uid` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `account` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `create_gettime` datetime NOT NULL,
  `type` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_discount`
--

CREATE TABLE `product_discount` (
  `id` int NOT NULL,
  `product_id` int NOT NULL DEFAULT '0',
  `discount` float NOT NULL DEFAULT '0',
  `min` int NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_order`
--

CREATE TABLE `product_order` (
  `id` int NOT NULL,
  `trans_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `product_id` int NOT NULL DEFAULT '0',
  `supplier_id` int NOT NULL DEFAULT '0',
  `product_name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `buyer` int NOT NULL DEFAULT '0',
  `seller` int NOT NULL DEFAULT '0',
  `amount` int NOT NULL DEFAULT '0',
  `money` float NOT NULL DEFAULT '0',
  `pay` float NOT NULL DEFAULT '0',
  `cost` int NOT NULL DEFAULT '0',
  `commission_fee` float NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `trash` int NOT NULL DEFAULT '0',
  `refund` int NOT NULL DEFAULT '0',
  `ip` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `device` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status_view_order` int NOT NULL DEFAULT '0',
  `api_transid` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `product_order`
--

INSERT INTO `product_order` (`id`, `trans_id`, `product_id`, `supplier_id`, `product_name`, `buyer`, `seller`, `amount`, `money`, `pay`, `cost`, `commission_fee`, `create_gettime`, `update_gettime`, `trash`, `refund`, `ip`, `device`, `status_view_order`, `api_transid`, `note`) VALUES
(1, 'R6N3681e51671be90', 1, 0, 'email 01', 1, 1, 3, 60, 60, 45, 0, '2025-05-10 02:03:03', '2025-05-10 02:03:03', 1, 0, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 0, '', NULL),
(2, '8WJF681e52a79956b', 3, 0, 'email 02', 1, 1, 3, 0, 0, 0, 0, '2025-05-10 02:08:23', '2025-05-10 02:08:23', 1, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', 0, '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_sold`
--

CREATE TABLE `product_sold` (
  `id` int NOT NULL,
  `product_code` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `trans_id` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `supplier_id` int NOT NULL DEFAULT '0',
  `buyer` int NOT NULL DEFAULT '0',
  `seller` int NOT NULL DEFAULT '0',
  `uid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `account` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `create_gettime` datetime NOT NULL,
  `time_check_live` int NOT NULL DEFAULT '0',
  `type` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT 'WEB'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `product_sold`
--

INSERT INTO `product_sold` (`id`, `product_code`, `trans_id`, `supplier_id`, `buyer`, `seller`, `uid`, `account`, `create_gettime`, `time_check_live`, `type`) VALUES
(1, '681e4f934ea85', 'R6N3681e51671be90', 0, 1, 1, '12', '12|2323', '2025-05-10 02:03:03', 0, 'WEB'),
(2, '681e4f934ea85', 'R6N3681e51671be90', 0, 1, 1, '12', '12|2323', '2025-05-10 02:03:03', 0, 'WEB'),
(3, '681e4f934ea85', 'R6N3681e51671be90', 0, 1, 1, '12', '12|2323', '2025-05-10 02:03:03', 0, 'WEB'),
(4, '681e51a2d9871', '8WJF681e52a79956b', 0, 1, 1, 'abc', 'abc|bcd', '2025-05-10 02:08:23', 0, 'WEB'),
(5, '681e51a2d9871', '8WJF681e52a79956b', 0, 1, 1, '12323', '12323|202020', '2025-05-10 02:08:23', 0, 'WEB'),
(6, '681e51a2d9871', '8WJF681e52a79956b', 0, 1, 1, 'abc', 'abc|bcd', '2025-05-10 02:08:23', 0, 'WEB');

-- --------------------------------------------------------

--
-- Table structure for table `product_stock`
--

CREATE TABLE `product_stock` (
  `id` int NOT NULL,
  `product_code` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `seller` int NOT NULL DEFAULT '0',
  `uid` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `account` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `create_gettime` datetime NOT NULL,
  `type` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT 'WEB',
  `time_check_live` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `product_stock`
--

INSERT INTO `product_stock` (`id`, `product_code`, `seller`, `uid`, `account`, `create_gettime`, `type`, `time_check_live`) VALUES
(4, '681e4f934ea85', 1, '12', '12|2323', '2025-05-10 01:59:50', 'WEB', 0),
(5, '681e4f934ea85', 1, '12', '12|2323', '2025-05-10 01:59:50', 'WEB', 0),
(6, '681e4f934ea85', 1, '12', '12|2323', '2025-05-10 01:59:50', 'WEB', 0),
(7, '681e4f934ea85', 1, '12', '12|2323', '2025-05-10 01:59:50', 'WEB', 0),
(8, '681e4f934ea85', 1, '12', '12|2323', '2025-05-10 01:59:50', 'WEB', 0),
(9, '681e4f934ea85', 1, '12', '12|2323', '2025-05-10 01:59:50', 'WEB', 0),
(10, '681e4f934ea85', 1, '12', '12|2323', '2025-05-10 01:59:50', 'WEB', 0),
(11, '681e4f934ea85', 1, '12', '12|2323', '2025-05-10 02:00:10', 'WEB', 0),
(12, '681e4f934ea85', 1, '12', '12|2323', '2025-05-10 02:00:10', 'WEB', 0),
(13, '681e4f934ea85', 1, '12', '12|2323', '2025-05-10 02:00:10', 'WEB', 0),
(14, '681e4f934ea85', 1, '12', '12|2323', '2025-05-10 02:00:10', 'WEB', 0),
(15, '681e4f934ea85', 1, '12', '12|2323', '2025-05-10 02:00:10', 'WEB', 0),
(16, '681e4f934ea85', 1, '12', '12|2323', '2025-05-10 02:00:10', 'WEB', 0),
(24, '681e51a2d9871', 1, '12323', '12323|202020', '2025-05-10 02:05:45', 'WEB', 0),
(25, '681e51a2d9871', 1, 'abc', 'abc|bcd', '2025-05-10 02:05:45', 'WEB', 0),
(26, '681e51a2d9871', 1, '12323', '12323|202020', '2025-05-10 02:05:45', 'WEB', 0),
(27, '681e51a2d9871', 1, 'abc', 'abc|bcd', '2025-05-10 02:05:45', 'WEB', 0),
(28, '681e51a2d9871', 1, '12323', '12323|202020', '2025-05-10 02:05:45', 'WEB', 0),
(29, '681e51a2d9871', 1, 'abc', 'abc|bcd', '2025-05-10 02:05:45', 'WEB', 0),
(30, '681e51a2d9871', 1, '12323', '12323|202020', '2025-05-10 02:05:45', 'WEB', 0),
(31, '681e51a2d9871', 1, 'abc', 'abc|bcd', '2025-05-10 02:05:45', 'WEB', 0),
(32, '681e51a2d9871', 1, '12323', '12323|202020', '2025-05-10 02:05:45', 'WEB', 0);

-- --------------------------------------------------------

--
-- Table structure for table `promotions`
--

CREATE TABLE `promotions` (
  `id` int NOT NULL,
  `min` float NOT NULL DEFAULT '0',
  `discount` float NOT NULL DEFAULT '0',
  `create_gettime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `value` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `value`) VALUES
(1, 'status_demo', '0'),
(2, 'type_password', 'bcrypt'),
(3, 'title', 'SHOPTEST - MARKETING ACCOUNT STORE'),
(4, 'description', 'ADS raw material sales system is automatic, reputable, cheap...'),
(5, 'keywords', ''),
(6, 'author', 'SHOPTEST'),
(7, 'timezone', 'Asia/Ho_Chi_Minh'),
(8, 'email', 'admin@domain.com'),
(9, 'status', '1'),
(10, 'status_update', '0'),
(12, 'session_login', '10000000'),
(13, 'javascript_header', '<link rel=\"preconnect\" href=\"https://fonts.googleapis.com\">\r\n<link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin>\r\n<link href=\"https://fonts.googleapis.com/css2?family=Saira+Semi+Condensed:wght@100;200;300;400;500;600;700;800;900&display=swap\" rel=\"stylesheet\">\r\n\r\n'),
(14, 'javascript_footer', ''),
(16, 'logo_light', 'assets/storage/images/logo_light_K0I.png'),
(17, 'logo_dark', 'assets/storage/images/logo_dark_GEX.png'),
(18, 'favicon', 'assets/storage/images/favicon_Q0J.png'),
(19, 'image', 'assets/storage/images/image_IYA.png'),
(20, 'bg_login', 'assets/storage/images/bg_loginBYI.png'),
(21, 'bg_register', 'assets/storage/images/bg_registerMOU.png'),
(26, 'telegram_token', ''),
(27, 'telegram_chat_id', ''),
(30, 'prefix_autobank', 'NAPTIEN'),
(35, 'bank_status', '0'),
(36, 'bank_notice', '<ul>\r\n	<li>Nhập đúng nội dung chuyển tiền.</li>\r\n	<li>Cộng tiền trong vài giây.</li>\r\n	<li>Liên hệ BQT nếu nhập sai nội dung chuyển.</li>\r\n</ul>\r\n'),
(43, 'notice_home', '<h4><strong>⚠️ <span style=\"color:#e74c3c\">Lưu &yacute;:</span>&nbsp;H&atilde;y đảm bảo t&agrave;i khoản đăng nhập v&agrave; mật khẩu của bạn kh&ocirc;ng khớp với th&ocirc;ng tin đăng nhập tr&ecirc;n c&aacute;c website kh&aacute;c để tr&aacute;nh trường hợp chủ website kh&aacute;c sử dụng th&ocirc;ng tin của bạn để đăng nhập v&agrave;o website n&agrave;y!</strong></h4>\r\n\r\n<hr />\r\n<p><img alt=\"yes\" src=\"https://clonemkt.com/public/ckeditor/plugins/smiley/images/thumbs_up.png\" title=\"yes\" />&nbsp;Sau khi lấy nick đ&atilde; lấy nick&nbsp;xong, qu&yacute; kh&aacute;ch n&ecirc;n nhấn&nbsp;<strong>Delete</strong>&nbsp;đơn h&agrave;ng để đảm bảo an to&agrave;n nhất c&oacute; thể.</p>\r\n\r\n<p><img alt=\"yes\" src=\"https://clonemkt.com/public/ckeditor/plugins/smiley/images/thumbs_up.png\" title=\"yes\" />&nbsp;Đối với đơn h&agrave;ng mua PAGE, BM, vui l&ograve;ng nhắn tin về&nbsp;<strong><a href=\"https://t.me/ntthanhz\" target=\"_blank\">Telegram</a></strong>&nbsp;để hỗ trợ nhận.</p>\r\n\r\n<p><img alt=\"yes\" src=\"https://clonemkt.com/public/ckeditor/plugins/smiley/images/thumbs_up.png\" title=\"yes\" />&nbsp;Li&ecirc;n hệ hỗ trợ qu&yacute; kh&aacute;ch vui l&ograve;ng nhắn tin về&nbsp;<strong><a href=\"https://t.me/ntthanhz\" target=\"_blank\">Telegram</a></strong>.</p>\r\n\r\n<p>⚠️&nbsp;Hệ thống sẽ x&oacute;a đơn h&agrave;ng đ&atilde; b&aacute;n sau&nbsp;<strong>15 ng&agrave;y</strong>, qu&yacute; kh&aacute;ch lưu lại đơn h&agrave;ng đ&atilde; mua về m&aacute;y, tr&aacute;nh thất lạc.</p>\r\n\r\n<p>⚠️&nbsp;Chỉ bảo h&agrave;nh trường hợp sai pass v&agrave; die trước khi mua,&nbsp;kh&ocirc;ng bảo h&agrave;nh đăng nhập v&agrave; sử dụng. Vui l&ograve;ng li&ecirc;n hệ bảo h&agrave;nh trong 24 giờ t&iacute;nh từ l&uacute;c mua, qu&aacute; thời hạn hệ thống sẽ x&oacute;a đơn h&agrave;ng ngưng bảo h&agrave;nh.</p>\r\n\r\n<p>⚠️ Hiện tại h&agrave;ng No 2FA chưa bị checkpoint số điện thoại khuyến kh&iacute;ch d&ugrave;ng h&agrave;ng n&agrave;y.</p>\r\n\r\n<p>⚠️ Faceook đăng nhập tr&ecirc;n thiết bị mới sẽ kh&ocirc;ng thể đổi pass, th&ecirc;m-x&oacute;a email... cần ng&acirc;m random 15-30 ng&agrave;y.</p>\r\n\r\n<p>⚠️ T&agrave;i khoản mua chủ động đổi pass mail + mai kp, c&aacute;c trường hợp sai sau khi mua sẽ kh&ocirc;ng được bảo h&agrave;nh.</p>\r\n\r\n<p>⚠️ Mội số h&agrave;ng No 2FA khi đăng nhập kh&ocirc;ng c&oacute; t&ugrave;y chọn hotmail, vui l&ograve;ng đăng nhập cookie, lỗi do thiết bị, kh&ocirc;ng bảo h&agrave;nh.</p>\r\n\r\n<p>⚠️ Nếu kh&ocirc;ng c&oacute; đơn h&agrave;ng sau khi thanh to&aacute;n th&agrave;nh c&ocirc;ng, vui l&ograve;ng li&ecirc;n hệ Live Chat ngay để được hỗ trợ nhanh nhất&nbsp;(tối đa trong 48 giờ, nếu chậm&nbsp;hơn&nbsp;sẽ kh&ocirc;ng xử l&yacute; được).</p>\r\n\r\n<p><img alt=\"yes\" src=\"https://clonemkt.com/public/ckeditor/plugins/smiley/images/thumbs_up.png\" title=\"yes\" />&nbsp;Hỗ trợ ho&agrave;n lại tiền thừ nếu sản phẩm qu&yacute; kh&aacute;ch cần kh&ocirc;ng c&oacute; h&agrave;ng qu&aacute; 48h.</p>\r\n'),
(44, 'font_family', 'font-family: \'Roboto\', sans-serif;'),
(59, 'popup_status', '0'),
(60, 'popup_noti', '<p><span style=\"font-size:14px\"><img alt=\"yes\" src=\"http://localhost/CMSNT.CO/SHOPCLONE7/public/ckeditor/plugins/smiley/images/thumbs_up.png\" style=\"height:23px; width:23px\" title=\"yes\" />&nbsp;Thay đổi th&ocirc;ng b&aacute;o nổi tại -&gt; <strong>Trang Quản Trị</strong> -&gt; <strong>C&agrave;i Đặt</strong> -&gt;&nbsp;<strong>Th&ocirc;ng b&aacute;o nổi ngo&agrave;i trang chủ</strong></span></p>\r\n\r\n<p><span style=\"font-size:14px\"><img alt=\"yes\" src=\"http://localhost/CMSNT.CO/SHOPCLONE7/public/ckeditor/plugins/smiley/images/thumbs_up.png\" style=\"height:23px; width:23px\" title=\"yes\" />&nbsp;Ẩn th&ocirc;ng b&aacute;o nổi tại -&gt; <strong>Trang Quản Trị</strong> -&gt; <strong>C&agrave;i Đặt</strong> -&gt;&nbsp;<strong>ON/OFF Th&ocirc;ng b&aacute;o nổi</strong></span></p>\r\n'),
(64, 'license_key', 'aeeb422ae3477fbbec7636cb7e20523d'),
(69, 'home_page', 'home'),
(70, 'smtp_host', 'smtp.gmail.com'),
(71, 'smtp_encryption', 'tls'),
(72, 'smtp_port', '587'),
(73, 'smtp_email', ''),
(74, 'smtp_password', ''),
(76, 'default_product_image', 'assets/storage/images/default_product_image3VL.png'),
(77, 'status_captcha', '0'),
(78, 'crypto_note', ''),
(79, 'crypto_address', ''),
(80, 'crypto_token', ''),
(81, 'crypto_min', '10'),
(82, 'crypto_max', '100000'),
(83, 'crypto_status', '1'),
(84, 'crypto_rate', '25000'),
(85, 'reCAPTCHA_site_key', ''),
(86, 'reCAPTCHA_secret_key', ''),
(87, 'reCAPTCHA_status', '0'),
(88, 'telegram_status', '0'),
(89, 'smtp_status', '0'),
(93, 'affiliate_ck', '5'),
(94, 'affiliate_status', '0'),
(95, 'affiliate_min', '10000'),
(96, 'affiliate_banks', 'Vietcombank\r\nMBBank\r\nTechcombank'),
(97, 'affiliate_note', '<p>Chia sẻ&nbsp;li&ecirc;n kết n&agrave;y l&ecirc;n mạng x&atilde; hội hoặc bạn b&egrave; của bạn.</p>\r\n'),
(98, 'affiliate_chat_id_telegram', ''),
(99, 'check_time_cron_cron2', '0'),
(100, 'bank_min', '1000'),
(101, 'bank_max', '1000000000'),
(102, 'paypal_clientId', ''),
(103, 'paypal_clientSecret', ''),
(104, 'paypal_status', '1'),
(105, 'paypal_rate', '23000'),
(108, 'paypal_note', ''),
(109, 'noti_recharge', '[{time}] <b>{username}</b> vừa nạp {amount} vào {method} thực nhận {price}.'),
(110, 'noti_action', '[{time}] \r\n- <b>Username</b>: <code>{username}</code>\r\n- <b>Action</b>:  <code>{action}</code>\r\n- <b>IP</b>: <code>{ip}</code>'),
(111, 'theme_color', '#2b5876'),
(112, 'hotline', '0988888XXX'),
(113, 'type_notification', 'telegram'),
(114, 'perfectmoney_status', '1'),
(115, 'perfectmoney_account', ''),
(116, 'perfectmoney_pass', ''),
(117, 'perfectmoney_rate', '23000'),
(118, 'perfectmoney_units', ''),
(119, 'perfectmoney_notice', ''),
(120, 'fanpage', 'https://www.facebook.com/shoptest.co'),
(121, 'address', '1Hd- 50, 010 Avenue, NY 90001 United States'),
(122, 'toyyibpay_status', '0'),
(123, 'toyyibpay_userSecretKey', ''),
(124, 'toyyibpay_categoryCode', ''),
(125, 'toyyibpay_min', '1'),
(126, 'toyyibpay_billChargeToCustomer', '0'),
(127, 'toyyibpay_rate', '5258'),
(128, 'toyyibpay_notice', ''),
(129, 'noti_affiliate_withdraw', '[{time}] \r\n- <b>Username</b>: <code>{username}</code>\r\n- <b>Action</b>:  <code>Tạo lệnh rút {amount} về ngân hàng {bank} | {account_number} | {account_name}</code>\r\n- <b>IP</b>: <code>{ip}</code>'),
(130, 'check_time_cron_sending_email', '1715250984'),
(131, 'squadco_status', '0'),
(132, 'squadco_Secret_Key', ''),
(133, 'squadco_Public_Key', ''),
(134, 'squadco_rate', '51'),
(135, 'squadco_currency_code', 'NGN'),
(136, 'squadco_notice', ''),
(137, 'theme_color1', '#1a5e75'),
(138, 'product_photo_display', '1'),
(139, 'product_rating_display', '0'),
(140, 'product_sold_display', '1'),
(141, 'banner_singer', 'assets/storage/images/banner_singer08A.png'),
(142, 'image_empty_state', 'assets/storage/images/image_empty_stateNPV.png'),
(143, 'copyright_footer', 'Software By <a href=\"https://www.cmsnt.co/\">CMSNT.CO</a>'),
(144, 'menu_category_right', '0'),
(145, 'crypto_trial', '5'),
(146, 'type_show_product', 'LIST'),
(147, 'check_time_cron_bank', '0'),
(148, 'google_analytics_status', '0'),
(149, 'google_analytics_id', ''),
(150, 'card_status', '0'),
(151, 'card_partner_id', ''),
(152, 'card_partner_key', ''),
(153, 'card_ck', '20'),
(154, 'card_notice', ''),
(155, 'api_status', '0'),
(156, 'time_cron_suppliers_shopclone6', '1734798034'),
(157, 'time_cron_suppliers_api1', '1711653105'),
(158, 'language_type', 'manual'),
(159, 'gtranslate_script', '<div class=\"gtranslate_wrapper\"></div>\n<script>window.gtranslateSettings = {\"default_language\":\"vi\",\"languages\":[\"vi\",\"fr\",\"de\",\"it\",\"es\",\"zh-CN\",\"ar\",\"tr\",\"ru\",\"uk\",\"km\",\"th\",\"en\"],\"wrapper_selector\":\".gtranslate_wrapper\"}</script>\n<script src=\"https://cdn.gtranslate.net/widgets/latest/dropdown.js\" defer></script>'),
(160, 'notice_top_left', 'Welcome to SHOPTEST website'),
(161, 'page_contact', ''),
(162, 'page_policy', '<p><strong>Ch&iacute;nh s&aacute;ch bảo mật</strong></p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i đặt rất nhiều gi&aacute; trị v&agrave;o việc bảo vệ th&ocirc;ng tin c&aacute; nh&acirc;n của bạn. Ch&iacute;nh s&aacute;ch quyền ri&ecirc;ng tư n&agrave;y giải th&iacute;ch c&aacute;ch ch&uacute;ng t&ocirc;i thu thập, sử dụng v&agrave; bảo vệ th&ocirc;ng tin c&aacute; nh&acirc;n của bạn khi bạn sử dụng dịch vụ của ch&uacute;ng t&ocirc;i.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Thu thập v&agrave; sử dụng th&ocirc;ng tin</strong></p>\r\n\r\n<p>Khi bạn sử dụng trang web của ch&uacute;ng t&ocirc;i hoặc tương t&aacute;c với c&aacute;c dịch vụ của ch&uacute;ng t&ocirc;i, ch&uacute;ng t&ocirc;i c&oacute; thể thu thập một số th&ocirc;ng tin c&aacute; nh&acirc;n nhất định từ bạn. Điều n&agrave;y c&oacute; thể bao gồm t&ecirc;n, địa chỉ email, số điện thoại, địa chỉ v&agrave; th&ocirc;ng tin kh&aacute;c m&agrave; bạn cung cấp khi đăng k&yacute; hoặc sử dụng dịch vụ của ch&uacute;ng t&ocirc;i.</p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i c&oacute; thể sử dụng th&ocirc;ng tin c&aacute; nh&acirc;n của bạn để:</p>\r\n\r\n<ul>\r\n	<li>Cung cấp v&agrave; duy tr&igrave; dịch vụ</li>\r\n	<li>Th&ocirc;ng b&aacute;o về những thay đổi đối với dịch vụ của ch&uacute;ng t&ocirc;i</li>\r\n	<li>Giải quyết vấn đề hoặc tranh chấp</li>\r\n	<li>Theo d&otilde;i v&agrave; ph&acirc;n t&iacute;ch việc sử dụng dịch vụ của ch&uacute;ng t&ocirc;i</li>\r\n	<li>N&acirc;ng cao trải nghiệm người d&ugrave;ng</li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Bảo vệ</strong></p>\r\n\r\n<p>Ch&uacute;ng t&ocirc;i cam kết bảo vệ th&ocirc;ng tin c&aacute; nh&acirc;n của bạn v&agrave; c&oacute; c&aacute;c biện ph&aacute;p bảo mật th&iacute;ch hợp để đảm bảo th&ocirc;ng tin của bạn được giữ an to&agrave;n khi bạn truy cập trang web của ch&uacute;ng t&ocirc;i.</p>\r\n\r\n<p>Tuy nhi&ecirc;n, h&atilde;y nhớ rằng kh&ocirc;ng c&oacute; phương thức truyền th&ocirc;ng tin n&agrave;o qua internet hoặc phương tiện điện tử l&agrave; an to&agrave;n hoặc đ&aacute;ng tin cậy 100%. Mặc d&ugrave; ch&uacute;ng t&ocirc;i cố gắng bảo vệ th&ocirc;ng tin c&aacute; nh&acirc;n của bạn nhưng ch&uacute;ng t&ocirc;i kh&ocirc;ng thể đảm bảo hoặc đảm bảo t&iacute;nh bảo mật của bất kỳ th&ocirc;ng tin n&agrave;o bạn gửi cho ch&uacute;ng t&ocirc;i hoặc từ c&aacute;c dịch vụ của ch&uacute;ng t&ocirc;i. v&agrave; bạn phải tự chịu rủi ro n&agrave;y.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Li&ecirc;n kết đến c&aacute;c trang web kh&aacute;c</strong></p>\r\n\r\n<p>Trang web của ch&uacute;ng t&ocirc;i c&oacute; thể chứa c&aacute;c li&ecirc;n kết đến c&aacute;c trang web kh&aacute;c kh&ocirc;ng do ch&uacute;ng t&ocirc;i điều h&agrave;nh. Nếu bạn nhấp v&agrave;o li&ecirc;n kết của b&ecirc;n thứ ba, bạn sẽ được chuyển hướng đến trang web của b&ecirc;n thứ ba đ&oacute;. Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n xem lại Ch&iacute;nh s&aacute;ch quyền ri&ecirc;ng tư của mọi trang web bạn truy cập v&igrave; ch&uacute;ng t&ocirc;i kh&ocirc;ng c&oacute; quyền kiểm so&aacute;t hoặc chịu tr&aacute;ch nhiệm đối với c&aacute;c hoạt động hoặc nội dung về quyền ri&ecirc;ng tư của c&aacute;c trang web hoặc dịch vụ của b&ecirc;n thứ ba. .</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong>Thay đổi ch&iacute;nh s&aacute;ch quyền ri&ecirc;ng tư</strong></p>\r\n\r\n<p>Đ&ocirc;i khi, ch&uacute;ng t&ocirc;i c&oacute; thể cập nhật Ch&iacute;nh s&aacute;ch quyền ri&ecirc;ng tư n&agrave;y m&agrave; kh&ocirc;ng cần th&ocirc;ng b&aacute;o trước. Mọi thay đổi sẽ được đăng l&ecirc;n trang n&agrave;y v&agrave; được &aacute;p dụng ngay sau khi ch&uacute;ng được đăng. Bằng việc tiếp tục sử dụng dịch vụ của ch&uacute;ng t&ocirc;i sau khi những thay đổi n&agrave;y được đăng, bạn đồng &yacute; với những thay đổi đ&oacute;.</p>\r\n'),
(163, 'page_faq', ''),
(164, 'page_block_ip', NULL),
(165, 'email_temp_content_warning_login', '<p>Ch&uacute;ng t&ocirc;i vừa ph&aacute;t hiện t&agrave;i khoản <strong>{username}</strong> của bạn đang được đăng nhập v&agrave;o hệ thống {domain}.<br />\r\nNếu kh&ocirc;ng phải bạn vui l&ograve;ng thay đổi th&ocirc;ng tin t&agrave;i khoản ngay hoặc li&ecirc;n hệ ngay cho ch&uacute;ng t&ocirc;i để hỗ trợ kiểm tra an to&agrave;n cho qu&yacute; kh&aacute;ch.</p>\r\n\r\n<ul>\r\n	<li>Thời gian: {time}</li>\r\n	<li>IP: {ip}</li>\r\n	<li>Thiết bị: {device}</li>\r\n</ul>\r\n'),
(166, 'email_temp_subject_warning_login', 'Cảnh báo đăng nhập tài khoản - {title}'),
(167, 'email_temp_content_otp_mail', '<p>OTP x&aacute;c minh đăng nhập v&agrave;o t&agrave;i khoản <strong>{username}</strong> của bạn l&agrave; <strong>{otp}</strong><br />\r\nNếu kh&ocirc;ng phải bạn vui l&ograve;ng thay đổi th&ocirc;ng tin t&agrave;i khoản ngay hoặc li&ecirc;n hệ ngay cho ch&uacute;ng t&ocirc;i để hỗ trợ kiểm tra an to&agrave;n cho qu&yacute; kh&aacute;ch.</p>\r\n\r\n<ul>\r\n	<li>Thời gian: {time}</li>\r\n	<li>IP: {ip}</li>\r\n	<li>Thiết bị: {device}</li>\r\n</ul>\r\n'),
(168, 'email_temp_subject_otp_mail', 'OTP xác minh đăng nhập website - {title}'),
(169, 'email_temp_content_forgot_password', '<p>Để x&aacute;c minh kh&ocirc;i phục mật khẩu t&agrave;i khoản <strong>{username}</strong> tại website <strong>{domain}</strong><br />\r\nVui l&ograve;ng nhấn v&agrave;o li&ecirc;n kết dưới đ&acirc;y để ho&agrave;n tất qu&aacute; tr&igrave;nh x&aacute;c minh: {link}<br />\r\nNếu kh&ocirc;ng phải bạn y&ecirc;u cầu kh&ocirc;i phục mật khẩu, vui l&ograve;ng bỏ qua mail n&agrave;y.</p>\r\n\r\n<ul>\r\n	<li>Thời gian: {time}</li>\r\n	<li>IP: {ip}</li>\r\n	<li>Thiết bị: {device}</li>\r\n</ul>\r\n'),
(170, 'email_temp_subject_forgot_password', 'Xác nhận khôi phục mật khẩu website - {title}'),
(171, 'time_cron_suppliers_api6', '1723709086'),
(172, 'time_cron_checklive_clone', '1740738217'),
(173, 'time_cron_checklive_hotmail', '1711615443'),
(174, 'product_hide_outstock', '1'),
(175, 'time_cron_suppliers_api14', '1710930652'),
(176, 'max_show_product_home', '6'),
(177, 'email_temp_content_buy_order', '<p><span style=\"font-size:16px\">Cảm ơn bạn đ&atilde; mua h&agrave;ng tại {title}, dưới đ&acirc;y l&agrave; th&ocirc;ng tin đơn h&agrave;ng của bạn. Nếu kh&ocirc;ng phải bạn vui l&ograve;ng thay đổi th&ocirc;ng tin t&agrave;i khoản ngay hoặc li&ecirc;n hệ ngay cho ch&uacute;ng t&ocirc;i để hỗ trợ kiểm tra an to&agrave;n cho qu&yacute; kh&aacute;ch.</span></p>\r\n\r\n<ul>\r\n	<li><span style=\"font-size:14px\">M&atilde; đơn h&agrave;ng: <strong>#{trans_id}</strong></span></li>\r\n	<li><span style=\"font-size:14px\">Sản phẩm:<strong> {product}</strong></span></li>\r\n	<li><span style=\"font-size:14px\">Số lượng: <span style=\"color:#3498db\"><strong>{amount}</strong></span></span></li>\r\n	<li><span style=\"font-size:14px\">Thanh to&aacute;n: <span style=\"color:#e74c3c\"><strong>{pay}</strong></span></span></li>\r\n</ul>\r\n\r\n<p><span style=\"font-size:14px\">Để đảm bảo an to&agrave;n, ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n x&oacute;a lịch sử đơn h&agrave;ng tr&ecirc;n hệ thống sau khi nhận được Email n&agrave;y.</span></p>\r\n\r\n<p><em>Thiết bị: {device} - IP: {ip}</em></p>\r\n'),
(178, 'email_temp_subject_buy_order', 'Chi tiết đơn hàng {product} - {title}'),
(179, 'time_cron_suppliers_shopclone7', '1736523184'),
(180, 'time_cron_suppliers_api18', '1711615441'),
(181, 'avatar', 'assets/storage/images/avatarP7U.png'),
(182, 'check_time_cron_momo', '1711213245'),
(183, 'momo_number', '0947838128'),
(184, 'momo_name', 'WEB DEMO VUI LÒNG KHÔNG NẠP'),
(185, 'momo_token', ''),
(186, 'momo_notice', ''),
(187, 'momo_status', '0'),
(188, 'script_footer_admin', ''),
(189, 'time_cron_suppliers_api19', '1711555019'),
(190, 'cot_so_du_ben_phai', '1'),
(191, 'time_cron_suppliers_api4', '1711863683'),
(192, 'status_giao_dich_gan_day', '0'),
(193, 'content_gd_mua_gan_day', '<b style=\"color: green;\">...{username}</b> mua <b style=\"color: red;\">{amount}</b> <b>{product_name}</b> với giá <b style=\"color:blue;\">{price}</b>'),
(194, 'content_gd_nap_tien_gan_day', '<b style=\"color: green;\">...{username}</b> thực hiện nạp <b style=\"color:blue;\">{amount}</b> bằng <b style=\"color:red;\">{method}</b> thực nhận <b style=\"color:blue;\">{received}</b>'),
(195, 'status_tao_gd_ao', '0'),
(196, 'sl_mua_toi_thieu_gd_ao', '1'),
(197, 'sl_mua_toi_da_gd_ao', '10'),
(198, 'toc_do_gd_mua_ao', '1'),
(199, 'menh_gia_nap_ao_ngau_nhien', '10000\r\n20000\r\n40000\r\n50000\r\n60000\r\n70000\r\n100000\r\n200000\r\n300000\r\n500000\r\n400000\r\n40000\r\n15000\r\n25000\r\n35000\r\n45000\r\n55000\r\n65000\r\n45000\r\n100000\r\n1500000\r\n200000'),
(200, 'toc_do_gd_nap_ao', '1'),
(201, 'method_nap_ao', 'ACB\r\nMB\r\nUSDT\r\nPayPal'),
(202, 'tao_gd_ao_sp_het_hang', '1'),
(203, 'check_time_cron_cron', '1715933184'),
(204, 'blog_status', '0'),
(205, 'cong_tien_nguoi_ban', '0'),
(206, 'noti_buy_product', '[{time}] <b>{username}</b> vừa mua {amount} tài khoản {product} với giá {pay} - #{trans_id}'),
(207, 'check_time_cron_task', '1726908868'),
(208, 'thoi_gian_mua_cach_nhau', '3'),
(209, 'max_register_ip', '5'),
(210, 'time_cron_suppliers_api20', '1715439606'),
(211, 'status_menu_tools', '0'),
(212, 'debug_auto_bank', '0'),
(213, 'time_cron_suppliers_api9', '1721537978'),
(214, 'debug_api_suppliers', '0'),
(215, 'order_by_product_home', '1'),
(216, 'token_webhook_web2m', ''),
(217, 'time_cron_suppliers_api21', '0'),
(218, 'time_cron_suppliers_api17', '1722102324'),
(219, 'api_check_live_gmail', ''),
(220, 'api_key_check_live_gmail', ''),
(221, 'time_cron_checklive_gmail', '1722164111'),
(222, 'time_limit_check_live_gmail', '1800'),
(223, 'widget_zalo1_status', '0'),
(224, 'widget_zalo1_sdt', ''),
(225, 'widget_phone1_status', '0'),
(226, 'widget_phone1_sdt', ''),
(227, 'flutterwave_status', '0'),
(228, 'flutterwave_rate', '16'),
(229, 'flutterwave_currency_code', 'NGN'),
(230, 'flutterwave_publicKey', ''),
(231, 'flutterwave_secretKey', ''),
(232, 'flutterwave_notice', ''),
(233, 'limit_block_ip_login', '5'),
(234, 'limit_block_client_login', '10'),
(235, 'limit_block_ip_api', '20'),
(236, 'limit_block_ip_admin_access', '5'),
(237, 'time_cron_suppliers_api22', '1724076154'),
(238, 'isPurchaseIpVerified', '0'),
(239, 'isPurchaseDeviceVerified', '0'),
(240, 'footer_card', ''),
(241, 'notice_orders', ''),
(242, 'widget_fbzalo2_status', '0'),
(243, 'widget_fbzalo2_zalo', ''),
(244, 'widget_fbzalo2_fb', ''),
(245, 'time_cron_suppliers_api23', '0'),
(246, 'show_btn_category_home', '1'),
(247, 'time_cron_suppliers_api24', '0'),
(248, 'status_only_ip_login_admin', '1'),
(249, 'time_cron_checklive_instagram', '1735476466'),
(250, 'check_time_cron_thesieure', '0'),
(251, 'thesieure_status', '1'),
(252, 'thesieure_number', '0999999999'),
(253, 'thesieure_email', 'mail@mail.com'),
(254, 'thesieure_token', ''),
(255, 'thesieure_notice', ''),
(256, 'thesieure_name', 'NGUYEN TAN THANH'),
(257, 'crypto_type_api', 'fpayment.net'),
(258, 'crypto_merchant_id', ''),
(259, 'crypto_api_key', ''),
(260, 'time_cron_suppliers_api25', '1734801278'),
(261, 'api_check_live_instagram', ''),
(262, 'api_key_check_live_instagram', ''),
(263, 'time_limit_check_live_instagram', '10'),
(266, 'isLoginRequiredToViewProduct', '0'),
(267, 'telegram_assistant_status', '0'),
(268, 'telegram_assistant_token', ''),
(269, 'telegram_assistant_list_username', ''),
(271, 'telegram_assistant_LicenseKey', ''),
(272, 'status_only_device_client', '1'),
(273, 'status_only_device_admin', '1'),
(274, 'is_uid_visible', '1'),
(275, 'list_network_topup_card', 'VIETTEL|Viettel\r\nVINAPHONE|Vinaphone\r\nMOBIFONE|Mobifone\r\nVNMOBI|Vietnamobile\r\nZING|Zing\r\nVCOIN|Vcoin\r\nGARENA|Garena (chỉ nhận thẻ trên 10k)\r\n'),
(276, 'gateway_xipay_status', '1'),
(277, 'xipay_notice', ''),
(278, 'xipay_min', '1'),
(279, 'xipay_max', '1000000'),
(280, 'gateway_xipay_md5key', ''),
(281, 'gateway_xipay_pid', ''),
(282, 'gateway_xipay_rate', '3508'),
(283, 'gateway_xipay_license', '');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `type` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `domain` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `username` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `password` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `api_key` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `token` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `coupon` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `price` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `discount` float NOT NULL DEFAULT '0',
  `update_name` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `sync_category` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'OFF',
  `update_price` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `roundMoney` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'ON',
  `status` int NOT NULL DEFAULT '1',
  `create_gettime` datetime NOT NULL,
  `update_gettime` datetime NOT NULL,
  `check_string_api` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'ON'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `telegram_logs`
--

CREATE TABLE `telegram_logs` (
  `id` int NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `command` varchar(100) DEFAULT NULL,
  `params` text,
  `type` varchar(50) DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `translate`
--

CREATE TABLE `translate` (
  `id` int NOT NULL,
  `lang_id` int NOT NULL DEFAULT '0',
  `name` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `value` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `translate`
--

INSERT INTO `translate` (`id`, `lang_id`, `name`, `value`) VALUES
(1, 1, 'Vui lòng nhập username', 'Vui lòng nhập username'),
(2, 2, 'Vui lòng nhập username', 'Please enter username'),
(3, 1, 'Vui lòng nhập mật khẩu', 'Vui lòng nhập mật khẩu'),
(4, 2, 'Vui lòng nhập mật khẩu', 'Please enter a password'),
(5, 1, 'Vui lòng xác minh Captcha', 'Vui lòng xác minh Captcha'),
(6, 2, 'Vui lòng xác minh Captcha', 'Please verify Captcha'),
(7, 1, 'Thông tin đăng nhập không chính xác', 'Thông tin đăng nhập không chính xác'),
(8, 2, 'Thông tin đăng nhập không chính xác', 'Login information is incorrect'),
(9, 1, 'Vui lòng nhập địa chỉ Email', 'Vui lòng nhập địa chỉ Email'),
(10, 2, 'Vui lòng nhập địa chỉ Email', 'Please enter your email address'),
(11, 1, 'Vui lòng nhập lại mật khẩu', 'Vui lòng nhập lại mật khẩu'),
(12, 2, 'Vui lòng nhập lại mật khẩu', 'Please re-enter your password'),
(13, 1, 'Xác minh mật khẩu không chính xác', 'Xác minh mật khẩu không chính xác'),
(14, 2, 'Xác minh mật khẩu không chính xác', 'Verify password is incorrect'),
(15, 1, 'Tên đăng nhập đã tồn tại trong hệ thống', 'Tên đăng nhập đã tồn tại trong hệ thống'),
(16, 2, 'Tên đăng nhập đã tồn tại trong hệ thống', 'Username already exists in the system'),
(17, 1, 'Địa chỉ email đã tồn tại trong hệ thống', 'Địa chỉ email đã tồn tại trong hệ thống'),
(18, 2, 'Địa chỉ email đã tồn tại trong hệ thống', 'Email address already exists in the system'),
(19, 1, 'IP của bạn đã đạt đến giới hạn tạo tài khoản cho phép', 'IP của bạn đã đạt đến giới hạn tạo tài khoản cho phép'),
(20, 2, 'IP của bạn đã đạt đến giới hạn tạo tài khoản cho phép', 'Your IP has reached the allowable account creation limit'),
(21, 1, 'Đăng ký thành công!', 'Đăng ký thành công!'),
(22, 2, 'Đăng ký thành công!', 'Sign Up Success!'),
(23, 1, 'Tạo tài khoản không thành công, vui lòng thử lại', 'Tạo tài khoản không thành công, vui lòng thử lại'),
(24, 2, 'Tạo tài khoản không thành công, vui lòng thử lại', 'Account creation failed, please try again'),
(25, 1, 'Vui lòng đăng nhập', 'Vui lòng đăng nhập'),
(26, 2, 'Vui lòng đăng nhập', 'please log in'),
(27, 1, 'Lưu thành công', 'Lưu thành công'),
(28, 2, 'Lưu thành công', 'Save successfully'),
(29, 1, 'Lưu thất bại', 'Lưu thất bại'),
(30, 2, 'Lưu thất bại', 'Save failed'),
(31, 1, 'Vui lòng nhập mật khẩu hiện tại', 'Vui lòng nhập mật khẩu hiện tại'),
(32, 2, 'Vui lòng nhập mật khẩu hiện tại', 'Please enter your current password'),
(33, 1, 'Vui lòng nhập mật khẩu mới', 'Vui lòng nhập mật khẩu mới'),
(34, 2, 'Vui lòng nhập mật khẩu mới', 'Please enter a new password'),
(35, 1, 'Mật khẩu mới quá ngắn', 'Mật khẩu mới quá ngắn'),
(36, 2, 'Mật khẩu mới quá ngắn', 'New password is too short'),
(37, 1, 'Xác nhận mật khẩu không chính xác', 'Xác nhận mật khẩu không chính xác'),
(38, 2, 'Xác nhận mật khẩu không chính xác', 'Confirm password is incorrect'),
(39, 1, 'Mật khẩu hiện tại không đúng', 'Mật khẩu hiện tại không đúng'),
(40, 2, 'Mật khẩu hiện tại không đúng', 'Current password is incorrect'),
(41, 1, 'Địa chỉ Email này không tồn tại trong hệ thống', 'Địa chỉ Email này không tồn tại trong hệ thống'),
(42, 2, 'Địa chỉ Email này không tồn tại trong hệ thống', 'This email address does not exist in the system'),
(43, 1, 'Vui lòng thử lại trong ít phút', 'Vui lòng thử lại trong ít phút'),
(44, 2, 'Vui lòng thử lại trong ít phút', 'Please try again in a few minutes'),
(45, 1, 'Nếu bạn yêu cầu đặt lại mật khẩu, vui lòng nhấp vào liên kết bên dưới để xác minh.', 'Nếu bạn yêu cầu đặt lại mật khẩu, vui lòng nhấp vào liên kết bên dưới để xác minh.'),
(46, 2, 'Nếu bạn yêu cầu đặt lại mật khẩu, vui lòng nhấp vào liên kết bên dưới để xác minh.', 'If you require a password reset, please click the link below to verify.'),
(47, 1, 'Nếu không phải là bạn, vui lòng liên hệ ngay với Quản trị viên của bạn để được hỗ trợ về bảo mật.', 'Nếu không phải là bạn, vui lòng liên hệ ngay với Quản trị viên của bạn để được hỗ trợ về bảo mật.'),
(48, 2, 'Nếu không phải là bạn, vui lòng liên hệ ngay với Quản trị viên của bạn để được hỗ trợ về bảo mật.', 'If not you, please contact your Administrator immediately for security assistance.'),
(49, 1, 'Xác nhận tìm mật khẩu website', 'Xác nhận tìm mật khẩu website'),
(50, 2, 'Xác nhận tìm mật khẩu website', 'Confirm to find the website password'),
(51, 1, 'Xác nhận khôi phục mật khẩu', 'Xác nhận khôi phục mật khẩu'),
(52, 2, 'Xác nhận khôi phục mật khẩu', 'Confirm Password Recovery'),
(53, 1, 'Vui lòng kiểm tra Email của bạn để hoàn tất quá trình đặt lại mật khẩu', 'Vui lòng kiểm tra Email của bạn để hoàn tất quá trình đặt lại mật khẩu'),
(54, 2, 'Vui lòng kiểm tra Email của bạn để hoàn tất quá trình đặt lại mật khẩu', 'Please check your Email to complete the password reset process'),
(55, 1, 'Có lỗi hệ thống, vui lòng liên hệ Developer', 'Có lỗi hệ thống, vui lòng liên hệ Developer'),
(56, 2, 'Có lỗi hệ thống, vui lòng liên hệ Developer', 'There is a system error, please contact Developer'),
(57, 1, 'Liên kết không tồn tại', 'Liên kết không tồn tại'),
(58, 2, 'Liên kết không tồn tại', 'Link does not exist'),
(59, 1, 'Thay đổi mật khẩu thành công', 'Thay đổi mật khẩu thành công'),
(60, 2, 'Thay đổi mật khẩu thành công', 'Change password successfully'),
(61, 1, 'Thay đổi mật khẩu thất bại', 'Thay đổi mật khẩu thất bại'),
(62, 2, 'Thay đổi mật khẩu thất bại', 'Password change failed'),
(63, 1, 'Hồ sơ của bạn', 'Hồ sơ của bạn'),
(64, 2, 'Hồ sơ của bạn', 'Your Profile'),
(65, 1, 'Tên đăng nhập', 'Tên đăng nhập'),
(66, 2, 'Tên đăng nhập', 'Username'),
(67, 1, 'Địa chỉ Email', 'Địa chỉ Email'),
(68, 2, 'Địa chỉ Email', 'Email address'),
(69, 1, 'Số điện thoại', 'Số điện thoại'),
(70, 2, 'Số điện thoại', 'Phone number'),
(71, 1, 'Họ và Tên', 'Họ và Tên'),
(72, 2, 'Họ và Tên', 'Full name'),
(73, 1, 'Địa chỉ IP', 'Địa chỉ IP'),
(74, 2, 'Địa chỉ IP', 'IP address'),
(75, 1, 'Thiết bị', 'Thiết bị'),
(76, 2, 'Thiết bị', 'Device'),
(77, 1, 'Đăng ký vào lúc', 'Đăng ký vào lúc'),
(78, 2, 'Đăng ký vào lúc', 'Sign up at'),
(79, 1, 'Đăng nhập gần nhất', 'Đăng nhập gần nhất'),
(80, 2, 'Đăng nhập gần nhất', 'Last login'),
(81, 1, 'Chỉnh sửa thông tin', 'Chỉnh sửa thông tin'),
(82, 2, 'Chỉnh sửa thông tin', 'Edit information'),
(83, 1, 'Thay đổi mật khẩu', 'Thay đổi mật khẩu'),
(84, 2, 'Thay đổi mật khẩu', 'Change password'),
(85, 1, 'Thay đổi mật khẩu đăng nhập của bạn là một cách dễ dàng để giữ an toàn cho tài khoản của bạn.', 'Thay đổi mật khẩu đăng nhập của bạn là một cách dễ dàng để giữ an toàn cho tài khoản của bạn.'),
(86, 2, 'Thay đổi mật khẩu đăng nhập của bạn là một cách dễ dàng để giữ an toàn cho tài khoản của bạn.', 'Changing your login password is an easy way to keep your account secure.'),
(87, 1, 'Mật khẩu hiện tại', 'Mật khẩu hiện tại'),
(88, 2, 'Mật khẩu hiện tại', 'Current password'),
(89, 1, 'Mật khẩu mới', 'Mật khẩu mới'),
(90, 2, 'Mật khẩu mới', 'New password'),
(91, 1, 'Nhập lại mật khẩu mới', 'Nhập lại mật khẩu mới'),
(92, 2, 'Nhập lại mật khẩu mới', 'Re-verify new password'),
(93, 1, 'Cập Nhật', 'Cập Nhật'),
(94, 2, 'Cập Nhật', 'Update'),
(95, 1, 'Đăng Xuất', 'Đăng Xuất'),
(96, 2, 'Đăng Xuất', 'Logout'),
(97, 1, 'Bạn có chắc không?', 'Bạn có chắc không?'),
(98, 2, 'Bạn có chắc không?', 'Are you sure?'),
(99, 1, 'Bạn sẽ bị đăng xuất khỏi tài khoản khi nhấn Đồng Ý', 'Bạn sẽ bị đăng xuất khỏi tài khoản khi nhấn Đồng Ý'),
(100, 2, 'Bạn sẽ bị đăng xuất khỏi tài khoản khi nhấn Đồng Ý', 'You will be posted from the account when click Okey'),
(101, 1, 'Đồng ý', 'Đồng ý'),
(102, 2, 'Đồng ý', 'Okey'),
(103, 1, 'Huỷ bỏ', 'Huỷ bỏ'),
(104, 2, 'Huỷ bỏ', 'Cancel'),
(105, 1, 'Đăng Nhập', 'Đăng Nhập'),
(106, 2, 'Đăng Nhập', 'Sign In'),
(107, 1, 'Vui Lòng Đăng Nhập Để Tiếp Tục', 'Vui Lòng Đăng Nhập Để Tiếp Tục'),
(108, 2, 'Vui Lòng Đăng Nhập Để Tiếp Tục', 'Please Login To Continue'),
(109, 1, 'Quên mật khẩu', 'Quên mật khẩu'),
(110, 2, 'Quên mật khẩu', 'Forgot password'),
(111, 1, 'Bạn quên mật khẩu?', 'Bạn quên mật khẩu?'),
(112, 2, 'Bạn quên mật khẩu?', 'Forgot your password?'),
(113, 1, 'Vui lòng nhập thông tin vào ô dưới đây để xác minh', 'Vui lòng nhập thông tin vào ô dưới đây để xác minh'),
(114, 2, 'Vui lòng nhập thông tin vào ô dưới đây để xác minh', 'Please enter information in the box below to verify'),
(115, 1, 'Xác minh', 'Xác minh'),
(116, 2, 'Xác minh', 'Verification'),
(117, 1, 'Bạn đã có tài khoản?', 'Bạn đã có tài khoản?'),
(118, 2, 'Bạn đã có tài khoản?', 'Do you already have an account?'),
(119, 1, 'Ghi nhớ tôi', 'Ghi nhớ tôi'),
(120, 2, 'Ghi nhớ tôi', 'Remember'),
(121, 1, 'Quên mật khẩu?', 'Quên mật khẩu?'),
(122, 2, 'Quên mật khẩu?', 'Forgot password?'),
(123, 1, 'Bạn chưa có tài khoản?', 'Bạn chưa có tài khoản?'),
(124, 2, 'Bạn chưa có tài khoản?', 'Do not have an account?'),
(125, 1, 'Đăng Ký Ngay', 'Đăng Ký Ngay'),
(126, 2, 'Đăng Ký Ngay', 'Register'),
(127, 1, 'Nạp tiền', 'Nạp tiền'),
(128, 2, 'Nạp tiền', 'Recharge'),
(129, 1, 'Ngân hàng', 'Ngân hàng'),
(130, 2, 'Ngân hàng', 'Bank'),
(131, 1, 'Ví của tôi', 'Ví của tôi'),
(132, 2, 'Ví của tôi', 'My Wallet'),
(133, 1, 'Số dư hiện tại', 'Số dư hiện tại'),
(134, 2, 'Số dư hiện tại', 'Current balance'),
(135, 1, 'Tổng tiền nạp', 'Tổng tiền nạp'),
(136, 2, 'Tổng tiền nạp', 'Total Deposit'),
(137, 1, 'Số dư đã sử dụng', 'Số dư đã sử dụng'),
(138, 2, 'Số dư đã sử dụng', 'Used Balance'),
(139, 1, 'THANH TOÁN', 'Thanh toán'),
(141, 1, 'Lưu ý nạp tiền', 'Lưu ý nạp tiền'),
(142, 2, 'Lưu ý nạp tiền', 'Recharge note'),
(143, 1, 'Lịch sử nạp tiền', 'Lịch sử nạp tiền'),
(144, 2, 'Lịch sử nạp tiền', 'Recharge History'),
(145, 1, 'Số tài khoản:', 'Số tài khoản:'),
(146, 2, 'Số tài khoản:', 'Account number:'),
(147, 1, 'Chủ tài khoản:', 'Chủ tài khoản:'),
(148, 2, 'Chủ tài khoản:', 'Account name:'),
(149, 1, 'Ngân hàng:', 'Ngân hàng:'),
(150, 2, 'Ngân hàng:', 'Bank:'),
(151, 1, 'Nội dung chuyển khoản:', 'Nội dung chuyển khoản:'),
(152, 2, 'Nội dung chuyển khoản:', 'Transfer content:'),
(153, 1, 'Mã giao dịch', 'Mã giao dịch'),
(154, 2, 'Mã giao dịch', 'Transaction'),
(155, 1, 'Nội dung', 'Nội dung'),
(156, 2, 'Nội dung', 'Content'),
(157, 1, 'Số tiền nạp', 'Số tiền nạp'),
(158, 2, 'Số tiền nạp', 'Amount'),
(159, 1, 'Thực nhận', 'Thực nhận'),
(160, 2, 'Thực nhận', 'Received'),
(161, 1, 'Thời gian', 'Thời gian'),
(162, 2, 'Thời gian', 'Time'),
(163, 1, 'Trạng thái', 'Trạng thái'),
(164, 2, 'Trạng thái', 'Status'),
(165, 1, 'Đã thanh toán', 'Đã thanh toán'),
(166, 2, 'Đã thanh toán', 'Paid'),
(167, 1, 'Tất cả', 'Tất cả'),
(168, 2, 'Tất cả', 'ALL'),
(169, 1, 'Hôm nay', 'Hôm nay'),
(170, 2, 'Hôm nay', 'Today'),
(171, 1, 'Tuần này', 'Tuần này'),
(172, 2, 'Tuần này', 'This week'),
(173, 1, 'Tháng này', 'Tháng này'),
(174, 2, 'Tháng này', 'This month'),
(175, 1, 'Đã thanh toán:', 'Đã thanh toán:'),
(176, 2, 'Đã thanh toán:', 'Paid:'),
(177, 1, 'Thực nhận:', 'Thực nhận:'),
(178, 2, 'Thực nhận:', 'Received:'),
(179, 1, 'Thao tác', 'Thao tác'),
(180, 2, 'Thao tác', 'Action'),
(181, 1, 'Nhật ký hoạt động', 'Nhật ký hoạt động'),
(182, 2, 'Nhật ký hoạt động', 'Activity Log'),
(183, 1, 'Tìm kiếm', 'Tìm kiếm'),
(184, 2, 'Tìm kiếm', 'Search'),
(185, 1, 'Bỏ lọc', 'Bỏ lọc'),
(186, 2, 'Bỏ lọc', 'Clear Filter'),
(187, 1, 'Hiển thị', 'Hiển thị'),
(188, 2, 'Hiển thị', 'Show'),
(189, 1, 'Ẩn', 'Ẩn'),
(190, 2, 'Ẩn', 'Hide'),
(191, 1, 'Biến động số dư', 'Biến động số dư'),
(192, 2, 'Biến động số dư', 'Transactions'),
(193, 1, 'Số dư ban đầu', 'Số dư ban đầu'),
(194, 2, 'Số dư ban đầu', 'Initial balance'),
(195, 1, 'Số dư thay đổi', 'Số dư thay đổi'),
(196, 2, 'Số dư thay đổi', 'Balance change'),
(197, 1, 'Lý do', 'Lý do'),
(198, 2, 'Lý do', 'Reason'),
(199, 1, 'Chọn thời gian cần tìm', 'Chọn thời gian cần tìm'),
(200, 2, 'Chọn thời gian cần tìm', 'Choose a time to search'),
(203, 2, 'Hiển thị thêm', 'Show more'),
(204, 1, 'Hiển thị thêm', 'Hiển thị thêm'),
(205, 1, 'Ẩn bớt', 'Ẩn bớt'),
(206, 2, 'Ẩn bớt', 'Hide'),
(207, 1, 'Nội dung chuyển khoản', 'Nội dung chuyển khoản'),
(208, 2, 'Nội dung chuyển khoản', 'Transfer contents'),
(209, 1, 'Đăng nhập bằng Google', 'Đăng nhập bằng Google'),
(210, 2, 'Đăng nhập bằng Google', 'Login with Google'),
(211, 1, 'Đăng nhập bằng Facebook', 'Đăng nhập bằng Facebook'),
(212, 2, 'Đăng nhập bằng Facebook', 'Login with Google'),
(213, 1, 'Đăng ký tài khoản', 'Đăng ký tài khoản'),
(214, 2, 'Đăng ký tài khoản', 'Sign up for an account'),
(215, 1, 'Tài khoản đăng nhập', 'Tài khoản đăng nhập'),
(216, 2, 'Tài khoản đăng nhập', 'Username'),
(217, 1, 'Mật khẩu', 'Mật khẩu'),
(218, 2, 'Mật khẩu', 'Password'),
(219, 1, 'Nhập lại mật khẩu', 'Nhập lại mật khẩu'),
(220, 2, 'Nhập lại mật khẩu', 'Confirm password'),
(221, 1, 'Đăng Ký', 'Đăng Ký'),
(222, 2, 'Đăng Ký', 'Register'),
(223, 1, 'Vui lòng nhập thông tin đăng ký', 'Vui lòng nhập thông tin đăng ký'),
(224, 2, 'Vui lòng nhập thông tin đăng ký', 'Please enter registration information'),
(225, 1, 'Vui lòng nhập thông tin đăng nhập', 'Vui lòng nhập thông tin đăng nhập'),
(226, 2, 'Vui lòng nhập thông tin đăng nhập', 'Please enter login information'),
(227, 1, 'Thông tin cá nhân', 'Thông tin cá nhân'),
(228, 2, 'Thông tin cá nhân', 'Personal information'),
(229, 1, 'Cấu hình nạp tiền Crypto', 'Cấu hình nạp tiền Crypto'),
(230, 2, 'Cấu hình nạp tiền Crypto', 'Configuration Recharge Crypto'),
(231, 1, 'All Time', 'All Time'),
(232, 2, 'All Time', 'Toàn thời gian'),
(235, 1, 'Thống kê thanh toán tháng', 'Thống kê thanh toán tháng'),
(236, 2, 'Thống kê thanh toán tháng', 'Payment Statistics Month'),
(237, 1, 'Lịch sử nạp tiền Crypto', 'Lịch sử nạp tiền Crypto'),
(238, 2, 'Lịch sử nạp tiền Crypto', 'Crypto Deposit History'),
(239, 1, 'Thống kê', 'Thống kê'),
(240, 2, 'Thống kê', 'Statistical'),
(241, 1, 'Cấu hình', 'Cấu hình'),
(242, 2, 'Cấu hình', 'Configuration'),
(243, 1, 'Nạp tối đa', 'Nạp tối đa'),
(244, 2, 'Nạp tối đa', 'Maximum deposit amount'),
(245, 1, 'Nạp tối thiểu', 'Nạp tối thiểu'),
(246, 2, 'Nạp tối thiểu', 'Minimum deposit amount'),
(247, 1, 'Nạp tiền bằng Crypto', 'Nạp tiền bằng Crypto'),
(248, 2, 'Nạp tiền bằng Crypto', 'Deposit with Crypto'),
(249, 1, 'Lưu ý', 'Lưu ý'),
(250, 2, 'Lưu ý', 'Note'),
(251, 1, 'Lịch sử nạp Crypto', 'Lịch sử nạp Crypto'),
(252, 2, 'Lịch sử nạp Crypto', 'Crypto Deposit History'),
(253, 1, 'Số lượng', 'Số lượng'),
(254, 2, 'Số lượng', 'Amount'),
(255, 1, 'Thời gian tạo', 'Thời gian tạo'),
(256, 2, 'Thời gian tạo', 'Create date'),
(257, 1, 'Xem thêm', 'Xem thêm'),
(258, 2, 'Xem thêm', 'See more'),
(259, 1, 'The minimum deposit amount is:', 'The minimum deposit amount is:'),
(261, 1, 'Số tiền gửi tối đa là:', 'Số tiền gửi tối đa là:'),
(262, 2, 'Số tiền gửi tối đa là:', 'The maximum deposit amount is:'),
(263, 1, 'Số tiền gửi tối thiểu là:', 'Số tiền gửi tối thiểu là:'),
(264, 2, 'Số tiền gửi tối thiểu là:', 'The minimum deposit amount is:'),
(265, 1, 'Chức năng này đang được bảo trì', 'Chức năng này đang được bảo trì'),
(266, 2, 'Chức năng này đang được bảo trì', 'This function is under maintenance'),
(267, 1, 'Không thể tạo hóa đơn do lỗi API, vui lòng thử lại sau', 'Không thể tạo hóa đơn do lỗi API, vui lòng thử lại sau'),
(268, 2, 'Không thể tạo hóa đơn do lỗi API, vui lòng thử lại sau', 'Invoice could not be generated due to API error, please try again later'),
(269, 1, 'Tạo hoá đơn nạp tiền thành công', 'Tạo hoá đơn nạp tiền thành công'),
(270, 2, 'Tạo hoá đơn nạp tiền thành công', 'Deposit request created successfully'),
(271, 1, 'Nạp tiền bằng PayPal', 'Nạp tiền bằng PayPal'),
(272, 2, 'Nạp tiền bằng PayPal', 'Pay with PayPal'),
(273, 1, 'Lịch sử nạp PayPal', 'Lịch sử nạp PayPal'),
(274, 2, 'Lịch sử nạp PayPal', 'PayPal Recharge History'),
(275, 1, 'Số tiền gửi', 'Số tiền gửi'),
(276, 2, 'Số tiền gửi', 'Amount'),
(277, 1, 'Vui lòng nhập số tiền cần nạp', 'Vui lòng nhập số tiền cần nạp'),
(278, 2, 'Vui lòng nhập số tiền cần nạp', 'Please enter the amount to deposit'),
(279, 1, 'Mặc định', 'Mặc định'),
(280, 2, 'Mặc định', 'Default'),
(281, 1, 'Phổ biến', 'Phổ biến'),
(282, 2, 'Phổ biến', 'Popular'),
(283, 1, 'Tìm kiếm bài viết', 'Tìm kiếm bài viết'),
(284, 2, 'Tìm kiếm bài viết', 'Find Blogs'),
(285, 1, 'Bài viết phổ biến', 'Bài viết phổ biến'),
(286, 2, 'Bài viết phổ biến', 'Popular Feeds'),
(287, 1, 'Liên kết giới thiệu của bạn', 'Liên kết giới thiệu của bạn'),
(288, 2, 'Liên kết giới thiệu của bạn', 'Your referral link'),
(289, 1, 'Đã sao chép vào bộ nhớ tạm', 'Đã sao chép vào bộ nhớ tạm'),
(290, 2, 'Đã sao chép vào bộ nhớ tạm', 'Copied to clipboard'),
(291, 1, 'Số tài khoản', 'Số tài khoản'),
(292, 2, 'Số tài khoản', 'Account number'),
(293, 1, 'Tên chủ tài khoản', 'Tên chủ tài khoản'),
(294, 2, 'Tên chủ tài khoản', 'Account name'),
(295, 1, 'Số tiền cần rút', 'Số tiền cần rút'),
(296, 2, 'Số tiền cần rút', 'Amount to withdraw'),
(297, 1, 'Rút số dư hoa hồng', 'Rút số dư hoa hồng'),
(298, 2, 'Rút số dư hoa hồng', 'Affiliate Withdraw'),
(299, 1, 'Lịch sử rút tiền', 'Lịch sử rút tiền'),
(300, 2, 'Lịch sử rút tiền', 'Withdraw history'),
(301, 1, 'Rút tiền', 'Rút tiền'),
(302, 2, 'Rút tiền', 'Withdraw'),
(303, 1, 'Lịch sử', 'Lịch sử'),
(304, 2, 'Lịch sử', 'History'),
(305, 1, 'Thao tác quá nhanh, vui lòng chờ', 'Thao tác quá nhanh, vui lòng chờ'),
(306, 2, 'Thao tác quá nhanh, vui lòng chờ', 'You are working too fast, please wait'),
(307, 1, 'Vui lòng chọn ngân hàng cần rút', 'Vui lòng chọn ngân hàng cần rút'),
(308, 2, 'Vui lòng chọn ngân hàng cần rút', 'Please select the bank to withdraw'),
(309, 1, 'Vui lòng nhập số tài khoản cần rút', 'Vui lòng nhập số tài khoản cần rút'),
(310, 2, 'Vui lòng nhập số tài khoản cần rút', 'Please enter the account number to withdraw'),
(311, 1, 'Vui lòng nhập tên chủ tài khoản', 'Vui lòng nhập tên chủ tài khoản'),
(312, 2, 'Vui lòng nhập tên chủ tài khoản', 'Please enter the account name'),
(313, 1, 'Vui lòng nhập số tiền cần rút', 'Vui lòng nhập số tiền cần rút'),
(314, 2, 'Vui lòng nhập số tiền cần rút', 'Please enter the amount to withdraw'),
(315, 1, 'Số tiền rút tối thiểu phải là', 'Số tiền rút tối thiểu phải là'),
(316, 2, 'Số tiền rút tối thiểu phải là', 'Minimum withdrawal amount should be'),
(317, 1, 'Số dư hoa hồng khả dụng của bạn không đủ', 'Số dư hoa hồng khả dụng của bạn không đủ'),
(318, 2, 'Số dư hoa hồng khả dụng của bạn không đủ', 'Your available commission balance is not enough'),
(319, 1, 'Gian lận khi rút số dư hoa hồng', 'Gian lận khi rút số dư hoa hồng'),
(320, 2, 'Gian lận khi rút số dư hoa hồng', 'Fraud when withdrawing commission balance'),
(321, 1, 'Tài khoản của bạn đã bị khóa vì gian lận', 'Tài khoản của bạn đã bị khóa vì gian lận'),
(322, 2, 'Tài khoản của bạn đã bị khóa vì gian lận', 'Your account has been blocked for cheating'),
(323, 1, 'Yêu cầu rút tiền được tạo thành công, vui lòng đợi ADMIN xử lý', 'Yêu cầu rút tiền được tạo thành công, vui lòng đợi ADMIN xử lý'),
(324, 2, 'Yêu cầu rút tiền được tạo thành công, vui lòng đợi ADMIN xử lý', 'Withdrawal request created successfully, please wait for ADMIN to process'),
(325, 1, 'Số tiền rút', 'Số tiền rút'),
(326, 2, 'Số tiền rút', 'Withdrawal amount'),
(327, 1, 'Thông kê của bạn', 'Thông kê của bạn'),
(328, 2, 'Thông kê của bạn', 'Your stats'),
(329, 1, 'Số tiền hoa hồng khả dụng', 'Số tiền hoa hồng khả dụng'),
(330, 2, 'Số tiền hoa hồng khả dụng', 'Amount of available commission'),
(331, 1, 'Tổng số tiền hoa hồng đã nhận', 'Tổng số tiền hoa hồng đã nhận'),
(332, 2, 'Tổng số tiền hoa hồng đã nhận', 'Total commission received'),
(333, 1, 'Số lần nhấp vào liên kết', 'Số lần nhấp vào liên kết'),
(334, 2, 'Số lần nhấp vào liên kết', 'Clicks'),
(335, 1, 'Lịch sử hoa hồng', 'Lịch sử hoa hồng'),
(336, 2, 'Lịch sử hoa hồng', 'History commission'),
(337, 1, 'Hoa hồng ban đầu', 'Hoa hồng ban đầu'),
(338, 2, 'Hoa hồng ban đầu', 'Initial commission balance'),
(339, 1, 'Hoa hồng thay đổi', 'Hoa hồng thay đổi'),
(340, 2, 'Hoa hồng thay đổi', 'Change commission balance'),
(341, 1, 'Hoa hồng hiện tại', 'Hoa hồng hiện tại'),
(342, 2, 'Hoa hồng hiện tại', 'Current commission balance'),
(343, 1, 'Vui lòng nhập số lượng cần mua', 'Vui lòng nhập số lượng cần mua'),
(344, 2, 'Vui lòng nhập số lượng cần mua', 'Please enter the quantity'),
(345, 1, 'Tổng tiền thanh toán:', 'Tổng tiền thanh toán:'),
(346, 2, 'Tổng tiền thanh toán:', 'Total payment:'),
(347, 1, 'Số tiền giảm:', 'Số tiền giảm:'),
(348, 2, 'Số tiền giảm:', 'Discount:'),
(349, 1, 'Thành tiền:', 'Thành tiền:'),
(350, 2, 'Thành tiền:', 'Price:'),
(351, 1, 'Mã giảm giá:', 'Mã giảm giá:'),
(352, 2, 'Mã giảm giá:', 'Coupon:'),
(353, 1, 'Nhập mã giảm giá nếu có', 'Nhập mã giảm giá nếu có'),
(354, 2, 'Nhập mã giảm giá nếu có', 'Enter discount code if available'),
(355, 1, 'THÔNG TIN MUA HÀNG', 'THÔNG TIN MUA HÀNG'),
(356, 2, 'THÔNG TIN MUA HÀNG', 'PURCHASE INFORMATION'),
(357, 1, 'Số lượng cần mua:', 'Số lượng cần mua:'),
(358, 2, 'Số lượng cần mua:', 'Amount:'),
(359, 1, 'Chia sẻ:', 'Chia sẻ:'),
(360, 2, 'Chia sẻ:', 'Share:'),
(361, 1, 'Mua Ngay', 'Mua Ngay'),
(362, 2, 'Mua Ngay', 'Buy Now'),
(363, 1, 'Kho hàng:', 'Kho hàng:'),
(364, 2, 'Kho hàng:', 'Stock:'),
(365, 1, 'Đã bán:', 'Đã bán:'),
(366, 2, 'Đã bán:', 'Sold:'),
(367, 1, 'Yêu Thích', 'Yêu Thích'),
(368, 2, 'Yêu Thích', 'Add Favourite'),
(369, 1, 'Bỏ Thích', 'Bỏ Thích'),
(370, 2, 'Bỏ Thích', 'Remove Favourite'),
(371, 1, 'Danh sách sản phẩm yêu thích', 'Danh sách sản phẩm yêu thích'),
(372, 2, 'Danh sách sản phẩm yêu thích', 'Favorites'),
(373, 1, 'Sản phẩm', 'Sản phẩm'),
(374, 2, 'Sản phẩm', 'Product'),
(375, 1, 'Kho hàng', 'Kho hàng'),
(376, 2, 'Kho hàng', 'Stock'),
(377, 1, 'Giá', 'Giá'),
(378, 2, 'Giá', 'Price'),
(379, 1, 'Mua', 'Mua'),
(380, 2, 'Mua', 'Buy'),
(381, 1, 'Xem', 'Xem'),
(382, 2, 'Xem', 'View'),
(383, 1, 'Xóa', 'Xóa'),
(384, 2, 'Xóa', 'Delete'),
(385, 1, 'Hết hàng', 'Hết hàng'),
(386, 2, 'Hết hàng', 'Out of Stock'),
(387, 1, 'Thêm vào mục yêu thích', 'Thêm vào mục yêu thích'),
(388, 2, 'Thêm vào mục yêu thích', 'Add to Favorites'),
(389, 1, 'Đã thêm vào mục yêu thích', 'Đã thêm vào mục yêu thích'),
(390, 2, 'Đã thêm vào mục yêu thích', 'Added to Favorites'),
(393, 2, 'Lịch sử đơn hàng', 'Order History'),
(394, 1, 'Xóa đơn hàng', 'Xóa đơn hàng'),
(395, 2, 'Xóa đơn hàng', 'Delete Order'),
(396, 1, 'Xóa đơn hàng đã chọn khỏi lịch sử của bạn', 'Xóa đơn hàng đã chọn khỏi lịch sử của bạn'),
(397, 2, 'Xóa đơn hàng đã chọn khỏi lịch sử của bạn', 'Delete selected orders from your history'),
(398, 1, 'Mã đơn hàng', 'Mã đơn hàng'),
(399, 2, 'Mã đơn hàng', 'Transaction'),
(400, 2, 'Thanh toán', 'Pay'),
(401, 1, 'Xem chi tiết', 'Xem chi tiết'),
(402, 2, 'Xem chi tiết', 'See details'),
(403, 1, 'Tải về máy', 'Tải về máy'),
(404, 2, 'Tải về máy', 'Download'),
(405, 1, 'Xóa khỏi lịch sử', 'Xóa khỏi lịch sử'),
(406, 2, 'Xóa khỏi lịch sử', 'Delete from history'),
(407, 1, 'Liên hệ', 'Liên hệ'),
(408, 2, 'Liên hệ', 'Contact'),
(409, 1, 'Chính sách', 'Chính sách'),
(410, 2, 'Chính sách', 'Policy'),
(411, 1, 'Tài liệu API', 'Tài liệu API'),
(412, 2, 'Tài liệu API', 'API Document'),
(413, 1, 'Trang chủ', 'Trang chủ'),
(414, 2, 'Trang chủ', 'Home'),
(415, 1, 'Liên kết', 'Liên kết'),
(416, 2, 'Liên kết', 'Links'),
(417, 1, 'Câu hỏi thường gặp', 'Câu hỏi thường gặp'),
(418, 2, 'Câu hỏi thường gặp', 'FAQ'),
(419, 1, 'Liên hệ chúng tôi', 'Liên hệ chúng tôi'),
(420, 2, 'Liên hệ chúng tôi', 'Contact us'),
(421, 1, 'Sản phẩm:', 'Sản phẩm:'),
(422, 2, 'Sản phẩm:', 'Product:'),
(423, 1, 'Số lượng mua:', 'Số lượng mua:'),
(424, 2, 'Số lượng mua:', 'Quantity purchased:'),
(425, 1, 'Thanh toán:', 'Thanh toán:'),
(426, 2, 'Thanh toán:', 'Pay:'),
(427, 1, 'Mã đơn hàng:', 'Mã đơn hàng:'),
(428, 2, 'Mã đơn hàng:', 'Transaction:'),
(429, 1, 'Chi tiết đơn hàng', 'Chi tiết đơn hàng'),
(430, 2, 'Chi tiết đơn hàng', 'Order details'),
(431, 1, 'Tài khoản', 'Tài khoản'),
(432, 2, 'Tài khoản', 'Account'),
(433, 1, 'Lưu các tài khoản đã chọn vào tệp .txt', 'Lưu các tài khoản đã chọn vào tệp .txt'),
(434, 2, 'Lưu các tài khoản đã chọn vào tệp .txt', 'Save selected accounts to a .txt file'),
(435, 1, 'Sao chép các tài khoản đã chọn', 'Sao chép các tài khoản đã chọn'),
(436, 2, 'Sao chép các tài khoản đã chọn', 'Copy selected accounts'),
(437, 1, 'Chỉ sao chép UID các tài khoản đã chọn', 'Chỉ sao chép UID các tài khoản đã chọn'),
(438, 2, 'Chỉ sao chép UID các tài khoản đã chọn', 'Copy only the UID of the selected accounts'),
(439, 1, 'Số dư của tôi:', 'Số dư của tôi:'),
(440, 2, 'Số dư của tôi:', 'My balance:'),
(441, 1, 'Khuyến mãi', 'Khuyến mãi'),
(442, 2, 'Khuyến mãi', 'Promotion'),
(443, 1, 'Số tiền nạp lớn hơn hoặc bằng', 'Số tiền nạp lớn hơn hoặc bằng'),
(444, 2, 'Số tiền nạp lớn hơn hoặc bằng', 'The deposit amount is greater than or equal to'),
(445, 1, 'Khuyến mãi thêm', 'Khuyến mãi thêm'),
(446, 2, 'Khuyến mãi thêm', 'Extra'),
(447, 1, 'Thông tin chi tiết khách hàng', 'Thông tin chi tiết khách hàng'),
(448, 2, 'Thông tin chi tiết khách hàng', 'Customer details'),
(449, 1, 'Chia sẻ liên kết này lên mạng xã hội hoặc bạn bè của bạn.', 'Chia sẻ liên kết này lên mạng xã hội hoặc bạn bè của bạn.'),
(451, 1, 'Tài liệu tích hợp API', 'Tài liệu tích hợp API'),
(452, 2, 'Tài liệu tích hợp API', 'API integration documentation'),
(453, 1, 'Lấy thông tin tài khoản', 'Lấy thông tin tài khoản'),
(454, 2, 'Lấy thông tin tài khoản', 'Get account information'),
(455, 1, 'Lấy danh sách chuyên mục và sản phẩm', 'Lấy danh sách chuyên mục và sản phẩm'),
(456, 2, 'Lấy danh sách chuyên mục và sản phẩm', 'Get a list of categories and products'),
(457, 1, 'Mua hàng', 'Mua hàng'),
(458, 2, 'Mua hàng', 'Purchase'),
(459, 1, 'ID sản phẩm cần mua', 'ID sản phẩm cần mua'),
(460, 2, 'ID sản phẩm cần mua', 'Product ID to buy'),
(461, 1, 'Số lượng cần mua', 'Số lượng cần mua'),
(462, 2, 'Số lượng cần mua', 'Quantity to buy'),
(463, 1, 'Mã giảm giá nếu có', 'Mã giảm giá nếu có'),
(464, 2, 'Mã giảm giá nếu có', 'Discount code if available'),
(465, 1, 'Bảo mật', 'Bảo mật'),
(466, 2, 'Bảo mật', 'Security'),
(467, 1, 'Bảo mật tài khoản', 'Bảo mật tài khoản'),
(468, 2, 'Bảo mật tài khoản', 'Account security'),
(469, 1, 'Xác minh đăng nhập bằng', 'Xác minh đăng nhập bằng'),
(470, 2, 'Xác minh đăng nhập bằng', 'Verify login with'),
(471, 1, 'Gửi thông báo về mail khi đăng nhập thành công:', 'Gửi thông báo về mail khi đăng nhập thành công:'),
(472, 2, 'Gửi thông báo về mail khi đăng nhập thành công:', 'Send email notification upon successful login:'),
(473, 1, 'Đúng Trình Duyệt và IP mua hàng mới có thể xem đơn hàng:', 'Đúng Trình Duyệt và IP mua hàng mới có thể xem đơn hàng:'),
(474, 2, 'Đúng Trình Duyệt và IP mua hàng mới có thể xem đơn hàng:', 'Only the correct browser and purchase IP can view orders:'),
(475, 1, '- Sử dụng điện thoại tải App Google Authenticator sau đó quét mã QR để nhận mã xác minh.', '- Sử dụng điện thoại tải App Google Authenticator sau đó quét mã QR để nhận mã xác minh.'),
(476, 2, '- Sử dụng điện thoại tải App Google Authenticator sau đó quét mã QR để nhận mã xác minh.', '- Use your phone to download the Google Authenticator App then scan the QR code to receive the verification code.'),
(477, 1, '- Mã QR sẽ được thay đổi khi bạn tắt xác minh.', '- Mã QR sẽ được thay đổi khi bạn tắt xác minh.'),
(478, 2, '- Mã QR sẽ được thay đổi khi bạn tắt xác minh.', '- The QR code will be changed when you turn off verification.'),
(479, 1, '- Nếu bật Xác minh đăng nhập bằng OTP Mail thì không bật Google Authenticator và ngược lại.', '- Nếu bật Xác minh đăng nhập bằng OTP Mail thì không bật Google Authenticator và ngược lại.'),
(480, 2, '- Nếu bật Xác minh đăng nhập bằng OTP Mail thì không bật Google Authenticator và ngược lại.', '- If you enable Login Verification using OTP Mail, do not enable Google Authenticator and vice versa.'),
(481, 1, 'Lưu', 'Lưu'),
(482, 2, 'Lưu', 'Save'),
(483, 1, 'Nhập mã xác minh để lưu', 'Nhập mã xác minh để lưu'),
(484, 2, 'Nhập mã xác minh để lưu', 'Enter the verification code to save'),
(485, 1, 'Sản phẩm liên quan đến từ khóa', 'Sản phẩm liên quan đến từ khóa'),
(486, 2, 'Sản phẩm liên quan đến từ khóa', 'Products related to keyword'),
(487, 1, 'trong số', 'trong số'),
(488, 2, 'trong số', 'of'),
(489, 1, 'Quay lại', 'Quay lại'),
(490, 2, 'Quay lại', 'Back'),
(491, 1, 'Tải về đơn hàng', 'Tải về đơn hàng'),
(492, 2, 'Tải về đơn hàng', 'Download Order'),
(493, 1, 'Hệ thống sẽ tải về đơn hàng khi bạn nhấn đồng ý', 'Hệ thống sẽ tải về đơn hàng khi bạn nhấn đồng ý'),
(494, 2, 'Hệ thống sẽ tải về đơn hàng khi bạn nhấn đồng ý', 'The system will download the order when you click Okey'),
(495, 1, 'Hệ thống sẽ xóa đơn hàng khỏi lịch sử của bạn khi bạn nhấn đồng ý', 'Hệ thống sẽ xóa đơn hàng khỏi lịch sử của bạn khi bạn nhấn đồng ý'),
(496, 2, 'Hệ thống sẽ xóa đơn hàng khỏi lịch sử của bạn khi bạn nhấn đồng ý', 'The system will delete the order from your history when you click Okey'),
(497, 1, 'Đóng', 'Đóng'),
(498, 2, 'Đóng', 'Cancel'),
(499, 1, 'Xuất tất cả tài khoản ra tệp .txt', 'Xuất tất cả tài khoản ra tệp .txt'),
(500, 2, 'Xuất tất cả tài khoản ra tệp .txt', 'Export all accounts to a .txt file'),
(501, 1, 'Xóa đơn hàng này khỏi lịch sử của bạn', 'Xóa đơn hàng này khỏi lịch sử của bạn'),
(502, 2, 'Xóa đơn hàng này khỏi lịch sử của bạn', 'Delete this order from your history'),
(503, 1, 'Thành công !', 'Thành công !'),
(504, 2, 'Thành công !', 'Success !'),
(505, 1, 'Xem chi tiết đơn hàng', 'Xem chi tiết đơn hàng'),
(506, 2, 'Xem chi tiết đơn hàng', 'View order details'),
(507, 1, 'Mua thêm', 'Mua thêm'),
(508, 2, 'Mua thêm', 'Buy more'),
(509, 1, 'Tạo đơn hàng thành công !', 'Tạo đơn hàng thành công !'),
(510, 2, 'Tạo đơn hàng thành công !', 'Create order successfully!'),
(511, 1, 'Đang xử lý...', 'Đang xử lý...'),
(512, 2, 'Đang xử lý...', 'Processing...'),
(513, 1, 'tài khoản giảm', 'tài khoản giảm'),
(514, 2, 'tài khoản giảm', 'account discount'),
(515, 1, 'Chi tiết', 'Chi tiết'),
(516, 2, 'Chi tiết', 'Detail'),
(517, 1, 'Tích hợp API', 'Tích hợp API'),
(518, 2, 'Tích hợp API', 'API integration'),
(519, 1, 'Lấy chi tiết sản phẩm', 'Lấy chi tiết sản phẩm'),
(520, 2, 'Lấy chi tiết sản phẩm', 'Get product details'),
(521, 1, 'Ghi chú cá nhân', 'Ghi chú cá nhân'),
(522, 2, 'Ghi chú cá nhân', 'Personal note'),
(523, 1, 'ngày trước', 'ngày trước'),
(524, 2, 'ngày trước', 'days ago'),
(525, 1, 'tiếng trước', 'tiếng trước'),
(526, 2, 'tiếng trước', 'hours ago'),
(527, 1, 'phút trước', 'phút trước'),
(528, 2, 'phút trước', 'minutes ago'),
(529, 1, 'giây trước', 'giây trước'),
(530, 2, 'giây trước', 'seconds ago'),
(531, 1, 'Hôm qua', 'Hôm qua'),
(532, 2, 'Hôm qua', 'Yesterday'),
(533, 1, 'tuần trước', 'tuần trước'),
(534, 2, 'tuần trước', 'weeks ago'),
(535, 1, 'tháng trước', 'tháng trước'),
(536, 2, 'tháng trước', 'months ago'),
(537, 1, 'năm trước', 'năm trước'),
(538, 2, 'năm trước', 'last year'),
(539, 1, 'Đơn hàng đã bị xóa', 'Đơn hàng đã bị xóa'),
(540, 2, 'Đơn hàng đã bị xóa', 'Order has been deleted'),
(541, 1, 'Bạn có chắc không', 'Bạn có chắc không'),
(543, 1, 'Hệ thống sẽ xóa', 'Hệ thống sẽ xóa'),
(544, 2, 'Hệ thống sẽ xóa', 'The system will delete'),
(545, 1, 'đơn hàng bạn chọn khi nhấn Đồng Ý', 'đơn hàng bạn chọn khi nhấn Đồng Ý'),
(546, 2, 'đơn hàng bạn chọn khi nhấn Đồng Ý', 'order you select when you click Agree'),
(547, 1, 'Vui lòng chọn ít nhất một đơn hàng.', 'Vui lòng chọn ít nhất một đơn hàng.'),
(548, 2, 'Vui lòng chọn ít nhất một đơn hàng.', 'Please select at least one order.'),
(549, 1, 'Thất bại!', 'Thất bại!'),
(550, 2, 'Thất bại!', 'Failure!'),
(551, 1, 'Thành công!', 'Thành công!'),
(552, 2, 'Thành công!', 'Success!'),
(553, 1, 'Xóa đơn hàng thành công', 'Xóa đơn hàng thành công'),
(554, 2, 'Xóa đơn hàng thành công', 'Order deleted successfully'),
(555, 1, 'Miễn phí', 'Miễn phí'),
(556, 2, 'Miễn phí', 'Free'),
(557, 1, 'Lấy mã 2FA', 'Lấy mã 2FA'),
(558, 2, 'Lấy mã 2FA', 'Get 2FA code'),
(559, 1, 'Bạn đang xem', 'Bạn đang xem'),
(560, 2, 'Bạn đang xem', 'You are viewing'),
(561, 1, 'Nhập danh sách UID', 'Nhập danh sách UID'),
(562, 2, 'Nhập danh sách UID', 'Import UID list'),
(563, 1, 'Mỗi dòng 1 UID', 'Mỗi dòng 1 UID'),
(564, 2, 'Mỗi dòng 1 UID', '1 UID per line'),
(565, 1, 'Tài khoản Live', 'Tài khoản Live'),
(566, 2, 'Tài khoản Live', 'UID Live'),
(567, 1, 'Tài khoản Die', 'Tài khoản Die'),
(568, 2, 'Tài khoản Die', 'UID Die'),
(569, 1, 'Giảm giá', 'Giảm giá'),
(570, 2, 'Giảm giá', 'Discount'),
(571, 1, 'Tỷ lệ hoa hồng', 'Tỷ lệ hoa hồng'),
(572, 2, 'Tỷ lệ hoa hồng', 'Commission Rate'),
(573, 1, 'Thành viên đã giới thiệu', 'Thành viên đã giới thiệu'),
(574, 2, 'Thành viên đã giới thiệu', 'Referred Member'),
(575, 1, 'Không có dữ liệu', 'Không có dữ liệu'),
(576, 2, 'Không có dữ liệu', 'No data available'),
(577, 1, 'Khách hàng', 'Khách hàng'),
(578, 2, 'Khách hàng', 'Username'),
(579, 1, 'Ngày đăng ký', 'Ngày đăng ký'),
(580, 2, 'Ngày đăng ký', 'Registration date'),
(581, 1, 'Hoa hồng', 'Hoa hồng'),
(582, 2, 'Hoa hồng', 'Commission'),
(583, 1, 'Mật khẩu mạnh', 'Mật khẩu mạnh'),
(584, 2, 'Mật khẩu mạnh', 'Strong password'),
(585, 1, 'Mật khẩu trung bình', 'Mật khẩu trung bình'),
(586, 2, 'Mật khẩu trung bình', 'Average Password'),
(587, 1, 'Mật khẩu rất yếu', 'Mật khẩu rất yếu'),
(588, 2, 'Mật khẩu rất yếu', 'Password is very weak'),
(589, 1, 'Vui lòng nhập mã xác minh 2FA', 'Vui lòng nhập mã xác minh 2FA'),
(590, 2, 'Vui lòng nhập mã xác minh 2FA', 'Please enter 2FA verification code'),
(591, 1, 'Mã xác minh không chính xác', 'Mã xác minh không chính xác'),
(592, 2, 'Mã xác minh không chính xác', 'Verification code is incorrect'),
(593, 1, 'Bật xác thực Google Authenticator', 'Bật xác thực Google Authenticator'),
(594, 2, 'Bật xác thực Google Authenticator', 'Enable Google Authenticator'),
(595, 1, 'Tắt xác thực Google Authenticator', 'Tắt xác thực Google Authenticator'),
(596, 2, 'Tắt xác thực Google Authenticator', 'Disable Google Authenticator'),
(597, 1, 'Vui lòng đăng nhập để sử dụng tính năng này', 'Vui lòng đăng nhập để sử dụng tính năng này'),
(598, 2, 'Vui lòng đăng nhập để sử dụng tính năng này', 'Please login to use this feature'),
(599, 1, 'Chọn phương thức nạp tiền', 'Chọn phương thức nạp tiền'),
(600, 2, 'Chọn phương thức nạp tiền', 'Select deposit method'),
(601, 1, 'Không hiển thị lại trong 2 giờ', 'Không hiển thị lại trong 2 giờ'),
(602, 2, 'Không hiển thị lại trong 2 giờ', 'hide for 2 hours'),
(603, 1, 'Thông báo', 'Thông báo'),
(604, 2, 'Thông báo', 'Notification'),
(605, 1, 'Tìm kiếm sản phẩm...', 'Tìm kiếm sản phẩm...'),
(606, 2, 'Tìm kiếm sản phẩm...', 'Search for products...'),
(607, 1, 'Chat hỗ trợ', 'Chat hỗ trợ'),
(608, 2, 'Chat hỗ trợ', 'Chat support'),
(609, 1, 'Chat ngay', 'Chat ngay'),
(610, 2, 'Chat ngay', 'Chat now'),
(611, 1, 'ĐƠN HÀNG GẦN ĐÂY', 'ĐƠN HÀNG GẦN ĐÂY'),
(612, 2, 'ĐƠN HÀNG GẦN ĐÂY', 'RECENT ORDERS'),
(613, 1, 'NẠP TIỀN GẦN ĐÂY', 'NẠP TIỀN GẦN ĐÂY'),
(614, 2, 'NẠP TIỀN GẦN ĐÂY', 'RECENT DEPOSIT'),
(615, 1, 'Chức năng này chưa được cấu hình, vui lòng liên hệ Admin', 'Chức năng này chưa được cấu hình, vui lòng liên hệ Admin'),
(616, 2, 'Chức năng này chưa được cấu hình, vui lòng liên hệ Admin', 'This function is not configured yet, please contact Admin'),
(617, 1, 'Số dư không đủ, vui lòng nạp thêm', 'Số dư không đủ, vui lòng nạp thêm'),
(618, 2, 'Số dư không đủ, vui lòng nạp thêm', 'Insufficient balance, please top up'),
(619, 1, 'Công cụ Check Live UID Facebook', 'Công cụ Check Live UID Facebook'),
(620, 2, 'Công cụ Check Live UID Facebook', 'Facebook Live UID Check Tool'),
(621, 1, 'Tiếp thị liên kết', 'Tiếp thị liên kết'),
(622, 2, 'Tiếp thị liên kết', 'Affiliate Marketing'),
(623, 1, 'Liên kết sản phẩm', 'Liên kết sản phẩm'),
(624, 2, 'Liên kết sản phẩm', 'Product Links'),
(625, 1, 'Chia sẻ liên kết sản phẩm dưới đây cho bạn bè của bạn, bạn sẽ nhận được hoa hồng khi bạn bè của bạn mua hàng thông qua liên kết phía dưới.', 'Chia sẻ liên kết sản phẩm dưới đây cho bạn bè của bạn, bạn sẽ nhận được hoa hồng khi bạn bè của bạn mua hàng thông qua liên kết phía dưới.'),
(626, 2, 'Chia sẻ liên kết sản phẩm dưới đây cho bạn bè của bạn, bạn sẽ nhận được hoa hồng khi bạn bè của bạn mua hàng thông qua liên kết phía dưới.', 'Share the product link below to your friends, you will receive commission when your friends purchase through the link below.'),
(627, 1, 'Tất cả sản phẩm', 'Tất cả sản phẩm'),
(628, 2, 'Tất cả sản phẩm', 'All products'),
(939, 1, 'Sản phẩm yêu thích', 'Sản phẩm yêu thích'),
(941, 2, 'Sản phẩm yêu thích', 'Favorites'),
(942, 20, 'Vui lòng nhập username', '请输入用户名'),
(943, 20, 'Vui lòng nhập mật khẩu', '请输入密码'),
(944, 20, 'Vui lòng xác minh Captcha', '请验证验证码'),
(945, 20, 'Thông tin đăng nhập không chính xác', '登录信息不正确'),
(946, 20, 'Vui lòng nhập địa chỉ Email', '请输入电子邮件地址'),
(947, 20, 'Vui lòng nhập lại mật khẩu', '请重新输入密码'),
(948, 20, 'Xác minh mật khẩu không chính xác', '确认密码不正确'),
(949, 20, 'Tên đăng nhập đã tồn tại trong hệ thống', '该登录名在系统中已经存在。'),
(950, 20, 'Địa chỉ email đã tồn tại trong hệ thống', '电子邮件地址已存在于系统中'),
(951, 20, 'IP của bạn đã đạt đến giới hạn tạo tài khoản cho phép', '您的 IP 已达到允许的帐户创建限制。'),
(952, 20, 'Đăng ký thành công!', '注册成功！'),
(953, 20, 'Tạo tài khoản không thành công, vui lòng thử lại', '账户创建失败，请重试'),
(954, 20, 'Vui lòng đăng nhập', '请登录'),
(955, 20, 'Lưu thành công', '保存成功'),
(956, 20, 'Lưu thất bại', '保存失败'),
(957, 20, 'Vui lòng nhập mật khẩu hiện tại', '请输入当前密码'),
(958, 20, 'Vui lòng nhập mật khẩu mới', '请输入新密码'),
(959, 20, 'Mật khẩu mới quá ngắn', '新密码太短'),
(960, 20, 'Xác nhận mật khẩu không chính xác', '确认密码不正确'),
(961, 20, 'Mật khẩu hiện tại không đúng', '当前密码不正确'),
(962, 20, 'Địa chỉ Email này không tồn tại trong hệ thống', '系统中不存在该电子邮件地址'),
(963, 20, 'Vui lòng thử lại trong ít phút', '请几分钟后重试'),
(964, 20, 'Nếu bạn yêu cầu đặt lại mật khẩu, vui lòng nhấp vào liên kết bên dưới để xác minh.', '如果您需要重置密码，请点击下面的链接进行验证。'),
(965, 20, 'Nếu không phải là bạn, vui lòng liên hệ ngay với Quản trị viên của bạn để được hỗ trợ về bảo mật.', '如果不是，请立即联系您的管理员寻求安全帮助。'),
(966, 20, 'Xác nhận tìm mật khẩu website', '确认查找网站密码'),
(967, 20, 'Xác nhận khôi phục mật khẩu', '确认密码恢复'),
(968, 20, 'Vui lòng kiểm tra Email của bạn để hoàn tất quá trình đặt lại mật khẩu', '请查看您的电子邮件以完成密码重置过程。'),
(969, 20, 'Có lỗi hệ thống, vui lòng liên hệ Developer', '系统错误，请联系开发者'),
(970, 20, 'Liên kết không tồn tại', '链接不存在'),
(971, 20, 'Thay đổi mật khẩu thành công', '密码修改成功'),
(972, 20, 'Thay đổi mật khẩu thất bại', '密码更改失败'),
(973, 20, 'Hồ sơ của bạn', '您的个人资料'),
(974, 20, 'Tên đăng nhập', '用户名'),
(975, 20, 'Địa chỉ Email', '电子邮件'),
(976, 20, 'Số điện thoại', '电话号码'),
(977, 20, 'Họ và Tên', '姓名'),
(978, 20, 'Địa chỉ IP', 'IP 地址'),
(979, 20, 'Thiết bị', '设备'),
(980, 20, 'Đăng ký vào lúc', '注册于'),
(981, 20, 'Đăng nhập gần nhất', '上次登录'),
(982, 20, 'Chỉnh sửa thông tin', '编辑信息'),
(983, 20, 'Thay đổi mật khẩu', '更改密码'),
(984, 20, 'Thay đổi mật khẩu đăng nhập của bạn là một cách dễ dàng để giữ an toàn cho tài khoản của bạn.', '更改登录密码是保证帐户安全的简单方法。'),
(985, 20, 'Mật khẩu hiện tại', '当前密码'),
(986, 20, 'Mật khẩu mới', '新密码'),
(987, 20, 'Nhập lại mật khẩu mới', '重新输入新密码'),
(988, 20, 'Cập Nhật', '更新'),
(989, 20, 'Đăng Xuất', '登出'),
(990, 20, 'Bạn có chắc không?', '你确定吗？'),
(991, 20, 'Bạn sẽ bị đăng xuất khỏi tài khoản khi nhấn Đồng Ý', '单击“同意”后，您将退出帐户。'),
(992, 20, 'Đồng ý', '同意'),
(993, 20, 'Huỷ bỏ', '取消'),
(994, 20, 'Đăng Nhập', '登录'),
(995, 20, 'Vui Lòng Đăng Nhập Để Tiếp Tục', '请登录后继续'),
(996, 20, 'Quên mật khẩu', '忘记密码'),
(997, 20, 'Bạn quên mật khẩu?', '忘记密码了吗？'),
(998, 20, 'Vui lòng nhập thông tin vào ô dưới đây để xác minh', '请在下面的框中输入信息以进行验证'),
(999, 20, 'Xác minh', '核实'),
(1000, 20, 'Bạn đã có tài khoản?', '已有账户？'),
(1001, 20, 'Ghi nhớ tôi', '记住账号'),
(1002, 20, 'Quên mật khẩu?', '忘记密码？'),
(1003, 20, 'Bạn chưa có tài khoản?', '沒有帳戶？'),
(1004, 20, 'Đăng Ký Ngay', '立即注册'),
(1005, 20, 'Nạp tiền', '订金'),
(1006, 20, 'Ngân hàng', '银行'),
(1007, 20, 'Ví của tôi', '我的钱包'),
(1008, 20, 'Số dư hiện tại', '当前余额'),
(1009, 20, 'Tổng tiền nạp', '总存款'),
(1010, 20, 'Số dư đã sử dụng', '已使用余额'),
(1011, 20, 'THANH TOÁN', '支付'),
(1012, 20, 'Lưu ý nạp tiền', '存款须知'),
(1013, 20, 'Lịch sử nạp tiền', '存款历史'),
(1014, 20, 'Số tài khoản:', '帐号：'),
(1015, 20, 'Chủ tài khoản:', '帐户持有人：'),
(1016, 20, 'Ngân hàng:', '银行：'),
(1017, 20, 'Nội dung chuyển khoản:', '转让内容：'),
(1018, 20, 'Mã giao dịch', '交易代码'),
(1019, 20, 'Nội dung', '内容'),
(1020, 20, 'Số tiền nạp', '存款金额'),
(1021, 20, 'Thực nhận', '实现'),
(1022, 20, 'Thời gian', '时间'),
(1023, 20, 'Trạng thái', '地位'),
(1024, 20, 'Đã thanh toán', '有薪酬的'),
(1025, 20, 'Tất cả', '全部'),
(1026, 20, 'Hôm nay', '今天'),
(1027, 20, 'Tuần này', '本星期'),
(1028, 20, 'Tháng này', '本月'),
(1029, 20, 'Đã thanh toán:', '有薪酬的：'),
(1030, 20, 'Thực nhận:', '实际收到：'),
(1031, 20, 'Thao tác', '手术'),
(1032, 20, 'Nhật ký hoạt động', '活动日志'),
(1033, 20, 'Tìm kiếm', '搜索'),
(1034, 20, 'Bỏ lọc', '取消过滤'),
(1035, 20, 'Hiển thị', '展示'),
(1036, 20, 'Ẩn', '隐藏'),
(1037, 20, 'Biến động số dư', '余额波动'),
(1038, 20, 'Số dư ban đầu', '期初余额'),
(1039, 20, 'Số dư thay đổi', '平衡调整'),
(1040, 20, 'Lý do', '原因'),
(1041, 20, 'Chọn thời gian cần tìm', '选择时间进行搜索'),
(1042, 20, 'Hiển thị thêm', '显示更多'),
(1043, 20, 'Ẩn bớt', '隐藏'),
(1044, 20, 'Nội dung chuyển khoản', '传输内容'),
(1045, 20, 'Đăng nhập bằng Google', '使用 Google 登录'),
(1046, 20, 'Đăng nhập bằng Facebook', '使用 Facebook 登录'),
(1047, 20, 'Đăng ký tài khoản', '注册账户'),
(1048, 20, 'Tài khoản đăng nhập', '登录账户'),
(1049, 20, 'Mật khẩu', '密码'),
(1050, 20, 'Nhập lại mật khẩu', '重新输入密码'),
(1051, 20, 'Đăng Ký', '登记'),
(1052, 20, 'Vui lòng nhập thông tin đăng ký', '请输入注册信息'),
(1053, 20, 'Vui lòng nhập thông tin đăng nhập', '请输入您的登录信息'),
(1054, 20, 'Thông tin cá nhân', '个人信息'),
(1055, 20, 'Cấu hình nạp tiền Crypto', '加密货币存款配置'),
(1056, 20, 'All Time', '所有时间'),
(1057, 20, 'Thống kê thanh toán tháng', '每月付款统计'),
(1058, 20, 'Lịch sử nạp tiền Crypto', '加密货币存款历史记录'),
(1059, 20, 'Thống kê', '统计'),
(1060, 20, 'Cấu hình', '配置'),
(1061, 20, 'Nạp tối đa', '最大负载'),
(1062, 20, 'Nạp tối thiểu', '最低存款'),
(1063, 20, 'Nạp tiền bằng Crypto', '使用加密货币存款'),
(1064, 20, 'Lưu ý', '笔记'),
(1065, 20, 'Lịch sử nạp Crypto', '加密货币存款历史记录'),
(1066, 20, 'Số lượng', '数量'),
(1067, 20, 'Thời gian tạo', '创建时间'),
(1068, 20, 'Xem thêm', '查看更多'),
(1069, 20, 'The minimum deposit amount is:', '最低存款金额为：'),
(1070, 20, 'Số tiền gửi tối đa là:', '最高存款额为：'),
(1071, 20, 'Số tiền gửi tối thiểu là:', '最低存款金额为：'),
(1072, 20, 'Chức năng này đang được bảo trì', '该功能正在维护中。'),
(1073, 20, 'Không thể tạo hóa đơn do lỗi API, vui lòng thử lại sau', '由于 API 错误，无法生成发票，请稍后重试'),
(1074, 20, 'Tạo hoá đơn nạp tiền thành công', '充值发票创建成功'),
(1075, 20, 'Nạp tiền bằng PayPal', '通过 PayPal 存款'),
(1076, 20, 'Lịch sử nạp PayPal', 'PayPal 存款历史记录'),
(1077, 20, 'Số tiền gửi', '存款金额'),
(1078, 20, 'Vui lòng nhập số tiền cần nạp', '请输入存款金额'),
(1079, 20, 'Mặc định', '默认'),
(1080, 20, 'Phổ biến', '受欢迎的'),
(1081, 20, 'Tìm kiếm bài viết', '搜索文章'),
(1082, 20, 'Bài viết phổ biến', '热门文章'),
(1083, 20, 'Liên kết giới thiệu của bạn', '您的推荐链接'),
(1084, 20, 'Đã sao chép vào bộ nhớ tạm', '已复制到剪贴板'),
(1085, 20, 'Số tài khoản', '帐号'),
(1086, 20, 'Tên chủ tài khoản', '帐户持有人姓名'),
(1087, 20, 'Số tiền cần rút', '提款金额'),
(1088, 20, 'Rút số dư hoa hồng', '提取佣金余额'),
(1089, 20, 'Lịch sử rút tiền', '提款记录'),
(1090, 20, 'Rút tiền', '提款'),
(1091, 20, 'Lịch sử', '历史'),
(1092, 20, 'Thao tác quá nhanh, vui lòng chờ', '操作太快，请等待。'),
(1093, 20, 'Vui lòng chọn ngân hàng cần rút', '请选择您要提款的银行。'),
(1094, 20, 'Vui lòng nhập số tài khoản cần rút', '请输入提款账号'),
(1095, 20, 'Vui lòng nhập tên chủ tài khoản', '请输入帐户持有人姓名'),
(1096, 20, 'Vui lòng nhập số tiền cần rút', '请输入提款金额'),
(1097, 20, 'Số tiền rút tối thiểu phải là', '最低提款金额必须为'),
(1098, 20, 'Số dư hoa hồng khả dụng của bạn không đủ', '您的可用佣金余额不足'),
(1099, 20, 'Gian lận khi rút số dư hoa hồng', '提取佣金余额存在欺诈行为'),
(1100, 20, 'Tài khoản của bạn đã bị khóa vì gian lận', '您的帐户因欺诈已被锁定'),
(1101, 20, 'Yêu cầu rút tiền được tạo thành công, vui lòng đợi ADMIN xử lý', '提款请求创建成功，请等待管理员处理'),
(1102, 20, 'Số tiền rút', '提款金额'),
(1103, 20, 'Thông kê của bạn', '您的统计数据'),
(1104, 20, 'Số tiền hoa hồng khả dụng', '可用佣金额'),
(1105, 20, 'Tổng số tiền hoa hồng đã nhận', '收到的佣金总额'),
(1106, 20, 'Số lần nhấp vào liên kết', '链接点击次数'),
(1107, 20, 'Lịch sử hoa hồng', '玫瑰的历史'),
(1108, 20, 'Hoa hồng ban đầu', '初始佣金'),
(1109, 20, 'Hoa hồng thay đổi', '佣金变动'),
(1110, 20, 'Hoa hồng hiện tại', '现任委员会'),
(1111, 20, 'Vui lòng nhập số lượng cần mua', '请输入购买数量'),
(1112, 20, 'Tổng tiền thanh toán:', '总付款：'),
(1113, 20, 'Số tiền giảm:', '折扣金额：'),
(1114, 20, 'Thành tiền:', '总金额：'),
(1115, 20, 'Mã giảm giá:', '折扣代码：'),
(1116, 20, 'Nhập mã giảm giá nếu có', '如果有折扣码请输入'),
(1117, 20, 'THÔNG TIN MUA HÀNG', '购买信息'),
(1118, 20, 'Số lượng cần mua:', '购买数量：'),
(1119, 20, 'Chia sẻ:', '分享：'),
(1120, 20, 'Mua Ngay', '立即购买'),
(1121, 20, 'Kho hàng:', '仓库：'),
(1122, 20, 'Đã bán:', '卖：'),
(1123, 20, 'Yêu Thích', '最喜欢的'),
(1124, 20, 'Bỏ Thích', '喜欢'),
(1125, 20, 'Danh sách sản phẩm yêu thích', '最喜爱产品列表'),
(1126, 20, 'Sản phẩm', '产品'),
(1127, 20, 'Kho hàng', '仓库'),
(1128, 20, 'Giá', '价格'),
(1129, 20, 'Mua', '第一的'),
(1130, 20, 'Xem', '看'),
(1131, 20, 'Xóa', '擦除'),
(1132, 20, 'Hết hàng', '缺货'),
(1133, 20, 'Thêm vào mục yêu thích', '添加到收藏夹'),
(1134, 20, 'Đã thêm vào mục yêu thích', '已添加到收藏夹'),
(1135, 20, 'Xóa đơn hàng', '删除订单'),
(1136, 20, 'Xóa đơn hàng đã chọn khỏi lịch sử của bạn', '从历史记录中删除选定的订单'),
(1137, 20, 'Mã đơn hàng', '订购代码'),
(1138, 20, 'Xem chi tiết', '查看详细信息'),
(1139, 20, 'Tải về máy', '下载'),
(1140, 20, 'Xóa khỏi lịch sử', '从历史记录中删除'),
(1141, 20, 'Liên hệ', '接触'),
(1142, 20, 'Chính sách', '政策'),
(1143, 20, 'Tài liệu API', 'API 文档'),
(1144, 20, 'Trang chủ', '家'),
(1145, 20, 'Liên kết', '关联'),
(1146, 20, 'Câu hỏi thường gặp', '常见问题'),
(1147, 20, 'Liên hệ chúng tôi', '联系我们'),
(1148, 20, 'Sản phẩm:', '产品：'),
(1149, 20, 'Số lượng mua:', '购买数量：'),
(1150, 20, 'Thanh toán:', '支付：'),
(1151, 20, 'Mã đơn hàng:', '订单代码：'),
(1152, 20, 'Chi tiết đơn hàng', '订单详情'),
(1153, 20, 'Tài khoản', '帐户'),
(1154, 20, 'Lưu các tài khoản đã chọn vào tệp .txt', '将选定的帐户保存到 .txt 文件'),
(1155, 20, 'Sao chép các tài khoản đã chọn', '复制选定的帐户'),
(1156, 20, 'Chỉ sao chép UID các tài khoản đã chọn', '仅复制选定帐户的 UID'),
(1157, 20, 'Số dư của tôi:', '我的余额：'),
(1158, 20, 'Khuyến mãi', '晋升'),
(1159, 20, 'Số tiền nạp lớn hơn hoặc bằng', '存款金额大于或等于'),
(1160, 20, 'Khuyến mãi thêm', '更多促销活动'),
(1161, 20, 'Thông tin chi tiết khách hàng', '客户详细信息'),
(1162, 20, 'Chia sẻ liên kết này lên mạng xã hội hoặc bạn bè của bạn.', '在社交网络上或与您的朋友分享此链接。'),
(1163, 20, 'Tài liệu tích hợp API', 'API 集成文档'),
(1164, 20, 'Lấy thông tin tài khoản', '获取帐户信息'),
(1165, 20, 'Lấy danh sách chuyên mục và sản phẩm', '获取类别和产品列表'),
(1166, 20, 'Mua hàng', '购买'),
(1167, 20, 'ID sản phẩm cần mua', '要购买的产品ID'),
(1168, 20, 'Số lượng cần mua', '购买数量'),
(1169, 20, 'Mã giảm giá nếu có', 'Mã giảm giá nếu có'),
(1170, 20, 'Bảo mật', '安全'),
(1171, 20, 'Bảo mật tài khoản', '账户安全'),
(1172, 20, 'Xác minh đăng nhập bằng', '使用以下方式验证登录'),
(1173, 20, 'Gửi thông báo về mail khi đăng nhập thành công:', '登录成功时发送电子邮件通知：'),
(1174, 20, 'Đúng Trình Duyệt và IP mua hàng mới có thể xem đơn hàng:', '必须使用正确的浏览器和 IP 地址才能查看订单：'),
(1175, 20, '- Sử dụng điện thoại tải App Google Authenticator sau đó quét mã QR để nhận mã xác minh.', '- 使用您的手机下载 Google Authenticator App，然后扫描二维码以接收验证码。'),
(1176, 20, '- Mã QR sẽ được thay đổi khi bạn tắt xác minh.', '- 关闭验证时，二维码将会改变。'),
(1177, 20, '- Nếu bật Xác minh đăng nhập bằng OTP Mail thì không bật Google Authenticator và ngược lại.', '- 如果您启用使用 OTP 邮件登录验证，请不要启用 Google Authenticator，反之亦然。'),
(1178, 20, 'Lưu', '节省'),
(1179, 20, 'Nhập mã xác minh để lưu', '输入验证码保存'),
(1180, 20, 'Sản phẩm liên quan đến từ khóa', '与关键词相关的产品'),
(1181, 20, 'trong số', '之中'),
(1182, 20, 'Quay lại', '回来'),
(1183, 20, 'Tải về đơn hàng', '下载订单'),
(1184, 20, 'Hệ thống sẽ tải về đơn hàng khi bạn nhấn đồng ý', '点击同意后系统将下载订单。'),
(1185, 20, 'Hệ thống sẽ xóa đơn hàng khỏi lịch sử của bạn khi bạn nhấn đồng ý', '当您点击同意时，系统将从您的历史记录中删除该订单。'),
(1186, 20, 'Đóng', '关闭'),
(1187, 20, 'Xuất tất cả tài khoản ra tệp .txt', '将所有帐户导出到 .txt 文件'),
(1188, 20, 'Xóa đơn hàng này khỏi lịch sử của bạn', '从历史记录中删除此订单'),
(1189, 20, 'Thành công !', '成功 ！'),
(1190, 20, 'Xem chi tiết đơn hàng', '查看订单详情'),
(1191, 20, 'Mua thêm', '购买更多'),
(1192, 20, 'Tạo đơn hàng thành công !', '订单创建成功！'),
(1193, 20, 'Đang xử lý...', '加工...'),
(1194, 20, 'tài khoản giảm', '帐户减少'),
(1195, 20, 'Chi tiết', '细节'),
(1196, 20, 'Tích hợp API', 'API 集成'),
(1197, 20, 'Lấy chi tiết sản phẩm', '获取产品详细信息'),
(1198, 20, 'Ghi chú cá nhân', '个人笔记'),
(1199, 20, 'ngày trước', '前一天'),
(1200, 20, 'tiếng trước', '以前的'),
(1201, 20, 'phút trước', '分钟前'),
(1202, 20, 'giây trước', '几秒前'),
(1203, 20, 'Hôm qua', '昨天'),
(1204, 20, 'tuần trước', '上星期'),
(1205, 20, 'tháng trước', '上个月'),
(1206, 20, 'năm trước', '去年'),
(1207, 20, 'Đơn hàng đã bị xóa', '订单已删除'),
(1208, 20, 'Bạn có chắc không', '你确定吗？'),
(1209, 20, 'Hệ thống sẽ xóa', '系统将删除'),
(1210, 20, 'đơn hàng bạn chọn khi nhấn Đồng Ý', '单击“同意”时选择的顺序'),
(1211, 20, 'Vui lòng chọn ít nhất một đơn hàng.', 'Vui lòng chọn ít nhất một đơn hàng.'),
(1212, 20, 'Thất bại!', '失败！'),
(1213, 20, 'Thành công!', '成功！'),
(1214, 20, 'Xóa đơn hàng thành công', '订单删除成功'),
(1215, 20, 'Miễn phí', '免费'),
(1216, 20, 'Lấy mã 2FA', '获取 2FA 代码'),
(1217, 20, 'Bạn đang xem', '您正在查看'),
(1218, 20, 'Nhập danh sách UID', '导入UID列表'),
(1219, 20, 'Mỗi dòng 1 UID', '每行 1 个 UID'),
(1220, 20, 'Tài khoản Live', '真实账户'),
(1221, 20, 'Tài khoản Die', '死账户'),
(1222, 20, 'Giảm giá', '折扣'),
(1223, 20, 'Tỷ lệ hoa hồng', '佣金率'),
(1224, 20, 'Thành viên đã giới thiệu', '推荐会员'),
(1225, 20, 'Không có dữ liệu', '没有可用数据'),
(1226, 20, 'Khách hàng', '客户'),
(1227, 20, 'Ngày đăng ký', '注册日期'),
(1228, 20, 'Hoa hồng', '玫瑰'),
(1229, 20, 'Mật khẩu mạnh', '强密码'),
(1230, 20, 'Mật khẩu trung bình', '平均密码'),
(1231, 20, 'Mật khẩu rất yếu', '密码强度太弱'),
(1232, 20, 'Vui lòng nhập mã xác minh 2FA', '请输入2FA验证码'),
(1233, 20, 'Mã xác minh không chính xác', '验证码不正确'),
(1234, 20, 'Bật xác thực Google Authenticator', '启用 Google 身份验证器'),
(1235, 20, 'Tắt xác thực Google Authenticator', '关闭 Google Authenticator 身份验证'),
(1236, 20, 'Vui lòng đăng nhập để sử dụng tính năng này', '请登录以使用此功能'),
(1237, 20, 'Chọn phương thức nạp tiền', '选择存款方式'),
(1238, 20, 'Không hiển thị lại trong 2 giờ', '2小时后再无显示'),
(1239, 20, 'Thông báo', '通知'),
(1240, 20, 'Tìm kiếm sản phẩm...', '搜索产品...'),
(1241, 20, 'Chat hỗ trợ', '聊天支持'),
(1242, 20, 'Chat ngay', '立即聊天'),
(1243, 20, 'ĐƠN HÀNG GẦN ĐÂY', '近期订单'),
(1244, 20, 'NẠP TIỀN GẦN ĐÂY', '最近存款'),
(1245, 20, 'Chức năng này chưa được cấu hình, vui lòng liên hệ Admin', '该功能尚未配置，请联系管理员'),
(1246, 20, 'Số dư không đủ, vui lòng nạp thêm', '余额不足，请充值'),
(1247, 20, 'Công cụ Check Live UID Facebook', 'Facebook Live UID 检查工具'),
(1248, 20, 'Tiếp thị liên kết', '联盟营销'),
(1249, 20, 'Liên kết sản phẩm', '产品链接'),
(1250, 20, 'Chia sẻ liên kết sản phẩm dưới đây cho bạn bè của bạn, bạn sẽ nhận được hoa hồng khi bạn bè của bạn mua hàng thông qua liên kết phía dưới.', '分享以下产品链接给您的朋友，当您的朋友通过以下链接购买时，您将获得佣金。'),
(1251, 20, 'Tất cả sản phẩm', '所有产品'),
(1252, 20, 'Sản phẩm yêu thích', '最喜欢的产品'),
(1253, 1, 'Chưa thanh toán:', 'Chưa thanh toán:'),
(1254, 20, 'Chưa thanh toán:', 'Chưa thanh toán:'),
(1256, 1, 'Chưa thanh toán', 'Chưa thanh toán'),
(1257, 20, 'Chưa thanh toán', 'Chưa thanh toán');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `fullname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `admin` int NOT NULL DEFAULT '0',
  `ctv` int NOT NULL DEFAULT '0',
  `banned` int NOT NULL DEFAULT '0',
  `reason_banned` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `time_session` int DEFAULT '0',
  `time_request` int NOT NULL DEFAULT '0',
  `ip` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `token_2fa` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `token_forgot_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `time_forgot_password` int NOT NULL DEFAULT '0',
  `money` float NOT NULL DEFAULT '0',
  `total_money` float NOT NULL DEFAULT '0',
  `debit` float NOT NULL DEFAULT '0',
  `gender` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'Male',
  `device` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `avatar` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `status_2fa` int NOT NULL DEFAULT '0',
  `SecretKey_2fa` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `limit_2fa` int NOT NULL DEFAULT '0',
  `discount` float NOT NULL DEFAULT '0',
  `trial` int NOT NULL DEFAULT '0',
  `ref_id` int NOT NULL DEFAULT '0',
  `ref_ck` float NOT NULL DEFAULT '0',
  `ref_click` int NOT NULL DEFAULT '0',
  `ref_amount` float NOT NULL DEFAULT '0',
  `ref_price` float NOT NULL DEFAULT '0',
  `ref_total_price` float NOT NULL DEFAULT '0',
  `telegram_chat_id` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `api_key` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `login_attempts` int NOT NULL DEFAULT '0',
  `status_otp_mail` int NOT NULL DEFAULT '0',
  `otp_mail` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `token_otp_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `limit_otp_mail` int NOT NULL DEFAULT '0',
  `status_noti_login_to_mail` int NOT NULL DEFAULT '0',
  `status_view_order` int NOT NULL DEFAULT '0',
  `utm_source` varchar(55) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'web'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `fullname`, `phone`, `admin`, `ctv`, `banned`, `reason_banned`, `create_date`, `update_date`, `time_session`, `time_request`, `ip`, `token`, `remember_token`, `token_2fa`, `token_forgot_password`, `time_forgot_password`, `money`, `total_money`, `debit`, `gender`, `device`, `avatar`, `status_2fa`, `SecretKey_2fa`, `limit_2fa`, `discount`, `trial`, `ref_id`, `ref_ck`, `ref_click`, `ref_amount`, `ref_price`, `ref_total_price`, `telegram_chat_id`, `api_key`, `login_attempts`, `status_otp_mail`, `otp_mail`, `token_otp_mail`, `limit_otp_mail`, `status_noti_login_to_mail`, `status_view_order`, `utm_source`) VALUES
(1, 'test001', '$2y$10$/VjGkB9x/PgBLe1dfjk0OedMav4iUvQ3u9vW9x4VR4DypHTNeWimu', 'test001@gmail.com', NULL, NULL, 1, 0, 0, NULL, '2025-05-10 01:23:12', '2025-05-10 01:23:12', 1746931172, 1746927953, '127.0.0.1', 'Mfxg3EvnSC9WdOeZtsyYRH50N8hDuPTI7BwJLKl2zVbjkUoqQ1mrapcG4AX6i1746814992e8aa9481a1c7375a4538a9ac82bba2e7', NULL, '', NULL, 0, 99999900, 100000000, 0, 'Male', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36', NULL, 0, 'BOMEXYXNTBTEXGJ7', 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 'ee9386915bfe5dbec988e607776f5642', 1, 0, '', '', 0, 0, 0, 'web');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_request_logs`
--
ALTER TABLE `admin_request_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_role`
--
ALTER TABLE `admin_role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `aff_log`
--
ALTER TABLE `aff_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `aff_withdraw`
--
ALTER TABLE `aff_withdraw`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `automations`
--
ALTER TABLE `automations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banks`
--
ALTER TABLE `banks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `block_ip`
--
ALTER TABLE `block_ip`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cards`
--
ALTER TABLE `cards`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `trans_id` (`trans_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupon_used`
--
ALTER TABLE `coupon_used`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposit_log`
--
ALTER TABLE `deposit_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dongtien`
--
ALTER TABLE `dongtien`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transid` (`transid`);

--
-- Indexes for table `email_campaigns`
--
ALTER TABLE `email_campaigns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_sending`
--
ALTER TABLE `email_sending`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_attempts`
--
ALTER TABLE `failed_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_bank_auto`
--
ALTER TABLE `log_bank_auto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tid` (`tid`);

--
-- Indexes for table `log_ref`
--
ALTER TABLE `log_ref`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `momo`
--
ALTER TABLE `momo`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `tranId` (`tranId`);

--
-- Indexes for table `order_log`
--
ALTER TABLE `order_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_bank`
--
ALTER TABLE `payment_bank`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `tid` (`tid`);

--
-- Indexes for table `payment_crypto`
--
ALTER TABLE `payment_crypto`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_flutterwave`
--
ALTER TABLE `payment_flutterwave`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_manual`
--
ALTER TABLE `payment_manual`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_momo`
--
ALTER TABLE `payment_momo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tid` (`tid`);

--
-- Indexes for table `payment_paypal`
--
ALTER TABLE `payment_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_pm`
--
ALTER TABLE `payment_pm`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_squadco`
--
ALTER TABLE `payment_squadco`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_thesieure`
--
ALTER TABLE `payment_thesieure`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tid` (`tid`);

--
-- Indexes for table `payment_toyyibpay`
--
ALTER TABLE `payment_toyyibpay`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `trans_id` (`trans_id`),
  ADD UNIQUE KEY `BillCode` (`BillCode`);

--
-- Indexes for table `payment_xipay`
--
ALTER TABLE `payment_xipay`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `post_category`
--
ALTER TABLE `post_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_die`
--
ALTER TABLE `product_die`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uid` (`uid`);

--
-- Indexes for table `product_discount`
--
ALTER TABLE `product_discount`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_order`
--
ALTER TABLE `product_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `trans_id` (`trans_id`);

--
-- Indexes for table `product_sold`
--
ALTER TABLE `product_sold`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_stock`
--
ALTER TABLE `product_stock`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `promotions`
--
ALTER TABLE `promotions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `telegram_logs`
--
ALTER TABLE `telegram_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `translate`
--
ALTER TABLE `translate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_request_logs`
--
ALTER TABLE `admin_request_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_role`
--
ALTER TABLE `admin_role`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `aff_log`
--
ALTER TABLE `aff_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `aff_withdraw`
--
ALTER TABLE `aff_withdraw`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `automations`
--
ALTER TABLE `automations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `banks`
--
ALTER TABLE `banks`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `block_ip`
--
ALTER TABLE `block_ip`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cards`
--
ALTER TABLE `cards`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupon_used`
--
ALTER TABLE `coupon_used`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `deposit_log`
--
ALTER TABLE `deposit_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dongtien`
--
ALTER TABLE `dongtien`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `email_campaigns`
--
ALTER TABLE `email_campaigns`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_sending`
--
ALTER TABLE `email_sending`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_attempts`
--
ALTER TABLE `failed_attempts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `log_bank_auto`
--
ALTER TABLE `log_bank_auto`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `log_ref`
--
ALTER TABLE `log_ref`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `momo`
--
ALTER TABLE `momo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_log`
--
ALTER TABLE `order_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payment_bank`
--
ALTER TABLE `payment_bank`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_crypto`
--
ALTER TABLE `payment_crypto`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_flutterwave`
--
ALTER TABLE `payment_flutterwave`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_manual`
--
ALTER TABLE `payment_manual`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payment_momo`
--
ALTER TABLE `payment_momo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_paypal`
--
ALTER TABLE `payment_paypal`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_pm`
--
ALTER TABLE `payment_pm`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_squadco`
--
ALTER TABLE `payment_squadco`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_thesieure`
--
ALTER TABLE `payment_thesieure`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_toyyibpay`
--
ALTER TABLE `payment_toyyibpay`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_xipay`
--
ALTER TABLE `payment_xipay`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `post_category`
--
ALTER TABLE `post_category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_die`
--
ALTER TABLE `product_die`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_discount`
--
ALTER TABLE `product_discount`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_order`
--
ALTER TABLE `product_order`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_sold`
--
ALTER TABLE `product_sold`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product_stock`
--
ALTER TABLE `product_stock`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `promotions`
--
ALTER TABLE `promotions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=284;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `telegram_logs`
--
ALTER TABLE `telegram_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `translate`
--
ALTER TABLE `translate`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1260;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
