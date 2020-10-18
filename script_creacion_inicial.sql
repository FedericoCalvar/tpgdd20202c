USE [GD2C2020]
GO

IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'FFAN' )
    EXEC('CREATE SCHEMA [FFAN]');
GO

IF OBJECT_ID('FFAN.ITEM_COMPRA_AUTOMOVIL', 'U') IS NOT NULL 
DROP TABLE [FFAN].[ITEM_COMPRA_AUTOMOVIL]
GO

IF OBJECT_ID('FFAN.ITEM_COMPRA_AUTOPARTE', 'U') IS NOT NULL 
DROP TABLE [FFAN].[ITEM_COMPRA_AUTOPARTE]
GO

IF OBJECT_ID('FFAN.COMPRA', 'U') IS NOT NULL 
DROP TABLE [FFAN].[COMPRA]
GO

IF OBJECT_ID('FFAN.ITEM_FACTURA_AUTOMOVIL', 'U') IS NOT NULL 
DROP TABLE [FFAN].[ITEM_FACTURA_AUTOMOVIL]
GO

IF OBJECT_ID('FFAN.ITEM_FACTURA_AUTOPARTE', 'U') IS NOT NULL 
DROP TABLE [FFAN].[ITEM_FACTURA_AUTOPARTE]
GO

IF OBJECT_ID('FFAN.FACTURA', 'U') IS NOT NULL 
DROP TABLE [FFAN].[FACTURA]
GO

IF OBJECT_ID('FFAN.AUTOMOVIL', 'U') IS NOT NULL 
DROP TABLE [FFAN].[AUTOMOVIL];
GO

IF OBJECT_ID('FFAN.AUTOPARTE', 'U') IS NOT NULL 
DROP TABLE [FFAN].[AUTOPARTE]
GO

IF OBJECT_ID('FFAN.TIPO_CAJA', 'U') IS NOT NULL 
DROP TABLE [FFAN].[TIPO_CAJA]; 
GO

IF OBJECT_ID('FFAN.TIPO_TRANSMISION', 'U') IS NOT NULL 
DROP TABLE [FFAN].[TIPO_TRANSMISION]; 
GO

IF OBJECT_ID('FFAN.TIPO_MOTOR', 'U') IS NOT NULL 
DROP TABLE [FFAN].[TIPO_MOTOR]; 
GO

IF OBJECT_ID('FFAN.TIPO_AUTO', 'U') IS NOT NULL 
DROP TABLE [FFAN].[TIPO_AUTO]; 
GO

IF OBJECT_ID('FFAN.MODELO', 'U') IS NOT NULL 
DROP TABLE  [FFAN].[MODELO]; 
GO

IF OBJECT_ID('FFAN.FABRICANTE', 'U') IS NOT NULL 
DROP TABLE  [FFAN].[FABRICANTE]; 
GO

IF OBJECT_ID('FFAN.CLIENTE', 'U') IS NOT NULL 
DROP TABLE [FFAN].[CLIENTE];
GO

IF OBJECT_ID('FFAN.SUCURSAL', 'U') IS NOT NULL 
DROP TABLE [FFAN].[SUCURSAL];
GO

CREATE TABLE [FFAN].[TIPO_CAJA] 
(
    TIPO_CAJA_CODIGO DECIMAL(18,0) NOT NULL PRIMARY KEY,  /* VERIFICAR SI DEBERIA EMPEZAR POR 1000 EN VEZ DE 1 */
    TIPO_CAJA_DESC NVARCHAR(255)
)
GO

CREATE TABLE [FFAN].[TIPO_TRANSMISION] 
(
    TIPO_TRANSMISION_CODIGO DECIMAL(18,0) NOT NULL PRIMARY KEY,  
    TIPO_TRANSMISION_DESC NVARCHAR(255)
)
GO

CREATE TABLE [FFAN].[TIPO_MOTOR] 
(
    TIPO_MOTOR_CODIGO DECIMAL(18,0) NOT NULL PRIMARY KEY,  
    TIPO_MOTOR_DESC NVARCHAR(255)
)
GO

CREATE TABLE [FFAN].[TIPO_AUTO] 
(
    TIPO_AUTO_CODIGO DECIMAL(18,0) NOT NULL PRIMARY KEY,  
    TIPO_AUTO_DESC NVARCHAR(255)
)
GO

CREATE TABLE [FFAN].[MODELO] 
(
    MODELO_CODIGO DECIMAL(18,0) NOT NULL PRIMARY KEY,  
    MODELO_NOMBRE NVARCHAR(255),
    MODELO_POTENCIA DECIMAL(18,0)
)
GO


