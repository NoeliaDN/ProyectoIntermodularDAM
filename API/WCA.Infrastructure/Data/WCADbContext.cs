using Microsoft.EntityFrameworkCore;

namespace WCA.Infrastructure.Data
{
    public class WCADbContext : DbContext
    {
        public WCADbContext(DbContextOptions<WCADbContext> options)
            : base(options)
        {
        }

        // TOD0: Añade tus DbSet aquí:

    }
}
