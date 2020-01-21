using System;
using System.Collections.Generic;

namespace CmdExtensions.ParserImplements
{
    public abstract class Base
    {
        protected Dictionary<string, string> Parameters { get; private set; }
        public void SetArgs(string[] args)
        {
            foreach(var arg in args)
            {
                var splitIndex = arg.IndexOf(':');

                if (splitIndex == -1)
                {
                    Parameters.Add(arg.Substring(1), bool.TrueString);
                }

                else
                {
                    Parameters.Add(arg.Substring(1, splitIndex - 1), arg.Substring(splitIndex + 1, arg.Length - splitIndex - 1));
                }
            }
        }

        protected bool HasParameter(string parameterName)
        {
            return Parameters.ContainsKey(parameterName);
        }

        protected string GetParameter(string parameterName)
        {
            return Parameters[parameterName];
        }


        protected Base()
        {
            Parameters = new Dictionary<string, string>();
        }

        public abstract string Execute();
    }
}