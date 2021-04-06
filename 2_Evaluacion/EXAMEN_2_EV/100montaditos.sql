-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-02-2021 a las 18:22:48
-- Versión del servidor: 10.1.37-MariaDB
-- Versión de PHP: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
DROP SCHEMA IF EXISTS 100Montaditos;
CREATE SCHEMA 100Montaditos;
USE 100Montaditos;
--
-- Base de datos: `100montaditos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bares`
--

CREATE TABLE `bares` (
  `nombre` varchar(30) NOT NULL,
  `tlf` varchar(9) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `capacidad` int(11) DEFAULT NULL,
  `tieneTerraza` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `bares`
--

INSERT INTO `bares` (`nombre`, `tlf`, `direccion`, `capacidad`, `tieneTerraza`) VALUES
('Bar Manolo', '95432323', 'C/Larga 18', 30, 0),
('Churrería', '90010021', 'Bulevar del Choco 46', 10, 1),
('Come y calla', '67890123', 'Avd. de la Sardina 23', 10, 1),
('Hambre', '95544332', 'Callejón del Pulpo 22', 2, 0),
('La hartá', '955548777', 'Callejón del Chipirón', 2, 0),
('La Taberna', '65432109', 'Plaza del Boquerón 7', 25, 1),
('Muy caro', '90010020', 'Bulevar del Choco 45', 40, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bodega`
--

CREATE TABLE `bodega` (
  `bar` varchar(30) NOT NULL,
  `vino` int(11) NOT NULL,
  `existencias` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `bodega`
--

INSERT INTO `bodega` (`bar`, `vino`, `existencias`) VALUES
('Bar Manolo', 1001, 3),
('Bar Manolo', 1002, 20),
('Bar Manolo', 1003, 50),
('Bar Manolo', 1004, 30),
('Come y calla', 1001, 50),
('Come y calla', 1005, 60),
('Hambre', 1001, 30),
('Hambre', 1002, 35),
('Hambre', 1006, 35),
('La Taberna', 1001, 10),
('La Taberna', 1002, 25),
('La Taberna', 1003, 33),
('La Taberna', 1004, 44),
('Muy caro', 1004, 15),
('Muy caro', 1005, 20);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `dni` varchar(9) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `tlf` varchar(9) DEFAULT NULL,
  `sueldo` decimal(6,2) DEFAULT NULL,
  `bar` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`dni`, `nombre`, `tlf`, `sueldo`, `bar`) VALUES
('11111111B', 'Bea Boniato', '66666666', '25.12', 'Bar Manolo'),
('12345678A', 'Antonio Almanaque', '67890123', '1200.00', 'Bar Manolo'),
('215478965', 'Paco Mé', '948556958', '1050.00', 'La hartá'),
('22222222C', 'Cristina Cristal', '67777777', '2400.50', 'Bar Manolo'),
('33333333D', 'Daniel Dado', '68888888', '1100.18', 'Come y calla'),
('33333333H', 'Aitor Menta', '945441122', '1000.00', 'La hartá'),
('44444444E', 'Ernesto Entrada', '95444444', '800.80', 'Come y calla'),
('55555555F', 'Fran Feo', '94444444', '990.90', 'Hambre'),
('66666666G', 'Gema Gigante', NULL, '1650.50', 'Hambre'),
('77777777H', 'Heidi Hielo', '95432109', '1518.18', 'Hambre'),
('88888888I', 'Inés Hignorante', '67676767', '1000.00', 'Muy caro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vinos`
--

CREATE TABLE `vinos` (
  `cod` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `precio` decimal(6,2) DEFAULT NULL,
  `tipo` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `vinos`
--

INSERT INTO `vinos` (`cod`, `nombre`, `precio`, `tipo`) VALUES
(1001, 'Condado de Camas', '15.67', 'Albariño'),
(1002, 'Don Raimo', '12.12', 'Rioja'),
(1003, 'Borrachera', '125.50', 'Blanco'),
(1004, 'Palacomida', '3.75', 'Rioja'),
(1005, 'Uvas redondas', '225.25', 'Albariño'),
(1006, 'Y se fue', '18.00', 'Albariño'),
(1007, 'Uvas cuadradas', '5.25', 'Mosto'),
(1008, 'Copa blanca', '19.00', 'Albariño'),
(1009, 'Terra Gallega', '20.00', 'Albariño'),
(1010, 'Peleón', '3.75', 'Ribera');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bares`
--
ALTER TABLE `bares`
  ADD PRIMARY KEY (`nombre`);

--
-- Indices de la tabla `bodega`
--
ALTER TABLE `bodega`
  ADD PRIMARY KEY (`bar`,`vino`),
  ADD KEY `vino` (`vino`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`dni`),
  ADD KEY `bar` (`bar`);

--
-- Indices de la tabla `vinos`
--
ALTER TABLE `vinos`
  ADD PRIMARY KEY (`cod`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bodega`
--
ALTER TABLE `bodega`
  ADD CONSTRAINT `bodega_ibfk_1` FOREIGN KEY (`bar`) REFERENCES `bares` (`nombre`),
  ADD CONSTRAINT `bodega_ibfk_2` FOREIGN KEY (`vino`) REFERENCES `vinos` (`cod`);

--
-- Filtros para la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD CONSTRAINT `empleados_ibfk_1` FOREIGN KEY (`bar`) REFERENCES `bares` (`nombre`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
