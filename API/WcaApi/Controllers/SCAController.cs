using Microsoft.AspNetCore.Mvc;
using WCA.Application.DTOs;
using WCA.Application.Services;

namespace WCA.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SCAController : ControllerBase
    {
        private readonly IPerfilSCAService _perfilScaService;

        public SCAController(IPerfilSCAService perfilScaService)
        {
            _perfilScaService = perfilScaService;
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
        [HttpGet("perfilLote/{id:int}")]
        [ProducesResponseType(typeof(SCADto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetCafeSca(int id, CancellationToken ct)
        {
            var result = await _perfilScaService.GetCoffeeSCAByIdAsync(id, ct);
            if (result is null) return NotFound();// gestionar 404 en el fromnt

            return Ok(result);
        }

    }


}