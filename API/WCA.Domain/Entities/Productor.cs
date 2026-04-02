namespace WCA.Domain.Entities
{
    public class Productor
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = null!;

        public string? DescripcionBreve { get; set; }

        public int TipoProductorId { get; set; }

        public TipoProductor TipoProductor { get; set; } = null!;

        public ICollection<CafeLote> LotesCafe { get; set; } = new List<CafeLote>();

    }
}
