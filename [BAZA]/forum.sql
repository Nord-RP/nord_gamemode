-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Czas generowania: 20 Kwi 2023, 14:22
-- Wersja serwera: 10.10.2-MariaDB
-- Wersja PHP: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `forum`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mta_auth_token`
--

DROP TABLE IF EXISTS `mta_auth_token`;
CREATE TABLE IF NOT EXISTS `mta_auth_token` (
  `id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Zrzut danych tabeli `mta_auth_token`
--

INSERT INTO `mta_auth_token` (`id`, `token`, `created_at`, `updated_at`) VALUES
(1, '5WwcjLoQFFB52QLTZlQI2DOZ5Mbhba73FAsAvT0PlbAXvkTZcWhkpdQs5ylgikClxXbWLrOrsOMn49wxntG4n9HNarlAALi9gQzA', '2023-04-12 21:17:26', '2023-04-12 21:17:26');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `mta_characters`
--

DROP TABLE IF EXISTS `mta_characters`;
CREATE TABLE IF NOT EXISTS `mta_characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `surname` varchar(30) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `sex` int(1) DEFAULT NULL,
  `money` int(11) NOT NULL DEFAULT 20000,
  `bank_money` int(11) NOT NULL DEFAULT 0,
  `health` int(11) NOT NULL DEFAULT 0,
  `psyche` int(11) NOT NULL DEFAULT 0,
  `strength` int(11) NOT NULL DEFAULT 0,
  `skin` int(11) DEFAULT NULL,
  `online` int(1) DEFAULT NULL,
  `blocked` int(1) DEFAULT NULL,
  `hidden` int(1) DEFAULT NULL,
  `playtime` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Zrzut danych tabeli `mta_characters`
--

INSERT INTO `mta_characters` (`id`, `owner_id`, `name`, `surname`, `age`, `sex`, `money`, `bank_money`, `health`, `psyche`, `strength`, `skin`, `online`, `blocked`, `hidden`, `playtime`, `created_at`, `updated_at`) VALUES
(1, 1, 'Jeff', 'Block', 21, 2, 20000, 53000, 75, 50, 25, 1, 1, 0, 0, 5400000, '2023-04-12 20:36:11', '2023-04-12 20:36:11'),
(2, 1, 'Tyler', 'Johnson', 2, 1, 20000, 0, 0, 0, 0, 16, 0, 1, 0, 0, '2023-04-14 01:15:16', '2023-04-14 01:15:16'),
(3, 1, 'Ethan', 'Davis', 2, 1, 20000, 0, 0, 0, 0, 14, 0, 0, 0, 0, '2023-04-14 01:15:16', '2023-04-14 01:15:16');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
