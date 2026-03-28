using Microsoft.EntityFrameworkCore;
using WCA.Application.DTOs;
using WCA.Application.Interfaces;
using WCA.Infrastructure.Data;

namespace WCA.Infrastructure.Services
{
    public class CafeLoteService : ICafeLoteService
    {

        private readonly WCADbContext _db;

        public CafeLoteService(WCADbContext db) => _db = db;

        public async Task<IEnumerable<CafeLoteDto>> GetAllAsync(CancellationToken ct = default)
        {
            return await _db.CafeLotes
                .AsNoTracking()
                .Select(e => new CafeLoteDto
                {
                    Id = e.Id,
                    Nombre = e.Nombre,
                    Descripcion = e.Descripcion,
                    NotasCata = e.NotasCata,
                    AltitudMin = e.AltitudMin,
                    AltitudMax = e.AltitudMax,
                    RegionId = e.RegionId,
                    ProductorId = e.ProductorId,
                    ProcesoId = e.ProcesoId,
                    VariedadId = e.VariedadId,
                    TuesteId = e.TuesteId,
                    AltitudMedia = e.AltitudMedia,
                    DescripcionExtendida = e.DescripcionExtendida
                })
                .ToListAsync(ct);
        }
    }
}
