using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(WebGestionArticulo_Almacen.Startup))]
namespace WebGestionArticulo_Almacen
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
