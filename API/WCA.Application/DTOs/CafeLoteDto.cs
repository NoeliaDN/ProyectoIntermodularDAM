namespace WCA.Application.DTOs
{
    public class CafeLoteDto
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = null!;
        public string? Descripcion { get; set; }
        public string? NotasCata { get; set; }
        public int AltitudMin { get; set; }
        public int AltitudMax { get; set; }
        public int RegionId { get; set; }
        public int ProductorId { get; set; }
        public int ProcesoId { get; set; }
        public int VariedadId { get; set; }
        public int TuesteId { get; set; }
        public decimal AltitudMedia { get; set; }
        public string? DescripcionExtendida { get; set; }
    }
}
