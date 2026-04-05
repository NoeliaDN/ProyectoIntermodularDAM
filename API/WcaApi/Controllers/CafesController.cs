using Microsoft.AspNetCore.Mvc;
using WCA.Application.DTOs;
using WCA.Application.Interfaces;

namespace WCA.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CafesController : ControllerBase
    {
        private readonly ICafeLoteService _cafeLoteService;

        public CafesController(ICafeLoteService cafeLoteService)
        {
            _cafeLoteService = cafeLoteService;
           
        }

        /// <summary>
        /// Obtiene la lista de todos los cafés disponibles (solo Id y nombre).
        /// </summary>
        /// <remarks>
        /// Este endpoint se utiliza para rellenar el selector de cafés en el front.
        /// </remarks>
        /// <param name="ct">Token de cancelación.</param>
        /// <returns>Lista de cafés con Id y Nombre.</returns>
        /// <response code="200">Devuelve la lista de cafés.</response>
        [HttpGet("nombres")]
        [ProducesResponseType(typeof(IReadOnlyList<CafeNombreDto>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetNombres(CancellationToken ct)
        {
            var result = await _cafeLoteService.GetAllCoffeeNamesAsync(ct);
            return Ok(result);
        }

        /// <summary>
        /// Obtiene la información principal de un café (sin perfil SCA).
        /// </summary>
        /// <remarks>
        /// Incluye datos generales del lote: descripción, notas de cata, altitudes, etc.
        /// </remarks>
        /// <param name="id">Identificador del café (LoteCafeId).</param>
        /// <param name="ct">Token de cancelación.</param>
        /// <returns>Datos del café.</returns>
        /// <response code="200">Devuelve los datos del café.</response>
        [HttpGet("info/{id:int}")] // GET api/cafes/info/{id}
        [ProducesResponseType(typeof(CafeLoteDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetCafeInfo(int id, CancellationToken ct)
        {
            var result = await _cafeLoteService.GetCoffeeInfoByIdAsync(id, ct);
            if (result is null) return NotFound();

            return Ok(result);
        }

        
        /// <summary>
        /// Obtiene la información de variedad, productor y localización de un café.
        /// </summary>
        /// <remarks>
        /// Este endpoint se utiliza en la página de detalle para mostrar información
        /// de variedad, tipo de productor, región y país, junto con mapas de Power BI.
        /// </remarks>
        /// <param name="id">Identificador del café (LoteCafeId).</param>
        /// <param name="ct">Token de cancelación.</param>
        /// <returns>Detalle de variedad, productor y origen del café.</returns>
        /// <response code="200">Devuelve el detalle de variedad y productor.</response>
        [HttpGet("{id:int}/detalle")]
        [ProducesResponseType(typeof(CafeDetalleDto), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetCafeDetalle(int id, CancellationToken ct)
        {
            var result = await _cafeLoteService.GetCoffeeDetailAsync(id, ct);
            if (result is null) return NotFound();

            return Ok(result);
        }


        //Endpoint para altitudes:
        [HttpGet("altitud")]
        [ProducesResponseType(typeof(IReadOnlyList<CafeAltitudesDto>), StatusCodes.Status200OK)]
        public async Task<IActionResult> GetAltitudes(CancellationToken ct)
        {
            var result = await _cafeLoteService.GetAllCoffeeAltitudesAsync(ct);
            return Ok(result);
        }

    }
}