CREATE TABLE [FFAN].[FABRICANTE] 
(
    FABRICANTE_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,  
    FABRICANTE_NOMBRE NVARCHAR(255)
)
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
GO

CREATE TABLE [FFAN].[SUCURSAL](
    SUCURSAL_ID DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
    SUCURSAL_DIRECCION NVARCHAR(255),
    SUCURSAL_MAIL NVARCHAR(255),
    SUCURSAL_TELEFONO DECIMAL(18,0),
    SUCURSAL_CIUDAD NVARCHAR(255)
)
GO

CREATE TABLE [FFAN].[AUTOPARTE]
(
    AUTOPARTE_CODIGO DECIMAL(18,0) NOT NULL PRIMARY KEY,
    AUTOPARTE_DESCRIPCION NVARCHAR(255),
    AUTOPARTE_FABRICANTE_CODIGO DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.FABRICANTE(FABRICANTE_CODIGO),
    AUTOPARTE_MODELO_CODIGO DECIMAL(18,0)
)
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
GO

CREATE TABLE [FFAN].[COMPRA]
(
    COMPRA_NRO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY ,
    COMPRA_FECHA DATETIME2(3),
    COMPRA_CLIENTE DECIMAL(18,0) FOREIGN KEY REFERENCES FFAN.CLIENTE(CLIENTE_ID),
    COMPRA_PRECIO_TOTAL DECIMAL(18,2),
    COMPRA_SUCURSAL_ID DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.SUCURSAL(SUCURSAL_ID),
    COMPRA_SUCURSAL_DIRECCION NVARCHAR(255),
    COMPRA_SUCURSAL_CIUDAD NVARCHAR(255)
)
GO


CREATE TABLE [FFAN].[ITEM_COMPRA_AUTOMOVIL]
(
    ITEM_COMPRA_AUTO_NRO DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.COMPRA(COMPRA_NRO) ,
    ITEM_COMPRA_AUTO_ID DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.AUTOMOVIL(AUTO_ID),
    ITEM_COMPRA_AUTO_AUTOMOVIL_PRECIO DECIMAL(18,0),
    PRIMARY KEY(ITEM_COMPRA_AUTO_NRO,ITEM_COMPRA_AUTO_ID )
)
GO

CREATE TABLE [FFAN].[ITEM_COMPRA_AUTOPARTE]
(
    ITEM_COMPRA_AUTOPARTE_NRO DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.COMPRA(COMPRA_NRO),
    ITEM_COMPRA_AUTOPARTE_CODIGO DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.AUTOPARTE(AUTOPARTE_CODIGO),
    ITEM_COMPRA_AUTOPARTE_PRECIO DECIMAL(18,0),
    ITEM_COMPRA_AUTOPARTE_CANT DECIMAL(18,0),
    PRIMARY KEY (ITEM_COMPRA_AUTOPARTE_NRO,ITEM_COMPRA_AUTOPARTE_CODIGO)
)


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

CREATE TABLE [FFAN].[ITEM_FACTURA_AUTOPARTE]
(
    ITEM_FACTURA_AUTOPARTE_NRO DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.FACTURA(FACTURA_NUMERO),
    ITEM_FACTURA_AUTOPARTE_CODIGO DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.AUTOPARTE(AUTOPARTE_CODIGO),
    ITEM_FACTURA_AUTOPARTE_PRECIO DECIMAL(18,2),
    ITEM_FACTURA_AUTOPARTE_CANT DECIMAL(18,0),
    PRIMARY KEY (ITEM_FACTURA_AUTOPARTE_NRO,ITEM_FACTURA_AUTOPARTE_CODIGO)
)
GO


CREATE TABLE [FFAN].[ITEM_FACTURA_AUTOMOVIL]
(
    ITEM_FACTURA_AUTOMOVIL_NRO DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.FACTURA(FACTURA_NUMERO),
    ITEM_FACTURA_AUTOMOVIL_ID DECIMAL(18,0) NOT NULL FOREIGN KEY REFERENCES FFAN.AUTOMOVIL(AUTO_ID),
    ITEM_FACTURA_AUTOMOVIL_PRECIO DECIMAL(18,2),
    PRIMARY KEY (ITEM_FACTURA_AUTOMOVIL_NRO,ITEM_FACTURA_AUTOMOVIL_ID)
)
GO


/*

ALEXIS : AUTOMOVIL Y TODAS LAS FK DE AUTOMOVIL
NACHO: FACTURA + ITEM FACTURA AUTOPARTE E ITEM FACTURA AUTOMOVIL
FACU: COMPRA + ITEM COMPRA AUTOPARTE E ITEM COMPRA AUTOMOVIL + ORDENAR SCRIPT
FEDE: SUCURSAL + CLIENTE 

*/

