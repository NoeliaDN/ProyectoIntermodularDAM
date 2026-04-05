using Microsoft.EntityFrameworkCore;
using WCA.Application.DTOs;
using WCA.Application.Interfaces;
using WCA.Domain.Entities;
using WCA.Domain.Repositories;
using WCA.Infrastructure.Data;
using WCA.Infrastructure.Repositories;

namespace WCA.Infrastructure.Services
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
                Proceso = lote.Proceso.Nombre,   // ajusta al nombre real
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
