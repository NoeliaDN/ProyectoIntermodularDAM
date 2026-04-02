using WCA.Domain.Entities;

namespace WCA.Domain.Repositories
{
    public interface ISCARepository
    {
            Task<IReadOnlyList<SCA>> GetAllAsync(CancellationToken ct = default);
            Task<SCA?> GetOneByIdAsync(int id, CancellationToken ct = default);
    }
}
