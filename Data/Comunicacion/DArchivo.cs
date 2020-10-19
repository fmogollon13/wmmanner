using System;
using System.IO;
using System.Security.Cryptography;
using System.Net;

namespace Data.Comunicacion
{
    public sealed class DArchivo
    {
        #region Clase Singleton
        private static DArchivo instance = null;
        private static readonly object padlock = new object();

        /// <summary>
        /// Contructor
        /// </summary>
        DArchivo() { }

        public static DArchivo Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new DArchivo();
                    }

                    return instance;
                }
            }
        }
        #endregion

        /// <summary>
        /// Calcular el checksum del archivo
        /// </summary>
        private static MD5 md5 = MD5.Create();

        #region Subir archivos
        /// <summary>
        /// Indica el inicio de carga de archivo en el server.
        /// </summary>
        /// <param name="maxChunkSize">Salida que contiene el tamaño maximo de las partes (chunk) a enviar a este webservice.</param>
        /// <param name="rutaServer">Ruta donde Se guardara el archivo en el server, ej: C:\\Aploclec\\Datos\\ </param>
        /// <param name="fileHandle">Handle que se debe pasar con cada llamada adicional con respecto a carga del archivo que fue anunciado al llamar a este método. </param>
        /// <param name="msg">Mensaje en caso de error </param>
        /// <returns>true: si la operacion es exitosa, de lo contrario retorna false</returns>
        public bool IniciarSubidaArchivo(string rutaServer, out int maxChunkSize, out string fileHandle, out string msg)
        {
            maxChunkSize = 100 * 1024;    // This server will not allow more than 100KB to be sent in one call
            fileHandle = "";
            msg = "Inicio ok, ";
            string nombreArch = "";
            try
            {
                // Now we will create a temporary file in temporary directory
                // File name will be in form _partNNN.dat, where NNN is a three-digit unique number
                // This unique number will then be returned as file handle

                DirectoryInfo dir = new DirectoryInfo(rutaServer);
                if (!dir.Exists)
                {
                    dir.Create();
                }
                msg += "Ruta de envio: " + dir.FullName;
                Random rnd = new Random();
                int n = 0;

                do
                {
                    n = rnd.Next(1000);
                    nombreArch = string.Format("_part{0:000}.dat", n);
                }
                while (dir.GetFiles(nombreArch).Length > 0);

                // At this point we have obtained unique name which is identified by number n

                FileStream fs = new FileStream(dir.FullName + "\\" + nombreArch, FileMode.CreateNew);
                fs.Close();

                // Now we have created a file of size zero, which is server-side representative of the file handle
                // Finally, return handle to the caller
                fileHandle = n.ToString("000");

            }
            catch (Exception ex)
            {
                EliminarArchivoTemporal(rutaServer + "\\" + nombreArch);
                msg = "Excepcion en Web Service: " + ex.Message;
                return false;
            }

            return true;
        }

        /// <summary>
        /// Sube una Parte del Archivo la agrega al archivo temporarl
        /// </summary>
        /// <param name="rutaServer">Ruta donde Se guardara el archivo en el server, ej: C:\\Aploclec\\Datos\\ </param>
        /// <param name="fileHandle">Handle que se debe pasar con cada llamada adicional</param>
        /// <param name="data">cadena del archivo</param>
        /// <param name="startAt">inicio de la parte</param>
        public void SubirParte(string rutaServer, string fileHandle, byte[] data, long startAt)
        {
            string nombreArch = "";
            try
            {
                nombreArch = "\\_part" + fileHandle + ".dat";
                FileInfo fi = new FileInfo(rutaServer + nombreArch);

                // Perform validation
                if (!fi.Exists || fi.Length != startAt)
                {
                    // Do whatever needs to be done when validation fails
                    throw new Exception("Archivo Temporal No existe o partes no coinciden, reinicie el proceso!");
                }

                // When validation has passed, 
                using (FileStream fs = new FileStream(fi.FullName, FileMode.Append))
                {
                    fs.Write(data, 0, data.Length);
                }
            }
            catch (Exception ex)
            {
                EliminarArchivoTemporal(rutaServer + nombreArch);
                throw new Exception("Excepcion en Web Service: " + ex.Message);
            }
        }

        /// <summary>
        /// Finaliza el envio de archivo,Mueve el archivo temporal al la ruta de destino
        /// elimina el archivo si este ya existia.
        /// </summary>
        /// <param name="rutaServer">Ruta donde Se guardara el archivo en el server, ej: C:\\Aploclec\\Datos\\ </param>
        /// <param name="fileHandle">Handle que se debe pasar con cada llamada adicional</param>
        /// <param name="nombreArchivo"> nombre del archivo a guardar en el server ej:Instalador.cab</param>
        /// <param name="md5ArchOrig">Suma de verificaion del archivo original para ser comprado con el archivo en el server </param>
        /// <param name="msg">Mensaje en caso de error </param>
        /// <returns>true: si la operacion es exitosa, de lo contrario retorna false</returns>
        public bool FinalizarSubidaArchivo(string rutaServer, string fileHandle, string nombreArchivo, string md5ArchOrig, out string msg)
        {
            string nombreTmp = "";
            FileStream archivo = null;
            try
            {
                nombreTmp = "\\_part" + fileHandle + ".dat";
                string rutaArchLocal = rutaServer + "\\" + nombreArchivo;
                string rutaTmpArchLocal = rutaServer + nombreTmp;

                if (!File.Exists(rutaTmpArchLocal))//validar la ecistencia del archivo temporal
                {
                    msg = "Archivo Temporal no existe";
                    return false;
                }

                if (File.Exists(rutaArchLocal))//eliminar archivo existente
                {
                    File.Delete(rutaArchLocal);
                }

                #region comparar md5 del archivo en el server y el archivo descargado

                #region obtener md5 del archivo subido al server

                string md5ArchDest;
                using (archivo = File.OpenRead(rutaTmpArchLocal))
                {
                    byte[] checksum = md5.ComputeHash(archivo);
                    md5ArchDest = BitConverter.ToString(checksum).Replace("-", string.Empty); // hex string
                    //archivo.Close();
                }

                #endregion

                if (string.IsNullOrEmpty(md5ArchDest) || string.IsNullOrEmpty(md5ArchOrig))
                {
                    msg = "No fue posible verificar el archivo descargado" + rutaTmpArchLocal;
                    return false;
                }

                if (!String.Equals(md5ArchOrig, md5ArchDest, StringComparison.Ordinal))
                {
                    msg = "El archivo Descargado no concuerda con el original en el server" + rutaTmpArchLocal;
                    return false;
                }

                #endregion


                File.Move(rutaTmpArchLocal, rutaArchLocal);
                msg = "Subida de archivo Finalizada Correctamente";
            }
            catch (Exception ex)
            {
                //if (archivo != null)
                //{
                //    archivo.Close();
                //}

                msg = "Excepcion en Web Service: " + ex.Message;
                EliminarArchivoTemporal(rutaServer + nombreTmp);
                return false;
            }

            return true;
        }

        /// <summary>
        /// Obtiene el estado actual del acrhivo basandose en handler dado.
        /// </summary>
        /// <param name="fileHandle">Handle que se debe pasar con cada llamada adicional </param>
        /// <param name="rutaServer">Ruta donde Se guardara el archivo en el server, ej: C:\\Aploclec\\Datos\\</param>
        /// <returns>Valor indicando la longitud actual del archivo subido</returns>
        public long EstadoDeTransaccion(string fileHandle, string rutaServer)
        {
            FileInfo fi = new FileInfo(rutaServer + "\\_part" + fileHandle + ".dat");
            long pos = (fi.Exists ? fi.Length : 0);
            return pos;
        }

        private bool EliminarArchivoTemporal(string fullRutaNombre)
        {
            try
            {
                if (File.Exists(fullRutaNombre))
                {
                    File.Delete(fullRutaNombre);
                }
            }
            catch (Exception)
            {
                return false;
            }

            return true;
        }

        #endregion

        #region Bajar archivos
        /// <summary>
        /// retorna la informacion necesaria para la descarga de archivo desde el server
        /// </summary>
        /// <param name="nombreArchivo">Nombre del archivo a descargar ej: instalador.cab </param>
        /// <param name="rutaServer">Ruta donde Se buscara el archivo en el server, ej: C:\\Aploclec\\Datos\\ </param>
        /// <param name="tamaArchivo">tamaño del archivo a descargar </param>
        /// <param name="md5Archivo">suma de verificacion del archivo a descargar </param>
        /// <param name="msg">Mensaje en caso de error </param>
        /// <returns>true: si la operacion es exitosa, de lo contrario retorna false</returns>
        public bool ObtenerDatosDescarga(string rutaServer, string nombreArchivo, out long tamaArchivo, out string md5Archivo, out string msg)
        {
            tamaArchivo = 0;
            md5Archivo = string.Empty;
            FileStream archivo = null;

            try
            {
                #region verificar que el archivo existe

                var fi = new FileInfo(rutaServer + nombreArchivo);
                if (!fi.Exists)
                {
                    msg = "Archivo a descargar: " + rutaServer + nombreArchivo + " no existe o no se tiene acceso";
                    return false;
                }
                tamaArchivo = fi.Length;

                #endregion

                #region obtener md5 del archivo

                using (archivo = File.OpenRead(fi.FullName))
                {
                    byte[] checksum = md5.ComputeHash(archivo);
                    md5Archivo = BitConverter.ToString(checksum).Replace("-", string.Empty); // hex string
                    //archivo.Close();
                }
                #endregion

                msg = "Inicio descarga archivo ok, Ruta de descarga: " + rutaServer + nombreArchivo;
                return true;
            }
            catch (Exception ex)
            {
                //if (archivo != null)
                //{
                //    archivo.Close();
                //}

                msg = "Excepcion en Web Service: " + ex.Message;
                return false;
            }
        }

        /// <summary>
        /// retorna la informacion de version del app movil en el server
        /// </summary>
        /// <param name="nombreArchivo">Nombre del archivo a descargar ej: instalador.cab </param>
        /// <param name="rutaServer">Ruta donde Se buscara el archivo en el server, ej: C:\\Aploclec\\Datos\\ </param>
        /// <param name="version">Numero de version que hay en server</param>
        /// <param name="msg">Mensaje en caso de error </param>
        /// <returns>true: si la operacion es exitosa, de lo contrario retorna false</returns>
        public bool ObtenerFechaUltimaVersion(string rutaServer, string nombreArchivo, out DateTime fechaUltimaVersion, out string msg)
        {
            //FileStream archivo = null;
            fechaUltimaVersion = DateTime.Now;

            try
            {
                //validar que el archivo exista
                var fi = new FileInfo(rutaServer + nombreArchivo);
                if (!fi.Exists)
                {
                    msg = "ObtenerDatosVersion: " + rutaServer + nombreArchivo + " no existe o no se tiene acceso";
                    return false;
                }

                fechaUltimaVersion = fi.LastWriteTime;
                msg = "ObtenerDatosVersion, ruta: " + rutaServer + nombreArchivo;
                return true;
            }
            catch (Exception ex)
            {
                msg = "Excepcion en Web Service: " + ex.Message;
                return false;
            }
        }


        /// <summary>
        /// descarga una Parte del Archivo
        /// </summary>
        /// <param name="rutaServer">Ruta en el server donde se encuentra el archivo a descargar, ej: C:\\Aploclec\\Datos\\ </param>
        /// <param name="nombreArchivo">Nombre del archivo a descargar ej: instalador.cab</param>
        /// <param name="tamaPaquete">porcion a leer del acrhivo</param>
        /// <param name="datos">porcion de dato leida del acrhivo plano</param>
        /// <param name="posInicio">posicion iniciar a leer</param>
        /// <param name="mensaje">Mensaje en caso de error </param>
        public bool BajarParte(string rutaServer, string nombreArchivo, long posInicio, int tamaPaquete, out byte[] datos, out string mensaje)
        {
            datos = null;
            mensaje = string.Empty;
            byte[] tmpBuffer;
            int bytesRead;
            FileStream fs = null;

            string rutaArchivo = rutaServer + nombreArchivo;

            #region validar que el acrhivo exista

            var fi = new FileInfo(rutaArchivo);
            if (!fi.Exists)
            {
                mensaje = "Archivo a descargar: " + rutaArchivo + " no existe o no se tiene acceso";
                return false;
            }

            #endregion

            long tamaArchivo = fi.Length;

            #region validar posicion de incio y tamaño de archivo

            if (posInicio > tamaArchivo)
            {
                mensaje = "posicion de inicio incorrecta - " + String.Format("el tamaño del acrhivo es {0}, posicion in {1}", tamaArchivo, posInicio);
                return false;
            }

            #endregion

            try
            {
                #region inciar lectura de porcion de datos

                using (fs = new FileStream(rutaArchivo, FileMode.Open, FileAccess.Read, FileShare.Read))
                {
                    fs.Seek(posInicio, SeekOrigin.Begin);	// this is relevent during a retry. otherwise, it just seeks to the start
                    tmpBuffer = new byte[tamaPaquete];
                    bytesRead = fs.Read(tmpBuffer, 0, tamaPaquete);	// read the first chunk in the buffer (which is re-used for every chunk)
                }

                if (bytesRead != tamaPaquete)
                {
                    // the last chunk will almost certainly not fill the buffer, so it must be trimmed before returning
                    byte[] trimmedBuffer = new byte[bytesRead];
                    Array.Copy(tmpBuffer, trimmedBuffer, bytesRead);
                    datos = trimmedBuffer;
                    mensaje = "ultima parte";
                }
                else
                {
                    datos = tmpBuffer;
                }

                return true;

                #endregion
            }
            catch (System.UnauthorizedAccessException exc)
            {
                //if (fs != null)
                //{
                //    fs.Close();
                //}
                mensaje = "No se pudo acceder el archivo," + exc.Message;
                datos = null;
                return false;
            }
            catch (Exception ex)
            {
                //if (fs != null)
                //{
                //    fs.Close();
                //}
                mensaje = "Excepcion en Web Service al descargar parte, " + ex.Message;
                datos = null;
                return false;
            }
        }
        #endregion

        #region Anterior
        private string Escribir(string archivo, DateTime fechacreado, byte[] trama)
        {
            string sres = string.Empty;
            string spath = System.Configuration.ConfigurationManager.AppSettings["FilePath"];
            string usuario = System.Configuration.ConfigurationManager.AppSettings["Usuario"];
            string clave = System.Configuration.ConfigurationManager.AppSettings["Clave"];
            string dominio = System.Configuration.ConfigurationManager.AppSettings["Dominio"];

            string sarch = string.Empty, sapat = string.Empty;

            try
            {
                if (!spath.EndsWith("\\"))
                    spath += "\\";

                sapat += ExtaerPath(archivo);
                if (sapat != string.Empty)
                    sarch = archivo.Replace(sapat, string.Empty);
                else
                    sarch = archivo;

                spath += sapat;

                using (new NetworkConnection(spath, new NetworkCredential(usuario, clave, dominio)))
                {
                    if (!Directory.Exists(spath))
                        Directory.CreateDirectory(spath);

                    if (!File.Exists(spath + sarch))
                    {
                        using (BinaryWriter writer = new BinaryWriter(File.Open(spath + sarch, FileMode.Append)))
                        {
                            writer.Write(trama);
                        }
                        File.SetCreationTime(spath + sarch, fechacreado);
                        sres = "0";
                    }
                    else
                        sres = "404";
                }
            }
            catch (Exception ex)
            {
                sres = "402";
                Logger.ErrorLog.RegErrorDB(Logger.NivelDeError.Seis, sres, this.ToString(), "Escribir()", ex.Message + "|" + ex.StackTrace);
            }
            return sres;
        }

        private string ExtaerPath(string archivo)
        {
            string spath = string.Empty;
            string[] sdivi = archivo.Split('\\');

            for (int i = 0; i < sdivi.Length - 1; i++)
            {
                if (sdivi[i] != string.Empty)
                    spath += sdivi[i] + "\\";
            }

            return spath;
        }
        #endregion
    }
}
