using WCA.Application.DTOs;

namespace WCA.Application.Interfaces;
public interface ICafeLoteService
{
    Task<IReadOnlyList<CafeNombreDto>> GetAllCoffeeNamesAsync(CancellationToken ct = default);

    Task<CafeLoteDto?> GetCoffeeInfoByIdAsync(int id, CancellationToken ct = default);

    Task<CafeDetalleDto?> GetCoffeeDetailAsync(int id, CancellationToken ct = default);

}