CREATE TABLE [cafe].[LoteCafe] (
    [Id]                   INT            IDENTITY (1, 1) NOT NULL,
    [Nombre]               NVARCHAR (150) NOT NULL,
    [Descripcion]          NVARCHAR (500) NULL,
    [NotasCata]            NVARCHAR (300) NULL,
    [AltitudMin]           INT            NOT NULL,
    [AltitudMax]           INT            NOT NULL,
    [RegionId]             INT            NOT NULL,
    [ProductorId]          INT            NOT NULL,
    [ProcesoId]            INT            NOT NULL,
    [VariedadId]           INT            NOT NULL,
    [TuesteId]             INT            NOT NULL,
    [AltitudMedia]         AS             (([AltitudMin]+[AltitudMax])/(2.0)),
    [DescripcionExtendida] NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_LoteCafe_Proceso] FOREIGN KEY ([ProcesoId]) REFERENCES [maestra].[Proceso] ([Id]),
    CONSTRAINT [FK_LoteCafe_Productor] FOREIGN KEY ([ProductorId]) REFERENCES [origen].[Productor] ([Id]),
    CONSTRAINT [FK_LoteCafe_Region] FOREIGN KEY ([RegionId]) REFERENCES [origen].[Region] ([Id]),
    CONSTRAINT [FK_LoteCafe_Tueste] FOREIGN KEY ([TuesteId]) REFERENCES [maestra].[Tueste] ([Id]),
    CONSTRAINT [FK_LoteCafe_Variedad] FOREIGN KEY ([VariedadId]) REFERENCES [maestra].[Variedad] ([Id])
);

