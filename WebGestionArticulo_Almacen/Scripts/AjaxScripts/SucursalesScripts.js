$(document).ready(function () {



    function msjOk() {
        toastr.success('Guardado', 'Ready');

    }

    function msjErr() {
        toastr.error('Se ha producido un error en la creacion', 'Error');

    }


    //Llamada aJAX para la notificacion del toastr  y el click

    $('#btnSubmit').click(function () {
        var sucursales={
            Sucursal: $('#txtSucursal').val(),
            IDLocalidad: $('#ddLocalidad').val(),
            Calle: $('#txtCalle').val(),
            Sector:$('#txtSector').val(),
            Apartamento: $('#txtApartamento').val(),
            Provincia: $('#ddProvincia').val(),
            Telefono1: $('#txtTelefono1').val(),
            Telefono2: $('#txtTelefono2').val(),
            Referencia: $('#txtReferencia').val(),
            
        }


        
        if (sucursales.Sucursal.length >= 1 && sucursales.IDLocalidad.length
            >= 1 && sucursales.Calle.length && sucursales.Sector.length
            && sucursales.Telefono1.length) {
            $.post('PostSucursal', { suc: sucursales }, function (result) {

                if (result == 'success') {
                    msjOk();
                    setTimeout(function () { window.location.href = "Index"; }, 1000);
                }
                else {
                    msjErr();
                    setTimeout(function () { window.location.href = "CrearSucursal"; }, 1200);
                }

            });
        }
        else {
            toastr.error("Complete los campos", "Error");
        }



    })

    //Llamada aJAX para la notificacion del toastr  y el click



    $('#btnEdit').click(function () {
        var sucursales = {
            Sucursal: $('#txtSucursal').val(),
            IDLocalidad: $('#ddLocalidad').val(),
            Calle: $('#txtCalle').val(),
            Sector: $('#txtSector').val(),
            Apartamento: $('#txtApartamento').val(),
            Provincia: $('#ddProvincia').val(),
            Telefono1: $('#txtTelefono1').val(),
            Telefono2: $('#txtTelefono2').val(),
            ReferenciaDireccion: $('#txtReferencia').val(),
            IDSucursal: $('#hiddenId').val(),
            IDCliente: $('#hiddenIdCliente').val(),
            IDEmpleado: $('#hiddenIdEmpleado').val(),
            IDOficina: $('#hiddenIdOficina').val()
        
           

        }
        if (sucursales.Sucursal.length >= 1 && sucursales.IDLocalidad.length
            >= 1 && sucursales.Calle.length && sucursales.Sector.length
            && sucursales.Telefono1.length) {
            $.post('PostEditarSucursal', { suc: sucursales }, function (result) {

                if (result == 'success') {
                    msjOk();
                    setTimeout(function () { window.location.href = "Index"; }, 1000);
                }
                else {
                    msjErr();
                    setTimeout(function () { window.location.href = "EditarSucursal"; }, 1200);
                }

            });

        }
        else {
            toastr.error("Complete los campos", "Error");
        }



    })
})