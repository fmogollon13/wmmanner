using System;
//using System.Linq;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Security.Cryptography;
using System.Web.Configuration;
using System.Configuration;

namespace Data.Comunicacion
{
    public class DCifrar
    {
        static byte[] _Key;
        static byte[] _IV;

        public static void SetCifrado()
        {
            int keySize = 32;
            int ivSize = 16;

            //clave
            string strKey = "4g3nc14p4r414r31nt3gr4c10n";
            //vector de inicio
            string strIv = "4crc0l0mb142012";

            // Convertir la llave y el vector de inicio a su representación en bytes

            byte[] key = UTF8Encoding.UTF8.GetBytes(strKey);
            byte[] iv = UTF8Encoding.UTF8.GetBytes(strIv);

            // Garantizar el tamaño correcto de la clave y el vector de inicio
            // mediante substring o padding
            Array.Resize<byte>(ref key, keySize);
            Array.Resize<byte>(ref iv, ivSize);
            _Key = key;
            _IV = iv;

        }

        public static string CifrarCadena(String plainMessage)
        {
            SetCifrado();
            // Crear una instancia del algoritmo de Rijndael
            Rijndael RijndaelAlg = Rijndael.Create();

            RijndaelAlg.Mode = CipherMode.CBC;

            // Establecer un flujo en memoria para el cifrado
            MemoryStream memoryStream = new MemoryStream();

            // Crear un flujo de cifrado basado en el flujo de los datos
            CryptoStream cryptoStream = new CryptoStream(memoryStream,
                                                         RijndaelAlg.CreateEncryptor(_Key, _IV),
                                                         CryptoStreamMode.Write);

            // Obtener la representacin en bytes de la información a cifrar
            byte[] plainMessageBytes = UTF8Encoding.UTF8.GetBytes(plainMessage);

            // Cifrar los datos envióndolos al flujo de cifrado
            cryptoStream.Write(plainMessageBytes, 0, plainMessageBytes.Length);
            cryptoStream.FlushFinalBlock();

            // Obtener los datos datos cifrados como un arreglo de bytes
            byte[] cipherMessageBytes = memoryStream.ToArray();

            // Cerrar los flujos utilizados
            memoryStream.Close();
            cryptoStream.Close();

            // Retornar la representación de texto de los datos cifrados
            return Convert.ToBase64String(cipherMessageBytes);
        }

