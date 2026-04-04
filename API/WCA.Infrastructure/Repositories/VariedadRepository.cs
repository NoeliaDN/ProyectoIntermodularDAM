using Microsoft.EntityFrameworkCore;
using WCA.Domain.Entities;
using WCA.Domain.Repositories;
using WCA.Infrastructure.Data;

namespace WCA.Infrastructure.Repositories
{
    public class VariedadRepository : IVariedadRepository
    {

        private readonly WCADbContext _context;

        public VariedadRepository(WCADbContext context)
        {
            _context = context;

        }


        public async Task<IReadOnlyList<Variedad>> GetAllVariedadesAsync(CancellationToken ct = default)
        {
            return await _context.Variedades
                .AsNoTracking()
                .OrderBy(v => v.Nombre)
                .ToListAsync(ct);

        }

        public async Task<Variedad?> GetOneByVarietyIdAsync(int id, CancellationToken ct = default)
        {
            return await _context.Variedades
                .AsNoTracking()
                .FirstOrDefaultAsync(v => v.Id == id, ct);
        }

        public async Task<Variedad?> GetVariedadWithDetallesAsync(int variedadId, CancellationToken ct = default)
        {
            return await _context.Variedades
                .AsNoTracking()
                .Include(v => v.LotesCafe)
                    .ThenInclude(l => l.Productor)
                        .ThenInclude(p => p.TipoProductor)
                .Include(v => v.LotesCafe)
                    .ThenInclude(l => l.Region)
                        .ThenInclude(r => r.Pais)
                .FirstOrDefaultAsync(v => v.Id == variedadId, ct);
        }
    }
}
