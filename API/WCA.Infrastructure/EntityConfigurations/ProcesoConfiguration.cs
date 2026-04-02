using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WCA.Domain.Entities;

namespace WCA.Infrastructure.EntityConfigurations
{
    public class ProcesoConfiguration : IEntityTypeConfiguration<Proceso>
    {
        public void Configure(EntityTypeBuilder<Proceso> builder)
        {
            builder.ToTable("Proceso", "maestra");
            builder.HasKey(p => p.Id);

            builder.Property(p => p.Nombre)
                   .IsRequired()
                   .HasMaxLength(100);

            builder.Property(p => p.Descripcion)
                   .HasMaxLength(300);
        }

    }
}
