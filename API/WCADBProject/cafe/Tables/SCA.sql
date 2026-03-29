CREATE TABLE [cafe].[SCA] (
    [LoteCafeId]    INT            NOT NULL,
    [Acidez]        DECIMAL (4, 2) NOT NULL,
    [Cuerpo]        DECIMAL (4, 2) NOT NULL,
    [Dulzor]        DECIMAL (4, 2) NOT NULL,
    [Aroma]         DECIMAL (4, 2) NOT NULL,
    [Retrogusto]    DECIMAL (4, 2) NOT NULL,
    [Balance]       DECIMAL (4, 2) NOT NULL,
    [PuntuacionSCA] AS             (CONVERT([decimal](4,2),round(((((([Acidez]+[Cuerpo])+[Dulzor])+[Aroma])+[Retrogusto])+[Balance])/(6.0),(2)))),
    PRIMARY KEY CLUSTERED ([LoteCafeId] ASC),
    CONSTRAINT [FK_SCA_LoteCafe] FOREIGN KEY ([LoteCafeId]) REFERENCES [cafe].[LoteCafe] ([Id]) ON DELETE CASCADE
);

