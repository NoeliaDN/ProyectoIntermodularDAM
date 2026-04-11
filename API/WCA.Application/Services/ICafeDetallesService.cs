using WCA.Application.DTOs;
using WCA.Domain.Entities;

namespace WCA.Application.Services
{
    public interface ICafeDetallesService
    {
        // Task<string?> GetVariedadNombreByIdAsync(int id, CancellationToken ct = default);
        Task<IReadOnlyList<VariedadNombreDto>> GetAllVariedadesNombresAsync(CancellationToken ct = default);

        //Task<CafeDetalleDto?> GetDetallesByVariedadIdAsync(int variedadId, CancellationToken ct = default);
        Task<Variedad?> GetVariedadConDetallesAsync(int variedadId, CancellationToken ct = default);

    }
}
