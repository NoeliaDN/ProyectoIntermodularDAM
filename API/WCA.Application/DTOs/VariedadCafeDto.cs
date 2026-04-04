namespace WCA.Application.DTOs
{
    public class VariedadCafeDto
    {
        public int CafeId { get; set; }
        public string CafeNombre { get; set; } = string.Empty;

        public string Productor { get; set; } = string.Empty;
        public string? ProductorDescripcion { get; set; } = string.Empty;
        public string TipoProductor { get; set; } = string.Empty;
        public string Region { get; set; } = string.Empty;
        public string Pais { get; set; } = string.Empty;
    }
}
