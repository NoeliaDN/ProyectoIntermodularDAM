using Microsoft.EntityFrameworkCore;
using WCA.Infrastructure.Data;
using WCA.Application.Interfaces;
using WCA.Infrastructure.Services;

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
            builder.Services.AddScoped<ICafeLoteService, CafeLoteService>();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}
