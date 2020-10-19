using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using EConector.Comunes;

namespace Entity.Enrutador
{
    /// <summary>
    /// Representa a EProvider en el sistema.
    /// </summary>
    public class EProvider
    {
        private string idProvider = string.Empty;
        private string dataProvider = string.Empty;
        private string connectionString = string.Empty;
        private Destinos tipoDestino = Destinos.Ninguno;

        /// <summary>
        /// Identificación de Proveedor.
        /// </summary>
        public string IdProvider
        {
            get { return idProvider; }
            set { idProvider = value; }
        }

        /// <summary>
        /// Proveedor de conexión.
        /// </summary>
        public string DataProvider
        {
            get { return dataProvider; }
            set { dataProvider = value; }
        }

        /// <summary>
        /// Cadena de conexión, path o URL.
        /// </summary>
        public string ConnectionString
        {
            get { return connectionString; }
            set { connectionString = value; }
        }

        /// <summary>
        /// Tipo de destino.
        /// </summary>
        public Destinos TipoDestino
        {
            get { return tipoDestino; }
            set { tipoDestino = value; }
        }
    }
}
