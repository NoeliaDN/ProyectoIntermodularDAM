CREATE TABLE [origen].[Pais] (
    [Id]        INT            IDENTITY (1, 1) NOT NULL,
    [Nombre]    NVARCHAR (100) NOT NULL,
    [CodigoISO] CHAR (2)       NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

