using Microsoft.EntityFrameworkCore;
using WCA.Application.DTOs;
using WCA.Infrastructure.Data;

namespace WCA.Infrastructure.Services
{
    public  class PerfilSCAService
    {
        private readonly WCADbContext _context;

        public PerfilSCAService(WCADbContext context)
        {
            _context = context;
        }

        public async Task<SCADto?> GetCoffeeSCAByIdAsync(int id, CancellationToken ct = default)
        {
            var cafeLote = await _context.CafeLotes
                .AsNoTracking()
                .Include(cl => cl.Sca) // Incluir la entidad SCA relacionada
                .FirstOrDefaultAsync(cl => cl.Id == id, ct);
            if (cafeLote == null || cafeLote.Sca == null)
                return null;
            return new SCADto
            {
                Acidez = cafeLote.Sca.Acidez,
                Cuerpo = cafeLote.Sca.Cuerpo,
                Dulzor = cafeLote.Sca.Dulzor,
                Aroma = cafeLote.Sca.Aroma,
                Retrogusto = cafeLote.Sca.Retrogusto,
                Balance = cafeLote.Sca.Balance,
                PuntuacionSCA = cafeLote.Sca.PuntuacionSCA
            };

        }
    }
}
