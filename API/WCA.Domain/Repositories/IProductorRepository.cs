using WCA.Domain.Entities;

namespace WCA.Domain.Repositories
{
    public interface IProductorRepository
    {

        Task<IReadOnlyList<Productor>> GetAllProductoresAsync(CancellationToken ct = default);
        Task<Productor?> GetOneByProductorIdAsync(int id, CancellationToken ct = default);

    }
}
