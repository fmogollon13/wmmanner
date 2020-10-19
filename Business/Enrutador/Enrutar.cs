using System;
using System.Collections.Generic;
using System.Xml;
using System.Configuration;
using Data.Enrutador;
using Entity.Comunicacion;
using Entity.Enrutador;
using System.Text;

namespace Business.Enrutador
{
    /// <summary>
    /// Clase que genera las reglas de negocio para Enrutar.
    /// Tipo 'Singleton'.
    /// </summary>
    public class Enrutar
    {
        private static Enrutar instance = null;
        private static DEnrutar mapa = new DEnrutar();

        // Objeto de bloqueo de sincronización 
        private static object syncLock = new object();

        // Constructor (protected)
        protected Enrutar()
        {
            InicializarLog();
            CargarListaTransacciones();
        }

        public static Enrutar GetEnrutar()
        {
            // Soporta las aplicaciones multiproceso a través del patron
            // 'Control de bloqueo doble' el cual (una vez que la instancia existe)
            // evita bloqueos cada vez que se invoca el método
            if (instance == null)
            {
                lock (syncLock)
                {
                    if (instance == null)
                    {
                        instance = new Enrutar();
                    }
                }
            }

            return instance;
        }

        private void InicializarLog()
        {
            Logger.ErrorLog.AppInfo = System.Reflection.Assembly.GetAssembly(this.GetType());
            Logger.ErrorLog.ErrorLevel = short.Parse(ConfigurationManager.AppSettings["ErrorLevel"]);
            Logger.ErrorLog.LogPath = ConfigurationManager.AppSettings["LogPath"];
        }

        /// <summary>
        /// Gestiona las reglas de negocio para crear un Enrutar.
        /// </summary>
        private void CargarListaTransacciones()
        {
            mapa.CargarListaTransacciones();
        }

        /// <summary>
        /// Procesa la transacción solicitada.
        /// </summary>
        /// <param name="credencial">Representación lógica de un encabezado.</param>
        /// <param name="datos">Recibe una cadena de texto en formato JSon.</param>
        /// <returns>
        /// Retorna código de error o datos solicitados por el cliente de la aplicación.
        /// </returns>
        public string ProcesarTransaccion(EEncabezado credencial, string datos)
        {
            string sres = string.Empty, sred = string.Empty;
            Autorizador autorizador = new Autorizador();
            Despachar despachar = new Despachar();

            if (credencial != null)
            {

                if (autorizador.ValidarUsuario(credencial.Usuario, credencial.Clave))
                {
                    if (mapa.Transacciones.Count > 0)
                    {
                        foreach (EEnrutar item in mapa.Transacciones)
                        {
                            if (item.Transaccion == credencial.Transaccion)
                            {
                                foreach (EDestino destino in item.Destinos)
                                {
                                    sred = despachar.Remitir(credencial, datos, destino
                                        , mapa.Proveedores.Find(delegate(EProvider e) { return e.IdProvider == destino.Conexion; })
                                        , item.TipoOperacion, item.Evento);
                                    // REVISAR CUANDO DEVUELVE EL ERROR A LA TERMINAL
                                    // CUANDO ALGUNOS DE LOS DETINOS GENERA ERROR??????????
                                    if (sres == string.Empty)
                                        sres = sred;
                                    //else
                                    //    if (sred == "0")
                                    //        sres = sred;
                                }
                                break;
                            }
                        }
                    }
                    else
                    {
                        sres = "103"; // Mapa de transacciones vacio.
                        Logger.ErrorLog.RegErrorDB(Logger.NivelDeError.Tres, sres, this.ToString(), "ProcesarTransaccion()", "Mapa de transacciones vacio.");
                    }
                }
                else
                {
                    sres = "102: " + credencial.Usuario + ", " + credencial.Clave; // Usuario o clave no valido.
                    Logger.ErrorLog.RegErrorDB(Logger.NivelDeError.Tres, sres, this.ToString(), "ProcesarTransaccion()", "Usuario o clave no valido.");
                }
            }
            else
            {
                sres = "101"; // No ha ingresado datos que identifican al usuario que solicita la transacción.
                Logger.ErrorLog.RegErrorDB(Logger.NivelDeError.Tres, sres, this.ToString(), "ProcesarTransaccion()", "No ha ingresado datos que identifican al usuario que solicita la transacción.");
            }

            if (sres == string.Empty)
            {
                sres = "999"; // No se pudo procesar transacción.
                Logger.ErrorLog.RegErrorDB(Logger.NivelDeError.Tres, sres, this.ToString(), "ProcesarTransaccion()", "No se pudo procesar transacción.");
            }

            return sres;
        }

