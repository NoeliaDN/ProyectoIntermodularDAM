using Microsoft.EntityFrameworkCore;
using WCA.Infrastructure.Data;
using WCA.Application.Interfaces;
using WCA.Infrastructure.Services;
using WCA.Domain.Repositories;
using WCA.Infrastructure.Repositories;

namespace WcaApi
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Obtener la cadena de conexión (user-secrets)
            var connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
                                   ?? throw new InvalidOperationException("Define la cadena de conexión 'DefaultConnection'.");

            // Servicios:

            builder.Services.AddControllers();
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            // DbContext:
            builder.Services.AddDbContext<WCADbContext>(options => options.UseSqlServer(connectionString));

            // Services:            
            builder.Services.AddScoped<ICafeLoteRepository, CafeLoteRepository>();
            builder.Services.AddScoped<ISCARepository, SCARepository>();
            builder.Services.AddScoped<IVariedadRepository, VariedadRepository>();
            builder.Services.AddScoped<IProductorRepository, ProductorRepository>();
            builder.Services.AddScoped<ICafeLoteService, CafeLoteService>();
            builder.Services.AddScoped<IPerfilSCAService, PerfilSCAService>();
            builder.Services.AddScoped<ICafeDetallesService, CafeDetallesService>();
            //builder.Services.AddCors(options =>
            //{
            //    options.AddPolicy("FlutterDev", policy =>
            //    {
            //        // Permite peticiones desde Flutter web en local a mis puertos:
            //        policy.WithOrigins(
            //         "http://localhost:8080",
            //          "http://localhost:5000",
            //           "http://localhost:4040"
            //      )
            //      .AllowAnyMethod()
            //     .AllowAnyHeader();
            //    });
            //});
            // Para desarrollo p
            builder.Services.AddCors(options =>
            {
                options.AddPolicy("FlutterDev", policy =>
                {
                    policy
                        .AllowAnyOrigin()
                        .AllowAnyMethod()
                        .AllowAnyHeader();
                });
            });


            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();

            app.UseAuthorization();

            app.UseCors("FlutterDev");// para Flutter

            app.MapControllers();

            app.Run();
        }
    }
}
