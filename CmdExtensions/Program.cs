using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Threading.Tasks;

using CmdExtensions.ParserImplements;

namespace CmdExtensions
{
    class Program
    {
        static void Main(string[] args)
        {
            var baseClass = CreateInstance(args[0], args.Skip(1).ToArray());
            var value = baseClass.Execute();
            Console.WriteLine(value);
        }

        public static Base CreateInstance(string className, string[] paramArray)
        {
            var typeName = Type.GetType($"CmdExtensions.ParserImplements.{className}, CmdExtensions");
            var baseItem = (Base)Activator.CreateInstance(typeName);
            baseItem.SetArgs(paramArray);

            return baseItem;
        }
    }
}
