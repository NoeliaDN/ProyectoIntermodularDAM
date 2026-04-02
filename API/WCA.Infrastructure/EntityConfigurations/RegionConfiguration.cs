using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WCA.Domain.Entities;

namespace WCA.Infrastructure.EntityConfigurations
{
    public class RegionConfiguration : IEntityTypeConfiguration<Region>
    {
        public void Configure(EntityTypeBuilder<Region> builder)
        {
            builder.ToTable("Region", "origen");
            builder.HasKey(r => r.Id);

            builder.Property(r => r.Nombre)
                   .IsRequired()
                   .HasMaxLength(100);

            builder.HasOne(r => r.Pais)
                   .WithMany(p => p.Regiones)
                   .HasForeignKey(r => r.PaisId);
        }
    }
}
