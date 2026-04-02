using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WCA.Domain.Entities;

namespace WCA.Infrastructure.EntityConfigurations
{
    public class ProductorConfiguration : IEntityTypeConfiguration<Productor>
    {
        public void Configure(EntityTypeBuilder<Productor> builder)
        {
            builder.ToTable("Productor", "origen");
            builder.HasKey(p => p.Id);

            builder.Property(p => p.Nombre)
                   .IsRequired()
                   .HasMaxLength(150);

            // Si decides añadir AnioFundacion en la entidad:
            builder.Property<int?>("AnioFundacion");

            builder.HasOne(p => p.TipoProductor)
                   .WithMany(t => t.Productores)
                   .HasForeignKey(p => p.TipoProductorId);
        }
    }
}
