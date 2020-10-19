using System;
using System.Collections.Generic;
using EConector.Comunes;

namespace Entity.Enrutador
{
    /// <summary>
    /// Representa un Enrutar en el sistema.
    /// </summary>
    public class EEnrutar
    {
        private int transaccion = 0;
        private Operacion tipoOperacion = Operacion.Obtener;
        private short evento = 0;
        private List<EDestino> destinos = new List<EDestino> { };

        /// <summary>
        /// Código que identifica el tipo de transacción.
        /// </summary>
        public int Transaccion
        {
            get { return transaccion; }
            set { transaccion = value; }
        }

        /// <summary>
        /// Tipo de operación de la transacción; Registrar u Obtener.
        /// </summary>
        public Operacion TipoOperacion
        {
            get { return tipoOperacion; }
            set { tipoOperacion = value; }
        }

        /// <summary>
        /// Evento de transacción
        /// </summary>
        public short Evento
        {
            get { return evento; }
            set { evento = value; }
        }

        /// <summary>
        /// Destino de la transacción.
        /// </summary>
        public List<EDestino> Destinos
        {
            get { return destinos; }
            set { destinos = value; }
        }
    }
}
