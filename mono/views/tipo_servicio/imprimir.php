<?php
// NADA de espacios ni HTML antes de esto

// Conexión a la BD
require_once '../../config/conexion.php';

// Librería FPDF
require_once 'fpdf/fpdf.php';

// Conectar
$con = new ClaseConectar();
$conexion = $con->ProcedimientoConectar();

// Traer los servicios activos
$sql = "SELECT id, detalle, valor, estado FROM tiposervicio WHERE estado = 1 ORDER BY id ASC";
$resultado = mysqli_query($conexion, $sql);

// Clase PDF personalizada
class PDF extends FPDF
{
    function Header()
    {
        // Título
        $this->SetFont('Courier','B',14);
        $this->Cell(0,10,utf8_decode('Servicios Ofertados'),0,1,'C');
        $this->Ln(2);

        // Encabezado de tabla
        $this->SetFont('Courier','B',10);
        $this->SetFillColor(230,230,230);

        $this->Cell(10,7,'N°',1,0,'C',true);          // contador
        $this->Cell(110,7,'Servicio',1,0,'L',true);   // más ancho
        $this->Cell(30,7,'Valor',1,0,'C',true);
        $this->Cell(30,7,'Estado',1,1,'C',true);
    }

    function Footer()
    {
        $this->SetY(-15);
        $this->SetFont('Courier','I',8);
        $this->Cell(0,10,'Pagina '.$this->PageNo().'/{nb}',0,0,'C');
    }
}

$pdf = new PDF();
$pdf->AliasNbPages();
$pdf->AddPage();
$pdf->SetFont('Courier','',10);

// Llenar la tabla
$contador = 1;
while ($row = mysqli_fetch_assoc($resultado)) {
    $estadoTexto = $row['estado'] == 1 ? 'Activo' : 'No Activo';

    $pdf->Cell(10,6,$contador,1,0,'C');
    $pdf->Cell(110,6,utf8_decode($row['detalle']),1,0,'L');
    $pdf->Cell(30,6,$row['valor'],1,0,'C');
    $pdf->Cell(30,6,$estadoTexto,1,1,'C');

    $contador++;
}

// Cerrar conexión (opcional)
mysqli_close($conexion);

// Mostrar PDF en el navegador
$pdf->Output('I', 'Servicios_Mecanica.pdf');
