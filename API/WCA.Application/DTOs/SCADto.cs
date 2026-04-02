namespace WCA.Application.DTOs
{
    public class SCADto
    {
        public decimal Acidez { get; set; }
        public decimal Cuerpo { get; set; }
        public decimal Dulzor { get; set; }
        public decimal Aroma { get; set; }
        public decimal Retrogusto { get; set; }
        public decimal Balance { get; set; }
        public decimal PuntuacionSCA { get; set; } // calculado
    }
}
