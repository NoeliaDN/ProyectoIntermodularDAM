namespace WCA.Domain.Entities
{
    public class Pais
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = null!;
        public string CodigoISO { get; set; } = null!;

        public ICollection<Region> Regiones { get; set; } = new List<Region>();

    }
}
