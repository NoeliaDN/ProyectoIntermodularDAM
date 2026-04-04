using WCA.Application.DTOs;

namespace WCA.Application.Interfaces
{
    public interface ICafeDetallesService
    {
        Task<string?> GetVariedadNombreByIdAsync(int id, CancellationToken ct = default);
        Task<CafeDetalleDto?> GetDetallesByVariedadIdAsync(int variedadId, CancellationToken ct = default);
    }
}
