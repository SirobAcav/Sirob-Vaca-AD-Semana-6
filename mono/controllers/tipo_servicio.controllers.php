<?php 
error_reporting(0);


//ini_set('display_errors', 1);              // NUEVO
//ini_set('display_startup_errors', 1);      // NUEVO
//error_reporting(E_ALL);                    // NUEVO

/*TODO: Requerimientos */
require_once('../config/sesiones.php');
require_once("../models/tipo_servicio.models.php");

//header('Content-Type: application/json; charset=utf-8'); // <<< NUEVO

$Tipo_Servicio = new Tipo_Servicio;

switch ($_GET["op"]) {

    /*TODO: Procedimiento para listar todos los registros */
    case 'todos':
        $datos = $Tipo_Servicio->todos();

        $lista = array();

        while ($row = mysqli_fetch_assoc($datos)) {
            // ARMAMOS UN OBJETO LIMPIO PARA JS / DATATABLES
            $lista[] = array(
                "id"      => $row["id"],
                "detalle" => $row["detalle"],
                "valor"   => $row["valor"],
                "estado"  => (int)$row["estado"]
            );
        }

        // DataTables (con dataSrc: "") espera un array []
        echo json_encode($lista);
        break;

    /*TODO: Procedimiento para sacar un registro */
    case 'uno':
        $idTipoServicio = $_POST["id_tipo_servicio"];
        $datos = $Tipo_Servicio->uno($idTipoServicio);
        $row = mysqli_fetch_assoc($datos);

        if ($row) {
            // Misma estructura de claves que usamos en JS
            $res = array(
                "id"      => $row["id"],
                "detalle" => $row["detalle"],
                "valor"   => $row["valor"],
                "estado"  => (int)$row["estado"]
            );
            echo json_encode($res);
        } else {
            echo json_encode(null);
        }
        break;

    case 'unoDetalle':
        $Detalle = $_POST["Detalle"];
        $datos = $Tipo_Servicio->unoDetalle($Detalle);
        $res = mysqli_fetch_assoc($datos);
        echo json_encode($res);
        break;
    
    case 'insertar':
        $detalle = $_POST["detalle"];
        $valor   = $_POST["valor"];
       
        $datos = $Tipo_Servicio->Insertar($detalle, $valor);
        // Se asume que el modelo devuelve "ok" o algo similar
        echo json_encode($datos);
        break;

    /*TODO: Procedimiento para actualizar */
    case 'actualizar':
        $idTipoServicio = $_POST["idTipoServicio"];
        $detalle        = $_POST["detalle"];
        $valor          = $_POST["valor"];
        $estado         = $_POST["estado"]; // "on" o no

        $datos = $Tipo_Servicio->Actualizar(
            $idTipoServicio,
            $detalle,
            $valor,
            $estado == "on" ? 1 : 0
        );
        echo json_encode($datos);
        break;

    /*TODO: Procedimiento para eliminar */
    case 'eliminar':
        $idTipoServicio = $_POST["idTipoServicio"];
        $datos = $Tipo_Servicio->Eliminar($idTipoServicio);
        echo json_encode($datos);
        break;

    case 'eliminarsuave':
        $idTipoServicio = $_POST["idTipoServicio"];
        $datos = $Tipo_Servicio->Eliminarsuave($idTipoServicio);
        echo json_encode($datos);
        break;

    /*TODO: Procedimiento para insertar */
    default:
        echo json_encode("operacion no valida");
        break;
}
