CREATE TABLE [origen].[Productor] (
    [Id]              INT            IDENTITY (1, 1) NOT NULL,
    [Nombre]          NVARCHAR (150) NOT NULL,
    [AnioFundacion]   INT            NULL,
    [TipoProductorId] INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Productor_TipoProductor] FOREIGN KEY ([TipoProductorId]) REFERENCES [origen].[TipoProductor] ([Id])
);

