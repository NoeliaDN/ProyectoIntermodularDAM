using WCA.Application.DTOs;
using WCA.Domain.Repositories;


namespace WCA.Application.Services
{
    public class CafeLoteService : ICafeLoteService
    {
        private readonly ICafeLoteRepository _cafeLoteRepository;

        public CafeLoteService(ICafeLoteRepository cafeLoteRepository)
        {
            _cafeLoteRepository = cafeLoteRepository;
        }



        // Nombres de cafés para seleccionar:
        public async Task<IReadOnlyList<CafeNombreDto>> GetAllCoffeeNamesAsync(CancellationToken ct = default)
        {
            var lotes = await _cafeLoteRepository.GetAllCoffeesAsync(ct);

            return lotes
                .Select(l => new CafeNombreDto
                {
                    Id = l.Id,
                    Nombre = l.Nombre
                })
                .ToList();
        }

        // Nombres de cafés, altitudes y codigo ISO para gráfico:
        public async Task<IReadOnlyList<CafeAltitudesDto>> GetAllCoffeeAltitudesAsync(CancellationToken ct = default)
        {
            var lotes = await _cafeLoteRepository.GetAllCoffeesAsync(ct);

            return lotes
                .Select(l => new CafeAltitudesDto
                {
                    CafeId = l.Id,
                    CafeNombre = l.Nombre,
                    AltitudMin = l.AltitudMin,
                    AltitudMax = l.AltitudMax,
                    AltitudMedia = l.AltitudMedia,
                    PaisISO = l.Region.Pais.CodigoISO

                })
                .ToList();
        }

        // Datos del café sin SCA:
        public async Task<CafeLoteDto?> GetCoffeeInfoByIdAsync(int id, CancellationToken ct = default)
        {
            var lote = await _cafeLoteRepository.GetOneCoffeeByIdAsync(id, ct);
            if (lote is null) return null;

            return new CafeLoteDto
            {
                Id = lote.Id,
                Nombre = lote.Nombre,
                Descripcion = lote.Descripcion,
                NotasCata = lote.NotasCata,
                AltitudMin = lote.AltitudMin,
                AltitudMax = lote.AltitudMax,
                AltitudMedia = lote.AltitudMedia,
                DescripcionExtendida = lote.DescripcionExtendida,

                Region = lote.Region.Nombre,
                Pais = lote.Region.Pais.Nombre,
                Productor = lote.Productor.Nombre,
                Proceso = lote.Proceso.Nombre,
                ProcesoDescripcion = lote.Proceso.Descripcion,
                Variedad = lote.Variedad.Nombre,
                Tueste = lote.Tueste.Nombre
            };
        }

        // Detalle de variedad, productor y localización:
        public async Task<CafeDetalleDto?> GetCoffeeDetailAsync(int id, CancellationToken ct = default)
        {
            var lote = await _cafeLoteRepository.GetOneCoffeeByIdAsync(id, ct);
            if (lote is null) return null;

            return new CafeDetalleDto
            {
                CafeId = lote.Id,
                CafeNombre = lote.Nombre,

                VariedadId = lote.VariedadId,
                Variedad = lote.Variedad.Nombre,
                Especie = lote.Variedad.Especie,
                VariedadDescripcion = lote.Variedad.Descripcion,

                Productor = lote.Productor.Nombre,
                ProductorDescripcion = lote.Productor.DescripcionBreve,
                TipoProductor = lote.Productor.TipoProductor.Tipo,
                Region = lote.Region.Nombre,
                Pais = lote.Region.Pais.Nombre
            };
        }


    }
}
