using Microsoft.EntityFrameworkCore;
using WCA.Domain.Entities;
using WCA.Domain.Repositories;
using WCA.Infrastructure.Data;

namespace WCA.Infrastructure.Repositories
{
    public class CafeLoteRepository : ICafeLoteRepository
    {

        private readonly WCADbContext _context;

        public CafeLoteRepository(WCADbContext context)
        {
            _context = context;
        }

        public async Task<IReadOnlyList<CafeLote>> GetAllCoffeesAsync(CancellationToken ct = default)
        {
            return await _context.CafeLotes
            .AsNoTracking()
            .OrderBy(l => l.Nombre)
            .ToListAsync(ct);
        }

        public async Task<CafeLote?> GetOneCoffeeByIdAsync(int id, CancellationToken ct = default)
        {
            return await _context.CafeLotes
            .AsNoTracking()              
            .Include(l => l.Region).ThenInclude(r => r.Pais)
            .Include(l => l.Productor).ThenInclude(p => p.TipoProductor)
            .Include(l => l.Proceso)
            .Include(l => l.Tueste)
            .Include(l => l.Variedad)
            .FirstOrDefaultAsync(l => l.Id == id, ct);
        }
    }
}
