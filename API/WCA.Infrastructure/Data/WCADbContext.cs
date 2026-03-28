using Microsoft.EntityFrameworkCore;

namespace WCA.Infrastructure.Data
{
    public class WCADbContext : DbContext
    {
        public WCADbContext(DbContextOptions<WCADbContext> options)
            : base(options)
        {
        }

        // TOD0: Añadir DbSet aquí:

    }
}
