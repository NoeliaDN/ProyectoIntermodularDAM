using WCA.Application.DTOs;

namespace WCA.Application.Services
{
    public interface IPerfilSCAService
    {
        Task<SCADto?> GetCoffeeSCAByIdAsync(int id, CancellationToken ct = default);

    }
}
