using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Data.Comunicacion;

namespace Business.Comunicacion
{
    class Archivo
    {
        #region Subir archivo
        internal bool IniciarSubidaArchivo(string rutaServer, out int maxChunkSize, out string fileHandle, out string msg)
        {
            return DArchivo.Instance.IniciarSubidaArchivo(rutaServer, out  maxChunkSize, out fileHandle, out msg);
        }

        internal void SubirBloque(string rutaServer, string fileHandle, byte[] data, long startAt)
        {
            DArchivo.Instance.SubirParte(rutaServer, fileHandle, data, startAt);
        }

        internal bool FinSubirArchivo(string rutaServer, string fileHandle, string nombreArchivo, string md5ArchOrig, out string msg)
        {
            return DArchivo.Instance.FinalizarSubidaArchivo(rutaServer, fileHandle, nombreArchivo, md5ArchOrig, out msg);
        }

        internal long ObtenerEstado(string fileHandle, string rutaServer)
        {
            return DArchivo.Instance.EstadoDeTransaccion(fileHandle, rutaServer);
        }
        #endregion

        #region Darcargar archivo
        internal bool ObtenerDatosDescarga(string rutaServer, string nombreArchivo, out long tamaArchivo, out string md5Arch, out string msg)
        {
            return DArchivo.Instance.ObtenerDatosDescarga(rutaServer, nombreArchivo, out tamaArchivo, out md5Arch, out msg);
        }

        internal bool BajarBloque(string rutaServer, string nombreArchivo, long posicion, int tamaPaquete, out byte[] datos, out string msg)
        {
            return DArchivo.Instance.BajarParte(rutaServer, nombreArchivo, posicion, tamaPaquete, out datos, out msg);
        }

        internal bool ObtnenerFechaVersion(string rutaServer, string nombreArchivo, out DateTime fechaApp, out string msg)
        {
            return DArchivo.Instance.ObtenerFechaUltimaVersion(rutaServer, nombreArchivo, out fechaApp, out msg);
        }
        #endregion

        #region Darcargar RS de la BD

        #endregion
    }
}
