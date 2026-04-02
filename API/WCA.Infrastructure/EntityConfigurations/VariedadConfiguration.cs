using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WCA.Domain.Entities;

namespace WCA.Infrastructure.EntityConfigurations
{
    public class VariedadConfiguration : IEntityTypeConfiguration<Variedad>
    {
        public void Configure(EntityTypeBuilder<Variedad> builder)
        {
            builder.ToTable("Variedad", "maestra");
            builder.HasKey(v => v.Id);

            builder.Property(v => v.Nombre)
                   .IsRequired()
                   .HasMaxLength(100);

            builder.Property(v => v.Especie)
                   .IsRequired()
                   .HasMaxLength(50);

            builder.Property(v => v.Descripcion)
                   .HasMaxLength(500);
        }
    }
}
