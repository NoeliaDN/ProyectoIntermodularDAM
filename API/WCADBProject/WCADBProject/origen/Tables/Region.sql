CREATE TABLE [origen].[Region] (
    [Id]     INT            IDENTITY (1, 1) NOT NULL,
    [Nombre] NVARCHAR (100) NOT NULL,
    [PaisId] INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Region_Pais] FOREIGN KEY ([PaisId]) REFERENCES [origen].[Pais] ([Id])
);

