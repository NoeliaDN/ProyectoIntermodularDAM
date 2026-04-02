using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WCA.Domain.Entities;

namespace WCA.Infrastructure.EntityConfigurations
{
    public class TipoProductorConfiguration : IEntityTypeConfiguration<TipoProductor>
    {
        public void Configure(EntityTypeBuilder<TipoProductor> builder)
        {
            builder.ToTable("TipoProductor", "origen");
            builder.HasKey(t => t.Id);

            builder.Property(t => t.Tipo)
                   .IsRequired()
                   .HasMaxLength(100);
        }
    }

}
