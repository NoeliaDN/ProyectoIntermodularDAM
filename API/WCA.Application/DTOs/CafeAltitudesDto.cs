using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WCA.Application.DTOs
{
    public class CafeAltitudesDto
    {
        public int CafeId { get; set; }

        public string CafeNombre { get; set; } = String.Empty;

        public int AltitudMin { get; set; }

        public int AltitudMax { get; set; }

        public decimal AltitudMedia { get; set; }

        public string? PaisISO { get; set; }

    }
}
