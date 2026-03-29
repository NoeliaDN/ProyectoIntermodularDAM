CREATE TABLE [maestra].[Variedad] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Nombre]      NVARCHAR (100) NOT NULL,
    [Especie]     NVARCHAR (50)  NOT NULL,
    [Descripcion] NVARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

