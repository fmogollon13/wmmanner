using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity.Comunicacion;
using Entity.Enrutador;
using Data.Enrutador;
using EConector.Comunes;
using WMEConector.Comunes;

namespace Business.Enrutador
{
    class Despachar
    {
        public string Remitir(EEncabezado credencial, string datos, EDestino rumbo, EProvider proveedor, Operacion tipoOperacion, short evento)
        {
            string sres = string.Empty;
            DDespachar despachar = new DDespachar();
            ETransaccion transaccion = new ETransaccion();

            if (credencial != null && rumbo != null)
            {
                transaccion.Conexion = rumbo.Conexion;
                transaccion.Datos = datos;
                transaccion.Persiste = rumbo.Persiste;
                transaccion.Terminal = credencial.Terminal;
                transaccion.TipoDestino = rumbo.TipoDestino;
                transaccion.Transaccion = (Transacciones)credencial.Transaccion;
                transaccion.Usuario = credencial.Usuario;
                transaccion.Modo = 0;
                transaccion.Version = credencial.Version;
                transaccion.TipoOperacion = tipoOperacion;
                transaccion.Evento = evento;

                sres = despachar.Remitir(transaccion, proveedor);
            }
            else
            {
                sres = "999";
                Logger.ErrorLog.RegErrorDB(Logger.NivelDeError.Tres, sres, this.ToString(), "Remitir()", "No se pudo procesar transacción.");
            }

            return sres;
        }
    }
}
