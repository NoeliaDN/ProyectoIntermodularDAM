using Microsoft.EntityFrameworkCore;
using WCA.Application.DTOs;
using WCA.Application.Interfaces;
using WCA.Domain.Repositories;
using WCA.Infrastructure.Data;
using WCA.Infrastructure.Repositories;

namespace WCA.Infrastructure.Services
{
    public  class PerfilSCAService : IPerfilSCAService
    {
        private readonly ISCARepository _scaRepository;

        public PerfilSCAService(ISCARepository scaRepository)
        {
            _scaRepository = scaRepository;
        }

        public async Task<SCADto?> GetCoffeeSCAByIdAsync(int id, CancellationToken ct = default)
        {
            var sca = await _scaRepository.GetOneByCoffeeIdAsync(id, ct);
            if (sca is null) return null;

            return new SCADto
            {
                Acidez = sca.Acidez,
                Cuerpo = sca.Cuerpo,
                Dulzor = sca.Dulzor,
                Aroma = sca.Aroma,
                Retrogusto = sca.Retrogusto,
                Balance = sca.Balance,
                PuntuacionSCA = sca.PuntuacionSCA
            };

        }
    }
}
