using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practice
{
    class Intersection
    {
        public static List<int> FindIntersection(int[] first,int[] second)
        {
            List<int> result = new List<int>();

            for (int i = 0; i < first.Length; i++)
            {
                for (int j = 0; j < second.Length; j++)
                {
                    if (first[i] == second[j])
                    {
                        result.Add(first[i]);
                        break;
                    }
                }
            }

            return result;
        }

        public static HashSet<int> Optimized_FindIntersection(int[] first,int[] second)
        {
            HashSet<int> secondSet = new HashSet<int>();

            foreach (int number in second)
            {
                secondSet.Add(number);
            }

            HashSet<int> result = new HashSet<int>();

            foreach (int number in first)
            {
                if (secondSet.Contains(number))
                {
                    result.Add(number);
                }
            }

            return result;
        }
    }
}
