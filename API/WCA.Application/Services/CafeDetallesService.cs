using WCA.Application.DTOs;
using WCA.Domain.Entities;
using WCA.Domain.Repositories;

namespace WCA.Application.Services
{
    public class CafeDetallesService : ICafeDetallesService
    {
        private readonly IVariedadRepository _variedadRepository;
        private readonly IProductorRepository _productorRepository;


        public CafeDetallesService(IVariedadRepository variedadRepository, IProductorRepository productorRepository)
        {
            _variedadRepository = variedadRepository;
            _productorRepository = productorRepository;
        }

        //Obtener todos los nombres de las varidades:
        public async Task<IReadOnlyList<VariedadNombreDto>> GetAllVariedadesNombresAsync(CancellationToken ct = default)
        {
            var variedades = await _variedadRepository.GetAllVariedadesAsync(ct);

            return variedades
                .Select(v => new VariedadNombreDto
                {
                    VariedadId = v.Id,
                    VariedadNombre = v.Nombre
                })
                .ToList();
        }

        //Obtener info completa de esa vaiedad:

        public async Task<Variedad?> GetVariedadConDetallesAsync(int variedadId, CancellationToken ct = default)
        {
            return await _variedadRepository.GetVarietyWithDetailsAsync(variedadId, ct);
        }

        
        //public async Task<CafeDetalleDto?> GetDetallesByVariedadIdAsync(int variedadId, CancellationToken ct = default)
        //{
        //    var variedad = await _variedadRepository.GetVariedadWithDetallesAsync(variedadId, ct);
        //    if (variedad is null) return null;


        //    // Cogemos el primer lote asociado a esa variedad
        //    var lote = variedad.LotesCafe.FirstOrDefault();
        //    if (lote is null || lote.Productor is null || lote.Region is null || lote.Region.Pais is null)
        //        return null;

        //    return new CafeDetalleDto
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
        //}


    }
}