insert
	into
	FFAN.TIPO_CAJA
select
	GD_ESQUEMA.Maestra.TIPO_CAJA_CODIGO,
	GD_ESQUEMA.Maestra.TIPO_CAJA_DESC
from
	GD_ESQUEMA.Maestra
where
	TIPO_CAJA_CODIGO is not null
group by
	GD_ESQUEMA.Maestra.TIPO_CAJA_CODIGO,
	GD_ESQUEMA.Maestra.TIPO_CAJA_DESC
GO

insert
	into
	FFAN.TIPO_AUTO
select
	GD_ESQUEMA.Maestra.TIPO_AUTO_CODIGO ,
	GD_ESQUEMA.Maestra.TIPO_AUTO_DESC
from
	GD_ESQUEMA.Maestra
where
	TIPO_AUTO_CODIGO is not null
group by
	GD_ESQUEMA.Maestra.TIPO_AUTO_CODIGO,
	GD_ESQUEMA.Maestra.TIPO_AUTO_DESC
GO

insert
	into
	FFAN.TIPO_MOTOR
SELECT
	distinct tipo_motor_codigo,
	'Descripcion_' + convert(varchar(4),
	tipo_motor_codigo)
FROM
	gd_esquema.Maestra
where
	tipo_motor_codigo is not null
go

INSERT
	INTO
	FFAN.MODELO
SELECT
	GD_ESQUEMA.Maestra.MODELO_CODIGO,
	GD_ESQUEMA.Maestra.MODELO_NOMBRE,
	GD_ESQUEMA.Maestra.MODELO_POTENCIA
	FROM gd_esquema.Maestra 
	WHERE GD_ESQUEMA.Maestra.MODELO_CODIGO IS NOT NULL
GROUP BY
	GD_ESQUEMA.Maestra.MODELO_CODIGO,
	GD_ESQUEMA.Maestra.MODELO_NOMBRE,
	GD_ESQUEMA.Maestra.MODELO_POTENCIA
GO

INSERT
	INTO
	FFAN.TIPO_TRANSMISION
SELECT
	GD_ESQUEMA.MAESTRA.TIPO_TRANSMISION_CODIGO,
	GD_ESQUEMA.Maestra.TIPO_TRANSMISION_DESC
FROM
	GD_ESQUEMA.Maestra
where
	TIPO_TRANSMISION_CODIGO is not NULL
group by
	GD_ESQUEMA.MAESTRA.TIPO_TRANSMISION_CODIGO,
	GD_ESQUEMA.Maestra.TIPO_TRANSMISION_DESC
go

insert
	into
	FFAN.FABRICANTE (FFAN.FABRICANTE.FABRICANTE_NOMBRE )
SELECT
	DISTINCT(GD_ESQUEMA.MAESTRA.FABRICANTE_NOMBRE)
FROM
	gd_esquema.Maestra
WHERE
	GD_ESQUEMA.MAESTRA.FABRICANTE_NOMBRE IS NOT NULL
GO


insert
	into
	ffan.AUTOMOVIL (AUTO_PATENTE, AUTO_FECHA_ALTA, auto_cant_kms, auto_nro_chasis, auto_nro_motor, auto_modelo_codigo, auto_tipo_caja_codigo, auto_tipo_motor_codigo, auto_tipo_transmision, AUTO_TIPO_CODIGO, AUTO_FABRICANTE_CODIGO )
select
	m.AUTO_PATENTE,
	m.AUTO_FECHA_ALTA,
	m.AUTO_CANT_KMS,
	m.AUTO_NRO_CHASIS,
	m.AUTO_NRO_MOTOR,
	m.MODELO_CODIGO,
	m.tipo_caja_codigo,
	m.TIPO_MOTOR_CODIGO,
	m.TIPO_TRANSMISION_CODIGO,
	m.TIPO_AUTO_CODIGO,
	f.FABRICANTE_CODIGO
from
	gd_esquema.Maestra m,
	ffan.fabricante f
where
	m.FABRICANTE_NOMBRE = f.FABRICANTE_NOMBRE
	and m.AUTO_PATENTE is not null
group by
	m.AUTO_PATENTE,
	m.AUTO_FECHA_ALTA,
	m.AUTO_CANT_KMS,
	m.AUTO_NRO_CHASIS,
	m.AUTO_NRO_MOTOR,
	m.MODELO_CODIGO,
	m.tipo_caja_codigo,
	m.TIPO_MOTOR_CODIGO,
	m.TIPO_TRANSMISION_CODIGO,
	m.TIPO_AUTO_CODIGO,
	f.FABRICANTE_CODIGO
GO



