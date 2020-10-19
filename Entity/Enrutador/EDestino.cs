using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EConector.Comunes;

namespace Entity.Enrutador
{
    /// <summary>
    /// Representa un Destino en el sistema.
    /// </summary>
    public class EDestino
    {
        private string conexion = string.Empty;
        private int tiempoEspera = 0;
        private int reintentos = 0;
        private int tiempoReintento = 0;
        private Destinos tipoDestino = 0;
        private bool esObjeto = false;
        private bool persiste = false;
        private string usuario = string.Empty;
        private string clave = string.Empty;
        private string dominio = string.Empty;

        /// <summary>
        /// Cadena de conexión.
        /// </summary>
        public string Conexion
        {
            get { return conexion; }
            set { conexion = value; }
        }

        /// <summary>
        /// Tiempo de espera ejecutando la transacción (timeout).
        /// </summary>
        public int TiempoEspera
        {
            get { return tiempoEspera; }
            set { tiempoEspera = value; }
        }

        /// <summary>
        /// Número de reintetos cuando falla una transacción.
        /// </summary>
        public int Reintentos
        {
            get { return reintentos; }
            set { reintentos = value; }
        }

        /// <summary>
        /// Tiempo entre reintentos.
        /// </summary>
        public int TiempoReintento
        {
            get { return tiempoReintento; }
            set { tiempoReintento = value; }
        }

        /// <summary>
        /// Tipo de destino
        /// ConectorWS,
        /// ConectorDB,
        /// ConectorFS.
        /// </summary>
        public Destinos TipoDestino
        {
            get { return tipoDestino; }
            set { tipoDestino = value; }
        }

        /// <summary>
        /// Indica si se debe convertir la cadena a un objeto (clase).
        /// </summary>
        public bool EsObjeto
        {
            get { return esObjeto; }
            set { esObjeto = value; }
        }

        /// <summary>
        /// Indica si la transacción persiste información.
        /// </summary>
        public bool Persiste
        {
            get { return persiste; }
            set { persiste = value; }
        }

        /// <summary>
        /// Usuario que puede acceder a la carpeta de red.
        /// </summary>
        public string Usuario
        {
            get { return usuario; }
            set { usuario = value; }
        }

        /// <summary>
        /// Clave de acceso a la carpeta de red.
        /// </summary>
        public string Clave
        {
            get { return clave; }
            set { clave = value; }
        }

        /// <summary>
        /// Dominio del usuario que accede a la carpeta de red.
        /// </summary>
        public string Dominio
        {
            get { return dominio; }
            set { dominio = value; }
        }
    }
}
