using System.IO;
using System.Linq;

namespace CmdExtensions.ParserImplements
{
    public class GetIniConfig : Base
    {
        public override string Execute()
        {
            var filePath = GetParameter("FilePath");
            var list = File.ReadAllLines(filePath).Select(x =>
            {
                var splitIndex = x.IndexOf('=');
                var segment1 = x.Substring(0, splitIndex);
                var segment2 = x.Substring(splitIndex + 1, x.Length - splitIndex - 1);

                return new
                {
                    Key = segment1,
                    Value = segment2
                };
            }).ToList();

            return list.FirstOrDefault(x => x.Key == GetParameter("Key"))?.Value;;
        }
    }
}
