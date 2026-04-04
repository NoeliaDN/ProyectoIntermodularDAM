using Microsoft.EntityFrameworkCore;
using WCA.Domain.Entities;
using WCA.Domain.Repositories;
using WCA.Infrastructure.Data;

namespace WCA.Infrastructure.Repositories
{
    public class ProductorRepository : IProductorRepository
    {
        private readonly WCADbContext _context;


        public ProductorRepository(WCADbContext context)
        {
            _context = context;
        }

        public async Task<IReadOnlyList<Productor>> GetAllProductoresAsync(CancellationToken ct = default)
        {
            return await _context.Productores
                .AsNoTracking()
                .OrderBy(p => p.Nombre)
                .ToListAsync(ct);
        }

        public async Task<Productor?> GetOneByProductorIdAsync(int id, CancellationToken ct = default)
        {
            return await _context.Productores
                .AsNoTracking()
                .Include(p => p.TipoProductor)
                .FirstOrDefaultAsync(p => p.Id == id, ct);
        }
    }
}
