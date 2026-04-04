using Microsoft.AspNetCore.Mvc;
using System.Runtime.InteropServices;
using WCA.Application.DTOs;
using WCA.Application.Interfaces;

namespace WCA.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class VariedadesController : ControllerBase
    {
        private readonly ICafeDetallesService _cafeDetallesService;

        public VariedadesController(ICafeDetallesService cafeDetallesService)
        {
            _cafeDetallesService = cafeDetallesService;
        }

        // GET api/variedades/{id}/detalles
        [HttpGet("{id:int}/detalles")]
        [ProducesResponseType(typeof(CafeDetalleDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetDetalles(int id, CancellationToken ct)
        {
            var result = await _cafeDetallesService.GetDetallesByVariedadIdAsync(id, ct);
            if (result is null) return NotFound();

            return Ok(result);
        }
    }
}