CREATE TABLE [maestra].[Tueste] (
    [Id]          INT            IDENTITY (1, 1) NOT NULL,
    [Nombre]      NVARCHAR (50)  NOT NULL,
    [Descripcion] NVARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

