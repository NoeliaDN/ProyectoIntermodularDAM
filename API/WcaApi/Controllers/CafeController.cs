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
        private readonly IPerfilSCAService _perfilScaService;

        public CafesController(
            ICafeLoteService cafeLoteService,
            IPerfilSCAService perfilScaService)
        {
            _cafeLoteService = cafeLoteService;
            _perfilScaService = perfilScaService;
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
        /// <response code="404">No se ha encontrado un café con el Id especificado.</response>
        [HttpGet("/info/{id:int}")] // GET api/cafes/info/{id}
        [ProducesResponseType(typeof(CafeLoteDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetCafeInfo(int id, CancellationToken ct)
        {
            var result = await _cafeLoteService.GetCoffeeInfoByIdAsync(id, ct);
            if (result is null) return NotFound();

            return Ok(result);
        }

        /// <summary>
        /// Obtiene el perfil SCA de un café concreto.
        /// </summary>
        /// <remarks>
        /// Los datos devueltos se utilizan para representar un gráfico radial en el front.
        /// </remarks>
        /// <param name="id">Identificador del café (LoteCafeId).</param>
        /// <param name="ct">Token de cancelación.</param>
        /// <returns>Perfil SCA del café.</returns>
        /// <response code="200">Devuelve el perfil SCA del café.</response>
        /// <response code="404">No se ha encontrado perfil SCA para el café indicado.</response>
        [HttpGet("{id:int}/sca")]
        [ProducesResponseType(typeof(SCADto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetCafeSca(int id, CancellationToken ct)
        {
            var result = await _perfilScaService.GetCoffeeSCAByIdAsync(id, ct);
            if (result is null) return NotFound();

            return Ok(result);
        }


        
    }
}