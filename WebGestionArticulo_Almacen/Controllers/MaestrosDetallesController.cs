using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WebGestionArticulo_Almacen.Models;


namespace WebGestionArticulo_Almacen.Controllers
{
    public class MaestrosDetallesController : Controller
    {
        private GestionArticuloEntities db = new GestionArticuloEntities();
        public ActionResult Index()
        {

            using (GestionArticuloEntities db = new GestionArticuloEntities())
            {
                var list = db.TableEntradas.ToList();

                return View(list);
            }

        }


        public ActionResult CrearMaestro()
        {
            using (var db = new GestionArticuloEntities())
            {
                var almacen = (from al in db.TableAlmacenes
                               select new
                               {
                                   al.idalmacen,
                                   al.nombre
                               }).ToList();

                almacen.Add(new { idalmacen = 0, nombre = "-- Seleccione -- " });

                var listaAlmacenes = new SelectList(almacen.OrderBy(o => o.idalmacen), "idalmacen", "nombre");

                ViewData["almacenes"] = listaAlmacenes;

                // -----Para LLenar el articulo-----
                var articu = (from ar in db.TableArticulo
                              select new
                              {
                                  ar.iditem,
                                  ar.descripcion
                              }).ToList();

                articu.Add(new { iditem = 0, descripcion = "-- Seleccione --" });

                var listaArticulos = new SelectList(articu.OrderBy(o => o.iditem), "iditem", "descripcion");

                ViewData["articulos"] = listaArticulos;

                //------------- Tipo de Documento de Entrada 


                List<SelectListItem> lst = new List<SelectListItem>();
                lst.Add(new SelectListItem() { Text = "-- Seleccione --", Value = "0" });
                lst.Add(new SelectListItem() { Text = "Compra", Value = "1" });
                lst.Add(new SelectListItem() { Text = "Orden de Pedido", Value = "2" });
                lst.Add(new SelectListItem() { Text = "Una Entrega", Value = "3" });
                lst.Add(new SelectListItem() { Text = "Otras", Value = "4" });

                ViewData["numeroDocumento"] = lst;

            }
            return View();
        }

        [HttpPost]
        public ActionResult CrearMaestro(TableEntradas Ent, IEnumerable<TableDetalleEntradas> Detalles)
        {

            if (ModelState.IsValid)
            {
                Ent.status = "Activo";
                Ent.idusuario = 1;
                db.TableEntradas.Add(Ent);
                db.SaveChanges();
                var entrada = Ent.identrada.ToString();
                int identrada2 = Int32.Parse(entrada);

                foreach (var de in Detalles)
                {
                    de.identrada = identrada2;
                }
                db.TableDetalleEntradas.AddRange(Detalles);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(Ent);
            //return RedirectToAction("Index");           
        }

       
        public ActionResult Borrar(int? IdEntra)
        {
            if (IdEntra == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

           TableEntradas  Entra = new TableEntradas();
            using (var tableEntrada = new GestionArticuloEntities())
            {

                var id = db.TableEntradas.Find(IdEntra);
                Entra.identrada = id.identrada;
                Entra.numeroDocumento = id.numeroDocumento;
                Entra.comentario = id.comentario;              
                Entra.status = id.status;
                Entra.idusuario = id.idusuario;
            }
            return View(Entra);
        }

        [HttpPost]
        public ActionResult Borrar(int IdEntra)
        {
            if (ModelState.IsValid)
            {              
                db.TableDetalleEntradas.Where(d => d.identrada == IdEntra).ToList().ForEach(d => db.TableDetalleEntradas.Remove(d));               
                db.SaveChanges();                

                TableEntradas tableEntr = db.TableEntradas.Find(IdEntra);
                db.TableEntradas.Remove(tableEntr);
                db.SaveChanges();                                
                return RedirectToAction("Index");

            }
            return View();

        }

    }
}