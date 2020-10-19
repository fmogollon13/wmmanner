using System;
using System.Web.Services.Protocols;

namespace Entity.Comunicacion
{
    /// <summary>
    /// Representa un Encabezado en el sistema.
    /// </summary>
    public class EEncabezado : SoapHeader
    {
        private string usuario = string.Empty;
        private string clave = string.Empty;
        private string terminal = string.Empty;
        private string version = string.Empty;
        private int transaccion = 0;

        /// <summary>
        /// Usuario del terminal que se identifica ante el sistema central.
        /// </summary>
        public string Usuario
        {
            get { return usuario; }
            set { usuario = value; }
        }

        /// <summary>
        /// Clave del usuario que permite el acceso al sistema central.
        /// </summary>
        public string Clave
        {
            get { return clave; }
            set { clave = value; }
        }

        /// <summary>
        /// Número o serial de identificación de la terminal.
        /// </summary>
        public string Terminal
        {
            get { return terminal; }
            set { terminal = value; }
        }

        /// <summary>
        /// Versión de la aplicación Sipas instala en la terminal.
        /// </summary>
        public string Version
        {
            get { return version; }
            set { version = value; }
        }

        /// <summary>
        /// Código que identifica el tipo de transacción solicitada por la terminal.
        /// </summary>
        public int Transaccion
        {
            get { return transaccion; }
            set { transaccion = value; }
        }
    }
}
