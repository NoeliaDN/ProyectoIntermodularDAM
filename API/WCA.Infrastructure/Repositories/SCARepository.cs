using Microsoft.EntityFrameworkCore;
using WCA.Domain.Entities;
using WCA.Domain.Repositories;
using WCA.Infrastructure.Data;

namespace WCA.Infrastructure.Repositories
{
    public class SCARepository : ISCARepository
    {
        private readonly WCADbContext _context;

        public SCARepository(WCADbContext context)
        {
            _context = context;
        }

        public async Task<IReadOnlyList<SCA>> GetAllAsync(CancellationToken ct = default)
        {
            return await _context.Scas
               .AsNoTracking()
            .ToListAsync(ct);
        }

        public async Task<SCA?> GetOneByIdAsync(int cafeId, CancellationToken ct = default)
        {
            return await _context.Scas
                .AsNoTracking()
            .FirstOrDefaultAsync(s => s.LoteCafeId == cafeId, ct);

        }
    }
}
