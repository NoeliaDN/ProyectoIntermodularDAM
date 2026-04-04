using WCA.Domain.Entities;

namespace WCA.Domain.Repositories
{
    public interface IVariedadRepository
    {
        Task<IReadOnlyList<Variedad>> GetAllVariedadesAsync(CancellationToken ct = default);
        Task<Variedad?> GetOneByVarietyIdAsync(int id, CancellationToken ct = default);

        // Obtener una variedad con al menos un lote y sus relaciones:
        Task<Variedad?> GetVarietyWithDetailsAsync(int variedadId, CancellationToken ct = default);

    }
}
