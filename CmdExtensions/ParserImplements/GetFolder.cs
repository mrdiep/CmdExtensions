using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace CmdExtensions.ParserImplements
{
    public class GetFolder : Base
    {
        public override string Execute()
        {
            var folderParent = this.GetParameter("ParentFolder");
            var listFolders = Directory.GetDirectories(folderParent);

            if (HasParameter("OrderBy"))
            {
                   var orderBy = this.GetParameter("OrderBy");
                var directoryType = typeof(Directory);
                MethodInfo methodInfo = directoryType.GetMethod(orderBy);
                if (!orderBy.StartsWith("Get"))
                    throw new Exception();

                listFolders = listFolders.OrderBy(x => (DateTime)methodInfo.Invoke(null, new object[] { x })).ToArray();
            }

            if (HasParameter("First"))
            {
                return listFolders.First();
            }

            if (HasParameter("Last"))
            {
                return listFolders.Last();
            }

            if (HasParameter("Index"))
            {
                return listFolders[Convert.ToInt32(GetParameter("Index"))];
            }

            if (listFolders.Length == 1)
            {
                return listFolders[1];
            }
            return string.Join(GetParameter("SplitBy"), listFolders);
        }
    }
}
