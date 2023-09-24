-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Wrz 03, 2023 at 02:46 AM
-- Wersja serwera: 10.4.28-MariaDB
-- Wersja PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mta_nord_dev`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ips_core_members`
--

CREATE TABLE `ips_core_members` (
  `member_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `member_group_id` smallint(6) NOT NULL DEFAULT 0,
  `email` varchar(150) NOT NULL DEFAULT '',
  `joined` int(11) NOT NULL DEFAULT 0,
  `ip_address` varchar(46) NOT NULL DEFAULT '',
  `skin` smallint(6) DEFAULT NULL,
  `warn_level` int(11) DEFAULT NULL,
  `warn_lastwarn` int(11) NOT NULL DEFAULT 0,
  `language` mediumint(9) DEFAULT NULL,
  `restrict_post` int(11) NOT NULL DEFAULT 0,
  `bday_day` int(11) DEFAULT NULL,
  `bday_month` int(11) DEFAULT NULL,
  `bday_year` int(11) DEFAULT NULL,
  `msg_count_new` int(11) NOT NULL DEFAULT 0,
  `msg_count_total` int(11) NOT NULL DEFAULT 0,
  `msg_count_reset` int(11) NOT NULL DEFAULT 0,
  `msg_show_notification` int(11) NOT NULL DEFAULT 0,
  `last_visit` int(11) DEFAULT 0,
  `last_activity` int(11) DEFAULT 0,
  `mod_posts` int(11) NOT NULL DEFAULT 0,
  `auto_track` varchar(256) DEFAULT '0',
  `temp_ban` int(11) DEFAULT 0,
  `mgroup_others` varchar(245) NOT NULL DEFAULT '',
  `members_seo_name` varchar(255) NOT NULL DEFAULT '',
  `members_cache` mediumtext DEFAULT NULL,
  `failed_logins` text DEFAULT NULL,
  `failed_login_count` smallint(6) NOT NULL DEFAULT 0,
  `members_profile_views` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `members_pass_hash` varchar(255) DEFAULT NULL,
  `members_pass_salt` varchar(22) DEFAULT NULL,
  `members_bitoptions` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `members_day_posts` varchar(32) NOT NULL DEFAULT '0,0',
  `notification_cnt` mediumint(9) NOT NULL DEFAULT 0,
  `pp_last_visitors` text DEFAULT NULL,
  `pp_main_photo` text DEFAULT NULL,
  `pp_main_width` int(11) DEFAULT NULL,
  `pp_main_height` int(11) DEFAULT NULL,
  `pp_thumb_photo` text DEFAULT NULL,
  `pp_thumb_width` int(11) DEFAULT NULL,
  `pp_thumb_height` int(11) DEFAULT NULL,
  `pp_setting_count_comments` int(11) DEFAULT 0,
  `pp_reputation_points` int(11) DEFAULT NULL,
  `pp_photo_type` varchar(20) DEFAULT NULL,
  `signature` text DEFAULT NULL,
  `pconversation_filters` text DEFAULT NULL,
  `pp_customization` mediumtext DEFAULT NULL,
  `timezone` varchar(64) DEFAULT NULL,
  `pp_cover_photo` varchar(255) NOT NULL DEFAULT '',
  `profilesync` text DEFAULT NULL,
  `profilesync_lastsync` int(11) NOT NULL DEFAULT 0 COMMENT 'Indicates the last time any profile sync service was ran',
  `allow_admin_mails` bit(1) DEFAULT b'0',
  `members_bitoptions2` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `create_menu` text DEFAULT NULL COMMENT 'Cached contents of the "Create" drop down menu.',
  `members_disable_pm` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 - not disabled, 1 - disabled, member can re-enable, 2 - disabled',
  `marked_site_read` int(10) UNSIGNED DEFAULT 0,
  `pp_cover_offset` int(11) NOT NULL DEFAULT 0,
  `acp_language` mediumint(9) DEFAULT NULL,
  `member_title` varchar(64) DEFAULT NULL,
  `member_posts` mediumint(9) NOT NULL DEFAULT 0,
  `member_last_post` int(11) DEFAULT NULL,
  `member_streams` text DEFAULT NULL,
  `photo_last_update` int(11) DEFAULT NULL,
  `mfa_details` text DEFAULT NULL,
  `failed_mfa_attempts` smallint(5) UNSIGNED DEFAULT 0 COMMENT 'Number of times tried and failed MFA',
  `permission_array` text DEFAULT NULL COMMENT 'A cache of the clubs and social groups that the member is in',
  `completed` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Whether the account is completed or not',
  `achievements_points` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'The number of achievement points the member has',
  `unique_hash` varchar(255) DEFAULT NULL,
  `latest_alert` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Indicates the last alert that was viewed',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ips_core_members`
--

INSERT INTO `ips_core_members` (`member_id`, `name`, `member_group_id`, `email`, `joined`, `ip_address`, `skin`, `warn_level`, `warn_lastwarn`, `language`, `restrict_post`, `bday_day`, `bday_month`, `bday_year`, `msg_count_new`, `msg_count_total`, `msg_count_reset`, `msg_show_notification`, `last_visit`, `last_activity`, `mod_posts`, `auto_track`, `temp_ban`, `mgroup_others`, `members_seo_name`, `members_cache`, `failed_logins`, `failed_login_count`, `members_profile_views`, `members_pass_hash`, `members_pass_salt`, `members_bitoptions`, `members_day_posts`, `notification_cnt`, `pp_last_visitors`, `pp_main_photo`, `pp_main_width`, `pp_main_height`, `pp_thumb_photo`, `pp_thumb_width`, `pp_thumb_height`, `pp_setting_count_comments`, `pp_reputation_points`, `pp_photo_type`, `signature`, `pconversation_filters`, `pp_customization`, `timezone`, `pp_cover_photo`, `profilesync`, `profilesync_lastsync`, `allow_admin_mails`, `members_bitoptions2`, `create_menu`, `members_disable_pm`, `marked_site_read`, `pp_cover_offset`, `acp_language`, `member_title`, `member_posts`, `member_last_post`, `member_streams`, `photo_last_update`, `mfa_details`, `failed_mfa_attempts`, `permission_array`, `completed`, `achievements_points`, `unique_hash`, `latest_alert`, `created_at`, `updated_at`) VALUES
(1, 'Allerek', 4, 'allerek22@icloud.com', 1691696462, '::1', NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, '0', 0, '', 'allerek', NULL, NULL, 0, 0, '$2y$10$W1.H9c7GNXwk5YNaEkrhieyxZLMzhB6h6qar7eJ7gRxA6vE0hkzQi', NULL, 65536, '0,0', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '', NULL, NULL, NULL, 'UTC', '', NULL, 0, b'0', 0, NULL, 0, 0, 0, NULL, NULL, 0, NULL, NULL, NULL, NULL, 0, NULL, b'1', 0, NULL, 0, '2023-08-10 20:05:32', '2023-08-10 20:05:32');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mta_admins`
--

CREATE TABLE `mta_admins` (
  `user_id` int(11) NOT NULL,
  `level` tinyint(4) NOT NULL COMMENT '0-3 Supporter, 4-6 Moderator, 7-8 CM, 9-11 Developer, 12 Administrator, 13 RCON',
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mta_admins`
--

INSERT INTO `mta_admins` (`user_id`, `level`, `comment`, `created_at`, `updated_at`) VALUES
(1, 13, 'Super :D', '2023-08-16 18:41:41', '2023-08-16 18:41:41');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mta_auth_token`
--

CREATE TABLE `mta_auth_token` (
  `id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `mta_auth_token`
--

INSERT INTO `mta_auth_token` (`id`, `member_id`, `token`, `created_at`, `updated_at`) VALUES
(1, 0, 'plXgNrTsKLRVOjQreTHt3fZw6yLWqo1fdHNIefgkltwKrqPfv6K19jqEXnHGrLkPmL4lxN7CohUUlGmenWCI5Rj2OXtcAfz3zv0E', '2023-04-12 17:17:26', '2023-04-12 17:17:26'),
(2, 0, 'AAT4bkTCjHw8QYk5lcD4biddZ0CkESLe1o2LmkMU792dpaqPaypckeKioXVxVpWPcn01mD7UQ3WQxitxNc8LRQqKekSLzSNqtUWz', '2023-05-24 19:20:40', '2023-05-24 19:20:40'),
(3, 22, '5zyO2mjCs2DiRzeuYPY9WdhF7FJPxTnPiGlV3FK3WJMBiB16bdzpOvk2zhT9BJerrhCU7aBZpZjZRKPSPqg6DyTtTtjtn0zk1uba', '2023-05-24 19:27:32', '2023-05-24 19:27:32'),
(4, 1, 'GGfBLoivQcLXUKDOqYjKJAUQac2kpDfCL91phJEWyaTMUwenkh5nqGl2D7EQ0ye2eu4bEbGj9HW5beYXOMlYc5MyuDKDLonH9wrV', '2023-05-24 19:34:12', '2023-05-24 19:34:12');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mta_characters`
--

CREATE TABLE `mta_characters` (
  `id` int(11) NOT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `surname` varchar(30) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `money` int(11) NOT NULL DEFAULT 20000,
  `bank_money` int(11) NOT NULL DEFAULT 0,
  `health` int(11) NOT NULL DEFAULT 0,
  `psyche` int(11) NOT NULL DEFAULT 0,
  `strength` int(11) NOT NULL DEFAULT 0,
  `skin` int(11) DEFAULT NULL,
  `online` int(11) DEFAULT NULL,
  `blocked` int(11) DEFAULT NULL,
  `hidden` int(11) DEFAULT NULL,
  `playtime` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `mta_characters`
--

INSERT INTO `mta_characters` (`id`, `owner_id`, `name`, `surname`, `age`, `sex`, `money`, `bank_money`, `health`, `psyche`, `strength`, `skin`, `online`, `blocked`, `hidden`, `playtime`, `created_at`, `updated_at`) VALUES
(1, 1, 'Jeff', 'Block', 21, 2, 20000, 53000, 75, 50, 25, 1, 1, 0, 0, 5400000, '2023-04-12 20:36:11', '2023-04-12 20:36:11'),
(2, 1, 'Tyler', 'Johnson', 2, 1, 20000, 0, 100, 0, 0, 16, 0, 1, 0, 0, '2023-04-14 01:15:16', '2023-04-14 01:15:16'),
(3, 1, 'Ethan', 'Davis', 2, 1, 20000, 0, 100, 0, 0, 14, 0, 0, 0, 0, '2023-04-14 01:15:16', '2023-04-14 01:15:16'),
(4, 22, 'Ethan', 'Davidson', 2, 1, 20000, 0, 100, 0, 0, 14, 0, 0, 0, 0, '2023-04-14 01:15:16', '2023-04-14 01:15:16');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mta_vehicles`
--

CREATE TABLE `mta_vehicles` (
  `id` int(11) NOT NULL,
  `model` smallint(6) NOT NULL,
  `owner` int(11) NOT NULL,
  `owner_type` tinyint(4) NOT NULL COMMENT '0=player, 1=group',
  `fuel` tinyint(4) NOT NULL,
  `mileage` int(11) NOT NULL,
  `plate` varchar(8) NOT NULL,
  `color` varchar(255) NOT NULL,
  `spawn_position` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mta_vehicles`
--

INSERT INTO `mta_vehicles` (`id`, `model`, `owner`, `owner_type`, `fuel`, `mileage`, `plate`, `color`, `spawn_position`, `created_at`, `updated_at`) VALUES
(1, 411, 1, 0, 1, 1, 'fiance', '', '[ { \"y\": 4.442176818847656, \"x\": 2.278341770172119, \"z\": 3.1171875, \"rx\": 0, \"ry\": 0, \"rz\": 0 } ]', '2023-08-10 20:27:00', '2023-08-10 20:27:00');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `ips_core_members`
--
ALTER TABLE `ips_core_members`
  ADD PRIMARY KEY (`member_id`),
  ADD KEY `bday_day` (`bday_day`),
  ADD KEY `bday_month` (`bday_month`),
  ADD KEY `members_bitoptions` (`members_bitoptions`),
  ADD KEY `ip_address` (`ip_address`),
  ADD KEY `failed_login_count` (`failed_login_count`),
  ADD KEY `joined` (`joined`),
  ADD KEY `email` (`email`),
  ADD KEY `member_groups` (`member_group_id`,`mgroup_others`(188)),
  ADD KEY `mgroup` (`member_id`,`member_group_id`),
  ADD KEY `allow_admin_mails` (`allow_admin_mails`),
  ADD KEY `name_index` (`name`(191)),
  ADD KEY `mod_posts` (`mod_posts`),
  ADD KEY `photo_last_update` (`photo_last_update`),
  ADD KEY `last_activity` (`last_activity`),
  ADD KEY `completed` (`completed`,`temp_ban`),
  ADD KEY `profilesync` (`profilesync_lastsync`,`profilesync`(181)),
  ADD KEY `member_posts` (`member_posts`,`member_id`);

--
-- Indeksy dla tabeli `mta_auth_token`
--
ALTER TABLE `mta_auth_token`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `mta_characters`
--
ALTER TABLE `mta_characters`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `mta_vehicles`
--
ALTER TABLE `mta_vehicles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ips_core_members`
--
ALTER TABLE `ips_core_members`
  MODIFY `member_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `mta_characters`
--
ALTER TABLE `mta_characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `mta_vehicles`
--
ALTER TABLE `mta_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
