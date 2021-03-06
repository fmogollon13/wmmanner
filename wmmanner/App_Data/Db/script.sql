USE [master]
GO
/****** Object:  Database [WMActivosFijos]    Script Date: 22/08/2016 6:34:30 p. m. ******/
/*
By Ms
Agosto 22 -2016
Script para la versin 1.0.0.16206 del Servicio Web wmmanner
*/

CREATE DATABASE [WMActivosFijos]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WMActivosFijos', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\WMActivosFijos.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'WMActivosFijos_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\WMActivosFijos_log.ldf' , SIZE = 7168KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [WMActivosFijos] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WMActivosFijos].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WMActivosFijos] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WMActivosFijos] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WMActivosFijos] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WMActivosFijos] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WMActivosFijos] SET ARITHABORT OFF 
GO
ALTER DATABASE [WMActivosFijos] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WMActivosFijos] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WMActivosFijos] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WMActivosFijos] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WMActivosFijos] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WMActivosFijos] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WMActivosFijos] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WMActivosFijos] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WMActivosFijos] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WMActivosFijos] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WMActivosFijos] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WMActivosFijos] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WMActivosFijos] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WMActivosFijos] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WMActivosFijos] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WMActivosFijos] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WMActivosFijos] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WMActivosFijos] SET RECOVERY FULL 
GO
ALTER DATABASE [WMActivosFijos] SET  MULTI_USER 
GO
ALTER DATABASE [WMActivosFijos] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WMActivosFijos] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WMActivosFijos] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WMActivosFijos] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [WMActivosFijos] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'WMActivosFijos', N'ON'
GO
USE [WMActivosFijos]
GO
/****** Object:  Schema [Movil]    Script Date: 22/08/2016 6:34:30 p. m. ******/
CREATE SCHEMA [Movil]
GO
/****** Object:  Table [dbo].[Activos]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Activos](
	[PlacaInventario] [nvarchar](15) NOT NULL,
	[DescripcionActivo] [nvarchar](150) NOT NULL,
	[CodigoBarras] [nvarchar](15) NULL,
	[FechaInventario] [datetime] NULL,
	[CentroCosto] [nvarchar](6) NULL,
	[Ubicacion] [nvarchar](5) NULL,
	[EstadoFisico] [nvarchar](10) NULL,
	[CCResponsable] [nvarchar](12) NULL,
	[TipoActivo] [nvarchar](7) NULL,
	[NumeroSerie] [nvarchar](20) NULL,
	[Observacion] [nvarchar](200) NULL,
	[Estado] [int] NULL,
	[Aux1] [nvarchar](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[PlacaInventario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[catAplicacion]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[catAplicacion](
	[Aplicacion] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_catAplicacion] PRIMARY KEY CLUSTERED 
(
	[Aplicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[catEmpresa]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[catEmpresa](
	[IdEmpresa] [uniqueidentifier] NOT NULL DEFAULT (newid()),
	[IdEmpresaPadre] [uniqueidentifier] NULL CONSTRAINT [DF_catEmpresa_IdEmpresaPadre]  DEFAULT ('4D617274-696E-2044-2044-617A61204700'),
	[Nombre] [varchar](80) NOT NULL,
	[IdEsquema] [uniqueidentifier] NOT NULL,
	[Contacto] [varchar](50) NULL,
	[Celular] [varchar](20) NULL,
	[FechaInicio] [date] NOT NULL DEFAULT (getdate()),
	[FechaFin] [date] NOT NULL DEFAULT ('2099/12/31'),
	[Activo] [bit] NOT NULL DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[IdEmpresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[catEsquema]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[catEsquema](
	[IdEsquema] [uniqueidentifier] NOT NULL CONSTRAINT [DF_catEsquema_IdEsquema]  DEFAULT (newid()),
	[IdEsquemaPadre] [uniqueidentifier] NOT NULL CONSTRAINT [DF_catEsquema_IdEsquemaPadre]  DEFAULT ('4d617274-696e-2044-2044-617a61204700'),
	[Esquema] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_catEsquema] PRIMARY KEY CLUSTERED 
(
	[IdEsquema] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[catFuncion]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[catFuncion](
	[Funcion] [nvarchar](50) NOT NULL,
	[Aplicacion] [nvarchar](50) NOT NULL,
	[IdFuncion] [int] NOT NULL,
	[IdFuncionPadre] [int] NOT NULL,
 CONSTRAINT [PK_catFuncion] PRIMARY KEY CLUSTERED 
(
	[Funcion] ASC,
	[Aplicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[catRol]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[catRol](
	[Rol] [nvarchar](50) NOT NULL,
	[Aplicacion] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_catRol] PRIMARY KEY CLUSTERED 
(
	[Rol] ASC,
	[Aplicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[catRolEnFuncion]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[catRolEnFuncion](
	[Rol] [nvarchar](50) NOT NULL,
	[Funcion] [nvarchar](50) NOT NULL,
	[Aplicacion] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_catRolEnFuncion] PRIMARY KEY CLUSTERED 
(
	[Rol] ASC,
	[Funcion] ASC,
	[Aplicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[catUsuario]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[catUsuario](
	[Id] [uniqueidentifier] NOT NULL CONSTRAINT [DF_cat_usuario_Id]  DEFAULT (newid()),
	[Usuario] [nvarchar](50) NOT NULL,
	[Aplicacion] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Comentario] [nvarchar](255) NOT NULL,
	[Pase] [nvarchar](255) NOT NULL,
	[Pregunta] [nvarchar](255) NULL,
	[Respuesta] [nvarchar](255) NULL,
	[SeAprueba] [bit] NOT NULL CONSTRAINT [DF_catUsuario_SeAprueba]  DEFAULT ((0)),
	[UltimaActividad] [datetime2](7) NOT NULL CONSTRAINT [DF_catUsuario_UltimaActividad]  DEFAULT (getdate()),
	[UltimoAcceso] [datetime2](7) NOT NULL CONSTRAINT [DF_catUsuario_UltimoAcceso]  DEFAULT (getdate()),
	[CambioPase] [datetime2](7) NOT NULL CONSTRAINT [DF_catUsuario_CambioPase]  DEFAULT (getdate()),
	[FechaCreado] [datetime2](7) NOT NULL CONSTRAINT [DF_catUsuario_FechaCreado]  DEFAULT (getdate()),
	[EstaConectado] [bit] NOT NULL CONSTRAINT [DF_catUsuario_EstaConectado]  DEFAULT ((0)),
	[EstaBloqueado] [bit] NOT NULL CONSTRAINT [DF_catUsuario_EstaBloqueado]  DEFAULT ((0)),
	[UltimoBloqueo] [datetime] NOT NULL CONSTRAINT [DF_catUsuario_UltimoBloqueo]  DEFAULT (getdate()),
	[IntentosErrorPase] [smallint] NOT NULL CONSTRAINT [DF_catUsuario_IntentosErrorPase]  DEFAULT ((0)),
	[VentanaIntentoInicialPase] [datetime2](7) NOT NULL CONSTRAINT [DF_catUsuario_VentanaIntentoInicialPase]  DEFAULT (getdate()),
	[IntentosErrorPaseRespuesta] [smallint] NOT NULL CONSTRAINT [DF_catUsuario_IntentosErrorPaseRespuesta]  DEFAULT ((0)),
	[VentanaIntnetoInicialRespuesta] [datetime2](7) NOT NULL CONSTRAINT [DF_catUsuario_VentanaIntnetoInicialRespuesta]  DEFAULT (getdate()),
	[Nombre] [varchar](30) NULL,
	[Apellido] [varchar](30) NULL,
	[IdEsquema] [uniqueidentifier] NOT NULL CONSTRAINT [DF_catUsuario_IdEsquema]  DEFAULT ('4d617274-696e-2044-2044-617a61204700'),
	[IdEmpresa] [uniqueidentifier] NOT NULL CONSTRAINT [DF_catUsuario_IdEmpresa]  DEFAULT ('4D617274-696E-2044-2044-617A61204700'),
 CONSTRAINT [PK_catUsuario] PRIMARY KEY CLUSTERED 
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[catUsuarioEnRol]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[catUsuarioEnRol](
	[Usuario] [nvarchar](50) NOT NULL,
	[Rol] [nvarchar](50) NOT NULL,
	[Aplicacion] [nvarchar](50) NOT NULL,
 CONSTRAINT [PKcatUsuarioEnRol] PRIMARY KEY CLUSTERED 
(
	[Usuario] ASC,
	[Rol] ASC,
	[Aplicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LogTransaccionesAct]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogTransaccionesAct](
	[Login] [nvarchar](20) NOT NULL,
	[CodigoEvento] [nvarchar](2) NULL,
	[FechaLectura] [datetime] NULL,
	[Indicador] [int] NULL,
	[OrigenEvento] [nvarchar](20) NULL,
	[SeEnvio] [int] NULL,
	[DatosEvento] [nvarchar](700) NULL,
	[FechaRegistro] [datetime2](7) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLogger]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLogger](
	[IdLogger] [bigint] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime2](7) NOT NULL,
	[Codigo] [nvarchar](max) NULL,
	[Texto] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tblLogger] PRIMARY KEY CLUSTERED 
(
	[IdLogger] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblTabla]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTabla](
	[IdTabla] [int] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Tipolista] [varchar](1) NOT NULL,
	[Titulo] [varchar](20) NOT NULL,
	[Titulo2] [varchar](20) NULL,
	[Activo] [bit] NOT NULL DEFAULT ((1)),
	[Version] [int] NOT NULL CONSTRAINT [DF_tblTabla_Version]  DEFAULT ((1)),
	[FechaActualizacion] [datetime2](7) NOT NULL CONSTRAINT [DF_tblTabla_FechaActualizacion]  DEFAULT (getdate()),
	[Usuario] [nvarchar](50) NULL,
	[Destino] [smallint] NOT NULL CONSTRAINT [DF_tblTabla_Destino]  DEFAULT ((0)),
 CONSTRAINT [tblTabla_pk] PRIMARY KEY CLUSTERED 
(
	[IdTabla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTablaDetalle]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTablaDetalle](
	[IdTabla] [int] NOT NULL,
	[IdTablaDetalle] [varchar](36) NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
	[Reservado1] [varchar](100) NULL,
	[Reservado2] [varchar](100) NULL,
	[Activo] [bit] NOT NULL,
 CONSTRAINT [tblTablaDetalle_pk] PRIMARY KEY CLUSTERED 
(
	[IdTabla] ASC,
	[IdTablaDetalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  UserDefinedFunction [dbo].[ufnEmpresaPorUsuario]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ufnEmpresaPorUsuario] (@pUsuarioEmpresa nvarchar(50))
RETURNS TABLE
AS
RETURN 
(
    WITH arbolEmpresa(IdEmpresa,IdEmpresaPadre,Nombre,NivelArbol)
    AS
    (
        SELECT e.IdEmpresa,e.IdEmpresaPadre,e.Nombre,0
        FROM catEmpresa AS e
        WHERE e.IdEmpresa IN(
        SELECT IdEmpresa
        FROM catUsuario
        WHERE Usuario=@pUsuarioEmpresa
        )
        UNION ALL
        SELECT nh.IdEmpresa,nh.IdEmpresaPadre,nh.Nombre,NivelArbol+1
        FROM catEmpresa AS nh
        INNER JOIN arbolEmpresa ON nh.IdEmpresaPadre=arbolEmpresa.IdEmpresa
    )
    SELECT IdEmpresa,IdEmpresaPadre,Nombre,NivelArbol
    FROM arbolEmpresa
);


GO
/****** Object:  UserDefinedFunction [dbo].[ufnEsquemaPorUsuario]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ufnEsquemaPorUsuario] (@pUsuarioEsquema nvarchar(50))
RETURNS TABLE
AS
RETURN 
(
    WITH arbolEsquema(IdEsquema,IdEsquemaPadre,Esquema,NivelArbol)
    AS
    (
        SELECT e.IdEsquema,e.IdEsquemaPadre,e.Esquema,0
        FROM catEsquema AS e
        INNER JOIN catUsuario AS u ON e.IdEsquema=u.IdEsquema
        WHERE u.Usuario=@pUsuarioEsquema
        UNION ALL
        SELECT nh.IdEsquema,nh.IdEsquemaPadre,nh.Esquema,NivelArbol+1
        FROM catEsquema AS nh
        INNER JOIN arbolEsquema ON nh.IdEsquemaPadre=arbolEsquema.IdEsquema
    )
    SELECT IdEsquema,IdEsquemaPadre,Esquema,NivelArbol
    FROM arbolEsquema
   
);


GO
INSERT [dbo].[Activos] ([PlacaInventario], [DescripcionActivo], [CodigoBarras], [FechaInventario], [CentroCosto], [Ubicacion], [EstadoFisico], [CCResponsable], [TipoActivo], [NumeroSerie], [Observacion], [Estado], [Aux1]) VALUES (N'PL001', N'Descripcion Activo 1', N'PL001', CAST(N'2016-08-22 00:00:00.000' AS DateTime), N'2087', N'Ub001', N'Estd001', N'CCRes001', N'Tpo001', N'NumSerie001', N'Observacion 001', 1, NULL)
INSERT [dbo].[Activos] ([PlacaInventario], [DescripcionActivo], [CodigoBarras], [FechaInventario], [CentroCosto], [Ubicacion], [EstadoFisico], [CCResponsable], [TipoActivo], [NumeroSerie], [Observacion], [Estado], [Aux1]) VALUES (N'PL002', N'Descripcion Activo 2', N'PL002', CAST(N'2016-08-22 00:00:00.000' AS DateTime), N'2087', N'Ub001', N'Estd002', N'CCRes001', N'Tpo001', N'NumSerie002', N'Observacion 002', 1, NULL)
INSERT [dbo].[catAplicacion] ([Aplicacion]) VALUES (N'WmActivosFijosMobile')
INSERT [dbo].[catEmpresa] ([IdEmpresa], [IdEmpresaPadre], [Nombre], [IdEsquema], [Contacto], [Celular], [FechaInicio], [FechaFin], [Activo]) VALUES (N'4d617274-696e-2044-2044-617a61204700', N'4d617274-696e-2044-2044-617a61204700', N'Wm Wireless &', N'07dc94a3-94f3-4379-9736-e482ac167bb9', NULL, NULL, CAST(N'2016-08-22' AS Date), CAST(N'2099-12-31' AS Date), 1)
INSERT [dbo].[catEsquema] ([IdEsquema], [IdEsquemaPadre], [Esquema]) VALUES (N'07dc94a3-94f3-4379-9736-e482ac167bb9', N'00000000-0000-0000-0000-000000000000', N'WM')
INSERT [dbo].[catRol] ([Rol], [Aplicacion]) VALUES (N'Auditor', N'WmActivosFijosMobile')
INSERT [dbo].[catRol] ([Rol], [Aplicacion]) VALUES (N'Coordinador', N'WmActivosFijosMobile')
INSERT [dbo].[catRol] ([Rol], [Aplicacion]) VALUES (N'Operador', N'WmActivosFijosMobile')
INSERT [dbo].[catUsuario] ([Id], [Usuario], [Aplicacion], [Email], [Comentario], [Pase], [Pregunta], [Respuesta], [SeAprueba], [UltimaActividad], [UltimoAcceso], [CambioPase], [FechaCreado], [EstaConectado], [EstaBloqueado], [UltimoBloqueo], [IntentosErrorPase], [VentanaIntentoInicialPase], [IntentosErrorPaseRespuesta], [VentanaIntnetoInicialRespuesta], [Nombre], [Apellido], [IdEsquema], [IdEmpresa]) VALUES (N'bb423c51-2f8b-4bd9-b5a4-380337e4edd0', N'123', N'WmActivosFijosMobile', N'TstMobile@Tst.com', N'Test', N'gDr/8Y7Dai5DisyMcUYVJA==', N'1', N'1', 1, CAST(N'2016-08-22 16:03:49.2130000' AS DateTime2), CAST(N'2016-08-22 16:03:49.2130000' AS DateTime2), CAST(N'2016-08-22 16:03:49.2130000' AS DateTime2), CAST(N'2016-08-22 00:00:00.0000000' AS DateTime2), 0, 0, CAST(N'2016-08-22 16:03:49.213' AS DateTime), 0, CAST(N'2016-08-22 16:03:49.2130000' AS DateTime2), 0, CAST(N'2016-08-22 16:03:49.2130000' AS DateTime2), N'Test', N'Mobile', N'07dc94a3-94f3-4379-9736-e482ac167bb9', N'4d617274-696e-2044-2044-617a61204700')
INSERT [dbo].[catUsuarioEnRol] ([Usuario], [Rol], [Aplicacion]) VALUES (N'123', N'Auditor', N'WmActivosFijosMobile')
INSERT [dbo].[catUsuarioEnRol] ([Usuario], [Rol], [Aplicacion]) VALUES (N'123', N'Coordinador', N'WmActivosFijosMobile')
INSERT [dbo].[catUsuarioEnRol] ([Usuario], [Rol], [Aplicacion]) VALUES (N'123', N'Operador', N'WmActivosFijosMobile')
INSERT [dbo].[LogTransaccionesAct] ([Login], [CodigoEvento], [FechaLectura], [Indicador], [OrigenEvento], [SeEnvio], [DatosEvento], [FechaRegistro]) VALUES (N'1', N'I', CAST(N'2014-01-21 09:20:00.000' AS DateTime), 1, N'12223D112', 1, N'124556PLACA de PRUEBA...', CAST(N'2016-08-22 18:21:18.7776981' AS DateTime2))
SET IDENTITY_INSERT [dbo].[tblLogger] ON 

INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (39, CAST(N'2016-08-22 18:01:13.1643684' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (40, CAST(N'2016-08-22 18:06:24.1613850' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (41, CAST(N'2016-08-22 18:08:25.1649460' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (42, CAST(N'2016-08-22 18:10:26.4240078' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (43, CAST(N'2016-08-22 18:14:53.1276481' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (44, CAST(N'2016-08-22 18:15:02.1032884' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (45, CAST(N'2016-08-22 18:15:09.4085728' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (46, CAST(N'2016-08-22 18:17:37.7445471' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (47, CAST(N'2016-08-22 18:18:21.3519878' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (48, CAST(N'2016-08-22 18:19:34.3620680' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (49, CAST(N'2016-08-22 18:21:11.3414988' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (50, CAST(N'2016-08-22 18:21:19.0164244' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (51, CAST(N'2016-08-22 18:23:28.5974256' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (52, CAST(N'2016-08-22 18:25:46.9899187' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (53, CAST(N'2016-08-22 18:28:01.8158581' AS DateTime2), N'201', N'	201	WMDConector.Comunicacion.DConectorDB	La columna ''login'' no pertenece a la tabla Table.|   en System.Data.DataRow.GetDataColumn(String columnName)..    en System.Data.DataRow.get_Item(String columnName)..    en System.Data.DataRowExtensions.Field[T](DataRow row, String columnName)..    en WMDConector.Comunicacion.DConectorDB.ObtenerUsuario(ETransaccion transaccion, EProveedor proveedor) en C:\Proyectos\Conector\DConector\Comunicacion\DConectorDB.cs:línea 448	Movil.sprSeleccionarUsuario')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (54, CAST(N'2016-08-22 18:28:01.8198609' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (55, CAST(N'2016-08-22 18:28:43.2187272' AS DateTime2), N'201', N'	201	WMDConector.Comunicacion.DConectorDB	La columna ''login'' no pertenece a la tabla Table.|   en System.Data.DataRow.GetDataColumn(String columnName)..    en System.Data.DataRow.get_Item(String columnName)..    en System.Data.DataRowExtensions.Field[T](DataRow row, String columnName)..    en WMDConector.Comunicacion.DConectorDB.ObtenerUsuario(ETransaccion transaccion, EProveedor proveedor) en C:\Proyectos\Conector\DConector\Comunicacion\DConectorDB.cs:línea 448	Movil.sprSeleccionarUsuario')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (56, CAST(N'2016-08-22 18:28:43.2312362' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
INSERT [dbo].[tblLogger] ([IdLogger], [Fecha], [Codigo], [Texto]) VALUES (57, CAST(N'2016-08-22 18:29:47.4732213' AS DateTime2), N'201', N'	201	Data.Enrutador.DDespachar	Could not find stored procedure ''Movil.sprRegistrarTransaccion''.|   en System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)..    en System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)..    en System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)..    en System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)..    en System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)..    en System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)..    en System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)..    en System.Data.SqlClient.SqlCommand.ExecuteNonQuery()..    en WmDataAccessLayer.DataAccessLayerBaseClass.ExecuteQuery(String commandText, CommandType commandType, IDataParameter[] commandParameters) en C:\Proyectos\DataAccessLayer\DataAccessLayer.cs:línea 537..    en Data.Enrutador.DDespachar.Persistir(ETransaccion transaccion, String resultado) en C:\Proyectos\Activos Fijos\Data\Enrutador\DDespachar.cs:línea 129	Movil.sprRegistrarTransaccion')
SET IDENTITY_INSERT [dbo].[tblLogger] OFF
INSERT [dbo].[tblTabla] ([IdTabla], [Nombre], [Tipolista], [Titulo], [Titulo2], [Activo], [Version], [FechaActualizacion], [Usuario], [Destino]) VALUES (0, N'CentroCosto', N'2', N'CentroCosto', NULL, 1, 1, CAST(N'2016-08-22 17:47:13.1970000' AS DateTime2), NULL, 1)
INSERT [dbo].[tblTabla] ([IdTabla], [Nombre], [Tipolista], [Titulo], [Titulo2], [Activo], [Version], [FechaActualizacion], [Usuario], [Destino]) VALUES (1, N'Ubicacion', N'2', N'Ubicacion', NULL, 1, 1, CAST(N'2016-08-22 17:47:31.1100000' AS DateTime2), NULL, 1)
INSERT [dbo].[tblTabla] ([IdTabla], [Nombre], [Tipolista], [Titulo], [Titulo2], [Activo], [Version], [FechaActualizacion], [Usuario], [Destino]) VALUES (2, N'CCResponsable', N'2', N'CCResponsable', NULL, 1, 1, CAST(N'2016-08-22 17:47:44.2530000' AS DateTime2), NULL, 1)
INSERT [dbo].[tblTabla] ([IdTabla], [Nombre], [Tipolista], [Titulo], [Titulo2], [Activo], [Version], [FechaActualizacion], [Usuario], [Destino]) VALUES (3, N'EstadoFisico', N'2', N'EstadoFisico', NULL, 1, 1, CAST(N'2016-08-22 17:47:57.5030000' AS DateTime2), NULL, 1)
INSERT [dbo].[tblTabla] ([IdTabla], [Nombre], [Tipolista], [Titulo], [Titulo2], [Activo], [Version], [FechaActualizacion], [Usuario], [Destino]) VALUES (4, N'TipoActivo', N'2', N'TipoActivo', NULL, 1, 1, CAST(N'2016-08-22 17:48:11.1000000' AS DateTime2), NULL, 1)
/****** Object:  Index [IX_catFuncion]    Script Date: 22/08/2016 6:34:30 p. m. ******/
ALTER TABLE [dbo].[catFuncion] ADD  CONSTRAINT [IX_catFuncion] UNIQUE NONCLUSTERED 
(
	[IdFuncion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_catUsuario]    Script Date: 22/08/2016 6:34:30 p. m. ******/
ALTER TABLE [dbo].[catUsuario] ADD  CONSTRAINT [IX_catUsuario] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblTablaDetalle] ADD  CONSTRAINT [DF__tblTablaD__Activ__6DCC4D03]  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[catEmpresa]  WITH CHECK ADD  CONSTRAINT [FK_catEmpresa_catEsquema] FOREIGN KEY([IdEsquema])
REFERENCES [dbo].[catEsquema] ([IdEsquema])
GO
ALTER TABLE [dbo].[catEmpresa] CHECK CONSTRAINT [FK_catEmpresa_catEsquema]
GO
ALTER TABLE [dbo].[catFuncion]  WITH CHECK ADD  CONSTRAINT [FK_catFuncion_catAplicacion] FOREIGN KEY([Aplicacion])
REFERENCES [dbo].[catAplicacion] ([Aplicacion])
GO
ALTER TABLE [dbo].[catFuncion] CHECK CONSTRAINT [FK_catFuncion_catAplicacion]
GO
ALTER TABLE [dbo].[catRol]  WITH CHECK ADD  CONSTRAINT [FK_catRol_catAplicacion] FOREIGN KEY([Aplicacion])
REFERENCES [dbo].[catAplicacion] ([Aplicacion])
GO
ALTER TABLE [dbo].[catRol] CHECK CONSTRAINT [FK_catRol_catAplicacion]
GO
ALTER TABLE [dbo].[catRolEnFuncion]  WITH CHECK ADD  CONSTRAINT [FK_catRolEnFuncion_catFuncion] FOREIGN KEY([Funcion], [Aplicacion])
REFERENCES [dbo].[catFuncion] ([Funcion], [Aplicacion])
GO
ALTER TABLE [dbo].[catRolEnFuncion] CHECK CONSTRAINT [FK_catRolEnFuncion_catFuncion]
GO
ALTER TABLE [dbo].[catRolEnFuncion]  WITH CHECK ADD  CONSTRAINT [FK_catRolEnFuncion_catRol] FOREIGN KEY([Rol], [Aplicacion])
REFERENCES [dbo].[catRol] ([Rol], [Aplicacion])
GO
ALTER TABLE [dbo].[catRolEnFuncion] CHECK CONSTRAINT [FK_catRolEnFuncion_catRol]
GO
ALTER TABLE [dbo].[catUsuario]  WITH CHECK ADD  CONSTRAINT [FK_catUsuario_catAplicacion] FOREIGN KEY([Aplicacion])
REFERENCES [dbo].[catAplicacion] ([Aplicacion])
GO
ALTER TABLE [dbo].[catUsuario] CHECK CONSTRAINT [FK_catUsuario_catAplicacion]
GO
ALTER TABLE [dbo].[catUsuario]  WITH CHECK ADD  CONSTRAINT [FK_catUsuario_catEmpresa] FOREIGN KEY([IdEmpresa])
REFERENCES [dbo].[catEmpresa] ([IdEmpresa])
GO
ALTER TABLE [dbo].[catUsuario] CHECK CONSTRAINT [FK_catUsuario_catEmpresa]
GO
ALTER TABLE [dbo].[catUsuario]  WITH CHECK ADD  CONSTRAINT [FK_catUsuario_catEsquema] FOREIGN KEY([IdEsquema])
REFERENCES [dbo].[catEsquema] ([IdEsquema])
GO
ALTER TABLE [dbo].[catUsuario] CHECK CONSTRAINT [FK_catUsuario_catEsquema]
GO
ALTER TABLE [dbo].[catUsuarioEnRol]  WITH CHECK ADD  CONSTRAINT [FK_catUsuarioEnRol_catAplicacion] FOREIGN KEY([Aplicacion])
REFERENCES [dbo].[catAplicacion] ([Aplicacion])
GO
ALTER TABLE [dbo].[catUsuarioEnRol] CHECK CONSTRAINT [FK_catUsuarioEnRol_catAplicacion]
GO
ALTER TABLE [dbo].[catUsuarioEnRol]  WITH CHECK ADD  CONSTRAINT [FK_catUsuarioEnRol_catRol] FOREIGN KEY([Rol], [Aplicacion])
REFERENCES [dbo].[catRol] ([Rol], [Aplicacion])
GO
ALTER TABLE [dbo].[catUsuarioEnRol] CHECK CONSTRAINT [FK_catUsuarioEnRol_catRol]
GO
ALTER TABLE [dbo].[catUsuarioEnRol]  WITH CHECK ADD  CONSTRAINT [FK_catUsuarioEnRol_catUsuario] FOREIGN KEY([Usuario])
REFERENCES [dbo].[catUsuario] ([Usuario])
GO
ALTER TABLE [dbo].[catUsuarioEnRol] CHECK CONSTRAINT [FK_catUsuarioEnRol_catUsuario]
GO
ALTER TABLE [dbo].[tblTablaDetalle]  WITH CHECK ADD  CONSTRAINT [tbl_lista_tbl_lista_detalle_fk] FOREIGN KEY([IdTabla])
REFERENCES [dbo].[tblTabla] ([IdTabla])
GO
ALTER TABLE [dbo].[tblTablaDetalle] CHECK CONSTRAINT [tbl_lista_tbl_lista_detalle_fk]
GO
/****** Object:  StoredProcedure [Movil].[sprEsUsuarioValido]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		
-- Create date: 
-- Description:	Procedimiento para Validar un Usuario
-- =============================================
CREATE PROCEDURE [Movil].[sprEsUsuarioValido]
    --Parametros de Salida
    @pCodigo int OUTPUT, @pMensaje VARCHAR(500) OUTPUT,

    --Parametros entrada
    @pUsuario nvarchar(50),
    @pClave nvarchar(255)
AS
--Declaración de Variables
BEGIN
    SET NOCOUNT ON -- turn off rows affected messages
    IF EXISTS (SELECT Usuario FROM catUsuario WHERE Usuario=@pUsuario AND Pase=@pClave)
    BEGIN
        SET @pCodigo = 0
        SET @pMensaje = 'OK'
		RETURN 0
    END
    ELSE
    BEGIN
        SET @pCodigo = 1
        SET @pMensaje = 'Usuario no existe o clave errada'
		RETURN 1
	END
END


GO
/****** Object:  StoredProcedure [Movil].[sprRegistrarListaEditableEjecutada]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		
-- Create date: 2013-10-16
-- Description:	Procedimiento para 
-- =============================================
CREATE PROCEDURE [Movil].[sprRegistrarListaEditableEjecutada] 	
	--Parametros de Salida
	@pCodigo int OUTPUT, @pMensaje VARCHAR(255) OUTPUT,

	--Parametros entrada
	@pidlista int,
	@pCodigoID nvarchar(255),
	@pdetalle nvarchar(255),
	@pidnuevo  nvarchar(255)

AS
--Declaración de Variables
DECLARE @vCodigo INT,
        @vMensaje VARCHAR(255),
        @vIntentos tinyint
BEGIN 
	--Bloque de sentencias select, asignaciones y validaciones
	SET XACT_ABORT ON
	BEGIN TRY
		BEGIN TRANSACTION

            SET @vCodigo = 0
            SET @vMensaje = 'OK (' + CAST(@@ROWCOUNT AS nvarchar(12)) + ')'
		COMMIT TRANSACTION
		SET @pCodigo = @vCodigo
        SET @pMensaje = @vMensaje
		RETURN 1
	END TRY
    BEGIN CATCH
        -- Obtener info del error. Escribir en tabla de track de Errores
        DECLARE @verror_message VARCHAR(255)

        SET @verror_message = 'Error ' + CAST(ERROR_NUMBER() AS NVARCHAR(20))
			+ ' Severidad Error ' + CAST(ERROR_SEVERITY() AS NVARCHAR(20))
			+ ' Estado Error ' + CAST(ERROR_STATE() AS VARCHAR(20))
			+ ' Error en Procedimiento ' + ERROR_PROCEDURE()
			+ ' en la Linea ' + CAST(ERROR_LINE() AS VARCHAR(20))
			+ ' con la descripción ' + ERROR_MESSAGE()

        -- If  1, la XACT es "committable". COMMIT
        -- If -1, la XACT es "uncommittable". ROLLBACK
        -- If  0, no hay XACT abierta.

        IF (XACT_STATE()) = -1
            ROLLBACK TRANSACTION

        IF (XACT_STATE()) = 1
            COMMIT TRANSACTION

--        INSERT INTO lg_logger (fecha,codigo,mensaje) VALUES(GETDATE(),101, @verror_message) 

        SET @vCodigo = 204
        SET @vMensaje = 'Detalle del Error: ' + @verror_message

        SET @pCodigo = @vCodigo
        SET @pMensaje = @vMensaje
        --SELECT <@ValorDevuelto>[, <@MensajeDevuelto>]

        -- Salida con error
        RETURN 0
    END CATCH
END

GO
/****** Object:  StoredProcedure [Movil].[sprRegistrarLog]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		
-- Create date:	
-- Description:	Procedimiento para registrar log de errores
-- =============================================
CREATE PROCEDURE [Movil].[sprRegistrarLog]
    --Parametros de Salida
	@pCodigo int OUTPUT, @pMensaje VARCHAR(255) OUTPUT,

    --Parametros entrada
    @pCodigoRegistrar nvarchar(MAX),
    @pTexto nvarchar(MAX)
AS
--Declaración de Variables
DECLARE @vCodigo int
DECLARE @vMensaje nvarchar(500)
BEGIN
    BEGIN TRANSACTION;
    
    BEGIN TRY
        -- Generate a constraint violation error.
        INSERT INTO tblLogger (Fecha,Codigo,Texto)
        VALUES (SYSDATETIME(),@pCodigoRegistrar,@pTexto)
    END TRY
    BEGIN CATCH
        SELECT 
             ERROR_NUMBER() AS ErrorNumber
            ,ERROR_SEVERITY() AS ErrorSeverity
            ,ERROR_STATE() AS ErrorState
            ,ERROR_PROCEDURE() AS ErrorProcedure
            ,ERROR_LINE() AS ErrorLine
            ,ERROR_MESSAGE() AS ErrorMessage;
    
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
    
    IF @@TRANCOUNT > 0
        COMMIT TRANSACTION;
END

GO
/****** Object:  StoredProcedure [Movil].[sprRegistrarLogTransaccionesAct]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		
-- Create date:	2013-09-24
-- Description:	Procedimiento para registrar log 
-- =============================================
CREATE PROCEDURE [Movil].[sprRegistrarLogTransaccionesAct]
    --Parametros de Salida
	@pCodigo int OUTPUT, @pMensaje VARCHAR(255) OUTPUT,

    --Parametros entrada
    @plogin nvarchar(20),
	@pcodigoevento nvarchar(2),
    @pfechalectura datetime2,
	@pindicador int,
	@porigenevento nvarchar(20),
	@pdatosevento nvarchar(700),
	@pseenvio int
AS
--Declaración de Variables
DECLARE @vCodigo int
DECLARE @vMensaje nvarchar(500)
BEGIN
    BEGIN TRANSACTION;
    
    BEGIN TRY
        INSERT INTO LogTransaccionesAct (FechaRegistro,Login,CodigoEvento,FechaLectura, Indicador, OrigenEvento, DatosEvento,SeEnvio)
        VALUES (SYSDATETIME(),@plogin, @pcodigoevento,@pfechalectura, @pindicador, @porigenevento, @pdatosevento,@pseenvio)
		
		SET @pCodigo=0

    END TRY
    BEGIN CATCH
        SELECT 
             ERROR_NUMBER() AS ErrorNumber
            ,ERROR_SEVERITY() AS ErrorSeverity
            ,ERROR_STATE() AS ErrorState
            ,ERROR_PROCEDURE() AS ErrorProcedure
            ,ERROR_LINE() AS ErrorLine
            ,ERROR_MESSAGE() AS ErrorMessage;
    
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
    
    IF @@TRANCOUNT > 0
        COMMIT TRANSACTION;
END


GO
/****** Object:  StoredProcedure [Movil].[sprRegistrarPrincipalEjecutado]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		
-- Create date:	2013-09-24
-- Description:	Procedimiento para registrar 
-- =============================================
CREATE PROCEDURE [Movil].[sprRegistrarPrincipalEjecutado]
    --Parametros de Salida
	@pCodigo int OUTPUT, @pMensaje VARCHAR(255) OUTPUT,

    --Parametros entrada
    @pdescripcionactivo nvarchar(150),
	@pplacainventario nvarchar(15),
	@pcodigobarras nvarchar(15),
	@pfechainventario datetime2,
	@pcentrocosto nvarchar(6),
	@pubicacion nvarchar(5),
	@pestadofisico nvarchar(10),
	@pccresponsable nvarchar(12),
	@ptipoactivo nvarchar(7),
	@pnumeroserie nvarchar(20),
	@pobservacion nvarchar(200),
	@pactividad nvarchar(200),
	@pmodificado nvarchar(200), 
	@pleido nvarchar(200),
	@poperador nvarchar(200),
	@pcodigonuevo nvarchar(15),
	@prutaimagen nvarchar(200),
	@pestado nvarchar(200),
	@paux1  nvarchar(7)
AS
--Declaración de Variables
DECLARE @vCodigo int
DECLARE @vMensaje nvarchar(500)
BEGIN
    BEGIN TRANSACTION;
    
    BEGIN TRY
        INSERT INTO Activos 
		(DescripcionActivo,PlacaInventario,CodigoBarras,FechaInventario,CentroCosto,Ubicacion,EstadoFisico
		,CCResponsable,TipoActivo,NumeroSerie,Observacion,Estado,Aux1)
        VALUES 
		(@pdescripcionactivo,@pplacainventario,@pcodigobarras,@pfechainventario,@pcentrocosto,@pubicacion,@pestadofisico
		, @pccresponsable,@ptipoactivo,@pnumeroserie,@pobservacion,@pestado,@paux1)

		SET @pCodigo= 0

    END TRY
    BEGIN CATCH
		SET @pCodigo=ERROR_NUMBER()
		SET @vMensaje = ERROR_MESSAGE()
        SELECT 
             ERROR_NUMBER() AS ErrorNumber
            ,ERROR_SEVERITY() AS ErrorSeverity
            ,ERROR_STATE() AS ErrorState
            ,ERROR_PROCEDURE() AS ErrorProcedure
            ,ERROR_LINE() AS ErrorLine
            ,ERROR_MESSAGE() AS ErrorMessage;
    
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
    
    IF @@TRANCOUNT > 0
        COMMIT TRANSACTION;
END


GO
/****** Object:  StoredProcedure [Movil].[sprSeleccionarActivos]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		
-- Create date: 24-sep-2013
-- Description:	Consulta Activos.
-- =============================================
CREATE PROCEDURE [Movil].[sprSeleccionarActivos]
    --Parametros entrada
	@pcentrocosto nvarchar(6),
	@pubicacion nvarchar(5),
	@pccresponsable nvarchar(12)

AS
--Declaración de Variables
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

	IF @pcentrocosto =''
	BEGIN
		SET @pcentrocosto = NULL
	END

	IF @pubicacion=''
	BEGIN
		SET @pubicacion=NULL
	END

	IF @pccresponsable=''
	BEGIN
		SET @pccresponsable=NULL
	END


	SELECT * from Activos
	where 
	Estado >0
	and CentroCosto =isNull(@pcentrocosto, CentroCosto)
	and Ubicacion =isNUll(@pubicacion, Ubicacion)
	and CCResponsable  =isNUll(@pccresponsable, CCResponsable)

END


GO
/****** Object:  StoredProcedure [Movil].[sprSeleccionarFechaHora]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Martin Daza
-- Create date: 24-sep-2013
-- Description:	Consulta la fecha y hora del servidor de base de datos.
-- =============================================
CREATE PROCEDURE [Movil].[sprSeleccionarFechaHora]
    --Parametros entrada
AS
--Declaración de Variables
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT SYSDATETIME() fechahora
END


GO
/****** Object:  StoredProcedure [Movil].[sprSeleccionarInicioSesion]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Martin Daza
-- Create date: 23-sep-2013
-- Description:	Consulta la información de inspección de una maniobra.
-- =============================================
CREATE PROCEDURE [Movil].[sprSeleccionarInicioSesion]
    --Parametros entrada
    @pUsuario nvarchar(50) = null
AS
--Declaración de Variables
BEGIN
    SET NOCOUNT ON -- turn off rows affected messages
	SELECT RTRIM(LTRIM(u.Nombre)) + ' ' + RTRIM(LTRIM(u.Apellido)) Nombre
	,u.EstaBloqueado esbloqueado
	FROM catUsuario u
	WHERE u.Usuario=@pUsuario
END


GO
/****** Object:  StoredProcedure [Movil].[sprSeleccionarRolFuncion]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		
-- Create date: 24-sep-2013
-- Description:	Consulta información de las funciones por rol.
-- =============================================
CREATE PROCEDURE [Movil].[sprSeleccionarRolFuncion]
    --Parametros entrada
    --@pUsuario nvarchar(50) = null
AS
--Declaración de Variables
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT Rol,Funcion
	FROM catRolEnFuncion
	WHERE Aplicacion='WmActivosFijosMobile'
	ORDER BY Rol,Funcion
END


GO
/****** Object:  StoredProcedure [Movil].[sprSeleccionarTabla]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		
-- Create date: 
-- Description:	Consulta la información tablas básicas.
-- =============================================
CREATE PROCEDURE [Movil].[sprSeleccionarTabla]
    --Parametros entrada
    @pIdTabla int, @pVersion int
AS
--Declaración de Variables
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @pIdTabla>=0
	BEGIN
	    SELECT 
		IdTabla Idlista,Nombre Codigo, Titulo Detalle
	    FROM tblTabla
	    WHERE IdTabla=@pIdTabla
	    AND [version]>@pVersion	
	    AND Activo<>0
	END
	ELSE
	BEGIN
	    SELECT IdTabla,Nombre,[Version]
	    FROM tblTabla
	    WHERE Activo<>0
	    AND Destino>1
	END
END


GO
/****** Object:  StoredProcedure [Movil].[sprSeleccionarUsuario]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		
-- Create date: 
-- Description:	Consulta información de usuarios.
-- =============================================
CREATE PROCEDURE [Movil].[sprSeleccionarUsuario]
    --Parametros entrada
    --@pUsuario nvarchar(50) = null
AS
--Declaración de Variables
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--SELECT u.Usuario,LTRIM(RTRIM(u.Nombre)) + ' ' + LTRIM(RTRIM(u.Apellido)) AS Nombre
	--,u.Pase AS Clave
	--FROM catUsuario AS u
	--INNER JOIN catUsuarioEnRol AS r ON r.Usuario=u.Usuario
	--INNER JOIN ufnEmpresaPorUsuario(@pUsuario) AS c ON c.IdEmpresa=u.IdEmpresa
	--INNER JOIN ufnEsquemaPorUsuario(@pUsuario) AS o ON o.IdEsquema=u.IdEsquema
	--WHERE r.Aplicacion='WmActivosFijosMobile'

	SELECT Distinct u.Usuario login ,LTRIM(RTRIM(u.Nombre)) + ' ' + LTRIM(RTRIM(u.Apellido)) AS nombre
	,u.Pase AS password, EstaBloqueado EsBloqueado
	FROM catUsuario AS u
	INNER JOIN catUsuarioEnRol AS r ON r.Usuario=u.Usuario
	WHERE r.Aplicacion='WmActivosFijosMobile'

END


GO
/****** Object:  StoredProcedure [Movil].[sprSeleccionarUsuarioRol]    Script Date: 22/08/2016 6:34:30 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		
-- Create date: 
-- Description:	Consulta los roles por usuario.
-- =============================================
CREATE PROCEDURE [Movil].[sprSeleccionarUsuarioRol]
    --Parametros entrada
    --@pUsuario nvarchar(50) = null
AS
--Declaración de Variables
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Select r.Usuario login, r.Rol 
	FROM catUsuarioEnRol AS r
	WHERE r.Aplicacion='WmActivosFijosMobile'
	ORDER BY r.Usuario,r.Rol

	--SELECT r.Usuario ,r.Rol
	--FROM catUsuarioEnRol AS r
	--INNER JOIN catUsuario AS u ON u.Usuario=r.Usuario
	--INNER JOIN ufnEmpresaPorUsuario(@pUsuario) AS c ON c.IdEmpresa=u.IdEmpresa
	--INNER JOIN ufnEsquemaPorUsuario(@pUsuario) AS o ON o.IdEsquema=u.IdEsquema
	--WHERE r.Aplicacion='WmActivosFijosMobile'
	--ORDER BY r.Usuario,r.Rol
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Identificación única del mensaje de error' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblLogger', @level2type=N'COLUMN',@level2name=N'IdLogger'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha y hora en que se capturó el error.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblLogger', @level2type=N'COLUMN',@level2name=N'Fecha'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de error personalizado.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblLogger', @level2type=N'COLUMN',@level2name=N'Codigo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Texto del error generado.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblLogger', @level2type=N'COLUMN',@level2name=N'Texto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Número de Versión de la lista' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblTabla', @level2type=N'COLUMN',@level2name=N'Version'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha / Hora Actualización de la lista' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblTabla', @level2type=N'COLUMN',@level2name=N'FechaActualizacion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre Usuario que hace la actualización de la Lista' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblTabla', @level2type=N'COLUMN',@level2name=N'Usuario'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Indica si la lista es usanda en 0:Ninguno, 1:Server, 2:Dispositivo, 3 Server y Mobile' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblTabla', @level2type=N'COLUMN',@level2name=N'Destino'
GO
USE [master]
GO
ALTER DATABASE [WMActivosFijos] SET  READ_WRITE 
GO
