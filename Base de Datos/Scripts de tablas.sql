USE [GestionArticulo]
GO
ALTER TABLE [dbo].[TableDetalleSalidas] DROP CONSTRAINT [FK_TableDetalleSalidas_TableSalidas]
GO
ALTER TABLE [dbo].[TableDetalleSalidas] DROP CONSTRAINT [FK_TableDetalleSalidas_TableArticulo]
GO
ALTER TABLE [dbo].[TableDetalleEntradas] DROP CONSTRAINT [FK_TableDetalleEntradas_TableEntradas]
GO
ALTER TABLE [dbo].[TableDetalleEntradas] DROP CONSTRAINT [FK_TableDetalleEntradas_TableArticulo]
GO
ALTER TABLE [dbo].[TableArticulo] DROP CONSTRAINT [FK_TableArticulo_TableAlmacenes]
GO
ALTER TABLE [dbo].[TableUsuarios] DROP CONSTRAINT [DF_TableUsuarios_fechacreacion]
GO
ALTER TABLE [dbo].[TableDetalleSalidas] DROP CONSTRAINT [DF_DetalleSalidas_status]
GO
ALTER TABLE [dbo].[TableDetalleEntradas] DROP CONSTRAINT [DF_TableDetalleEntradas_status]
GO
/****** Object:  Table [dbo].[TableUsuarios]    Script Date: 10/03/2019 6:14:28 PM ******/
DROP TABLE [dbo].[TableUsuarios]
GO
/****** Object:  Table [dbo].[TableSalidas]    Script Date: 10/03/2019 6:14:28 PM ******/
DROP TABLE [dbo].[TableSalidas]
GO
/****** Object:  Table [dbo].[TableEntradas]    Script Date: 10/03/2019 6:14:28 PM ******/
DROP TABLE [dbo].[TableEntradas]
GO
/****** Object:  Table [dbo].[TableDetalleSalidas]    Script Date: 10/03/2019 6:14:28 PM ******/
DROP TABLE [dbo].[TableDetalleSalidas]
GO
/****** Object:  Table [dbo].[TableDetalleEntradas]    Script Date: 10/03/2019 6:14:28 PM ******/
DROP TABLE [dbo].[TableDetalleEntradas]
GO
/****** Object:  Table [dbo].[TableArticulo]    Script Date: 10/03/2019 6:14:28 PM ******/
DROP TABLE [dbo].[TableArticulo]
GO
/****** Object:  Table [dbo].[TableAlmacenes]    Script Date: 10/03/2019 6:14:28 PM ******/
DROP TABLE [dbo].[TableAlmacenes]
GO
USE [master]
GO
/****** Object:  Database [GestionArticulo]    Script Date: 10/03/2019 6:14:28 PM ******/
DROP DATABASE [GestionArticulo]
GO
/****** Object:  Database [GestionArticulo]    Script Date: 10/03/2019 6:14:28 PM ******/
CREATE DATABASE [GestionArticulo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GestionArticulo', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\GestionArticulo.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'GestionArticulo_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\GestionArticulo_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [GestionArticulo] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GestionArticulo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GestionArticulo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GestionArticulo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GestionArticulo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GestionArticulo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GestionArticulo] SET ARITHABORT OFF 
GO
ALTER DATABASE [GestionArticulo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GestionArticulo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GestionArticulo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GestionArticulo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GestionArticulo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GestionArticulo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GestionArticulo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GestionArticulo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GestionArticulo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GestionArticulo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GestionArticulo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GestionArticulo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GestionArticulo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GestionArticulo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GestionArticulo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GestionArticulo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GestionArticulo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GestionArticulo] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [GestionArticulo] SET  MULTI_USER 
GO
ALTER DATABASE [GestionArticulo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GestionArticulo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GestionArticulo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GestionArticulo] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [GestionArticulo] SET DELAYED_DURABILITY = DISABLED 
GO
USE [GestionArticulo]
GO
/****** Object:  Table [dbo].[TableAlmacenes]    Script Date: 10/03/2019 6:14:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TableAlmacenes](
	[idalmacen] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NULL,
	[capacidad] [int] NULL,
	[comentario] [text] NULL,
	[status] [varchar](8) NULL CONSTRAINT [DF_TableAlmacenes_status]  DEFAULT ('Activo'),
	[idusuario] [int] NULL,
 CONSTRAINT [PK_TableAlmacenes] PRIMARY KEY CLUSTERED 
(
	[idalmacen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TableArticulo]    Script Date: 10/03/2019 6:14:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TableArticulo](
	[iditem] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](120) NOT NULL,
	[idalmacen] [int] NULL,
	[maximo] [numeric](9, 2) NULL,
	[minimo] [numeric](9, 2) NULL,
	[existencia] [numeric](13, 2) NULL,
	[costo] [numeric](13, 2) NULL,
	[precio] [numeric](13, 2) NULL,
	[preciominimo] [numeric](13, 2) NULL,
	[itemdescuento] [numeric](4, 2) NULL,
	[itbis] [numeric](4, 2) NULL,
	[vencimiento] [datetime] NULL CONSTRAINT [DF_TableItemes_vencimiento]  DEFAULT (((1)/(1))/(9999)),
	[comentario] [text] NULL,
	[idusuario] [int] NULL,
	[idusuariomodifico] [int] NULL,
	[status] [varchar](8) NULL CONSTRAINT [DF_TableItemes_status]  DEFAULT ('Activo'),
 CONSTRAINT [PK_TableArticulo] PRIMARY KEY CLUSTERED 
(
	[iditem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TableDetalleEntradas]    Script Date: 10/03/2019 6:14:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TableDetalleEntradas](
	[iddetalle] [int] IDENTITY(1,1) NOT NULL,
	[identrada] [int] NOT NULL,
	[iditem] [int] NULL,
	[cantidad] [numeric](9, 2) NULL,
	[costo] [numeric](13, 2) NULL,
	[idalmacen] [int] NULL,
	[status] [varchar](8) NULL,
	[idusuario] [int] NULL,
 CONSTRAINT [PK_TableDetalleEntradas] PRIMARY KEY CLUSTERED 
(
	[iddetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TableDetalleSalidas]    Script Date: 10/03/2019 6:14:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TableDetalleSalidas](
	[iddetalle] [int] IDENTITY(1,1) NOT NULL,
	[idsalida] [int] NOT NULL,
	[iditem] [int] NULL,
	[cantidad] [numeric](9, 2) NULL,
	[costo] [numeric](13, 2) NULL,
	[itemdescuento] [numeric](4, 2) NULL,
	[idalmacen] [int] NULL,
	[status] [varchar](8) NULL,
 CONSTRAINT [PK_DetalleSalidas_1] PRIMARY KEY CLUSTERED 
(
	[iddetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TableEntradas]    Script Date: 10/03/2019 6:14:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TableEntradas](
	[identrada] [int] IDENTITY(1,1) NOT NULL,
	[numeroDocumento] [int] NULL,
	[fecha] [datetime] NULL,
	[descuento] [numeric](4, 2) NULL,
	[total] [numeric](12, 2) NULL,
	[comentario] [text] NULL,
	[entregadopor] [text] NULL,
	[enviadoa] [text] NULL,
	[status] [varchar](8) NULL CONSTRAINT [DF_Entradas_status]  DEFAULT ('Activo'),
	[idusuario] [int] NULL,
 CONSTRAINT [PK_Entradas] PRIMARY KEY CLUSTERED 
(
	[identrada] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TableSalidas]    Script Date: 10/03/2019 6:14:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TableSalidas](
	[idsalida] [int] IDENTITY(1,1) NOT NULL,
	[idalmacen] [int] NULL,
	[fecha] [datetime] NULL,
	[descuento] [numeric](4, 2) NULL,
	[total] [numeric](13, 2) NULL,
	[comentario] [text] NULL,
	[entregadopor] [text] NULL,
	[enviadoa] [text] NULL,
	[status] [varchar](8) NULL,
	[idusuario] [int] NULL,
 CONSTRAINT [PK_TableSalidas] PRIMARY KEY CLUSTERED 
(
	[idsalida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TableUsuarios]    Script Date: 10/03/2019 6:14:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TableUsuarios](
	[idusuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](200) NULL,
	[apellido] [varchar](150) NULL,
	[usuario] [varchar](50) NULL,
	[password] [varchar](160) NULL,
	[idrol] [int] NOT NULL,
	[fechacreacion] [datetime] NULL,
	[fechaSalida] [datetime] NULL,
	[fechanacimiento] [date] NULL,
	[idcreador] [int] NULL,
	[idusuariomodifico] [int] NULL,
	[foto] [image] NULL,
	[Status] [char](10) NULL,
	[maquinaName] [varchar](100) NULL,
	[ipmaquina] [varchar](100) NULL,
 CONSTRAINT [PK_TableUsuarios] PRIMARY KEY CLUSTERED 
(
	[idusuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TableAlmacenes] ON 

INSERT [dbo].[TableAlmacenes] ([idalmacen], [nombre], [capacidad], [comentario], [status], [idusuario]) VALUES (6, N'Santo Domingo Este', 100, N'solo hay 50', N'Activo', NULL)
INSERT [dbo].[TableAlmacenes] ([idalmacen], [nombre], [capacidad], [comentario], [status], [idusuario]) VALUES (7, N'Santo Domingo Norte', 500, N'hello', N'Activo', NULL)
INSERT [dbo].[TableAlmacenes] ([idalmacen], [nombre], [capacidad], [comentario], [status], [idusuario]) VALUES (8, N'Santiago', 500, N'zona Norte del pais', N'Inactivo', NULL)
SET IDENTITY_INSERT [dbo].[TableAlmacenes] OFF
SET IDENTITY_INSERT [dbo].[TableArticulo] ON 

INSERT [dbo].[TableArticulo] ([iditem], [descripcion], [idalmacen], [maximo], [minimo], [existencia], [costo], [precio], [preciominimo], [itemdescuento], [itbis], [vencimiento], [comentario], [idusuario], [idusuariomodifico], [status]) VALUES (3, N'manzana', 6, CAST(800.00 AS Numeric(9, 2)), CAST(500.00 AS Numeric(9, 2)), CAST(10.00 AS Numeric(13, 2)), CAST(15.00 AS Numeric(13, 2)), CAST(20.00 AS Numeric(13, 2)), CAST(18.00 AS Numeric(13, 2)), CAST(2.00 AS Numeric(4, 2)), CAST(18.00 AS Numeric(4, 2)), CAST(N'2019-10-08 00:00:00.000' AS DateTime), N'producidad en contanza', NULL, NULL, N'Activo')
SET IDENTITY_INSERT [dbo].[TableArticulo] OFF
SET IDENTITY_INSERT [dbo].[TableEntradas] ON 

INSERT [dbo].[TableEntradas] ([identrada], [numeroDocumento], [fecha], [descuento], [total], [comentario], [entregadopor], [enviadoa], [status], [idusuario]) VALUES (19, 40, CAST(N'2019-10-10 00:00:00.000' AS DateTime), CAST(78.00 AS Numeric(4, 2)), CAST(1170.00 AS Numeric(12, 2)), N'Santo Domingo para el mundo', N'Camacho', N'juan', NULL, NULL)
SET IDENTITY_INSERT [dbo].[TableEntradas] OFF
ALTER TABLE [dbo].[TableDetalleEntradas] ADD  CONSTRAINT [DF_TableDetalleEntradas_status]  DEFAULT ('Activo') FOR [status]
GO
ALTER TABLE [dbo].[TableDetalleSalidas] ADD  CONSTRAINT [DF_DetalleSalidas_status]  DEFAULT ('Activo') FOR [status]
GO
ALTER TABLE [dbo].[TableUsuarios] ADD  CONSTRAINT [DF_TableUsuarios_fechacreacion]  DEFAULT (getdate()) FOR [fechacreacion]
GO
ALTER TABLE [dbo].[TableArticulo]  WITH CHECK ADD  CONSTRAINT [FK_TableArticulo_TableAlmacenes] FOREIGN KEY([idalmacen])
REFERENCES [dbo].[TableAlmacenes] ([idalmacen])
GO
ALTER TABLE [dbo].[TableArticulo] CHECK CONSTRAINT [FK_TableArticulo_TableAlmacenes]
GO
ALTER TABLE [dbo].[TableDetalleEntradas]  WITH CHECK ADD  CONSTRAINT [FK_TableDetalleEntradas_TableArticulo] FOREIGN KEY([iditem])
REFERENCES [dbo].[TableArticulo] ([iditem])
GO
ALTER TABLE [dbo].[TableDetalleEntradas] CHECK CONSTRAINT [FK_TableDetalleEntradas_TableArticulo]
GO
ALTER TABLE [dbo].[TableDetalleEntradas]  WITH CHECK ADD  CONSTRAINT [FK_TableDetalleEntradas_TableEntradas] FOREIGN KEY([identrada])
REFERENCES [dbo].[TableEntradas] ([identrada])
GO
ALTER TABLE [dbo].[TableDetalleEntradas] CHECK CONSTRAINT [FK_TableDetalleEntradas_TableEntradas]
GO
ALTER TABLE [dbo].[TableDetalleSalidas]  WITH CHECK ADD  CONSTRAINT [FK_TableDetalleSalidas_TableArticulo] FOREIGN KEY([iditem])
REFERENCES [dbo].[TableArticulo] ([iditem])
GO
ALTER TABLE [dbo].[TableDetalleSalidas] CHECK CONSTRAINT [FK_TableDetalleSalidas_TableArticulo]
GO
ALTER TABLE [dbo].[TableDetalleSalidas]  WITH CHECK ADD  CONSTRAINT [FK_TableDetalleSalidas_TableSalidas] FOREIGN KEY([idsalida])
REFERENCES [dbo].[TableSalidas] ([idsalida])
GO
ALTER TABLE [dbo].[TableDetalleSalidas] CHECK CONSTRAINT [FK_TableDetalleSalidas_TableSalidas]
GO
USE [master]
GO
ALTER DATABASE [GestionArticulo] SET  READ_WRITE 
GO
