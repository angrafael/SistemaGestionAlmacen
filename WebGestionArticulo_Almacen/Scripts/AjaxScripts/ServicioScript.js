$(document).ready(function () {
   
    

     function msjOk(){
         toastr.success('Guardado', 'Ready');
         
    }

    function msjErr(){
        toastr.error('Se ha producido un error en la creacion', 'Error');
       
    }


    //Llamada aJAX para la notificacion del toastr  y el click

    $('#btnSubmit').click(function () {
        var service ={
            Servicio: $('#txtService').val(),
            IDOficina: $('#ddOficinas').val(),
            Borrado: 0

            
        }
        if (service.Servicio.length >= 1 && service.IDOficina.length >= 1) {
            $.post('InsertarServicio', { serv: service }, function (result) {

                if (result == 'success') {
                    msjOk();
                    setTimeout(function () { window.location.href = "Index"; }, 1000);
                }
                else {
                    msjErr();
                    setTimeout(function () { window.location.href = "CrearServicio"; }, 1200);
                }

            });
        }
        else {
            toastr.error("Complete los campos","Error");
        }
      

      
    })

    //Llamada aJAX para la notificacion del toastr  y el click

    

    $('#btnEdit').click(function () {
        var service = {
            Idservicio:$('#hiddenId').val(),
            Servicio: $('#txtService').val(),
            IDOficina: $('#ddOficinas').val(),
            Borrado: 0


        }
        if (service.Servicio.length >= 1 && service.IDOficina.length >= 1) {
            $.post('PostEdit', { serv: service }, function (result) {

                if (result == 'success') {
                    msjOk();
                    setTimeout(function () { window.location.href = "Index"; }, 1000);
                }
                else {
                    msjErr();
                    setTimeout(function () { window.location.href = "CrearServicio"; }, 1200);
                }

            });

        }
        else {
            toastr.error("Complete los campos", "Error");
        }
     


    })
})