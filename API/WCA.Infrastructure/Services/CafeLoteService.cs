using Microsoft.EntityFrameworkCore;
using WCA.Application.DTOs;
using WCA.Application.Interfaces;
using WCA.Infrastructure.Data;
using WCA.Domain.Entities;

namespace WCA.Infrastructure.Services
{
    public class CafeLoteService : ICafeLoteService
    {
        private readonly WCADbContext _context;

        public CafeLoteService(WCADbContext context)
        {
            _context = context;
        }

        public async Task<string?> GetCoffeeNameByIdAsync(int id, CancellationToken ct = default)
        {
            var cafeLote = await _context.CafeLotes
                .AsNoTracking()
                .FirstOrDefaultAsync(cl => cl.Id == id, ct);
            return cafeLote?.Nombre;
        }

        public async Task<CafeLoteDto?> GetCoffeeInfoByIdAsync(int id, CancellationToken ct = default)
        {
            var cafeLote = await _context.CafeLotes
                .AsNoTracking()
                .FirstOrDefaultAsync(cl => cl.Id == id, ct);
            if (cafeLote == null)
                return null;
            return new CafeLoteDto
            {
                Id = cafeLote.Id,
                Nombre = cafeLote.Nombre,
                Descripcion = cafeLote.Descripcion,
                NotasCata = cafeLote.NotasCata,
                AltitudMin = cafeLote.AltitudMin,
                AltitudMax = cafeLote.AltitudMax,
                RegionId = cafeLote.RegionId,
                ProductorId = cafeLote.ProductorId,
                ProcesoId = cafeLote.ProcesoId,
                VariedadId = cafeLote.VariedadId,
                TuesteId = cafeLote.TuesteId,
                AltitudMedia = cafeLote.AltitudMedia,
                DescripcionExtendida = cafeLote.DescripcionExtendida
            };
        }
        
    }
}
