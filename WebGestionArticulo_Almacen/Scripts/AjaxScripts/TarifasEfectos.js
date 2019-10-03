$(document).ready(function () {
 
    $('#selectSucursal').change(function () {

        var valor = $('#selectSucursal').val();

        $.get('Index', { idSucursal: valor })
        .done(function (data) {
            drawTable(data);
        });
    });


    function drawTable(data) {
        for (var i = 0; i < data.length; i++) {
            drawRow(data[i]);
        }
    }


    function drawRow(rowData) {
        var row = $("<tr />");
        $('#listHistorialEfectos').append(row);

        row.append($("<td>" + rowData.IDEfecto + "</td>"));
        row.append($("<td>" + rowData.Efecto + "</td>"));
        row.append($("<td>" + rowData.Tarifa + "</td>"));
        row.append($("<td>" + rowData.Fecha + "</td>"));
        row.append($("<td>" + rowData.Usuario + "</td>"));
    }



});