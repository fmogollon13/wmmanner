using Data.Enrutador;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using ConectorEntity.Comunes;

namespace Testmanner
{


    /// <summary>
    ///Se trata de una clase de prueba para DDespacharTest y se pretende que
    ///contenga todas las pruebas unitarias DDespacharTest.
    ///</summary>
    [TestClass()]
    public class DDespacharTest
    {


        private TestContext testContextInstance;

        /// <summary>
        ///Obtiene o establece el contexto de la prueba que proporciona
        ///la información y funcionalidad para la ejecución de pruebas actual.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Atributos de prueba adicionales
        // 
        //Puede utilizar los siguientes atributos adicionales mientras escribe sus pruebas:
        //
        //Use ClassInitialize para ejecutar código antes de ejecutar la primera prueba en la clase 
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup para ejecutar código después de haber ejecutado todas las pruebas en una clase
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //Use TestInitialize para ejecutar código antes de ejecutar cada prueba
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{
        //}
        //
        //Use TestCleanup para ejecutar código después de que se hayan ejecutado todas las pruebas
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// <summary>
        ///Una prueba de Remitir
        ///</summary>
        [TestMethod()]
        public void RemitirTest()
        {
            DDespachar target = new DDespachar(); // TODO: Inicializar en un valor adecuado
            ETransaccion transaccion = null; // TODO: Inicializar en un valor adecuado
            string expected = "999"; // TODO: Inicializar en un valor adecuado
            string actual;
            actual = target.Remitir(transaccion);
            Assert.AreEqual(expected, actual);
           // Assert.Inconclusive("Compruebe la exactitud de este método de prueba.");
        }

        /// <summary>
        ///Una prueba de Remitir
        ///</summary>
        [TestMethod()]
        public void RemitirTest1()
        {
            DDespachar target = new DDespachar(); // TODO: Inicializar en un valor adecuado
            ETransaccion transaccion = new ETransaccion(); // TODO: Inicializar en un valor adecuado

            transaccion.Conexion = "http://192.168.0.8/sir_acr/Servicio.asmx";
            transaccion.Datos = "";
            transaccion.EsObjeto = false;
            transaccion.Reintentos = 3;
            transaccion.Terminal = "1234";
            transaccion.TiempoEspera = 60;
            transaccion.TiempoReintento = 10;
            transaccion.TipoDestino = Destinos.ConectorWS;
            transaccion.Transaccion = 1;
            transaccion.Usuario = "mdaza";

            string expected = string.Empty; // TODO: Inicializar en un valor adecuado
            string actual;
            actual = target.Remitir(transaccion);
            Assert.AreEqual(expected, actual);
    
        }
    }
}
