﻿using Logger;
using Microsoft.VisualStudio.TestTools.UnitTesting;
namespace Testmanner
{
    
    
    /// <summary>
    ///Se trata de una clase de prueba para ErrorLogTest y se pretende que
    ///contenga todas las pruebas unitarias ErrorLogTest.
    ///</summary>
    [TestClass()]
    public class ErrorLogTest
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
        ///Una prueba de RegErrorDB
        ///</summary>
        [TestMethod()]
        public void RegErrorDBTest()
        {
            short level = 0; // TODO: Inicializar en un valor adecuado
            string groupName = string.Empty; // TODO: Inicializar en un valor adecuado
            string objectName = string.Empty; // TODO: Inicializar en un valor adecuado
            string cmdText = string.Empty; // TODO: Inicializar en un valor adecuado
            string message = string.Empty; // TODO: Inicializar en un valor adecuado
            bool expected = false; // TODO: Inicializar en un valor adecuado
            bool actual;
            actual = ErrorLog.RegErrorDB(level, groupName, objectName, cmdText, message);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Compruebe la exactitud de este método de prueba.");
        }

        /// <summary>
        ///Una prueba de RegErrorDB
        ///</summary>
        [TestMethod()]
        public void RegErrorDBTest1()
        {
            short level = 0; // TODO: Inicializar en un valor adecuado
            string groupName = "500"; // TODO: Inicializar en un valor adecuado
            string objectName = this.ToString(); // TODO: Inicializar en un valor adecuado
            string cmdText = "RegErrorDBTest1()"; // TODO: Inicializar en un valor adecuado
            string message = "Prueba de registro de errores"; // TODO: Inicializar en un valor adecuado
            bool expected = true; // TODO: Inicializar en un valor adecuado
            bool actual;
            actual = ErrorLog.RegErrorDB(level, groupName, objectName, cmdText, message);
            Assert.AreEqual(expected, actual);
            //Assert.Inconclusive("Compruebe la exactitud de este método de prueba.");
        }
    }
}
