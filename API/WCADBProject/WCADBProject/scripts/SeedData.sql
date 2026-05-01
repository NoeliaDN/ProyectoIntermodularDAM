/*
Plantilla de script posterior a la implementación							
--------------------------------------------------------------------------------------
 Este archivo contiene instrucciones de SQL que se anexarán al script de compilación.		
 Use la sintaxis de SQLCMD para incluir un archivo en el script posterior a la implementación.			
 Ejemplo:      :r .\miArchivo.sql								
 Use la sintaxis de SQLCMD para hacer referencia a una variable en el script posterior a la implementación.		
 Ejemplo:      :setvar TableName miTabla							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

SET IDENTITY_INSERT [cafe].[LoteCafe] ON 

INSERT [cafe].[LoteCafe] ([Id], [Nombre], [Descripcion], [NotasCata], [AltitudMin], [AltitudMax], [RegionId], [ProductorId], [ProcesoId], [VariedadId], [TuesteId], [DescripcionExtendida]) VALUES (1, N'Café de Perú', N'Café de especialidad de Cajamarca con perfil floral, frutal y acidez brillante.', N'Frutas tropicales, florales, panela, acidez brillante', 1800, 1800, 1, 1, 1, 3, 3, N'Perú ha consolidado su posición como uno de los grandes productores de cafés de especialidad en América Latina, especialmente gracias a la calidad de sus microlotes y la diversidad de sus regiones productoras. La región de Cajamarca, y en particular el distrito de La Coipa, ha sido protagonista en las últimas ediciones de la Taza de Excelencia Perú, donde productores como Miguel Padilla Chinguel han alcanzado puntuaciones superiores a los 90 puntos SCA.

El café de Miguel Padilla Chinguel, cultivado a 1,800 metros sobre el nivel del mar, destaca por su acidez vibrante, notas de frutas tropicales y florales, y un dulzor envolvente que recuerda a la panela. El método de procesamiento lavado y el tueste medio permiten resaltar la claridad y la complejidad del perfil sensorial. La puntuación sensorial de este café lo sitúa entre los mejores del mundo, con una acidez de 92/100, cuerpo de 88/100 y un balance sobresaliente de 91/100.

La metodología de evaluación en la Taza de Excelencia Perú es rigurosa, con paneles de catadores nacionales e internacionales que aplican el protocolo SCA. Los cafés ganadores son subastados a precios muy superiores al mercado, lo que incentiva la producción de calidad y la profesionalización del sector.')
INSERT [cafe].[LoteCafe] ([Id], [Nombre], [Descripcion], [NotasCata], [AltitudMin], [AltitudMax], [RegionId], [ProductorId], [ProcesoId], [VariedadId], [TuesteId], [DescripcionExtendida]) VALUES (2, N'Café de Colombia', N'Café innovador con perfil exótico y gran complejidad aromática.', N'Frutas exóticas, jazmín, melocotón, panela', 1700, 1800, 2, 2, 4, 4, 2, N'Colombia es sinónimo de café de especialidad, con una diversidad altitudinal y de microclimas que permite la producción de una amplia gama de perfiles sensoriales. Regiones como Huila, Nariño y el Eje Cafetero (Quindío, Risaralda, Caldas) son reconocidas por sus cafés balanceados, con acidez brillante, dulzor natural y notas florales o frutales.

La finca El Paraíso, en Huila, es un ejemplo de innovación en el procesamiento, utilizando técnicas anaeróbicas que potencian las notas exóticas y la complejidad aromática. El café de Diego Bermúdez, cultivado a 1,700 msnm, presenta notas de frutas exóticas, jazmín y melocotón, con una acidez de 90/100 y un dulzor de 92/100. El método anaeróbico y el tueste medio-claro permiten una expresión sensorial única, que ha sido reconocida en competencias internacionales.

La tendencia hacia los microlotes y la trazabilidad ha permitido a Colombia adaptarse a los desafíos del cambio climático y la volatilidad del mercado, ofreciendo cafés con identidad y valor agregado.')
INSERT [cafe].[LoteCafe] ([Id], [Nombre], [Descripcion], [NotasCata], [AltitudMin], [AltitudMax], [RegionId], [ProductorId], [ProcesoId], [VariedadId], [TuesteId], [DescripcionExtendida]) VALUES (3, N'Café de Etiopía', N'Café floral y cítrico con gran complejidad genética.', N'Floral, chocolate, jazmín, naranja, dulce', 1800, 2200, 3, 16, 2, 11, 3, N'Etiopía es considerada la cuna del café arábica, y sus regiones productoras como Sidamo y Yirgacheffe son famosas por la diversidad genética de sus cafetos y la riqueza de sus perfiles sensoriales. Los cafés etíopes suelen cultivarse a altitudes elevadas (1,800-2,200 msnm), lo que favorece una maduración lenta y el desarrollo de notas florales, cítricas y frutales.

El café Sidamo de Ephtah Specialty Coffee, procesado de forma natural, destaca por su fragancia floral, base de chocolate y notas de flor blanca y naranja. La acidez es alta (83/100), el cuerpo medio (80/100) y el dulzor sobresaliente (85/100). El tueste medio resalta la complejidad y el equilibrio de este café, que es apreciado tanto en métodos de filtrado como en espresso.

Etiopía utiliza principalmente los métodos de procesamiento natural y lavado, cada uno aportando matices distintos a la taza. La comercialización suele realizarse por región y cooperativa, lo que refuerza la identidad de origen y la trazabilidad.')
INSERT [cafe].[LoteCafe] ([Id], [Nombre], [Descripcion], [NotasCata], [AltitudMin], [AltitudMax], [RegionId], [ProductorId], [ProcesoId], [VariedadId], [TuesteId], [DescripcionExtendida]) VALUES (4, N'Café de Brasil', N'Café dulce y achocolatado con cuerpo cremoso.', N'Chocolate, frutos secos, canela, caramelo', 1000, 1200, 4, 3, 2, 9, 3, N'Brasil es el mayor productor y exportador de café del mundo, y aunque históricamente ha sido asociado a cafés de volumen, en las últimas décadas ha emergido como un referente en cafés de especialidad. Regiones como Cerrado Mineiro y Minas Gerais producen cafés con perfiles sensoriales definidos, acidez suave, cuerpo cremoso y notas a chocolate, frutos secos y caramelo.

La finca Corrego, en Cerrado Mineiro, bajo la dirección de Andreia Cunha Neves Careta, produce un café natural con notas de chocolate con leche, almendra y canela. La acidez y el cuerpo alcanzan 83/100, mientras que el dulzor y el aroma se sitúan en 85 y 88 respectivamente. El tueste medio es ideal para resaltar el perfil clásico brasileño, que es muy apreciado en espresso y métodos de filtro.

La innovación en el procesamiento y la adopción de prácticas sostenibles han permitido a Brasil posicionarse también en el segmento premium, con cafés que compiten en la Taza de Excelencia y otras competencias internacionales.')
INSERT [cafe].[LoteCafe] ([Id], [Nombre], [Descripcion], [NotasCata], [AltitudMin], [AltitudMax], [RegionId], [ProductorId], [ProcesoId], [VariedadId], [TuesteId], [DescripcionExtendida]) VALUES (5, N'Café de Kenia', N'Café vibrante con acidez brillante y perfil frutal intenso.', N'Ruibarbo, pomelo, melón verde, acidez elevada', 1700, 1900, 5, 11, 1, 6, 1, N'El café de Kenia es reconocido mundialmente por su acidez brillante, cuerpo completo y complejidad aromática. Las regiones de Kirinyaga y Nyeri, situadas en las faldas del Monte Kenia, producen algunos de los cafés más apreciados por catadores y baristas. El sistema cooperativo y el procesamiento lavado tradicional son claves en la calidad y consistencia de los cafés kenianos.

El café Kirinyaga AA, procesado en la Fábrica Kii de la cooperativa Rungeto, destaca por sus notas de ruibarbo, pomelo y melón verde, con una acidez de 90/100 y un aroma de 90/100. El tueste claro permite resaltar la viveza y la jugosidad del perfil, mientras que el balance y el retrogusto prolongado lo convierten en una experiencia sensorial memorable.

La selección manual de cerezas, la doble fermentación y el secado en camas africanas son prácticas habituales que contribuyen a la excelencia del café keniano.')
INSERT [cafe].[LoteCafe] ([Id], [Nombre], [Descripcion], [NotasCata], [AltitudMin], [AltitudMax], [RegionId], [ProductorId], [ProcesoId], [VariedadId], [TuesteId], [DescripcionExtendida]) VALUES (6, N'Café de Guatemala', N'Café equilibrado con notas dulces y acidez cítrica.', N'Cítrica, madera tenue, caramelo, floral, avinatado', 1500, 2000, 6, 12, 1, 2, 3, N'Guatemala es famosa por la diversidad de sus regiones cafetaleras, cada una con microclimas y suelos volcánicos que aportan perfiles sensoriales únicos. Huehuetenango, en el altiplano occidental, es especialmente valorada por su altitud (hasta 2,000 msnm) y la complejidad de sus cafés, que presentan acidez cítrica, cuerpo completo y notas a caramelo, miel y frutas.

El café de la Cooperativa Comal, en Huehuetenango, es un ejemplo de equilibrio y elegancia, con acidez de 85/100, cuerpo de 83/100 y notas aromáticas de 86/100. El procesamiento lavado y el tueste medio permiten una taza limpia, fragante y persistente, ideal para métodos de filtrado y espresso.

La tradición cafetalera guatemalteca y la organización en cooperativas han permitido mantener altos estándares de calidad y sostenibilidad, posicionando al país como un referente en el mercado internacional.')
INSERT [cafe].[LoteCafe] ([Id], [Nombre], [Descripcion], [NotasCata], [AltitudMin], [AltitudMax], [RegionId], [ProductorId], [ProcesoId], [VariedadId], [TuesteId], [DescripcionExtendida]) VALUES (7, N'Café de Costa Rica', N'Café limpio y elegante con acidez melosa.', N'Cítricos, chocolate, caramelo, floral, equilibrado', 1500, 1600, 7, 4, 1, 10, 3, N'Costa Rica, y en particular la región de Tarrazú, es reconocida por la producción de cafés de altura con perfiles sensoriales limpios, acidez melosa y aromas florales y frutales. El valle de Tarrazú, con altitudes entre 1,200 y 1,900 msnm, ofrece condiciones ideales para el desarrollo de cafés de alta densidad y complejidad.

La finca La Candelilla, gestionada por la familia Sánchez, produce un café lavado con notas de cítricos, chocolate y caramelo, acidez de 87/100 y aroma de 88/100. El cuerpo medio y el balance estructurado hacen de este café una referencia para quienes buscan elegancia y nitidez en la taza.

El procesamiento lavado y el secado al sol en patios son prácticas tradicionales que contribuyen a la claridad y la expresión del terroir en los cafés costarricenses.')
INSERT [cafe].[LoteCafe] ([Id], [Nombre], [Descripcion], [NotasCata], [AltitudMin], [AltitudMax], [RegionId], [ProductorId], [ProcesoId], [VariedadId], [TuesteId], [DescripcionExtendida]) VALUES (8, N'Café de Honduras', N'Café dulce y balanceado con perfil clásico.', N'Chocolate, caramelo, floral, cuerpo cremoso', 1400, 1500, 8, 5, 2, 10, 2, N'Honduras ha experimentado una auténtica revolución en la calidad de sus cafés en la última década, pasando de ser un origen de volumen a un referente en el segmento de especialidad. Regiones como Copán, Santa Bárbara y Montecillos producen cafés con perfiles variados, desde achocolatados y florales hasta cítricos y tropicales.
La finca Santa Bárbara, de Samuel Mejía, destaca por su café natural con notas de chocolate, caramelo y floral, cuerpo cremoso y acidez de 85/100. El balance y el dulzor son elevados, lo que lo convierte en un café versátil tanto para espresso como para métodos de filtrado.
La apuesta por la trazabilidad, los microlotes y la experimentación en los procesos ha permitido a Honduras ganar reconocimiento internacional y acceder a mercados premium.
')
INSERT [cafe].[LoteCafe] ([Id], [Nombre], [Descripcion], [NotasCata], [AltitudMin], [AltitudMax], [RegionId], [ProductorId], [ProcesoId], [VariedadId], [TuesteId], [DescripcionExtendida]) VALUES (9, N'Café de Ruanda', N'Café elegante con acidez limpia y perfil floral.', N'Chocolate, maracuyá, floral, acidez limpia', 1650, 2100, 9, 10, 1, 2, 3, N'Ruanda, conocida como la tierra de las mil colinas, produce cafés de especialidad con perfiles florales, acidez limpia y dulzor fino. La variedad Bourbon, cultivada a altitudes superiores a 1,600 msnm, es la más extendida y apreciada por su equilibrio y elegancia. El procesamiento lavado y el secado en camas africanas son prácticas estándar que garantizan la calidad y la trazabilidad.

El café Muhororo, en Nyamasheke, es un ejemplo de la armonía entre tradición y naturaleza, con notas de chocolate y maracuyá, acidez de 86/100 y cuerpo de 85/100. El tueste medio resalta la frescura tropical y la textura sedosa, mientras que el balance y el retrogusto prolongado lo sitúan entre los mejores cafés africanos.

La cultura de la calidad y la profesionalización de las cooperativas han permitido a Ruanda competir de tú a tú con orígenes tradicionales como Colombia, Etiopía y Panamá.')
INSERT [cafe].[LoteCafe] ([Id], [Nombre], [Descripcion], [NotasCata], [AltitudMin], [AltitudMax], [RegionId], [ProductorId], [ProcesoId], [VariedadId], [TuesteId], [DescripcionExtendida]) VALUES (10, N'Café de Panamá', N'Café Geisha exclusivo con perfil floral y delicado.', N'Jazmín, fresa, nectarina, vainilla, toffee', 1600, 1700, 10, 6, 2, 5, 1, N'El café Geisha de Panamá es considerado uno de los más exquisitos y exclusivos del mundo, famoso por su perfil floral, acidez luminosa y complejidad aromática. La región de Boquete, en la provincia de Chiriquí, ofrece un microclima único que permite a la variedad Geisha expresar todo su potencial.

La finca Doña Elvira, en Alto Jaramillo, produce un Geisha natural con notas de jazmín, fresa, nectarina, vainilla y toffee. La acidez alcanza 92/100, el dulzor 93/100 y el aroma 94/100, con un balance y retrogusto excepcionales. El tueste claro es el preferido para resaltar la delicadeza y la transparencia de este café, que brilla especialmente en métodos de filtrado.

La historia del Geisha panameño es un ejemplo de cómo la innovación varietal y el enfoque en la calidad pueden transformar la reputación de un origen y posicionarlo en la cúspide del mercado global.')
INSERT [cafe].[LoteCafe] ([Id], [Nombre], [Descripcion], [NotasCata], [AltitudMin], [AltitudMax], [RegionId], [ProductorId], [ProcesoId], [VariedadId], [TuesteId], [DescripcionExtendida]) VALUES (11, N'Café de México', N'Café complejo con perfil floral y cítrico.', N'Bergamota, cítricos, miel', 1400, 1500, 11, 7, 3, 2, 2, N'México cuenta con una gran diversidad de regiones productoras, entre las que destacan Chiapas, Veracruz y Oaxaca. El auge del café de especialidad ha impulsado la producción de microlotes y la experimentación en los métodos de procesamiento, especialmente en Veracruz, donde la variedad Geisha ha alcanzado reconocimiento internacional.

La finca Pocitos, en Veracruz, bajo la dirección de Jesús Carlos Cadena Valdivia, produce un Geisha honey con notas florales, bergamota, cítricos y miel. La acidez es de 89/100, el dulzor de 90/100 y el aroma de 91/100. El balance y el retrogusto prolongado reflejan la calidad y la dedicación del productor.

La participación de México en la Taza de Excelencia y la profesionalización del sector han permitido posicionar al país como un origen de referencia en el segmento premium.')
INSERT [cafe].[LoteCafe] ([Id], [Nombre], [Descripcion], [NotasCata], [AltitudMin], [AltitudMax], [RegionId], [ProductorId], [ProcesoId], [VariedadId], [TuesteId], [DescripcionExtendida]) VALUES (12, N'Café de El Salvador', N'Café complejo con gran cuerpo y perfil floral.', N'Flores, frutos rojos', 1400, 1600, 12, 8, 1, 8, 3, N'El Salvador es el hogar de la variedad Pacamara, un híbrido de Pacas y Maragogipe que se ha convertido en un emblema del café de especialidad por su tamaño de grano y su perfil sensorial complejo. Regiones como Apaneca-Ilamatepec y Alotepec-Metapán producen cafés con acidez brillante, notas florales y frutales, y un cuerpo aterciopelado.

La finca Caporal, en Apaneca-Ilamatepec, destaca por su Pacamara lavado con notas de flores, frutos rojos y acidez vibrante. El cuerpo es de 87/100, el dulzor de 88/100 y el aroma de 89/100. El balance y el retrogusto largo son características distintivas de esta variedad, que ha ganado múltiples premios en competencias internacionales.

La innovación en el procesamiento y la apuesta por la trazabilidad han permitido a El Salvador mantener su reputación como productor de cafés excepcionales.')
INSERT [cafe].[LoteCafe] ([Id], [Nombre], [Descripcion], [NotasCata], [AltitudMin], [AltitudMax], [RegionId], [ProductorId], [ProcesoId], [VariedadId], [TuesteId], [DescripcionExtendida]) VALUES (13, N'Café de Nicaragua', N'Café equilibrado con notas dulces y achocolatadas.', N'Chocolate, azúcar moreno', 1200, 1300, 13, 9, 1, 3, 3, N'Nicaragua, y en particular la región de Jinotega, es reconocida por la producción de cafés de altura con perfiles balanceados, acidez cítrica y notas achocolatadas. La mayoría de los cafés se cultivan entre 1,200 y 1,500 msnm, en suelos volcánicos y bajo sombra, lo que favorece la complejidad y la sostenibilidad.

El café Las Mimosas, de pequeños productores en Jinotega, es un ejemplo de la tradición y la excelencia nicaragüense, con notas achocolatadas, acidez cítrica y azúcar moreno. El cuerpo es suave (82/100), el dulzor de 84/100 y el balance de 83/100. El procesamiento lavado y el tueste medio permiten una taza limpia y versátil.

La organización en cooperativas y la adopción de prácticas sostenibles han permitido a Nicaragua ganar reconocimiento en el mercado internacional de cafés de especialidad.')
INSERT [cafe].[LoteCafe] ([Id], [Nombre], [Descripcion], [NotasCata], [AltitudMin], [AltitudMax], [RegionId], [ProductorId], [ProcesoId], [VariedadId], [TuesteId], [DescripcionExtendida]) VALUES (14, N'Café de Tanzania', N'Café africano con acidez brillante y perfil frutal.', N'Uva, cereza, naranja, chocolate, acidez brillante', 1350, 1750, 14, 13, 1, 15, 1, N'Tanzania es famosa por sus cafés de altura, especialmente los cultivados en las laderas del Kilimanjaro. El peaberry tanzano es especialmente apreciado por su perfil complejo, acidez brillante y notas a frutas rojas, chocolate y cítricos. Las cooperativas Mamsera, Ushiri y Kirwa Keni, en la región de Kilimanjaro, producen cafés lavados de alta calidad.

El café Kilimanjaro Peaberry Classic destaca por sus notas de uva, cereza, naranja y chocolate, con una acidez de 83/100 y cuerpo de 83/100. El aroma frutal y el balance de 83/100 reflejan la riqueza del terroir y la precisión en el procesamiento.

El sistema cooperativo, la selección manual y el secado en camas africanas son prácticas que garantizan la calidad y la trazabilidad de los cafés tanzanos, que compiten en el segmento premium a nivel mundial.')
SET IDENTITY_INSERT [cafe].[LoteCafe] OFF
GO
INSERT [cafe].[SCA] ([LoteCafeId], [Acidez], [Cuerpo], [Dulzor], [Aroma], [Retrogusto], [Balance]) VALUES (1, CAST(92.00 AS Decimal(4, 2)), CAST(88.00 AS Decimal(4, 2)), CAST(90.00 AS Decimal(4, 2)), CAST(92.00 AS Decimal(4, 2)), CAST(90.00 AS Decimal(4, 2)), CAST(91.00 AS Decimal(4, 2)))
INSERT [cafe].[SCA] ([LoteCafeId], [Acidez], [Cuerpo], [Dulzor], [Aroma], [Retrogusto], [Balance]) VALUES (2, CAST(90.00 AS Decimal(4, 2)), CAST(88.00 AS Decimal(4, 2)), CAST(92.00 AS Decimal(4, 2)), CAST(91.00 AS Decimal(4, 2)), CAST(90.00 AS Decimal(4, 2)), CAST(91.00 AS Decimal(4, 2)))
INSERT [cafe].[SCA] ([LoteCafeId], [Acidez], [Cuerpo], [Dulzor], [Aroma], [Retrogusto], [Balance]) VALUES (3, CAST(87.00 AS Decimal(4, 2)), CAST(82.00 AS Decimal(4, 2)), CAST(88.00 AS Decimal(4, 2)), CAST(88.00 AS Decimal(4, 2)), CAST(86.00 AS Decimal(4, 2)), CAST(87.00 AS Decimal(4, 2)))
INSERT [cafe].[SCA] ([LoteCafeId], [Acidez], [Cuerpo], [Dulzor], [Aroma], [Retrogusto], [Balance]) VALUES (4, CAST(83.00 AS Decimal(4, 2)), CAST(83.00 AS Decimal(4, 2)), CAST(85.00 AS Decimal(4, 2)), CAST(88.00 AS Decimal(4, 2)), CAST(83.00 AS Decimal(4, 2)), CAST(80.00 AS Decimal(4, 2)))
INSERT [cafe].[SCA] ([LoteCafeId], [Acidez], [Cuerpo], [Dulzor], [Aroma], [Retrogusto], [Balance]) VALUES (5, CAST(90.00 AS Decimal(4, 2)), CAST(85.00 AS Decimal(4, 2)), CAST(88.00 AS Decimal(4, 2)), CAST(90.00 AS Decimal(4, 2)), CAST(87.00 AS Decimal(4, 2)), CAST(89.00 AS Decimal(4, 2)))
INSERT [cafe].[SCA] ([LoteCafeId], [Acidez], [Cuerpo], [Dulzor], [Aroma], [Retrogusto], [Balance]) VALUES (6, CAST(85.00 AS Decimal(4, 2)), CAST(83.00 AS Decimal(4, 2)), CAST(84.00 AS Decimal(4, 2)), CAST(86.00 AS Decimal(4, 2)), CAST(85.00 AS Decimal(4, 2)), CAST(84.00 AS Decimal(4, 2)))
INSERT [cafe].[SCA] ([LoteCafeId], [Acidez], [Cuerpo], [Dulzor], [Aroma], [Retrogusto], [Balance]) VALUES (7, CAST(88.00 AS Decimal(4, 2)), CAST(84.00 AS Decimal(4, 2)), CAST(87.00 AS Decimal(4, 2)), CAST(88.00 AS Decimal(4, 2)), CAST(87.00 AS Decimal(4, 2)), CAST(88.00 AS Decimal(4, 2)))
INSERT [cafe].[SCA] ([LoteCafeId], [Acidez], [Cuerpo], [Dulzor], [Aroma], [Retrogusto], [Balance]) VALUES (8, CAST(86.00 AS Decimal(4, 2)), CAST(85.00 AS Decimal(4, 2)), CAST(88.00 AS Decimal(4, 2)), CAST(86.00 AS Decimal(4, 2)), CAST(85.00 AS Decimal(4, 2)), CAST(87.00 AS Decimal(4, 2)))
INSERT [cafe].[SCA] ([LoteCafeId], [Acidez], [Cuerpo], [Dulzor], [Aroma], [Retrogusto], [Balance]) VALUES (9, CAST(85.00 AS Decimal(4, 2)), CAST(86.00 AS Decimal(4, 2)), CAST(87.00 AS Decimal(4, 2)), CAST(85.00 AS Decimal(4, 2)), CAST(84.00 AS Decimal(4, 2)), CAST(86.00 AS Decimal(4, 2)))
INSERT [cafe].[SCA] ([LoteCafeId], [Acidez], [Cuerpo], [Dulzor], [Aroma], [Retrogusto], [Balance]) VALUES (10, CAST(92.00 AS Decimal(4, 2)), CAST(88.00 AS Decimal(4, 2)), CAST(93.00 AS Decimal(4, 2)), CAST(94.00 AS Decimal(4, 2)), CAST(92.00 AS Decimal(4, 2)), CAST(93.00 AS Decimal(4, 2)))
INSERT [cafe].[SCA] ([LoteCafeId], [Acidez], [Cuerpo], [Dulzor], [Aroma], [Retrogusto], [Balance]) VALUES (11, CAST(87.00 AS Decimal(4, 2)), CAST(85.00 AS Decimal(4, 2)), CAST(88.00 AS Decimal(4, 2)), CAST(89.00 AS Decimal(4, 2)), CAST(87.00 AS Decimal(4, 2)), CAST(88.00 AS Decimal(4, 2)))
INSERT [cafe].[SCA] ([LoteCafeId], [Acidez], [Cuerpo], [Dulzor], [Aroma], [Retrogusto], [Balance]) VALUES (12, CAST(88.00 AS Decimal(4, 2)), CAST(87.00 AS Decimal(4, 2)), CAST(88.00 AS Decimal(4, 2)), CAST(89.00 AS Decimal(4, 2)), CAST(87.00 AS Decimal(4, 2)), CAST(88.00 AS Decimal(4, 2)))
INSERT [cafe].[SCA] ([LoteCafeId], [Acidez], [Cuerpo], [Dulzor], [Aroma], [Retrogusto], [Balance]) VALUES (13, CAST(83.00 AS Decimal(4, 2)), CAST(82.00 AS Decimal(4, 2)), CAST(84.00 AS Decimal(4, 2)), CAST(83.00 AS Decimal(4, 2)), CAST(82.00 AS Decimal(4, 2)), CAST(83.00 AS Decimal(4, 2)))
INSERT [cafe].[SCA] ([LoteCafeId], [Acidez], [Cuerpo], [Dulzor], [Aroma], [Retrogusto], [Balance]) VALUES (14, CAST(85.00 AS Decimal(4, 2)), CAST(83.00 AS Decimal(4, 2)), CAST(86.00 AS Decimal(4, 2)), CAST(87.00 AS Decimal(4, 2)), CAST(85.00 AS Decimal(4, 2)), CAST(85.00 AS Decimal(4, 2)))
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20260329152947_InitialMigration', N'8.0.25')
GO
SET IDENTITY_INSERT [maestra].[Proceso] ON 

INSERT [maestra].[Proceso] ([Id], [Nombre], [Descripcion]) VALUES (1, N'Lavado', N'Proceso donde la pulpa se elimina antes del secado, produciendo cafés limpios y con acidez brillante.')
INSERT [maestra].[Proceso] ([Id], [Nombre], [Descripcion]) VALUES (2, N'Natural', N'Proceso donde el café se seca con la pulpa intacta, generando perfiles más dulces y afrutados.')
INSERT [maestra].[Proceso] ([Id], [Nombre], [Descripcion]) VALUES (3, N'Honey', N'Proceso intermedio donde parte del mucílago se mantiene durante el secado, aportando dulzor y cuerpo.')
INSERT [maestra].[Proceso] ([Id], [Nombre], [Descripcion]) VALUES (4, N'Anaeróbico', N'Proceso de fermentación en ausencia de oxígeno que permite perfiles complejos, intensos y únicos.')
SET IDENTITY_INSERT [maestra].[Proceso] OFF
GO
SET IDENTITY_INSERT [maestra].[Tueste] ON 

INSERT [maestra].[Tueste] ([Id], [Nombre], [Descripcion]) VALUES (1, N'Claro', N'Tueste ligero que preserva las características originales del grano, destacando acidez y notas frutales.')
INSERT [maestra].[Tueste] ([Id], [Nombre], [Descripcion]) VALUES (2, N'Medio claro', N'Equilibrio entre acidez y dulzor, mantiene características de origen con mayor desarrollo de azúcares.')
INSERT [maestra].[Tueste] ([Id], [Nombre], [Descripcion]) VALUES (3, N'Medio', N'Tueste equilibrado que resalta dulzor, cuerpo y balance, con acidez moderada.')
SET IDENTITY_INSERT [maestra].[Tueste] OFF
GO
SET IDENTITY_INSERT [maestra].[Variedad] ON 

INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (1, N'Typica', N'Arábica', N'Una de las variedades más antiguas, con perfil limpio, suave y balanceado. Muy extendida en América Latina.')
INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (2, N'Bourbon', N'Arábica', N'Variedad tradicional conocida por su dulzor, equilibrio y cuerpo medio. Base genética de muchas otras variedades.')
INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (3, N'Caturra', N'Arábica', N'Mutación del Bourbon, de menor tamaño y mayor productividad. Perfil brillante con buena acidez.')
INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (4, N'Castillo', N'Arábica', N'Variedad desarrollada en Colombia resistente a enfermedades. Perfil balanceado con buena acidez y cuerpo medio.')
INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (5, N'Geisha', N'Arábica', N'Variedad originaria de Etiopía, famosa por su perfil floral (jazmín), notas a té y alta complejidad. Muy valorada en cafés de especialidad.')
INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (6, N'SL28', N'Arábica', N'Variedad keniana muy apreciada por su acidez brillante, notas a frutas negras y gran complejidad.')
INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (7, N'SL34', N'Arábica', N'Similar a SL28 pero con más cuerpo y menor acidez. Muy usada en Kenia.')
INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (8, N'Pacamara', N'Arábica', N'Híbrido de Pacas y Maragogipe. Grano grande con perfil complejo, notas frutales y especiadas.')
INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (9, N'Mundo Novo', N'Arábica', N'Híbrido de Typica y Bourbon, muy productivo. Perfil clásico, con buen cuerpo y dulzor.')
INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (10, N'Catuai', N'Arábica', N'Híbrido de Mundo Novo y Caturra. Muy cultivado en Brasil, con perfil equilibrado y buena resistencia.')
INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (11, N'Heirloom', N'Arábica', N'Término usado en Etiopía para referirse a variedades autóctonas no clasificadas. Perfil complejo, floral y frutal.')
INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (12, N'Maragogipe', N'Arábica', N'Conocida por sus granos gigantes y perfil suave, con menor intensidad pero gran elegancia.')
INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (13, N'Villa Sarchí', N'Arábica', N'Mutación del Bourbon originaria de Costa Rica. Perfil limpio con acidez brillante.')
INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (14, N'Ethiopian Landrace', N'Arábica', N'Variedades tradicionales etíopes con perfiles extremadamente complejos, florales y frutales.')
INSERT [maestra].[Variedad] ([Id], [Nombre], [Especie], [Descripcion]) VALUES (15, N'Kent', N'Arábica', N'Variedad tradicional de Coffea arabica desarrollada en India y ampliamente cultivada en África oriental, especialmente en Tanzania. Se caracteriza por su buena resistencia a enfermedades, acidez brillante y perfil en taza con notas frutales, cítricas y especiadas. Muy utilizada en cafés de altura.')
SET IDENTITY_INSERT [maestra].[Variedad] OFF
GO
SET IDENTITY_INSERT [origen].[Pais] ON 

INSERT [origen].[Pais] ([Id], [Nombre], [CodigoISO]) VALUES (1, N'Perú', N'PE')
INSERT [origen].[Pais] ([Id], [Nombre], [CodigoISO]) VALUES (2, N'Colombia', N'CO')
INSERT [origen].[Pais] ([Id], [Nombre], [CodigoISO]) VALUES (3, N'Etiopía', N'ET')
INSERT [origen].[Pais] ([Id], [Nombre], [CodigoISO]) VALUES (4, N'Brasil', N'BR')
INSERT [origen].[Pais] ([Id], [Nombre], [CodigoISO]) VALUES (5, N'Kenia', N'KE')
INSERT [origen].[Pais] ([Id], [Nombre], [CodigoISO]) VALUES (6, N'Guatemala', N'GT')
INSERT [origen].[Pais] ([Id], [Nombre], [CodigoISO]) VALUES (7, N'Costa Rica', N'CR')
INSERT [origen].[Pais] ([Id], [Nombre], [CodigoISO]) VALUES (8, N'Honduras', N'HN')
INSERT [origen].[Pais] ([Id], [Nombre], [CodigoISO]) VALUES (9, N'Ruanda', N'RW')
INSERT [origen].[Pais] ([Id], [Nombre], [CodigoISO]) VALUES (10, N'Panamá', N'PA')
INSERT [origen].[Pais] ([Id], [Nombre], [CodigoISO]) VALUES (11, N'México', N'MX')
INSERT [origen].[Pais] ([Id], [Nombre], [CodigoISO]) VALUES (12, N'El Salvador', N'SV')
INSERT [origen].[Pais] ([Id], [Nombre], [CodigoISO]) VALUES (13, N'Nicaragua', N'NI')
INSERT [origen].[Pais] ([Id], [Nombre], [CodigoISO]) VALUES (14, N'Tanzania', N'TZ')
SET IDENTITY_INSERT [origen].[Pais] OFF
GO
SET IDENTITY_INSERT [origen].[Productor] ON 

INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (1, N'Finca Miguel Padilla (Miguel Padilla Chinguel)', N'Finca familiar en Cajamarca enfocada en la producción de café de especialidad.', 1)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (2, N'Finca El Paraíso (Diego Bermúdez)', N'Finca colombiana reconocida por procesos experimentales e innovación en café de especialidad.', 1)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (3, N'Finca Corrego (Andreia Cunha Neves Careta)', N'Finca brasileña dedicada a la producción de café con enfoque en calidad y sostenibilidad.', 1)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (4, N'Finca La Candelilla (Familia Sánchez)', N'Finca costarricense con tradición familiar y producción de cafés de alta calidad.', 1)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (5, N'Finca Santa Bárbara (Samuel Mejía)', N'Productor hondureño centrado en cafés de especialidad cultivados en altura.', 1)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (6, N'Finca Doña Elvira (Familia Doña Elvira)', N'Finca familiar dedicada al cultivo tradicional de café en Centroamérica.', 1)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (7, N'Finca Pocitos (Jesús Carlos Cadena Valdivia)', N'Pequeña finca cafetera enfocada en producción artesanal de café de calidad.', 1)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (8, N'Finca Caporal (Familia Caporal)', N'Finca familiar con producción tradicional y enfoque en café de especialidad.', 1)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (9, N'Las Mimosas (pequeños productores)', N'Grupo de pequeños productores dedicados al cultivo de café en origen.', 1)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (10, N'Muhororo (pequeños productores)', N'Comunidad de pequeños productores de café en África oriental.', 1)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (11, N'Rungeto FCS', N'Sociedad cooperativa de Kenia que agrupa pequeños productores y estaciones de lavado.', 2)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (12, N'Cooperativa Comal', N'Cooperativa de productores que promueve comercio justo y café sostenible.', 2)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (13, N'Cooperativa Mamsera', N'Cooperativa africana enfocada en producción y procesamiento de café local.', 2)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (14, N'Cooperativa Ushiri', N'Asociación de productores dedicada al cultivo y comercialización de café.', 2)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (15, N'Cooperativa Kirwa Keni', N'Cooperativa regional que agrupa pequeños caficultores.', 2)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (16, N'Ephtah Specialty Coffee', N'Empresa dedicada a la producción y exportación de café de especialidad.', 3)
INSERT [origen].[Productor] ([Id], [Nombre], [DescripcionBreve], [TipoProductorId]) VALUES (17, N'Fábrica Kii', N'Estación de lavado en Kenia especializada en procesamiento de café de alta calidad.', 3)
SET IDENTITY_INSERT [origen].[Productor] OFF
GO
SET IDENTITY_INSERT [origen].[Region] ON 

INSERT [origen].[Region] ([Id], [Nombre], [PaisId]) VALUES (1, N'Cajamarca', 1)
INSERT [origen].[Region] ([Id], [Nombre], [PaisId]) VALUES (2, N'Huila', 2)
INSERT [origen].[Region] ([Id], [Nombre], [PaisId]) VALUES (3, N'Sidamo', 3)
INSERT [origen].[Region] ([Id], [Nombre], [PaisId]) VALUES (4, N'Cerrado Mineiro', 4)
INSERT [origen].[Region] ([Id], [Nombre], [PaisId]) VALUES (5, N'Kirinyaga', 5)
INSERT [origen].[Region] ([Id], [Nombre], [PaisId]) VALUES (6, N'Huehuetenango', 6)
INSERT [origen].[Region] ([Id], [Nombre], [PaisId]) VALUES (7, N'Tarrazú', 7)
INSERT [origen].[Region] ([Id], [Nombre], [PaisId]) VALUES (8, N'Copán', 8)
INSERT [origen].[Region] ([Id], [Nombre], [PaisId]) VALUES (9, N'Nyamasheke', 9)
INSERT [origen].[Region] ([Id], [Nombre], [PaisId]) VALUES (10, N'Boquete', 10)
INSERT [origen].[Region] ([Id], [Nombre], [PaisId]) VALUES (11, N'Veracruz', 11)
INSERT [origen].[Region] ([Id], [Nombre], [PaisId]) VALUES (12, N'Apaneca-Ilamatepec', 12)
INSERT [origen].[Region] ([Id], [Nombre], [PaisId]) VALUES (13, N'Jinotega', 13)
INSERT [origen].[Region] ([Id], [Nombre], [PaisId]) VALUES (14, N'Kilimanjaro', 14)
SET IDENTITY_INSERT [origen].[Region] OFF
GO
SET IDENTITY_INSERT [origen].[TipoProductor] ON 

INSERT [origen].[TipoProductor] ([Id], [Tipo]) VALUES (1, N'Finca')
INSERT [origen].[TipoProductor] ([Id], [Tipo]) VALUES (2, N'Cooperativa')
INSERT [origen].[TipoProductor] ([Id], [Tipo]) VALUES (3, N'Compañía')
SET IDENTITY_INSERT [origen].[TipoProductor] OFF
GO
ALTER TABLE [cafe].[LoteCafe]  WITH CHECK ADD  CONSTRAINT [FK_LoteCafe_Proceso] FOREIGN KEY([ProcesoId])
REFERENCES [maestra].[Proceso] ([Id])
GO
ALTER TABLE [cafe].[LoteCafe] CHECK CONSTRAINT [FK_LoteCafe_Proceso]
GO
ALTER TABLE [cafe].[LoteCafe]  WITH CHECK ADD  CONSTRAINT [FK_LoteCafe_Productor] FOREIGN KEY([ProductorId])
REFERENCES [origen].[Productor] ([Id])
GO
ALTER TABLE [cafe].[LoteCafe] CHECK CONSTRAINT [FK_LoteCafe_Productor]
GO
ALTER TABLE [cafe].[LoteCafe]  WITH CHECK ADD  CONSTRAINT [FK_LoteCafe_Region] FOREIGN KEY([RegionId])
REFERENCES [origen].[Region] ([Id])
GO
ALTER TABLE [cafe].[LoteCafe] CHECK CONSTRAINT [FK_LoteCafe_Region]
GO
ALTER TABLE [cafe].[LoteCafe]  WITH CHECK ADD  CONSTRAINT [FK_LoteCafe_Tueste] FOREIGN KEY([TuesteId])
REFERENCES [maestra].[Tueste] ([Id])
GO
ALTER TABLE [cafe].[LoteCafe] CHECK CONSTRAINT [FK_LoteCafe_Tueste]
GO
ALTER TABLE [cafe].[LoteCafe]  WITH CHECK ADD  CONSTRAINT [FK_LoteCafe_Variedad] FOREIGN KEY([VariedadId])
REFERENCES [maestra].[Variedad] ([Id])
GO
ALTER TABLE [cafe].[LoteCafe] CHECK CONSTRAINT [FK_LoteCafe_Variedad]
GO
ALTER TABLE [cafe].[SCA]  WITH NOCHECK ADD  CONSTRAINT [FK_SCA_LoteCafe] FOREIGN KEY([LoteCafeId])
REFERENCES [cafe].[LoteCafe] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [cafe].[SCA] CHECK CONSTRAINT [FK_SCA_LoteCafe]
GO
ALTER TABLE [origen].[Productor]  WITH CHECK ADD  CONSTRAINT [FK_Productor_TipoProductor] FOREIGN KEY([TipoProductorId])
REFERENCES [origen].[TipoProductor] ([Id])
GO
ALTER TABLE [origen].[Productor] CHECK CONSTRAINT [FK_Productor_TipoProductor]
GO
ALTER TABLE [origen].[Region]  WITH CHECK ADD  CONSTRAINT [FK_Region_Pais] FOREIGN KEY([PaisId])
REFERENCES [origen].[Pais] ([Id])
GO
ALTER TABLE [origen].[Region] CHECK CONSTRAINT [FK_Region_Pais]
GO
USE [master]
GO
ALTER DATABASE [WorldCoffeeDB] SET  READ_WRITE 
GO