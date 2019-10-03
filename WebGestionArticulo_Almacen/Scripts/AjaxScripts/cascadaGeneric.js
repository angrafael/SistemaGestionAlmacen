$(document).ready(function () {
    $("#IDProvincia").change(function () {
        $("#IDMunicipio").empty();
        $.ajax({
            type: 'POST',
            url: Url,            
            datatype: 'json',
            data: { IDProvincia: $("#IDProvincia").val() },
            success: function (Municipios) {
                $.each(Municipios, function (i, Municipio) {
                    $("#IDMunicipio").append('<option value="'
                        + Municipio.IDMunicipio + '">'
                        + Municipio.Municipio + '</option>');
                });
            },
            error: function (ex) {
                alert('Fallo en la carga' + ex);
            }
        });

        return false;
    })
});