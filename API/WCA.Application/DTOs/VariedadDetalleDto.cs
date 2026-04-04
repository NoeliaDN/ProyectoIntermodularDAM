using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WCA.Application.DTOs
{
    public class VariedadDetalleDto
    {
        public int VariedadId { get; set; }
        public string Variedad { get; set; } = string.Empty;
        public string Especie { get; set; } = string.Empty;
        public string? VariedadDescripcion { get; set; } = string.Empty;
                

    }
}
