namespace WCA.Domain.Entities
{
    public class TipoProductor
    {
        public int Id { get; set; }
        public string Tipo { get; set; } = null!;

        public ICollection<Productor> Productores { get; set; } = new List<Productor>();
    }
}
