namespace WCA.Domain.Entities
{
    public class Variedad
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = null!;
        public string Especie { get; set; } = null!;
        public string? Descripcion { get; set; }

        public ICollection<CafeLote> LotesCafe { get; set; } = new List<CafeLote>();
        

    }
}
