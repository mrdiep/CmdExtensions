using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CmdExtensions.ParserImplements
{
    public class GetId : Base
    {
        public override string Execute()
        {
            if (HasParameter("Format"))
            {
                return Guid.NewGuid().ToString(GetParameter("Format"));
            }

            return Guid.NewGuid().ToString();
        }
    }
}
