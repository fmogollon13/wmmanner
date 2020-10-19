using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Web.Script.Serialization;
using System.Text.RegularExpressions;
using WmDataAccessLayer;
using Data.Comunicacion;
using Entity.Comunicacion;
using Entity.Enrutador;
using Conector.Comunicacion;
using EConector.Comunes;

namespace Data.Enrutador
{
    /// <summary>
    /// Clase que gestiona la persistencia de datos de un Despachar
    /// </summary>
    public class DDespachar
    {
        /// <summary>
        /// Remite un despachar de acuerdo a lo indicado en el mapa de transacciones
        /// </summary>
        /// <param name="transaccion">Representación lógica de un Transaccion</param>
        /// <returns>
        /// Retorna cero si se ha guardado correctamente, valor distinto a cero
        /// si se presenta algún error.
        /// </returns>
        public string Remitir(ETransaccion transaccion, EProvider provider)
        {
            string sres = string.Empty;
            IConector conector;

            if (transaccion != null)
            {
                switch (transaccion.TipoDestino)
                {
                    case Destinos.ConectorWSJSon:
                        //Enviar transacción al WS
                        conector = null;
                        break;
                    case Destinos.ConectorDB:
                        //Enviar transacción al DB
                        conector = new ConectorDB();
                        break;
                    case Destinos.ConectorFS:
                        //Enviar transacción al FS
                        conector = null;
                        break;
                    case Destinos.ConectorWSObjeto:
                        //Enviar transacción al WS
                        conector = new ConectorWSObjeto();
                        break;
                    default:
                        conector = null;
                        break;
                }

                if (conector != null)
                {
                    EProveedor proveedor = new EProveedor()
                    {
                        Proveedor = provider.DataProvider,
                        CadenaConexion = provider.ConnectionString
                    };

                    sres = conector.Enviar(transaccion, proveedor);

                    if (sres != "104")
                        if (transaccion.Persiste && transaccion.Modo == 0)
                            Persistir(transaccion, sres);
                }
                else
                {
                    sres = "999";
                    Logger.ErrorLog.RegErrorDB(Logger.NivelDeError.Seis, sres, this.ToString(), "Remitir()", "Error ocurrido por falta de asignación de variables u objetos.");
                }
            }
            else
            {
                sres = "999";
                Logger.ErrorLog.RegErrorDB(Logger.NivelDeError.Seis, sres, this.ToString(), "Remitir()", "Error ocurrido por falta de asignación de variables u objetos.");
            }

            return sres;
        }

        /// <summary>
        /// Persiste los datos de la transacción.
        /// </summary>
        /// <param name="transaccion">Datos de la Transacción</param>
        /// <param name="resultado">Resultado del envío de la Transacción</param>
        private void Persistir(ETransaccion transaccion, string resultado)
        {
            string sres = string.Empty;
            int estado = 0;
            JavaScriptSerializer oSerializer = new JavaScriptSerializer();

            if (transaccion.TipoOperacion != Operacion.Registrar)
                estado = 1;
            //else
            //    if (resultado == "0")
            //        estado = 1;

            transaccion.Modo = 1;

            try
            {
                DataAccessLayerBaseClass dal = DataAccessLayerFactory.GetDataAccessLayer();
                IDataParameter[] opar = new IDataParameter[8];

                opar[0] = dal.CreateParameter("pCodigo", ParameterDirection.Output, null
                    , DbType.Int32, null, 0);
                opar[1] = dal.CreateParameter("pMensaje", ParameterDirection.Output, null
                    , DbType.String, null, 500);
                opar[2] = dal.CreateParameter("pCodigoTransaccion", ParameterDirection.Input, transaccion.Transaccion
                    , DbType.Int32, null, 0);
                opar[3] = dal.CreateParameter("pDatos", ParameterDirection.Input, oSerializer.Serialize(transaccion)
                    , DbType.StringFixedLength, null, 0);
                opar[4] = dal.CreateParameter("pRespuesta", ParameterDirection.Input, resultado
                    , DbType.StringFixedLength, null, 0);
                opar[5] = dal.CreateParameter("pEstado", ParameterDirection.Input, estado
                    , DbType.Double, null, 0);
                opar[6] = dal.CreateParameter("pTerminal", ParameterDirection.Input, transaccion.Terminal
                    , DbType.String, null, 0);
                opar[7] = dal.CreateParameter("pVersion", ParameterDirection.Input, transaccion.Version
                    , DbType.String, null, 0);

                int dae = dal.ExecuteQuery("Movil.sprRegistrarTransaccion", CommandType.StoredProcedure, opar);
                sres = "0";
            }
            catch (Exception ex)
            {
                sres = "201";
                Logger.ErrorLog.RegErrorDB(Logger.NivelDeError.Cinco, sres, this.ToString(), "Movil.sprRegistrarTransaccion", ex.Message + "|" + ex.StackTrace);
            }
        }

        private static bool EsNumerico(string strValor)
        {
            Regex objNotWholePattern = new Regex("[^0-9]");
            return !objNotWholePattern.IsMatch(strValor);
        }

        /// <summary>
        /// Actualiza el estado de la transacción pendiente a procesada.
        /// </summary>
        /// <param name="transaccion">Datos de la Transacción</param>
        /// <returns>
        /// Retorna cero si se ha guardado correctamente, valor distinto a cero
        /// si se presenta algún error.
        /// </returns>
        private string ActualizarTransaccion(ETransaccion transaccion)
        {
            string sres = string.Empty;
            int nres = 0;

            try
            {
                DataAccessLayerBaseClass dal = DataAccessLayerFactory.GetDataAccessLayer();
                IDataParameter[] opar = new IDataParameter[4];

                opar[0] = dal.CreateParameter("presult", ParameterDirection.Output, nres, DbType.Int32, null, 0);
                opar[1] = dal.CreateParameter("pmessage", ParameterDirection.Output, sres, DbType.String, null, 0);
                opar[2] = dal.CreateParameter("pidtransaccion", ParameterDirection.Input, transaccion.IdTransaccion, DbType.Guid, null, 0);
                opar[3] = dal.CreateParameter("pestado", ParameterDirection.Input, 1, DbType.Double, null, 0);

                int dae = dal.ExecuteQuery("sp_update_ps_transaccion", CommandType.StoredProcedure, opar);
            }
            catch (Exception ex)
            {
                sres = "201";
                Logger.ErrorLog.RegErrorDB(Logger.NivelDeError.Cinco, sres, this.ToString(), "sp_update_ps_transaccion", ex.Message + "|" + ex.StackTrace);
            }

            return sres;
        }
    }
}