        public static string DecifrarAESdeBase64(string dataToDeCrypt)
        {
            //Get the decryption key from the machine key section of the web.config
            MachineKeySection machineKey = (MachineKeySection)ConfigurationManager.GetSection("system.web/machineKey");
            string key = machineKey.DecryptionKey;
            byte[] keyBytes = new UTF8Encoding(false).GetBytes(key);
            Rfc2898DeriveBytes rfc = new Rfc2898DeriveBytes(key, keyBytes, 1000);

            AesManaged decryptor = new AesManaged();
            //decryptor.Mode = CipherMode.CBC;
            decryptor.Key = rfc.GetBytes(16);
            decryptor.IV = rfc.GetBytes(16);

            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream decrypt = new CryptoStream(ms, decryptor.CreateDecryptor(), CryptoStreamMode.Write))
                {
                    byte[] dataBytes = Convert.FromBase64String(dataToDeCrypt);
                    decrypt.Write(dataBytes, 0, dataBytes.Length);
                    decrypt.FlushFinalBlock();
                    decrypt.Close();

                    return new UTF8Encoding(false).GetString(ms.ToArray());
                }
            }
        }

        public static string DescifrarCadena(String encryptedMessage)
        {
            SetCifrado();
            // Obtener la representación en bytes del texto cifrado

            byte[] cipherTextBytes = Convert.FromBase64String(encryptedMessage);

            // Crear un arreglo de bytes para almacenar los datos descifrados

            byte[] plainTextBytes = new byte[cipherTextBytes.Length];

            // Crear una instancia del algoritmo de Rijndael			

            Rijndael RijndaelAlg = Rijndael.Create();

            RijndaelAlg.Mode = CipherMode.CBC;

            // Crear un flujo en memoria con la representación de bytes de la información cifrada

            MemoryStream memoryStream = new MemoryStream(cipherTextBytes);

            // Crear un flujo de descifrado basado en el flujo de los datos

            CryptoStream cryptoStream = new CryptoStream(memoryStream,
                                                         RijndaelAlg.CreateDecryptor(_Key, _IV),
                                                         CryptoStreamMode.Read);

            // Obtener los datos descifrados obtenióndolos del flujo de descifrado

            int decryptedByteCount = cryptoStream.Read(plainTextBytes, 0, plainTextBytes.Length);

            // Cerrar los flujos utilizados

            memoryStream.Close();
            cryptoStream.Close();

            // Retornar la representación de texto de los datos descifrados

            return Encoding.UTF8.GetString(plainTextBytes, 0, decryptedByteCount);
        }

        /**
         * Cifra una cadena texto con el algoritmo de Rijndael y lo almacena en un archivo
         * 
         * @param	plainMessage	mensaje plano (sin cifrar)
         * @param	filename		nombre del archivo donde se almacenaró el mensaje cifrado
         * @param	Key				clave del cifrado para Rijndael
         * @param	IV				vector de inicio para Rijndael
         * @return	void
         */
        public static void CifrarEnArchivo(String cadena, String nombreArchivo)
        {
            // Crear un flujo para el archivo a generarse
            FileStream fileStream = File.Open(nombreArchivo, FileMode.OpenOrCreate);

            // Crear una instancia del algoritmo Rijndael
            Rijndael RijndaelAlg = Rijndael.Create();

            RijndaelAlg.Mode = CipherMode.CBC;

            // Crear un flujo de cifrado basado en el flujo de los datos
            CryptoStream cryptoStream = new CryptoStream(fileStream,
                                             RijndaelAlg.CreateEncryptor(_Key, _IV),
                                             CryptoStreamMode.Write);

            // Crear un flujo de escritura basado en el flujo de cifrado
            StreamWriter streamWriter = new StreamWriter(cryptoStream);

            // Cifrar el mensaje a través del flujo de escritura
            streamWriter.WriteLine(cadena);

            // Cerrar los flujos utilizados
            streamWriter.Close();
            cryptoStream.Close();
            fileStream.Close();
        }

        /**
         * Descifra el contenido de un archivo con el algoritmo de Rijndael y lo retorna
         * como una cadena de texto plano
         * 
         * @param	filename		nombre del archivo donde se encuentra el mensaje cifrado
         * @param	Key				clave del cifrado para Rijndael
         * @param	IV				vector de inicio para Rijndael
         * @return	string			mensaje descifrado (plano)
         */
        public static string DescifrarDeArchivo(String filename)
        {
            // Crear un flujo para el archivo a generarse
            FileStream fileStream = File.Open(filename, FileMode.OpenOrCreate);

            // Crear una instancia del algoritmo Rijndael
            Rijndael RijndaelAlg = Rijndael.Create();

            RijndaelAlg.Mode = CipherMode.CBC;

            // Crear un flujo de cifrado basado en el flujo de los datos
            CryptoStream cryptoStream = new CryptoStream(fileStream,
                                                         RijndaelAlg.CreateDecryptor(_Key, _IV),
                                                         CryptoStreamMode.Read);

            // Crear un flujo de lectura basado en el flujo de cifrado
            StreamReader streamReader = new StreamReader(cryptoStream);

            // Descifrar el mensaje a través del flujo de lectura
            string plainMessage = streamReader.ReadLine();

            // Cerrar los flujos utilizados
            streamReader.Close();
            cryptoStream.Close();
            fileStream.Close();

            return plainMessage;
        }
    }
}
