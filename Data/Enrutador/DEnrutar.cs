using System;
using System.Collections.Generic;
//using System.Linq;
using System.Text;
using System.Data;
using System.Reflection;
using Entity.Enrutador;
using EConector.Comunes;

namespace Data.Enrutador
{
    /// <summary>
    /// Clase que gestiona las transacciones.
    /// </summary>
    public class DEnrutar
    {
        private List<EEnrutar> transacciones = new List<EEnrutar> { };
        private List<EProvider> proveedores = new List<EProvider> { };

        /// <summary>
        /// Lista de tipos de transacción.
        /// </summary>
        public List<EEnrutar> Transacciones
        {
            get { return transacciones; }
            set { transacciones = value; }
        }

        /// <summary>
        /// Lista de proveedores.
        /// </summary>
        public List<EProvider> Proveedores
        {
            get { return proveedores; }
            set { proveedores = value; }
        }

        /// <summary>
        /// Carga en memoria el listado de tipos de transacción.
        /// </summary>
        public void CargarListaTransacciones()
        {
            Assembly asm = Assembly.GetExecutingAssembly();
            DataSet ds = new DataSet();
            int ntra = 0;

            try
            {
                //ds.ReadXml(asm.GetManifestResourceStream("Data.MapaTransaciones.xml"));
                string spath = System.Web.Hosting.HostingEnvironment.ApplicationPhysicalPath;
                if (string.IsNullOrEmpty(spath))
                    spath = System.AppDomain.CurrentDomain.BaseDirectory;
                if (spath.EndsWith("\\")) 
                    spath = spath.Substring(0, spath.Length-1);
                ds.ReadXml(spath + "\\MapaTransaciones.xml");
            }
            catch (Exception ex)
            {
                Logger.ErrorLog.RegErrorDB(Logger.NivelDeError.Seis, "999", this.ToString(), "MapaTransaciones.xml", ex.StackTrace);
            }
            DataTable dt = ds.Tables["proveedor"];
            if (dt != null)
                if (dt.Rows.Count > 0)
                {
                    if (Proveedores.Count > 0)
                        Proveedores.Clear();

                    foreach (DataRow row in dt.Rows)
                    {
                        EProvider proveedor = new EProvider();

                        proveedor.IdProvider = row.Field<string>("id");
                        proveedor.DataProvider = row.Field<string>("tipoproveedor");
                        proveedor.ConnectionString = row.Field<string>("cadenaconexion");
                        proveedor.TipoDestino = (Destinos)System.Enum.Parse(
                                    typeof(Destinos),
                                    row.Field<string>("tipodestino"),
                                    true);

                        proveedores.Add(proveedor);
                    }
                    dt.Dispose();
                }

            dt = ds.Tables["transaccion"];

            if (dt != null)
                if (dt.Rows.Count > 0)
                {
                    if (transacciones.Count > 0)
                        transacciones.Clear();

                    Operacion operacion = Operacion.NoDefinido;
                    short evento = 0;

                    foreach (DataRow row in dt.Rows)
                    {
                        if (int.TryParse(row["codigo"].ToString(), out ntra))
                        {
                            operacion = Operacion.NoDefinido;
                            evento = 0;
                            try
                            {
                                operacion = (Operacion)System.Enum.Parse(
                                        typeof(Operacion),
                                        row["operacion"].ToString(),
                                        true);
                                short.TryParse(row.Field<string>("evento"), out evento);
                            }
                            catch (Exception)
                            {
                            }

                            Entity.Enrutador.EEnrutar enrutar = new Entity.Enrutador.EEnrutar
                            {
                                Transaccion = ntra,
                                TipoOperacion = operacion,
                                Evento = evento
                            };
                            DataRow[] rows = ds.Tables["destino"].Select("transaccion_id=" + row["transaccion_id"].ToString());

                            foreach (DataRow rowdestino in rows)
                            {
                                Entity.Enrutador.EDestino destino = new Entity.Enrutador.EDestino();

                                Entity.Enrutador.EProvider proveedor = Proveedores.Find(delegate(EProvider e) { return e.IdProvider == rowdestino.Field<string>("conexion"); });
                                destino.TipoDestino = proveedor.TipoDestino;
                                if (rowdestino.Table.Columns.Contains("conexion"))
                                    destino.Conexion = rowdestino["conexion"].ToString();
                                if (rowdestino.Table.Columns.Contains("tiempoespera"))
                                    destino.TiempoEspera = int.Parse(rowdestino["tiempoespera"].ToString());
                                if (rowdestino.Table.Columns.Contains("reintentos"))
                                    destino.Reintentos = int.Parse(rowdestino["reintentos"].ToString());
                                if (rowdestino.Table.Columns.Contains("tiemporeintento"))
                                    destino.TiempoReintento = int.Parse(rowdestino["tiemporeintento"].ToString());
                                if (rowdestino.Table.Columns.Contains("esobjeto"))
                                    destino.EsObjeto = Convert.ToBoolean(rowdestino["esobjeto"].ToString());
                                if (rowdestino.Table.Columns.Contains("persiste"))
                                    destino.Persiste = Convert.ToBoolean(rowdestino["persiste"].ToString());

                                // Acceso a carpetas de red.
                                if (rowdestino.Table.Columns.Contains("usuario"))
                                    destino.Usuario = rowdestino["usuario"].ToString();
                                if (rowdestino.Table.Columns.Contains("clave"))
                                    destino.Clave = rowdestino["clave"].ToString();
                                if (rowdestino.Table.Columns.Contains("dominio"))
                                    destino.Dominio = rowdestino["dominio"].ToString();

                                enrutar.Destinos.Add(destino);
                            }

                            transacciones.Add(enrutar);
                        }
                    }

                    transacciones.Add(CargarLista(998, Operacion.Registrar));
                    transacciones.Add(CargarLista(999, Operacion.Obtener));
                }
        }

        private Entity.Enrutador.EEnrutar CargarLista(int idtransaccion, Operacion operacion)
        {
            Entity.Enrutador.EEnrutar enrutar = new Entity.Enrutador.EEnrutar { Transaccion = idtransaccion, TipoOperacion = operacion };
            Entity.Enrutador.EDestino destino = new Entity.Enrutador.EDestino { TipoDestino = Destinos.ConectorFS, EsObjeto = true, Persiste = false, Conexion = System.IO.Path.GetTempPath() };

            enrutar.Destinos.Add(destino);

            return enrutar;
        }

        public bool ProjectHasExtender(EnvDTE.Project proj, string extenderName)
        {
            bool result = false;
            object[] extenderNames;

            try
            {
                // We could use proj.Extender(extenderName) but it causes an exception if not present and 
                // therefore it can cause performance problems if called multiple times. We use instead:

                extenderNames = (object[])proj.ExtenderNames;

                if (extenderNames.Length > 0)
                {
                    foreach (object extenderNameObject in extenderNames)
                    {
                        if (extenderName.ToString() == extenderName)
                        {
                            result = true;
                            break;
                        }
                    }
                }
            }
            catch
            {
                // Ignore
            }
            return result;
        }
    }
}
