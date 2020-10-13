USE [GD2C2020]
GO

IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'FFAN' )
    EXEC('CREATE SCHEMA [FFAN]');
GO

IF OBJECT_ID('FFAN.TIPO_CAJA', 'U') IS NOT NULL 
DROP TABLE [FFAN].[TIPO_CAJA]; 
GO

CREATE TABLE [FFAN].[TIPO_CAJA] 
(
    TIPO_CAJA_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,  /* VERIFICAR SI DEBERIA EMPEZAR POR 1000 EN VEZ DE 1 */
    TIPO_CAJA_DESC NVARCHAR(255)
)
GO

IF OBJECT_ID('FFAN.TIPO_TRANSMISION', 'U') IS NOT NULL 
DROP TABLE [FFAN].[TIPO_TRANSMISION]; 
GO

CREATE TABLE [FFAN].[TIPO_TRANSMISION] 
(
    TIPO_TRANSMISION_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,  
    TIPO_TRANSMISION_DESC NVARCHAR(255)

)
GO

IF OBJECT_ID('FFAN.TIPO_MOTOR', 'U') IS NOT NULL 
DROP TABLE [FFAN].[TIPO_MOTOR]; 
GO

CREATE TABLE [FFAN].[TIPO_MOTOR] 
(
    TIPO_MOTOR_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,  
    TIPO_MOTOR_DESC NVARCHAR(255)

)
GO

IF OBJECT_ID('FFAN.TIPO_AUTO', 'U') IS NOT NULL 
DROP TABLE [FFAN].[TIPO_AUTO]; 
GO

CREATE TABLE [FFAN].[TIPO_AUTO] 
(
    TIPO_AUTO_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,  
    TIPO_AUTO_DESC NVARCHAR(255)

)
GO

IF OBJECT_ID('FFAN.MODELO', 'U') IS NOT NULL 
DROP TABLE  [FFAN].[MODELO]; 
GO

CREATE TABLE [FFAN].[MODELO] 
(
    MODELO_CODIGO DECIMAL(18,0) NOT NULL PRIMARY KEY,  
    MODELO_NOMBRE NVARCHAR(255),
    MODELO_POTENCIA DECIMAL(18,0)
)
GO

IF OBJECT_ID('FFAN.FABRICANTE', 'U') IS NOT NULL 
DROP TABLE  [FFAN].[FABRICANTE]; 
GO

CREATE TABLE [FFAN].[FABRICANTE] 
(
    FABRICANTE_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,  
    FABRICANTE_NOMBRE NVARCHAR(255)

)
GO

IF OBJECT_ID('FFAN.CLIENTE', 'U') IS NOT NULL 
DROP TABLE [FFAN].[CLIENTE];
GO

CREATE TABLE [FFAN].[CLIENTE] 
(
    CLIENTE_ID DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
    CLIENTE_APELLIDO NVARCHAR(255) NOT NULL,
    CLIENTE_NOMBRE NVARCHAR(255) NOT NULL,
    CLIENTE_DIRECCION NVARCHAR(255) NOT NULL,
    CLIENTE_DNI DECIMAL(18,0) NOT NULL,
    CLIENTE_FECHA_NAC  DATETIME2(3) NOT NULL,
    CLIENTE_EMAIL NVARCHAR(255),
)

IF OBJECT_ID('FFAN.AUTOMOVIL', 'U') IS NOT NULL 
DROP TABLE [FFAN].[AUTOMOVIL];
GO

CREATE TABLE [FFAN].[AUTOMOVIL]
(
    AUTO_ID DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
    AUTO_PATENTE NVARCHAR(50) NOT NULL,
    AUTO_FECHA_ALTA DATETIME2(2) NOT NULL,
    AUTO_CANT_KMS DECIMAL(18,0) NOT NULL,
    AUTO_NRO_CHASIS NVARCHAR(50) NOT NULL,
    AUTO_NRO_MOTOR NVARCHAR(50) NOT NULL,
    AUTO_MODELO_CODIGO DECIMAL(18,0) FOREIGN KEY REFERENCES FFAN.MODELO(MODELO_CODIGO),
    AUTO_TIPO_CAJA_CODIGO DECIMAL(18,0) FOREIGN KEY REFERENCES FFAN.TIPO_CAJA(TIPO_CAJA_CODIGO),
    AUTO_TIPO_MOTOR_CODIGO DECIMAL(18,0) FOREIGN KEY REFERENCES FFAN.TIPO_MOTOR(TIPO_MOTOR_CODIGO),
    AUTO_TIPO_TRANSMISION DECIMAL(18,0) FOREIGN KEY REFERENCES FFAN.TIPO_TRANSMISION(TIPO_TRANSMISION_CODIGO),
    AUTO_TIPO_CODIGO DECIMAL(18,0) FOREIGN KEY REFERENCES FFAN.TIPO_AUTO(TIPO_AUTO_CODIGO),
    AUTO_FABRICANTE_CODIGO DECIMAL(18,0) FOREIGN KEY REFERENCES FFAN.FABRICANTE(FABRICANTE_CODIGO)
)