        public string IsAlive()
        {
            string Alive = "0";

            if (Logger.ErrorLog.RegErrorDB(Logger.NivelDeError.Uno, "IsAlive", this.ToString(), string.Empty, string.Empty))
                Alive = "Logger: Bien";
            else
                Alive = "Logger: MAL";

            DEnrutar denrutar = new DEnrutar();

            return Alive;
        }

        #region Subir archivo
        public bool IniciarSubidaArchivo(string rutaServer, out int maxChunkSize, out string fileHandle, out string msg)
        {
            Comunicacion.Archivo archivo = new Comunicacion.Archivo();
            string ruta = ObtenerRutaLocal(rutaServer);

            return archivo.IniciarSubidaArchivo(ruta, out  maxChunkSize, out fileHandle, out msg);
        }

        public void SubirBloque(string rutaServer, string fileHandle, byte[] data, long startAt)
        {
            Comunicacion.Archivo archivo = new Comunicacion.Archivo();
            string ruta = ObtenerRutaLocal(rutaServer);

            archivo.SubirBloque(ruta, fileHandle, data, startAt);
        }

        public bool FinSubirArchivo(string rutaServer, string fileHandle, string nombreArchivo, string md5ArchOrig, out string msg)
        {
            Comunicacion.Archivo archivo = new Comunicacion.Archivo();
            string ruta = ObtenerRutaLocal(rutaServer);

            return archivo.FinSubirArchivo(ruta, fileHandle, nombreArchivo, md5ArchOrig, out msg);
        }

        public long ObtenerEstado(string fileHandle, string rutaServer)
        {
            Comunicacion.Archivo archivo = new Comunicacion.Archivo();
            string ruta = ObtenerRutaLocal(rutaServer);

            return archivo.ObtenerEstado(fileHandle, ruta);
        }
        #endregion

        #region Descargar archivo
        public bool ObtenerDatosDescarga(string rutaServer, string nombreArchivo, out long tamaArchivo, out string md5Arch, out string msg)
        {
            Comunicacion.Archivo archivo = new Comunicacion.Archivo();
            string ruta = ObtenerRutaLocal(rutaServer);

            return archivo.ObtenerDatosDescarga(ruta, nombreArchivo, out tamaArchivo, out md5Arch, out msg);
        }

        public bool BajarBloque(string rutaServer, string nombreArchivo, long posicion, int tamaPaquete, out byte[] datos, out string msg)
        {
            Comunicacion.Archivo archivo = new Comunicacion.Archivo();
            string ruta = ObtenerRutaLocal(rutaServer);

            return archivo.BajarBloque(ruta, nombreArchivo, posicion, tamaPaquete, out datos, out msg);
        }

        public bool ObtnenerFechaVersion(string rutaServer, string nombreArchivo, out DateTime fechaApp, out string msg)
        {
            Comunicacion.Archivo archivo = new Comunicacion.Archivo();
            string ruta = ObtenerRutaLocal(rutaServer);

            return archivo.ObtnenerFechaVersion(ruta, nombreArchivo, out fechaApp, out msg);
        }
        #endregion

        #region Metodo local
        private string ObtenerRutaLocal(string rutaServer)
        {
            StringBuilder ruta = new StringBuilder();

            ruta.Append(ConfigurationManager.AppSettings["FilePath"]);
            if (!ruta.ToString().EndsWith("\\"))
                ruta.Append("\\");
            if (rutaServer.StartsWith("\\"))
                ruta.Append(rutaServer.Substring(1));
            else
                ruta.Append(rutaServer);
            if (!rutaServer.EndsWith("\\"))
                ruta.Append("\\");

            return ruta.ToString();
        }
        #endregion
    }
}
