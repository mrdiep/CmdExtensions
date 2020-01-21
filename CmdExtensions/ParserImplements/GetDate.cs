using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CmdExtensions.ParserImplements
{
    public class GetDate : Base
    {
        public override string Execute()
        {
            if (HasParameter("Format"))
            {
                return DateTime.Now.ToString(GetParameter("Format"));
            }

            return DateTime.Now.ToString();
        }
    }
}
