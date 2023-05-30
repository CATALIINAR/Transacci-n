-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-05-2023 a las 17:33:12
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `transaccion`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `actualizacion_invent`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizacion_invent` (IN `id_productop` INT, IN `nombre_producto` VARCHAR(45), IN `cantidad_requerida` INT)   begin
	declare exit handler for 1690
    begin 
		select "no hay productos suficientes"
		rollback;
    end;
    start transaction;
    update inventario set cantidad = cantidad - cantidad_requerida where id_producto = id_productop;
    set nombre_producto =(select producto.nombre_producto from producto where id_producto = id_productop);
    insert into provedor (id, id_producto, nombre_product, cantidad) 
    values(0, id_productop, nombre_producto, cantidad_requerida);
    commit;
    
    end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

DROP TABLE IF EXISTS `inventario`;
CREATE TABLE `inventario` (
  `id_producto` int(11) NOT NULL,
  `cantidad` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id_producto`, `cantidad`) VALUES
(1, 0),
(2, 40),
(3, 90);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `nombre_producto` varchar(45) DEFAULT NULL,
  `valor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `nombre_producto`, `valor`) VALUES
(1, 'arroz', 50000),
(2, 'pasta ', 900000),
(3, 'papa', 80000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provedor`
--

DROP TABLE IF EXISTS `provedor`;
CREATE TABLE `provedor` (
  `id` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `nombre_product` varchar(45) DEFAULT NULL,
  `cantidad` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `provedor`
--

INSERT INTO `provedor` (`id`, `id_producto`, `nombre_product`, `cantidad`) VALUES
(1, 2, 'pasta', 100),
(2, 1, 'arroz', 10),
(3, 1, 'arroz', 10),
(4, 1, 'arroz', 20),
(5, 2, 'pasta ', 10);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `provedor`
--
ALTER TABLE `provedor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_producto` (`id_producto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `provedor`
--
ALTER TABLE `provedor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`);

--
-- Filtros para la tabla `provedor`
--
ALTER TABLE `provedor`
  ADD CONSTRAINT `provedor_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
