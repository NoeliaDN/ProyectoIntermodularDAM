using WCA.Application.DTOs;

namespace WCA.Application.Interfaces
{
    public interface IPerfilSCAService
    {
        Task<SCADto?> GetCoffeeSCAByIdAsync(int id, CancellationToken ct = default);

    }
}
