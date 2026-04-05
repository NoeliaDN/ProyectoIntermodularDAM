using Microsoft.AspNetCore.Mvc;
using System.Runtime.InteropServices;
using WCA.Application.DTOs;
using WCA.Application.Interfaces;

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

        ///// <summary>
        ///// Obtiene la información de variedad, productor y localización de un café a partir del Id de la variedad.
        ///// </summary>
        /////  <remarks>
        ///// Los datos devueltos se utilizan para mostrar información detallada de la variedad, productor y localización en la página de Variedades.
        ///// </remarks>
        ///// /// <param name="id">Identificador de la variedad (VariedadId).</param>
        ///// <param name="ct">Token de cancelación.</param>
        ///// <returns>Detalle de variedad, productor y origen del café.</returns>
        ///// <response code="200">Devuelve el detalle de variedad y productor.</response>
        //[HttpGet("{id:int}/detalles")]// GET api/variedades/{id}/detalles
        //[ProducesResponseType(typeof(CafeDetalleDto), StatusCodes.Status200OK)]
        //[ProducesResponseType(StatusCodes.Status404NotFound)]
        //public async Task<IActionResult> GetDetalles(int id, CancellationToken ct)
        //{
        //    var result = await _cafeDetallesService.GetDetallesByVariedadIdAsync(id, ct);
        //    if (result is null) return NotFound();

        //    return Ok(result);
        //}


        // Para devolver información dependiendo de si hay café asignado a esa variedad o no:

        /// <summary>
        /// Obtiene la información de una variedad concreta y, si existe,
        /// la información de un café asociado (productor, región, país, etc.).
        /// </summary>
        /// <remarks>
        /// Comportamiento:
        /// <list type="bullet">
        /// <item>
        /// <description>
        /// Si la variedad no tiene ningún café asociado, devuelve únicamente
        /// los datos de la variedad en un <see cref="VariedadDetalleDto"/>.
        /// </description>
        /// </item>
        /// <item>
        /// <description>
        /// Si la variedad tiene al menos un café con información completa
        /// (productor, región, país), devuelve un <see cref="CafeDetalleDto"/>
        /// combinando variedad + productor + localización.
        /// </description>
        /// </item>
        /// </list>
        /// Este endpoint está pensado para la página de Variedades de la app,
        /// que debe poder mostrar siempre información útil aunque la variedad
        /// aún no tenga cafés registrados.
        /// </remarks>
        /// <param name="id">Identificador de la variedad (VariedadId).</param>
        /// <param name="ct">Token de cancelación.</param>
        /// <returns>
        /// <para>
        /// 200 OK con un <see cref="VariedadDetalleDto"/> si no hay cafés asociados
        /// o los datos de origen están incompletos.
        /// </para>
        /// <para>
        /// 200 OK con un <see cref="CafeDetalleDto"/> si existe al menos un café
        /// asociado con información completa.
        /// </para>
        /// <para>
        /// 404 NotFound si la variedad no existe.
        /// </para>
        /// </returns>
        /// <response code="200">
        /// Devuelve información de la variedad y, opcionalmente,
        /// del café asociado y su origen.
        /// </response>
        /// <response code="404">
        /// No se ha encontrado ninguna variedad con el identificador indicado.
        /// </response>
        //[HttpGet("{id:int}/detalles")]
        //[ProducesResponseType(typeof(VariedadDetalleDto), StatusCodes.Status200OK)]
        //[ProducesResponseType(typeof(CafeDetalleDto), StatusCodes.Status200OK)]
        //[ProducesResponseType(StatusCodes.Status404NotFound)]
        //public async Task<IActionResult> GetDetalles(int id, CancellationToken ct)
        //{
        //    var variedad = await _cafeDetallesService.GetVariedadConDetallesAsync(id, ct);
        //    if (variedad is null) return NotFound();

        //    var lote = variedad.LotesCafe.FirstOrDefault();

        //    if (lote is null)
        //    {
        //        // No hay cafés para esta variedad → devolvemos solo datos de variedad
        //        var dtoVariedad = new VariedadDetalleDto
        //        {
        //            VariedadId = variedad.Id,
        //            Variedad = variedad.Nombre,
        //            Especie = variedad.Especie,
        //            VariedadDescripcion = variedad.Descripcion
        //        };

        //        return Ok(dtoVariedad);
        //    }

        //    if (lote.Productor is null || lote.Region is null || lote.Region.Pais is null)
        //    {
        //        // Datos de origen incompletos → devolvemos igualmente VariedadDetalleDto
        //        var dtoVariedadIncompleta = new VariedadDetalleDto
        //        {
        //            VariedadId = variedad.Id,
        //            Variedad = variedad.Nombre,
        //            Especie = variedad.Especie,
        //            VariedadDescripcion = variedad.Descripcion
        //        };

        //        return Ok(dtoVariedadIncompleta);
        //    }

        //    // Hay al menos un café completo asociado a la variedad → devolvemos CafeDetalleDto
        //    var dtoCafe = new CafeDetalleDto
        //    {
        //        CafeId = lote.Id,
        //        CafeNombre = lote.Nombre,

        //        VariedadId = variedad.Id,
        //        Variedad = variedad.Nombre,
        //        Especie = variedad.Especie,
        //        VariedadDescripcion = variedad.Descripcion,

        //        Productor = lote.Productor.Nombre,
        //        ProductorDescripcion = lote.Productor.DescripcionBreve,
        //        TipoProductor = lote.Productor.TipoProductor.Tipo,
        //        Region = lote.Region.Nombre,
        //        Pais = lote.Region.Pais.Nombre
        //    };

        //    return Ok(dtoCafe);
        //}

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
