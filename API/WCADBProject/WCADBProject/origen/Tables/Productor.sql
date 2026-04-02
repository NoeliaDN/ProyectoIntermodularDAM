CREATE TABLE [origen].[Productor] (
    [Id]               INT            IDENTITY (1, 1) NOT NULL,
    [Nombre]           NVARCHAR (150) NOT NULL,
    [DescripcionBreve] NVARCHAR (500) NULL,
    [TipoProductorId]  INT            NOT NULL,
    CONSTRAINT [PK__Producto__3214EC07AF63A22D] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Productor_TipoProductor] FOREIGN KEY ([TipoProductorId]) REFERENCES [origen].[TipoProductor] ([Id])
);

