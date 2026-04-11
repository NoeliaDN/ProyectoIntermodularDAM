using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WCA.Domain.Entities;

namespace WCA.Infrastructure.EntityConfigurations
{
    public class CafeLoteConfiguration : IEntityTypeConfiguration<CafeLote>
    {
        public void Configure(EntityTypeBuilder<CafeLote> builder)
        {
            builder.ToTable("LoteCafe", "cafe");
            builder.HasKey(e => e.Id);

            builder.Property(e => e.Nombre).IsRequired().HasMaxLength(150);
            builder.Property(e => e.Descripcion).HasMaxLength(500);
            builder.Property(e => e.NotasCata).HasMaxLength(300);
            builder.Property(e => e.DescripcionExtendida).HasColumnType("NVARCHAR(MAX)");

            // Columna calculada
            builder.Property(e => e.AltitudMedia)
                .HasColumnType("decimal(10,2)")
                   .HasComputedColumnSql("([AltitudMin]+[AltitudMax])/(2.0)", stored: false);
        }
    }
}
