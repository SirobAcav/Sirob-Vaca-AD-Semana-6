-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-12-2025 a las 03:57:07
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mecanica`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint(20) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `correo_electronico` varchar(150) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombres`, `apellidos`, `telefono`, `correo_electronico`, `fecha_creacion`) VALUES
(4, 'Carlos', 'Mendoza López', '0987654321', 'carlos.mendoza@example.com', '2025-11-24 00:21:26'),
(5, 'Andrea', 'Pérez Torres', '0991234567', 'andrea.perez@example.com', '2025-11-24 00:21:26'),
(6, 'David', 'Vaca Morales', '0981112223', 'david.vaca@example.com', '2025-11-24 00:21:26'),
(7, 'Sofía', 'Narváez Jiménez', '0998765432', 'sofia.narvaez@example.com', '2025-11-24 00:21:26'),
(8, 'Luis', 'Andrade Quiroz', '0985432176', 'luis.andrade@example.com', '2025-11-24 00:21:26'),
(9, 'María', 'Calle Gómez', '0976543210', 'maria.calle@example.com', '2025-11-24 00:21:26'),
(10, 'Fernando', 'Salazar Ruiz', '0961122334', 'fernando.salazar@example.com', '2025-11-24 00:21:26'),
(11, 'Paola', 'Torres Villacís', '0989988776', 'paola.torres@example.com', '2025-11-24 00:21:26'),
(12, 'Esteban', 'Mora Rojas', '0956677889', 'esteban.mora@example.com', '2025-11-24 00:21:26'),
(13, 'Karla', 'Vargas Paredes', '0993344556', 'karla.vargas@example.com', '2025-11-24 00:21:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `orden_trabajo`
--

CREATE TABLE `orden_trabajo` (
  `id` int(11) NOT NULL,
  `Descripcion` text NOT NULL,
  `Servicio_Id` bigint(20) NOT NULL,
  `TipoServicio_Id` bigint(20) NOT NULL,
  `Usuario_Id` bigint(20) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`, `descripcion`) VALUES
(1, 'Administrador', 'El Admin'),
(2, 'Secretaria', 'La Secre'),
(3, 'Mecanico', 'El Maestro'),
(4, 'Oficial', 'El Oficial');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id` bigint(20) NOT NULL,
  `id_vehiculo` bigint(20) NOT NULL,
  `id_usuario` bigint(20) NOT NULL,
  `fecha_servicio` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposervicio`
--

CREATE TABLE `tiposervicio` (
  `id` bigint(20) NOT NULL,
  `detalle` text NOT NULL,
  `valor` decimal(10,0) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tiposervicio`
--

INSERT INTO `tiposervicio` (`id`, `detalle`, `valor`, `estado`) VALUES
(1, 'Mantenimiento Preventivo', 100, 1),
(2, 'Mantenimiento de Frenos', 10, 1),
(3, 'Lavada de Vehiculo de LUX', 50, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` bigint(20) NOT NULL,
  `nombre_usuario` varchar(150) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `id_rol` bigint(20) NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `activo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre_usuario`, `contrasena`, `id_rol`, `fecha_creacion`, `activo`) VALUES
(5, 'admin', '202cb962ac59075b964b07152d234b70', 1, '2025-11-17 10:00:00', 1),
(6, 'edwin', '202cb962ac59075b964b07152d234b70', 2, '2025-11-17 10:00:00', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos`
--

CREATE TABLE `vehiculos` (
  `id` bigint(20) NOT NULL,
  `id_cliente` bigint(20) NOT NULL,
  `marca` varchar(100) NOT NULL,
  `modelo` varchar(100) NOT NULL,
  `anio` int(11) NOT NULL,
  `tipo_motor` enum('dos_tiempos','cuatro_tiempos') NOT NULL DEFAULT 'dos_tiempos',
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculos`
--

INSERT INTO `vehiculos` (`id`, `id_cliente`, `marca`, `modelo`, `anio`, `tipo_motor`, `fecha_creacion`) VALUES
(14, 4, 'Toyota', 'Corolla', 2018, 'cuatro_tiempos', '2025-11-24 00:23:08'),
(15, 5, 'Hyundai', 'Tucson', 2020, 'cuatro_tiempos', '2025-11-24 00:23:08'),
(16, 9, 'Nissan', 'Sentra', 2019, 'cuatro_tiempos', '2025-11-24 00:23:08'),
(17, 9, 'Kia', 'Rio', 2016, 'dos_tiempos', '2025-11-24 00:23:08'),
(18, 4, 'Chevrolet', 'Aveo', 2015, 'cuatro_tiempos', '2025-11-24 00:23:08'),
(19, 6, 'Honda', 'Civic', 2021, 'cuatro_tiempos', '2025-11-24 00:23:08'),
(20, 7, 'Ford', 'Fiesta', 2014, 'dos_tiempos', '2025-11-24 00:23:08'),
(21, 6, 'Mazda', 'CX-5', 2021, 'cuatro_tiempos', '2025-11-24 00:23:08'),
(22, 11, 'Volkswagen', 'Golf', 2017, 'cuatro_tiempos', '2025-11-24 00:23:08'),
(23, 12, 'Renault', 'Duster', 2020, 'cuatro_tiempos', '2025-11-24 00:23:08');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo_electronico` (`correo_electronico`);

--
-- Indices de la tabla `orden_trabajo`
--
ALTER TABLE `orden_trabajo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_serivicios` (`Servicio_Id`),
  ADD KEY `fk_tipo_servivio` (`TipoServicio_Id`),
  ADD KEY `fk_usuarios` (`Usuario_Id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_vehiculo` (`id_vehiculo`),
  ADD KEY `fk_usuario` (`id_usuario`);

--
-- Indices de la tabla `tiposervicio`
--
ALTER TABLE `tiposervicio`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD KEY `fk_rol` (`id_rol`);

--
-- Indices de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cliente` (`id_cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `orden_trabajo`
--
ALTER TABLE `orden_trabajo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tiposervicio`
--
ALTER TABLE `tiposervicio`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `orden_trabajo`
--
ALTER TABLE `orden_trabajo`
  ADD CONSTRAINT `fk_serivicios` FOREIGN KEY (`Servicio_Id`) REFERENCES `servicios` (`id`),
  ADD CONSTRAINT `fk_tipo_servivio` FOREIGN KEY (`TipoServicio_Id`) REFERENCES `tiposervicio` (`id`),
  ADD CONSTRAINT `fk_usuarios` FOREIGN KEY (`Usuario_Id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD CONSTRAINT `fk_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `fk_vehiculo` FOREIGN KEY (`id_vehiculo`) REFERENCES `vehiculos` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_rol` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD CONSTRAINT `fk_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
