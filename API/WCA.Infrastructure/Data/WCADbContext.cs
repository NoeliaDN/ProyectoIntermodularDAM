using Microsoft.EntityFrameworkCore;
using WCA.Domain.Entities;

namespace WCA.Infrastructure.Data
{
    public class WCADbContext : DbContext
    {
        public WCADbContext(DbContextOptions<WCADbContext> options)
            : base(options)
        {
        }
        //DBSets:
        public DbSet<CafeLote> CafeLotes => Set<CafeLote>();
        public DbSet<SCA> Scas => Set<SCA>();
        public DbSet<Region> Regiones => Set<Region>();
        public DbSet<Pais> Paises => Set<Pais>();
        public DbSet<Productor> Productores => Set<Productor>();
        public DbSet<TipoProductor> TiposProductor => Set<TipoProductor>();
        public DbSet<Proceso> Procesos => Set<Proceso>();
        public DbSet<Tueste> Tuestes => Set<Tueste>();
        public DbSet<Variedad> Variedades => Set<Variedad>();


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.ApplyConfigurationsFromAssembly(typeof(WCADbContext).Assembly);
        }

    }
}
