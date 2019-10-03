
    window.onload = function () {


     
        function MsjOk(msj) {
            toastr.success(msj, "Guardado");
        }


        function MsjErr(msj) {
            toastr.error(msj, "Error");
        }



        if (estado == "success") {
            MsjOk("Guardado Correctamente");
        }
        if (estado == null) {
            toastr.remove();
        }
        else {
            MsjErr("Error al Guardar");
        }
    }





