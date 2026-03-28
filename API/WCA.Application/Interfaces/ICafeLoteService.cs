using WCA.Application.DTOs;

namespace WCA.Application.Interfaces;
public interface ICafeLoteService
{
    Task<string?> GetCoffeeNameByIdAsync(int id, CancellationToken ct = default);
    Task<CafeLoteDto?> GetCoffeeInfoByIdAsync(int id, CancellationToken ct = default);

}