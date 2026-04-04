namespace WCA.Application.DTOs
{
    public class VariedadConCafesDto
    {
        public int VariedadId { get; set; }
        public string VariedadNombre { get; set; } = string.Empty;
        public string Especie { get; set; } = string.Empty;
        public string? VariedadDescripcion { get; set; } = string.Empty;

        // Cafés que utilizan esta variedad (puede estar vacía)
        public IReadOnlyList<VariedadCafeDto> Cafes { get; set; } = new List<VariedadCafeDto>();
    }
}
