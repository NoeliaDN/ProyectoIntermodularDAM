namespace WCA.Application.DTOs
{
    public class CafeLoteDto
    {
        public int Id { get; set; }
        public string Nombre { get; set; } = null!;
        public string? Descripcion { get; set; }
        public string? DescripcionExtendida { get; set; }
        public string? NotasCata { get; set; }
        public int AltitudMin { get; set; }
        public int AltitudMax { get; set; }
        public decimal AltitudMedia { get; set; }
        public string? Pais { get; set; }
        public string? Region { get; set; }
        public string? Productor { get; set; }
        public string? Proceso { get; set; }

        public string? ProcesoDescripcion { get; set; }
        public string? Variedad { get; set; }
        public string? Tueste { get; set; }

    }
}
