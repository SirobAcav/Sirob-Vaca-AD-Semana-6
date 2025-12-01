function init() {
  $("#form_tipo_servicio").on("submit", (e) => {
    GuardarEditar(e);
  });
}

const ruta = "../../controllers/tipo_servicio.controllers.php?op=";

$().ready(() => {
  // CargaLista(); // ya no la usamos para llenar la tabla principal

  $('#Tabla_Tipo_Servicio').DataTable({
    "aProcessing": true,
    "aServerSide": false,        // CAMBIO: sin modo servidor
    dom: 'Bfrtip',
    buttons: ['pdf', 'excel', 'csv'],
    "ajax": {
      url: ruta + "todos",
      type: "post",
      dataSrc: ""                // CAMBIO: el PHP devuelve un array []
    },
    // CAMBIO: definición de columnas
    "columns": [
      { // #
        "data": null,
        "render": function (data, type, row, meta) {
          return meta.row + 1;
        }
      },
      { "data": "detalle" },
      { "data": "valor" },
      {
        "data": "estado",
        "render": function (data) {
          return data == 1 ? "Activo" : "No Activo";
        }
      },
      { // ACCIONES
        "data": null,
        "render": function (data, type, row) {
          return `
            <button class='btn btn-primary' data-bs-toggle="modal" data-bs-target="#ModalTipo_Servicio"
                onclick='uno(${row.id})'>Editar</button>
            <button class='btn btn-danger' onclick='eliminar(${row.id})'>Eliminar</button>
            <button class='btn btn-warning' onclick='eliminarsuave(${row.id})'>Eliminar Suave</button>
          `;
        }
      }
    ],
    "bDestroy": true,
    "responsive": false,
    "bInfo": true,
    "iDisplayLength": 10,
    "order": [
      [0, "desc"]
    ],
    "language": {
      "sProcessing": "Procesando...",
      "sLengthMenu": "Mostrar _MENU_ registros",
      "sZeroRecords": "No se encontraron resultados",
      "sEmptyTable": "Ningún dato disponible en esta tabla",
      "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
      "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
      "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
      "sInfoPostFix": "",
      "sSearch": "Buscar:",
      "sUrl": "",
      "sInfoThousands": ",",
      "sLoadingRecords": "Cargando...",
      "oPaginate": {
        "sFirst": "Primero",
        "sLast": "Último",
        "sNext": "Siguiente",
        "sPrevious": "Anterior"
      },
      "oAria": {
        "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
      }
    }
  });
});

var CargaLista = () => {
  var html = "";
  $.get(ruta + "todos", (Lista_Servicios) => {
    // CAMBIO: ya viene como JSON, no hace falta JSON.parse
    // Lista_Servicios = JSON.parse(Lista_Servicios);

    $.each(Lista_Servicios, (index, servicio) => {
      html += `<tr>
            <td>${index + 1}</td>
            <td>${servicio.detalle}</td>
            <td>${servicio.valor}</td>
            <td>${servicio.estado == 1 ? "Activo" : "No Activo"}</td>
            <td>
              <button class='btn btn-primary' data-bs-toggle="modal" data-bs-target="#ModalTipo_Servicio" onclick='uno(${servicio.id})'>Editar</button>
              <button class='btn btn-danger' onclick='eliminar(${servicio.id})'>Eliminar</button>
              <button class='btn btn-warning' onclick='eliminarsuave(${servicio.id})'>Eliminar Suave</button>
            </td>
           </tr> `;
    });
    $("#ListaUsuarios").html(html);
  }, "json"); // CAMBIO: indicamos que la respuesta es JSON
};

var GuardarEditar = (e) => {
  e.preventDefault();
  var DatosFormularioServicio = new FormData($("#form_tipo_servicio")[0]);
  var accion = "";
  var id = document.getElementById("idTipoServicio").value;

  if (id > 0) {
    accion = ruta + "actualizar";
    DatosFormularioServicio.append("idTipoServicio", id);
  } else {
    accion = ruta + "insertar";
  }

  $.ajax({
    url: accion,
    type: "post",
    data: DatosFormularioServicio,
    processData: false,
    contentType: false,
    cache: false,
    dataType: "json",  // CAMBIO: esperamos JSON
    success: (respuesta) => {
      // CAMBIO: ya no hacemos JSON.parse
      if (respuesta == "ok") {
        alert("Se guardó con éxito");
        $('#Tabla_Tipo_Servicio').DataTable().ajax.reload();
        LimpiarCajas();
      } else {
        alert("Ocurrió un error");
        console.log(respuesta);
      }
    },
  });
};

var uno = async (idTipoServicio) => {
  $.post(
    ruta + "uno",
    { id_tipo_servicio: idTipoServicio },
    (tipo_servicio) => {
      // CAMBIO: ya viene como objeto JSON
      console.log(tipo_servicio);
      document.getElementById("idTipoServicio").value = tipo_servicio.id;
      document.getElementById("detalle").value = tipo_servicio.detalle;
      document.getElementById("valor").value = tipo_servicio.valor;
      if (tipo_servicio.estado == 1) {
        document.getElementById("estado").checked = true;
      } else {
        document.getElementById("estado").checked = false;
      }
      updateEstadoLabel();
    },
    "json" // CAMBIO: especificamos JSON
  );
};

var eliminar = (idTipoServicio) => {
  $.post(
    ruta + "eliminar",
    { idTipoServicio: idTipoServicio },
    (respuesta) => {
      // CAMBIO: ya no JSON.parse
      if (respuesta == "ok") {
        alert("Se eliminó con éxito");
        $('#Tabla_Tipo_Servicio').DataTable().ajax.reload();
        // o CargaLista(); si usas esa tabla también
      } else {
        alert("Error al eliminar");
        console.log(respuesta);
      }
    },
    "json" // CAMBIO
  );
};

var eliminarsuave = (idTipoServicio) => {
  $.post(
    ruta + "eliminarsuave",
    { idTipoServicio: idTipoServicio },
    (respuesta) => {
      // CAMBIO: ya no JSON.parse
      if (respuesta == "ok") {
        alert("Se eliminó con éxito");
        $('#Tabla_Tipo_Servicio').DataTable().ajax.reload();
        // o CargaLista();
      } else {
        alert("Error al eliminar");
        console.log(respuesta);
      }
    },
    "json" // CAMBIO
  );
};

var LimpiarCajas = () => {
  document.getElementById("idTipoServicio").value = "";
  document.getElementById("Detalle").value = "";
  document.getElementById("Valor").value = "";
  $("#ModalTipo_Servicio").modal("hide");
};

var updateEstadoLabel = () => {
  const estadoCheckbox = document.getElementById("estado");
  const estadoLabel = document.getElementById("lblEstado");

  if (estadoCheckbox.checked) {
    estadoLabel.textContent = "Activo";
  } else {
    estadoLabel.textContent = "No Activo";
  }
};

var imprimirTabla = () => {
  var tabla = document.getElementById("Tabla_Tipo_Servicio").innerHTML;
  var contenidoOriginal = document.body.innerHTML;
  document.body.innerHTML = tabla;
  window.print();
  document.body.innerHTML = contenidoOriginal;
};

init();
