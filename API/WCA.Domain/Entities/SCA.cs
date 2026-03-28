namespace WCA.Domain.Entities
{
    public class SCA
    {

        public int LoteCafeId { get; set; }
        public decimal Acidez { get; set; }
        public decimal Cuerpo { get; set; }
        public decimal Dulzor { get; set; }
        public decimal Aroma { get; set; }
        public decimal Retrogusto { get; set; }
        public decimal Balance { get; set; }        
        public decimal PuntuacionSCA { get; set; } // Columna calculada en BD

        public CafeLote? CafeLote { get; set; }  // Navegación a CafeLote (1:1)

    }
}
