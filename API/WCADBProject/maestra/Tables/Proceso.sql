CREATE TABLE [maestra].[Proceso] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Nombre]      NVARCHAR (100) NOT NULL,
    [Descripcion] NVARCHAR (300) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

