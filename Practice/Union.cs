using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practice
{
    class Union
    {
        public static HashSet<int> FindUnion(int[] first, int[] second)
        {
           HashSet<int> result = new HashSet<int>();

            foreach (int i in first)
            {
                result.Add(i);
            }
            foreach (int i in second)
            {
                result.Add(i);
            }
            return result;
        }
    }
}
