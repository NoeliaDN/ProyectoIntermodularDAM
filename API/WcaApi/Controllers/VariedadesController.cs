using Microsoft.AspNetCore.Mvc;
using WCA.Application.DTOs;
using WCA.Application.Services;

namespace WCA.Api.Controllers
{
    /// <summary>
    /// Controlador para la consulta de información de variedades de café.
    /// </summary>
    /// <remarks>
    /// Expone endpoints orientados a la página de Variedades del cliente.
    /// Permite obtener nombres y datos de una variedad concreta y, si existen,
    /// los datos de un café asociado (productor, región, país, etc.).
    /// </remarks>
    [ApiController]
    [Route("api/[controller]")]
    public class VariedadesController : ControllerBase
    {
        private readonly ICafeDetallesService _cafeDetallesService;

        public VariedadesController(ICafeDetallesService cafeDetallesService)
        {
            _cafeDetallesService = cafeDetallesService;
        }

        /// <summary>
        /// Obtiene la lista de todas las variedades disponibles (Id y nombre).
        /// </summary>
        /// <remarks>
        /// Este endpoint se utiliza para rellenar el selector de variedades
        /// en la página Variedades del cliente.
        /// </remarks>
        /// <param name="ct">Token de cancelación.</param>
        /// <returns>Lista de variedades con Id y Nombre.</returns>
        /// <response code="200">Devuelve la lista de variedades.</response>
        [HttpGet("nombres")]
        [ProducesResponseType(typeof(IReadOnlyList<VariedadNombreDto>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetAllNombresVariedad(CancellationToken ct)
        {
            var result = await _cafeDetallesService.GetAllVariedadesNombresAsync(ct);
            return Ok(result);
        }

           
        // Para mostrar la lista de cafés si hay más de uno que emplee esa variedad:

        /// <summary>
        /// Obtiene la información de una variedad concreta y la lista de cafés
        /// que utilizan dicha variedad, incluyendo productor y origen.
        /// </summary>
        /// <remarks>
        /// - Siempre devuelve los datos básicos de la variedad.
        /// - La colección de cafés puede estar vacía si aún no existen lotes
        ///   registrados con esa variedad.
        /// - Cada elemento de la colección incluye el café, su productor,
        ///   tipo de productor, región y país, pensado para su uso en la página
        ///   de Variedades y en visualizaciones (como mapas en Power BI).
        /// </remarks>
        /// <param name="id">Identificador de la variedad (VariedadId).</param>
        /// <param name="ct">Token de cancelación.</param>
        /// <returns>
        /// 200 OK con un <see cref="VariedadConCafesDto"/> o 404 si la variedad no existe.
        /// </returns>
        [HttpGet("detalles/{id:int}")]
        [ProducesResponseType(typeof(VariedadConCafesDto), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> GetDetalles(int id, CancellationToken ct)
        {
            var variedad = await _cafeDetallesService.GetVariedadConDetallesAsync(id, ct);
            if (variedad is null) return NotFound();

            // Proyectamos todos los cafés asociados a esta variedad:
            var cafes = variedad.LotesCafe
                .Where(l => l.Productor != null && l.Region != null && l.Region.Pais != null)
                .Select(l => new VariedadCafeDto
                {
                    CafeId = l.Id,
                    CafeNombre = l.Nombre,
                    Productor = l.Productor!.Nombre,
                    ProductorDescripcion = l.Productor.DescripcionBreve,
                    TipoProductor = l.Productor.TipoProductor.Tipo,
                    Region = l.Region!.Nombre,
                    Pais = l.Region.Pais!.Nombre
                })
                .ToList();

            var dto = new VariedadConCafesDto
            {
                VariedadId = variedad.Id,
                VariedadNombre = variedad.Nombre,
                Especie = variedad.Especie,
                VariedadDescripcion = variedad.Descripcion,
                Cafes = cafes
            };

            return Ok(dto);
        }

    }
}
