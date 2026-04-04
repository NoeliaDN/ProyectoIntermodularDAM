using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WCA.Application.DTOs
{
    public class CafeDetalleDto
    {
        public int CafeId { get; set; }
        public string CafeNombre { get; set; } = String.Empty;

        // Variedad:
        public int VariedadId { get; set; }
        public string Variedad { get; set; } = String.Empty;
        public string Especie { get; set; } = String.Empty;
        public string? VariedadDescripcion { get; set; } = String.Empty;


        // Productor + localización:
        public string Productor { get; set; } = default!;

        public string? ProductorDescripcion { get; set; } = default!;
        public string TipoProductor { get; set; } = default!;
        public string Region { get; set; } = default!;
        public string Pais { get; set; } = default!;
    }
}
