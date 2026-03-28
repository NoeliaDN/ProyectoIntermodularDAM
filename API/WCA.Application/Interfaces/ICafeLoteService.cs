using WCA.Application.DTOs;

namespace WCA.Application.Interfaces;
public interface ICafeLoteService
{
    Task<IEnumerable<CafeLoteDto>> GetAllAsync(CancellationToken ct = default);

}