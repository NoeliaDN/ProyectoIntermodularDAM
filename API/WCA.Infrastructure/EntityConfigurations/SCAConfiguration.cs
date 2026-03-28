using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WCA.Domain.Entities;


namespace WCA.Infrastructure.EntityConfigurations
{
    public class SCAConfiguration : IEntityTypeConfiguration<SCA>
    {
        public void Configure(EntityTypeBuilder<SCA> builder)
        {
            builder.ToTable("SCA", "cafe");
            builder.HasKey(s => s.LoteCafeId);

            builder.Property(s => s.Acidez).HasPrecision(4, 2);
            builder.Property(s => s.Cuerpo).HasPrecision(4, 2);
            builder.Property(s => s.Dulzor).HasPrecision(4, 2);
            builder.Property(s => s.Aroma).HasPrecision(4, 2);
            builder.Property(s => s.Retrogusto).HasPrecision(4, 2);
            builder.Property(s => s.Balance).HasPrecision(4, 2);

            //Columna calculada:
            builder.Property(s => s.PuntuacionSCA)
                   .HasComputedColumnSql("CONVERT([decimal](4,2),round(((((([Acidez]+[Cuerpo])+[Dulzor])+[Aroma])+[Retrogusto])+[Balance])/(6.0),(2)))", stored: false);
            
            //Relación:
            builder.HasOne(s => s.CafeLote)
                   .WithOne(c => c.Sca)
                   .HasForeignKey<SCA>(s => s.LoteCafeId);
        }
    
    }
}
