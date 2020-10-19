using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using Entity.Comunicacion;
using Business.Enrutador;

namespace wmmanner
{
    /// <summary>
    /// Servicio Web que atiende las transacciones que las terminales solicitan.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class manner : System.Web.Services.WebService
    {
        #region Atributos
        private EEncabezado credencial = null;
        /// <summary>
        /// Información de encabezado que permite identificar quien realiza la transaccion y desde que terminal.
        /// </summary>
        public EEncabezado Credencial
        {
            get { return credencial; }
            set { credencial = value; }
        }
        #endregion

        #region Métodos
        [SoapHeader("Credencial")]
        [WebMethod(Description = "Registra los datos (planos) que envían las terminales.")]
        public string RegistrarDatos(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        [SoapHeader("Credencial")]
        [WebMethod(Description = "Entrega los datos (planos) solicitados por las terminales.")]
        public string ObtenerDatos(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        [WebMethod(Description = "Información de Operatividad del Servicio Web.")]
        public string IsAlive()
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.IsAlive();
        }

        [WebMethod(Description = "Entrega fecha y hora solicitados por los terminales portátiles")]
        public string Obtenerfechayhora()
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, "");
        }

        [WebMethod(Description = "Entrega Login solicitado por los terminales portátiles")]
        [SoapHeader("Credencial")]
        public string Obtenerlogin(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        [WebMethod(Description = "Entrega datos de Activos solicitados por los terminales portátiles")]
        public string ObtenerActivoaEjecutar(string datos)
        {

            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        [WebMethod(Description = "Entrega rol(es) por usuario solicitados por los terminales portátiles")]
        [SoapHeader("Credencial")]
        public string ObtenerUsuarioRol(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        [WebMethod(Description = "Entrega funcion(es) por rol solicitados por los terminales portátiles")]
        public string ObtenerRolFuncion(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        [WebMethod(Description = "Entrega Listas de ayuda solicitadas por los terminales portátiles")]
        public string ObtenerLista(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        //[WebMethod(Description = "Entrega Listas de ayuda solicitados por los terminales portátiles")]
        //public string ObtenerListaEditable(string datos)
        //{
        //    Enrutar enrutar = Enrutar.GetEnrutar();
        //    return enrutar.ProcesarTransaccion(credencial, datos);
        //}

        [WebMethod(Description = "Entrega Usuarios de la aplicación solicitados por los terminales portátiles")]
        public string ObtenerUsuario(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        [WebMethod(Description = "Registra Listas actualizadas que entregan las terminales portátiles")]
        public string RegistrarListaEditableEjecutada(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        [WebMethod(Description = "Registra logAct que entregan las terminales portátiles")]
        public string RegistrarLogTransaccionesAct(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        [WebMethod(Description = "Registra Activos que entregan las terminales portátiles")]
        public string RegistrarActivoEjecutado(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        #endregion

        #region Subir archivo plano
        [WebMethod(Description = "Indica el inicio de carga de archivo en el server.")]
        public bool IniciarSubidaArchivo(string rutaServer, out int maxChunkSize, out string fileHandle, out string msg)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.IniciarSubidaArchivo(rutaServer, out  maxChunkSize, out fileHandle, out msg);
        }

        [WebMethod(Description = "Sube una parte del archivo y la agrega al archivo temporal.")]
        [SoapDocumentMethod(OneWay = true)]
        public void SubirBloque(string rutaServer, string fileHandle, byte[] data, long startAt)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            enrutar.SubirBloque(rutaServer, fileHandle, data, startAt);
        }


        [WebMethod(Description = "Finaliza el envio de archivo, mueve el archivo temporal a la ruta de destino y elimina el archivo si este ya existia.")]
        public bool FinSubirArchivo(string rutaServer, string fileHandle, string nombreArchivo, string md5ArchOrig, out string msg)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.FinSubirArchivo(rutaServer, fileHandle, nombreArchivo, md5ArchOrig, out msg);
        }

        [WebMethod(Description = "Obtiene el estado actual del acrhivo basandose en handler dado.")]
        public long ObtenerEstado(string fileHandle, string rutaServer)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ObtenerEstado(fileHandle, rutaServer);
        }
        #endregion

        #region Descargar Archivo Plano
        [WebMethod(Description = "Retorna la información necesaria para la descarga de archivo desde el server.")]
        public bool ObtenerDatosDescarga(string rutaServer, string nombreArchivo, out long tamaArchivo, out string md5Arch, out string msg)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ObtenerDatosDescarga(rutaServer, nombreArchivo, out  tamaArchivo, out md5Arch, out msg);
        }

        [WebMethod(Description = "Descarga una parte del archivo.")]
        public bool BajarBloque(string rutaServer, string nombreArchivo, long posicion, int tamaPaquete, out byte[] datos, out string msg)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.BajarBloque(rutaServer, nombreArchivo, posicion, tamaPaquete, out datos, out msg);
        }

        [WebMethod(Description = "Retorna la informacion de version del app movil en el server.")]
        public bool ObtnenerFechaVersion(string rutaServer, string nombreArchivo, out DateTime fechaApp, out string msg)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ObtnenerFechaVersion(rutaServer, nombreArchivo, out fechaApp, out msg);
        }
        #endregion

        #region test de pruebas en revisiones unitarias
        [WebMethod(Description = "Pruebas")]
        public string ZTest()
        {
            credencial = new EEncabezado();
            credencial.Usuario = "123";
            credencial.Clave = "123";
            credencial.Terminal = "12231DB1212";
            credencial.Version = "0.0.0.1";

            //credencial.Usuario = "123";
            //credencial.Clave = "6kZaiRQFAxbCSlauEwrVxw==";
            //credencial.Terminal = "12231DB1212";
            //credencial.Version = "0.0.0.1";

            //credencial.Transaccion = 1; //ObtenerFechaHora
            //return fncpruebaObtenerfechayhora();

            string datos = "123";
            credencial.Transaccion = 2; //ObtenerLogin
            return fncpruebaObtenerlogin(datos);

            //string datos = "";
            //credencial.Transaccion = 3; //ObtenerUsuarioRol
            //return fncpruebaObtenerUsuarioRol(datos);

            
            //string datos = "";
            //credencial.Transaccion = 4; //ObtenerRolFuncion
            //return fncpruebaObtenerRolFuncion(datos);

            //string datos = " {'CentroCosto': '2087', 'Ubicacion': '', 'CCresponsable': ''}";
            //credencial.Transaccion = 5; //ObtenerActivo
            //return fncpruebaObtenerActivoaEjecutar(datos);

            //string datos = " {'pidtabla': '0', 'pversion': '0'}";
            //credencial.Transaccion = 6; //ObtenerListaEditable
            //return fncpruebaObtenerListaEditable(datos);

            //string datos = " {'pidtabla': '0', 'pversion': '0'}";
            //credencial.Transaccion = 7; //ObtenerLista
            //return fncpruebaObtenerLista(datos);

            //string datos = " {'DescripcionActivo': 'PLACA de PRUEBA...', 'PlacaInventario': '12134567', 'CodigoBarras': '', 'FechaInventario': '2014/01/21 15:20:00', 'CentroCosto': '2072', 'Ubicacion': '21314564SD', 'EstadoFisico': '1', 'CCResponsable': '1234', 'TipoActivo': 'A', 'NumeroSerie': '', 'Observacion': 'PRUEBAS WEB', 'Actividad': 'M', 'Modificado': '0', 'Leido': '1', 'Operador': '1', 'CodigoNuevo': '', 'RutaImagen': '', 'Estado': '5', 'Aux1': ''}";
            //credencial.Transaccion = 8; //RegistrarActivoEjecutado
            //return fncpruebaRegistrarActivoEjecutado(datos);

            //string datos = " {'idlista': 4, 'Codigo': '1234', 'detalle': 'Item de Prueba', 'idnuevo': 'N'}";
            //credencial.Transaccion = 9; //RegistrarListaEditableEjecutada
            //return fncpruebaRegistrarListaEditableEjecutada(datos);

            //string datos = " {'login': '1', 'codigoEvento': 'I', 'fechaLectura': '2014/01/21 14:20:00', 'indicador': 1, 'origenEvento': '12223D112', 'datosEvento': '124556PLACA de PRUEBA...', 'seEnvio': 1}";
            //credencial.Transaccion = 10; //RegistrarLogTransaccionesAct
            //return fncpruebaRegistrarLogTransaccionesAct(datos);

            //string datos = "";
            //credencial.Transaccion = 11; //ObtenerUsuario
            //return fncpruebaObtenerUsuario(datos);
        }

        private string fncpruebaObtenerfechayhora()
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, "");
        }

        private string fncpruebaObtenerlogin(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        private string fncpruebaObtenerActivoaEjecutar(string datos)
        {

            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        private string fncpruebaObtenerUsuarioRol(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        private string fncpruebaObtenerRolFuncion(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        private string fncpruebaObtenerLista(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        private string fncpruebaObtenerListaEditable(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        private string fncpruebaObtenerUsuario(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        private string fncpruebaRegistrarListaEditableEjecutada(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        private string fncpruebaRegistrarLogTransaccionesAct(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }

        private string fncpruebaRegistrarActivoEjecutado(string datos)
        {
            Enrutar enrutar = Enrutar.GetEnrutar();
            return enrutar.ProcesarTransaccion(credencial, datos);
        }
        #endregion

    }
}
