using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using WebGestionArticulo_Almacen.Models;

namespace WebGestionArticulo_Almacen.Controllers
{
    public class GestionAlmacenController : Controller
    {
        private  GestionArticuloEntities db = new GestionArticuloEntities();
        // public TableAlmacenes Almacen;
        private IEnumerable<TableAlmacenes> linq;
        public ActionResult Index()
        {
            using (GestionArticuloEntities db = new GestionArticuloEntities())
            {
                var list = db.TableAlmacenes.ToList();
                return View(list);
            }
               
        }

        public ActionResult AgregarAlmacen()
        {
            return View("AgregarAlmacen");
        }

        
        public ActionResult AgregarAlmacen(TableAlmacenes al)
        {
            if (ModelState.IsValid)
            {              
                
                db.TableAlmacenes.Add(al);
                db.SaveChangesAsync();               
                return RedirectToAction("Index");
            }
            return View(al);
        }
        public ActionResult modificarAlmacen(int IdAlmacen)
        {


            if (IdAlmacen == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            TableAlmacenes alma = new TableAlmacenes();


            using (var tableAlmacenes = new GestionArticuloEntities())
            {

                var id = db.TableAlmacenes.Find(IdAlmacen);
                alma.idalmacen = id.idalmacen;
                alma.nombre = id.nombre;
                alma.comentario = id.comentario;
                alma.capacidad = id.capacidad;
                alma.status = id.status;
                alma.idusuario = id.idusuario;

            }
            return View(alma);
        }


       
        public ActionResult modificarAlmacen(TableAlmacenes al)
        {
            if (ModelState.IsValid)
            {
                db.Entry(al).State = EntityState.Modified;
                db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(al);          
           
        }
        
        public ActionResult BorrarAlmacen(int? IdAlmacen)
        {
            if (IdAlmacen == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            TableAlmacenes alma = new TableAlmacenes();
            using (var tableAlmacenes = new GestionArticuloEntities())
            {

                var id = db.TableAlmacenes.Find(IdAlmacen);
                alma.idalmacen = id.idalmacen;
                alma.nombre = id.nombre;
                alma.comentario = id.comentario;
                alma.capacidad = id.capacidad;
                alma.status = id.status;
                alma.idusuario = id.idusuario;

            }
            return View(alma);
        }
        
        
        public ActionResult BorrarAlmacen(int IdAlmacen)
        {
            if (ModelState.IsValid)
            {
                TableAlmacenes tableAlmacenes = db.TableAlmacenes.Find(IdAlmacen);
                db.TableAlmacenes.Remove(tableAlmacenes);
                db.SaveChangesAsync();
                return RedirectToAction("Index");
              
            }
            return View();
           
        }
        //-------------------------------Para Controlar la Creacion de articulos-------------------

        public ActionResult IndexArticulo()
        {
            using (GestionArticuloEntities db = new GestionArticuloEntities())
            {
                
                
                var list = db.TableArticulo.ToList();
                return View(list);
            }

        }
        public ActionResult AgregarArticulo()
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

                var listaAlmacenes = new SelectList( almacen.OrderBy(o => o.idalmacen), "idalmacen", "nombre");

                ViewData["almacenes"] = listaAlmacenes;

                
            }
            return View();
        }

        [HttpPost]
        public ActionResult AgregarArticulo(TableArticulo ar)
        {
            if (ModelState.IsValid)
            {

                db.TableArticulo.Add(ar);
                db.SaveChangesAsync();
                
                ModelState.AddModelError("Articulo", "Agaregado Correctamente");
                return RedirectToAction("IndexArticulo");
            }
            return View(ar);
        }

        public ActionResult modificarArticulo(int iditem)
        {


            if (iditem == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            TableArticulo  art = new TableArticulo();


            using (var tableArticulos = new GestionArticuloEntities())
            {

                var id = db.TableArticulo.Find(iditem);
                art.iditem = id.iditem;
                art.descripcion = id.descripcion;               
                art.idalmacen = id.idalmacen;
                art.maximo = id.maximo;
                art.minimo = id.minimo;
                art.existencia = id.existencia;
                art.costo = id.costo;
                art.precio = id.precio;
                art.preciominimo = id.preciominimo;
                art.itemdescuento = id.itemdescuento;
                art.itbis = id.itbis;
                art.vencimiento = id.vencimiento;
                art.comentario = id.comentario;
                art.idusuario = id.idusuario;
                art.idusuariomodifico = id.idusuariomodifico;
                art.status = id.status;


               // -------------

                var almacen = (from al in db.TableAlmacenes
                               select new
                               {
                                   al.idalmacen,
                                   al.nombre
                               }
                               ).ToList();

                almacen.Add(new { idalmacen = 0, nombre = "-- Seleccione -- " });

                var listaAlmacenes = new SelectList(almacen.OrderBy(o => o.idalmacen), "idalmacen", "nombre");

                ViewData["almacenes"] = listaAlmacenes;

            }
            return View(art);
        }


        [HttpPost]
        public ActionResult modificarArticulo(TableArticulo art)
        {
            if (ModelState.IsValid)
            {
                db.Entry(art).State = EntityState.Modified;
                db.SaveChangesAsync();
                return RedirectToAction("IndexArticulo");
            }
            return View(art);

        }

        public ActionResult BorrarArticulo(int? iditem)
        {
            if (iditem == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            TableArticulo art = new TableArticulo();
            using (var tableArticulos = new GestionArticuloEntities())
            {

                var id = db.TableArticulo.Find(iditem);
                art.iditem = id.iditem;
                art.descripcion = id.descripcion;
                art.idalmacen = id.idalmacen;
                art.maximo = id.maximo;
                art.minimo = id.minimo;
                art.existencia = id.existencia;
                art.costo = id.costo;
                art.precio = id.precio;
                art.preciominimo = id.preciominimo;
                art.itemdescuento = id.itemdescuento;
                art.itbis = id.itbis;
                art.vencimiento = id.vencimiento;
                art.comentario = id.comentario;
                art.idusuario = id.idusuario;
                art.idusuariomodifico = id.idusuariomodifico;
                art.status = id.status;

            }
            return View(art);
        }

        [HttpPost]
        public ActionResult BorrarArticulo(int iditem)
        {
            if (ModelState.IsValid)
            {
               TableArticulo tableArticulo = db.TableArticulo.Find(iditem);
                db.TableArticulo.Remove(tableArticulo);
                db.SaveChangesAsync();
                return RedirectToAction("IndexArticulo");

            }
            return View();
        }



    }
}