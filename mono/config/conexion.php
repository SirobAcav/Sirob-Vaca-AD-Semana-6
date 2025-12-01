<?php
class ClaseConectar
{
    public $conexion;
    protected $db;
    private $host = "localhost";
    private $usu  = "root";
    private $clave = "";
    private $base  = "mecanica";

    public function ProcedimientoConectar()
    {
        $this->conexion = mysqli_connect($this->host, $this->usu, $this->clave, $this->base);

        if (!$this->conexion) {
            die("Error al conectarse con MySQL: " . mysqli_connect_error());
        }

        mysqli_query($this->conexion, "SET NAMES utf8");

        // Ya pasaste la BD en mysqli_connect, realmente no hace falta esto,
        // pero si lo quieres dejar:
        $this->db = mysqli_select_db($this->conexion, $this->base);
        if (!$this->db) {
            die("Error conexión con la base de datos: " . mysqli_error($this->conexion));
        }

        return $this->conexion;
    }
}
?>
