using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;
using System.Data;
using WmDataAccessLayer;

namespace Data.Enrutador
{
    public class DAutorizador
    {
        public bool ValidarUsuario(string usuario, string clave)
        {
            bool bres = false;
            DataAccessLayerBaseClass dal = DataAccessLayerFactory.GetDataAccessLayer();
            IDataParameter[] opar = new IDataParameter[4];
            
            //string claveTemporal = Data.Comunicacion.DCifrar.DescifrarCadena(clave);
            //claveTemporal = Data.Comunicacion.DCifrar.DescifrarCadena(claveTemporal);
            string claveTemporal = clave;

            try
            {
                opar[0] = dal.CreateParameter("pCodigo", ParameterDirection.Output, null, DbType.Int32, null, 0);
                opar[1] = dal.CreateParameter("pMensaje", ParameterDirection.Output, null, DbType.String, null, 500);
                //opar[2] = dal.CreateParameter("pUsuario", ParameterDirection.Input, usuario, DbType.String, "", 0);
                opar[2] = dal.CreateParameter("pUsuario", ParameterDirection.Input, int.Parse(usuario), DbType.Int32, "", 0);

                string ClaveTmp = Cifrar.Seguridad.Cifrado.CifrarAESaBase64(claveTemporal);

                opar[3] = dal.CreateParameter("pClave", ParameterDirection.Input
                    , Cifrar.Seguridad.Cifrado.CifrarAESaBase64(claveTemporal)
                    , DbType.String, "", 0);
                //opar[3] = dal.CreateParameter("pClave", ParameterDirection.Input, int.Parse(claveTemporal), DbType.Int32, "", 0);

                int re = dal.ExecuteQuery("Movil.sprEsUsuarioValido", CommandType.StoredProcedure, opar);
                if (opar[0].Value.ToString() == "0")
                    bres = true;
            }
            catch (Exception ex)
            {
                Logger.ErrorLog.RegErrorDB(Logger.NivelDeError.Cinco, "200", this.ToString(), string.Empty, ex.StackTrace);
            }

            return bres;
        }

        public bool TienePermiso(string usuario, string permiso)
        {
            bool bres = false;
            //RoleProviderJdb objSecurity = new RoleProviderJdb();

            //try
            //{
            //    sres = objSecurity.IsUserInRole(usuario, permiso);
            //}
            //catch (Exception ex)
            //{
            //    Logger.ErrorLog.RegErrorDB(Logger.NivelDeError.Cinco, "200", this.ToString(), string.Empty, ex.StackTrace);
            //}

            return bres;
        }
    }
}
