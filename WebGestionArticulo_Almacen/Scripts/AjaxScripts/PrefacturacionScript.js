$(document).ready(function () {
    //Mucho cuidado con este script
    //Es el que hace todo el proceso de la seleccion de elementos en 
    //La pantalla de prefacturacion


    var cantidadDatosEnArray = 0;
    var globalArr;
    var tipoBusqueda = null;

    var radiochecked = document.getElementById('radioOrden').checked;
    if (radiochecked == true) {
        $('#OrdenServicio').prop("disabled", false);
        $('#FechaDesde').prop("disabled", true);
        $('#FechaHasta').prop("disabled", true);
        $('#ddProductos').prop("disabled", true);
        $('#ddOficinas').prop("disabled", false);
    }
    $('input:radio[name="Filtro"]').change(function () {
        if ($(this).is(':checked') && $(this).val() == 1) {
            $('#OrdenServicio').prop("disabled", false);
            $('#FechaDesde').prop("disabled", true);
            $('#FechaHasta').prop("disabled", true);
            $('#ddProductos').prop("disabled", true);
            $('#ddOficinas').prop("disabled", false);
            tipoBusqueda = 0;
        }
        if ($(this).is(':checked') && $(this).val() == 2) {
            $('#OrdenServicio').prop("disabled", true);
            $('#OrdenServicio').val(0);
            $('#FechaDesde').prop("disabled", false);
            $('#FechaHasta').prop("disabled", false);
            $('#ddProductos').prop("disabled", false);
            $('#ddOficinas').prop("disabled", false);
            tipobusqueda = 1;
        }
    });

    $('#Cliente').change(function () {

        $.get('Prefacturacion/GetProductosByCliente',
            { cliente: $('#Cliente').val() },
            function (data) {
                $('#ddProductos').empty();

                for (x = 0; x < data.length; x++) {
                    $('#ddProductos')
                                .append($("<option></option>")
                                    .attr("value", data[x].Producto)
                                    .text(data[x].Producto));
                }

                //$.each(data,
                //    function () {
                //        //$('#Cliente').append("<select value=" + data[count].Producto + ">" + data[count].Producto + "</select>");
                //        $('#ddProductos').empty();
                //        $('#ddProductos')
                //            .append($("<option></option>")
                //                .attr("value", data[count].Producto)
                //                .text(data[count].Producto));
                //        count++;
                //    });

                //$.get('Prefacturacion/GetOficinasbyCliente',
                //    { cliente: $('#Cliente').val() },
                //    function (data2) {

                //        if (data2 == null || data2.length == 0) {
                //            $('#ddOficinas').empty();
                //            $('#ddOficinas')
                //                .append($("<option></option>")
                //                    .attr("value", "(TODOS)")
                //                    .text("(TODOS)"));
                //        } else {
                //            $('#ddOficinas').empty();
                //            $('#ddOficinas')
                //                .append($("<option></option>")
                //                    .attr("value", "(TODOS)")
                //                    .text("(TODOS)"));
                //            var countr = 0;
                //            $.each(data2,
                //                function () {
                //                    //$('#Cliente').append("<select value=" + data[count].Producto + ">" + data[count].Producto + "</select>");
                //                    $('#ddOficinas')
                //                        .append($("<option></option>")
                //                            .attr("value", data2[countr].Oficina)
                //                            .text(data2[countr].Oficina));
                //                    countr++;
                //                });
                //        }

                //    });
            });
    });

    //Traer Toda la informacion de la prefacturacion.
    $('#btnBuscar').click(function () {
        var rptRecibido = document.getElementById('radioRecibido').checked;
        var rptDevueltoyEntregado = document.getElementById('radioDevuelto').checked;

        $('#btnBuscar').prop('disabled', true);
        if (rptRecibido == false && rptDevueltoyEntregado == true) {

            if ($('#Concepto').val() != null && $('#Concepto').val().length > 0) {


                var filter = {
                    OrdenServicio: $('#OrdenServicio').val(),
                    FechaDesde: $('#FechaDesde').val(),
                    FechaHasta: $('#FechaHasta').val(),
                    Producto: $('#ddProductos').val(),
                    Oficina: $('#ddOficinas').val(),
                    Cliente: $('#Cliente').val(),
                    Concepto: $('#Concepto').val()

                }


                $.get('Prefacturacion/CargarPrefacturaTcRecibidoyDevuelto',
                    {
                        fdesde: filter.FechaDesde,
                        fhasta: filter.FechaHasta,
                        prod: filter.Producto,
                        os: filter.OrdenServicio,
                        oficina: filter.Oficina,
                        schema: filter.Cliente,
                        concepto: filter.Concepto
                    },
                    function (list) {
                        if (list == null || list.length <= 0) {
                            toastr.warning("No Existen Datos para este tipo", "No Existen");
                        }
                        cantidadDatosEnArray = list.length;
                        globalArr = list;
                        localStorage.setItem("Lista", JSON.stringify(list));
                        localStorage.setItem("opcional", JSON.stringify(list));                       
                        $('#btnBuscar').prop('disabled', false);
                        $('#tbdesglose').DataTable(
                            {
                                //language: {
                                //    url:'/Scripts/AjaxScripts/spanish.json'
                                //},
                                destroy: true,
                                responsive: true,
                                paging: true,
                                data: list,
                                columns: [
                                    { data: 'Checked' },
                                    { data: 'Tracking' },
                                    { data: 'Oficina' },
                                    { data: 'Nombre' },
                                    { data: 'Producto' },
                                    { data: 'Mensajero' },
                                    { data: 'Direccion' },
                                    { data: 'Devuelto2' },
                                    { data: 'Entregado2' }
                                ]
                            });

                        var id2;
                        for (x = 1; x < cantidadDatosEnArray + 1; x++) {
                            $('#Checked' + x).click(function () {

                                var objTruco = {
                                    Checked: '',
                                    Tracking: '',
                                    Oficina: '',
                                    Nombre: '',
                                    Producto: '',
                                    Mensajero: '',
                                    Direccion: ''
                                }

                                var chb = this;
                                var chkstatus = chb.checked;
                                var items = JSON.parse(localStorage.getItem("Lista"));

                                if (chkstatus == false) { //Si esta checked y le haces click quitalo.

                                    //var texts = $("#1 td").map(function () {
                                    //    return $(this).text();
                                    //});
                                    var id = $(this).closest('tr').attr('id');
                                    id2 = id;

                                    for (i = 0; i < items.length; i++) {
                                        var item = items[i];
                                        if (item.DT_RowId == id) {
                                            items.splice(item.DT_RowId - 1, 1, objTruco);
                                        }
                                    }
                                    chkstatus = false;
                                    localStorage.setItem("Lista", JSON.stringify(items));
                                } else { // Si no esta Checked y le haces click Agregalo
                                    var opt = JSON.parse(localStorage.getItem("opcional"));
                                    var itemopt = opt[id2 - 1];
                                    //items.push(itemopt);
                                    items.splice(id2 - 1, 1, itemopt);

                                    localStorage.setItem("Lista", JSON.stringify(items));

                                }

                            });
                        }
                    });

            } else {
                toastr.error("Debe Ingresar un concepto", "Ingrese Concepto");
            }

        }
        if (rptRecibido == true && rptDevueltoyEntregado == false) {
            if ($('#Concepto').val() != null && $('#Concepto').val().length > 0) {

                $('#btnBuscar').prop('disabled', true);
                var filter = {
                    OrdenServicio: $('#OrdenServicio').val(),
                    FechaDesde: $('#FechaDesde').val(),
                    FechaHasta: $('#FechaHasta').val(),
                    Producto: $('#ddProductos').val(),
                    Oficina: $('#ddOficinas').val(),
                    Cliente: $('#Cliente').val(),
                    Concepto: $('#Concepto').val()

                }


                $.get('Prefacturacion/CargarPrefactura',
                    {
                        fdesde: filter.FechaDesde,
                        fhasta: filter.FechaHasta,
                        prod: filter.Producto,
                        os: filter.OrdenServicio,
                        oficina: filter.Oficina,
                        schema: filter.Cliente,
                        concepto: filter.Concepto
                    },
                    function (list) {
                        if (list == null || list.length <= 0) {
                            toastr.warning("No Existen Datos para este tipo", "No Existen");
                        }
                        cantidadDatosEnArray = list.length;
                        globalArr = list;
                        localStorage.setItem("Lista", JSON.stringify(list));
                        localStorage.setItem("opcional", JSON.stringify(list));
                        $('#btnBuscar').prop('disabled', false);
                        $('#tbdesglose').DataTable(
                            {
                                //language: {
                                //    url:'/Scripts/AjaxScripts/spanish.json'
                                //},
                                destroy: true,
                                responsive: true,
                                paging: true,
                                data: list,
                                columns: [
                                    { data: 'Checked' },
                                    { data: 'Tracking' },
                                    { data: 'Oficina' },
                                    { data: 'Nombre' },
                                    { data: 'Producto' },
                                    { data: 'Mensajero' },
                                    { data: 'Direccion' },
                                ]
                            });

                        var id2;
                        for (x = 1; x < cantidadDatosEnArray + 1; x++) {
                            $('#Checked' + x).click(function () {

                                var objTruco = {
                                    Checked: '',
                                    Tracking: '',
                                    Oficina: '',
                                    Nombre: '',
                                    Producto: '',
                                    Mensajero: '',
                                    Direccion: ''
                                }

                                var chb = this;
                                var chkstatus = chb.checked;
                                var items = JSON.parse(localStorage.getItem("Lista"));

                                if (chkstatus == false) { //Si esta checked y le haces click quitalo.

                                    //var texts = $("#1 td").map(function () {
                                    //    return $(this).text();
                                    //});
                                    var id = $(this).closest('tr').attr('id');
                                    id2 = id;

                                    for (i = 0; i < items.length; i++) {
                                        var item = items[i];
                                        if (item.DT_RowId == id) {
                                            items.splice(item.DT_RowId - 1, 1, objTruco);
                                        }
                                    }
                                    chkstatus = false;
                                    localStorage.setItem("Lista", JSON.stringify(items));
                                } else { // Si no esta Checked y le haces click Agregalo
                                    var opt = JSON.parse(localStorage.getItem("opcional"));
                                    var itemopt = opt[id2 - 1];
                                    //items.push(itemopt);
                                    items.splice(id2 - 1, 1, itemopt);

                                    localStorage.setItem("Lista", JSON.stringify(items));

                                }

                            });
                        }
                    });

            } else {
                toastr.error("Debe Ingresar un concepto", "Ingrese Concepto");
            }
        }
    });

    //Fin Traer Toda la informacion de la prefacturacion.

    //Inicio De Post De la informacion
    $('#btnPrefacturar').click(function () {
        var rptRecibido = document.getElementById('radioRecibido').checked;
        var rptDevueltoyEntregado = document.getElementById('radioDevuelto').checked;
        $('#btnPrefacturar').prop('disabled', true);
        if (rptDevueltoyEntregado == true) {
            var items = JSON.parse(localStorage.getItem("Lista"));
            $.ajax({
                type: 'POST',
                dataType: 'json',
                url: 'Prefacturacion/PostPrefacturacionTc',
                data: { prefact: items },
                success: function (id) {
                    localStorage.clear();
                    toastr.success("El Proceso Ha Sido Realizado Correctamente", "Realizado");
                    window.location.href = 'Prefacturacion/InformacionDesglose?idPrefacturacion=' + id;
                    
                },
                error: function () {
                    toastr.error("No se ha completado el proceso", "Error");
                }
            });
        }
        if (rptRecibido) {

        var items = JSON.parse(localStorage.getItem("Lista"));
        $.ajax({
            type: 'POST',
            dataType: 'json',
            url: 'Prefacturacion/PostPrefacturacion',
            data: { prefact: items },
            success: function (id) {
                toastr.success("El Proceso Ha Sido Realizado Correctamente", "Realizado");
                window.location.href = 'Prefacturacion/InformacionDesglose?idPrefacturacion=' + id;
            },
            error: function () {
                toastr.error("No se ha completado el proceso", "Error");
            }
        });
        }

    });


    //Fin Post de la informacion


});
