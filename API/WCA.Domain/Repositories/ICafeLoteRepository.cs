using WCA.Domain.Entities;

namespace WCA.Domain.Repositories
{
    public interface ICafeLoteRepository
    {
        //Task<IReadOnlyList<CafeLote>> GetAllAsync(CancellationToken ct = default);

        Task<IReadOnlyList<CafeLote>> GetAllCoffeesAsync(CancellationToken ct = default);
        Task<CafeLote?> GetOneCoffeeByIdAsync(int id, CancellationToken ct = default);
    }
}
