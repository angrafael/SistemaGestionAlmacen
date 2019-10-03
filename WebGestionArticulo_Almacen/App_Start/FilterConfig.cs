using System.Web;
using System.Web.Mvc;

namespace WebGestionArticulo_Almacen
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
