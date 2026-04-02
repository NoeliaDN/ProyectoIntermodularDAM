namespace WCA.Domain.Entities
{
    public class Region
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = null!;
        public int PaisId { get; set; }

        public Pais Pais { get; set; } = null!;
        public ICollection<CafeLote> LotesCafe { get; set; } = new List<CafeLote>();
    }
}
