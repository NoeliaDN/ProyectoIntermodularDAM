using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WCA.Domain.Entities;

namespace WCA.Infrastructure.EntityConfigurations
{
    public class TuesteConfiguration : IEntityTypeConfiguration<Tueste>
    {
        public void Configure(EntityTypeBuilder<Tueste> builder)
        {
            builder.ToTable("Tueste", "maestra");
            builder.HasKey(t => t.Id);

            builder.Property(t => t.Nombre)
                   .IsRequired()
                   .HasMaxLength(50);

            builder.Property(t => t.Descripcion)
                   .HasMaxLength(200);
        }
    }
}