IF OBJECT_ID('FFAN.SUCURSAL', 'U') IS NOT NULL 
DROP TABLE [FFAN].[SUCURSAL];
GO

CREATE TABLE [FFAN].[SUCURSAL](
    SUCURSAL_ID DECIMAL(18,0) NOT NULL PRIMARY KEY,
    SUCURSAL_DIRECCION NVARCHAR(255),
    SUCURSAL_MAIL NVARCHAR(255),
    SUCURSAL_TELEFONO DECIMAL(18,0),
    SUCURSAL_CIUDAD NVARCHAR(255)
)

IF OBJECT_ID('FFAN.AUTOPARTE', 'U') IS NOT NULL 
DROP TABLE [FFAN].[AUTOPARTE]
GO

CREATE TABLE [FFAN].[AUTOPARTE] 
(
	AUTOPARTE_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	AUTOPARTE_DESCRIPCION NVARCHAR(255) NOT NULL,
	AUTOPARTE_FRABRICANTE_CODIGO DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.FABRICANTE(FABRICANTE_CODIGO),
	AUTOPARTE_MODELO_CODIGO DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.MODELO(MODELO_CODIGO)
)
GO

IF OBJECT_ID('FFAN.FACTURA', 'U') IS NOT NULL 
DROP TABLE [FFAN].[FACTURA]
GO

CREATE TABLE [FFAN].[FACTURA]
(
	FACTURA_NUMERO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	FACTURA_FECHA DATETIME2(3) NOT NULL,
	FACTURA_PRECIO_TOTAL DECIMAL(18,2) NOT NULL,
	FACTURA_SUCURSAL_CIUDAD NVARCHAR(255),
	FACTURA_SUCURSAL_DIRECCION NVARCHAR(255),
	FACTURA_CLIENTE_ID DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.CLIENTE(CLIENTE_ID),
	FACTURA_SUCURSAL_ID DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.SUCURSAL(SUCURSAL_ID)
)
GO

IF OBJECT_ID('FFAN.ITEM_FACTURA_AUTOPARTE', 'U') IS NOT NULL 
DROP TABLE [FFAN].[ITEM_FACTURA_AUTOPARTE]
GO


CREATE TABLE [FFAN].[ITEM_FACTURA_AUTOPARTE]
(
	ITEM_FACTURA_AUTOPARTE_NRO DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.FACTURA(FACTURA_NUMERO) PRIMARY KEY,
    ITEM_FACTURA_AUTOPARTE_CODAUTOPARTE DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.AUTOPARTE(AUTOPARTE_CODIGO) PRIMARY KEY,
    ITEM_FACTURA_AUTOPARTE_PRECIO DECIMAL(18,2),
    ITEM_FACTURA_AUTOPARTE_CANT DECIMAL(18,0)
)


IF OBJECT_ID('FFAN.ITEM_FACTURA_AUTOMOVIL', 'U') IS NOT NULL 
DROP TABLE [FFAN].[ITEM_FACTURA_AUTOMOVIL]
GO


CREATE TABLE [FFAN].[ITEM_FACTURA_AUTOMOVIL]
(
	ITEM_FACTURA_AUTOMOVIL_NRO DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.FACTURA(FACTURA_NUMERO) PRIMARY KEY,
    ITEM_FACTURA_AUTOMOVIL_ID DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.AUTOMOVIL(AUTO_ID) PRIMARY KEY,
    ITEM_FACTURA_AUTOMOVIL_PRECIO DECIMAL(18,2),
)

IF OBJECT_ID('FFAN.COMPRA', 'U') IS NOT NULL 
DROP TABLE [FFAN].[COMPRA]
GO

CREATE TABLE [FFAN].[COMPRA]
(
    COMPRA_NRO DECIMAL(18,0) NOT NULL PRIMARY KEY,
    COMPRA_FECHA DATETIME2(3),
    COMPRA_CLIENTE DECIMAL(18,0) FOREIGN KEY REFERENCES FFAN.CLIENTE(CLIENTE_ID),
    COMPRA_PRECIO_TOTAL DECIMAL(18,2),
    COMPRA_SUCURSAL DECIMAL(18,2) NOT NULL FOREIGN KEY REFERENCES FFAN.SUCURSAL(SUCURSAL_ID),
    COMPRA_SUCURSAL_DIRECCION NVARCHAR(255),
    COMPRA_SUCURSAL_CIUDAD NVARCHAR(255)
)