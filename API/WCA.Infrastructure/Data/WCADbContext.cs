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

        // TOD0: Añadir DbSetS aquí:
        public DbSet<CafeLote> CafeLotes { get; set; } = null!;
        public DbSet<SCA> Scas { get; set; } = null!;


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.ApplyConfigurationsFromAssembly(typeof(WCADbContext).Assembly);
        }

    }
}
