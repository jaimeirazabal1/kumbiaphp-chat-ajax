-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 19-09-2015 a las 12:16:59
-- Versión del servidor: 5.5.44-0ubuntu0.14.04.1
-- Versión de PHP: 5.5.9-1ubuntu4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `chat-kumbia-ajax`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `canal`
--

CREATE TABLE IF NOT EXISTS `canal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mensaje` text COLLATE utf8_unicode_ci NOT NULL,
  `identificador_canal` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `leido` tinyint(1) DEFAULT NULL,
  `leido_admin` tinyint(1) DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `disconnected` tinyint(1) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=103 ;

--
-- Volcado de datos para la tabla `canal`
--

INSERT INTO `canal` (`id`, `mensaje`, `identificador_canal`, `leido`, `leido_admin`, `usuario_id`, `disconnected`, `created`) VALUES
(100, '<span style=''float:left;padding-top:10px;''><img style=''float:left;padding:4px;'' src=''http://www.gravatar.com/avatar/d41d8cd98f00b204e9800998ecf8427e?s=80&d=mm&r=g'' width="50" alt="Tu Imagen"><b>Jaime Irazabal(jaimeirazabal1@gmail.com)</b>: <br>Puedes Ayudarme en un soporte?</span>', '22b4faa7f4e3fc44821dbbfd133244e4', 1, 1, 0, NULL, '2015-09-19 16:14:01'),
(101, '<span style=''float:left;padding-top:10px;''><img style=''float:left;padding:4px;'' src=''http://www.gravatar.com/avatar/d41d8cd98f00b204e9800998ecf8427e?s=80&d=mm&r=g'' width="50" alt="Tu Imagen"><b>Jaime Irazabal(jaimeirazabal1@gmail.com)</b>: <br>Puedes Ayudarme en un soporte?</span>', 'd82e35afb4bc126cc92904acccf1a871', 1, 1, 0, NULL, '2015-09-19 16:14:19'),
(102, '<span style=''float:left;padding-top:10px;''><img style=''float:left;padding:4px;'' src=''http://www.gravatar.com/avatar/d41d8cd98f00b204e9800998ecf8427e?s=80&d=mm&r=g'' width="50" alt="Tu Imagen"><b>Jaime(jaimeirazabal1@gmail.com)</b>: <br>Puedes Ayudarme en un soporte?</span>', '4d5c2899df6de00030bd2017e8d10b07', 1, NULL, 80, NULL, '2015-09-19 16:27:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `online` tinyint(1) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=81 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `email`, `online`, `created`) VALUES
(8, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 14:58:21'),
(9, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:00:24'),
(10, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:00:49'),
(11, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:01:45'),
(12, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:02:13'),
(13, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:02:47'),
(14, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:04:30'),
(15, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:05:45'),
(16, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:05:47'),
(17, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:06:58'),
(18, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:07:03'),
(19, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:07:44'),
(20, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:07:47'),
(21, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:08:01'),
(22, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:08:04'),
(23, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:08:05'),
(24, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:08:12'),
(25, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:08:12'),
(26, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:08:24'),
(27, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:09:40'),
(28, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:10:29'),
(29, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:11:30'),
(30, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:11:44'),
(31, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:11:48'),
(32, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:12:22'),
(33, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:12:30'),
(34, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:14:22'),
(35, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:14:41'),
(36, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:15:28'),
(37, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:16:16'),
(38, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:16:39'),
(39, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:16:46'),
(40, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:17:16'),
(41, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:17:17'),
(42, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:17:19'),
(43, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:17:29'),
(44, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:19:25'),
(45, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:19:59'),
(46, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:20:28'),
(47, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:22:39'),
(48, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:26:44'),
(49, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:29:51'),
(50, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:33:19'),
(51, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:34:49'),
(52, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:35:16'),
(53, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:37:41'),
(54, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:37:50'),
(55, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:38:19'),
(56, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:38:32'),
(57, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:39:45'),
(58, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:40:09'),
(59, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:40:29'),
(60, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:41:57'),
(61, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:42:51'),
(62, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:44:04'),
(63, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:44:57'),
(64, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:45:17'),
(65, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:46:48'),
(66, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:47:07'),
(67, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:47:26'),
(68, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:50:58'),
(69, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:52:00'),
(70, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:52:32'),
(71, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:53:03'),
(72, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:53:29'),
(73, 'Jaig', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:54:04'),
(74, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:54:45'),
(75, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:57:05'),
(76, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:57:20'),
(77, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 15:57:46'),
(78, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 16:14:01'),
(79, 'Jaime Irazabal', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 16:14:19'),
(80, 'Jaime', 'jaimeirazabal1@gmail.com', 1, '2015-09-19 16:27:10');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
