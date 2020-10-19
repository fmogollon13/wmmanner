using wmmanner;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.VisualStudio.TestTools.UnitTesting.Web;

namespace Testmanner
{
    
    
    /// <summary>
    ///Se trata de una clase de prueba para mannerTest y se pretende que
    ///contenga todas las pruebas unitarias mannerTest.
    ///</summary>
    [TestClass()]
    public class mannerTest
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
        ///Una prueba de ObtenerDatos
        ///</summary>
        // TODO: Asegúrese de que el atributo UrlToTest especifica una dirección URL de una página ASP.NET (por ejemplo, 
        // http://.../Default.aspx). Esto es necesario para ejecutar la prueba unitaria en el servidor web,
        // si va a probar una página, un servicio web o un servicio WCF.
        [TestMethod()]
        [HostType("ASP.NET")]
        [AspNetDevelopmentServerHost("C:\\Proyecto\\ACR\\Progs\\wmmanner\\wmmanner", "/")]
        [UrlToTest("http://localhost:51225/")]
        public void ObtenerDatosTest()
        {
            manner target = new manner(); // TODO: Inicializar en un valor adecuado
            string datos = string.Empty; // TODO: Inicializar en un valor adecuado
            string expected = string.Empty; // TODO: Inicializar en un valor adecuado
            string actual;
            actual = target.ObtenerDatos(datos);
            Assert.AreEqual(expected, actual);
            //Assert.Inconclusive("Compruebe la exactitud de este método de prueba.");
        }

        /// <summary>
        ///Una prueba de RegistrarDatos
        ///</summary>
        // TODO: Asegúrese de que el atributo UrlToTest especifica una dirección URL de una página ASP.NET (por ejemplo, 
        // http://.../Default.aspx). Esto es necesario para ejecutar la prueba unitaria en el servidor web,
        // si va a probar una página, un servicio web o un servicio WCF.
        [TestMethod()]
        [HostType("ASP.NET")]
        [AspNetDevelopmentServerHost("C:\\Proyecto\\ACR\\Progs\\wmmanner\\wmmanner", "/")]
        [UrlToTest("http://localhost:51225/")]
        public void RegistrarDatosTest()
        {
            manner target = new manner(); // TODO: Inicializar en un valor adecuado
            string datos = string.Empty; // TODO: Inicializar en un valor adecuado
            string expected = string.Empty; // TODO: Inicializar en un valor adecuado
            string actual;
            actual = target.RegistrarDatos(datos);
            Assert.AreEqual(expected, actual);
            //Assert.Inconclusive("Compruebe la exactitud de este método de prueba.");
        }
    }
}
