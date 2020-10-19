using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Data.Enrutador;

namespace Business.Enrutador
{
    public class Autorizador
    {
        public bool ValidarUsuario(string usuario, string clave)
        {
            DAutorizador autorizador = new DAutorizador();
            return autorizador.ValidarUsuario(usuario, clave);
        }

        public bool TienePermiso(string usuario, string permiso)
        {
            DAutorizador autorizador = new DAutorizador();
            return autorizador.TienePermiso(usuario, permiso);
        }
    }
}
