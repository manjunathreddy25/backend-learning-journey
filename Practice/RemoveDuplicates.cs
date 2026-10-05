using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practice
{
    class RemoveDuplicates
    {
        public static int[] Duplicates_Of_SortedArray(int[] numbers)
        {
            int uniqueCount = 1;

            for(int i = 1; i < numbers.Length; i++)
            {
                if(numbers[i] != numbers[uniqueCount - 1])
                {
                    numbers[uniqueCount] = numbers[i];
                    uniqueCount++;
                }
            }
            int [] result = new int[uniqueCount];
            for(int i = 0; i < uniqueCount; i++)
            {
                result[i] = numbers[i];
            }
            return result;
        }
        public static int[] Duplicates_Of_UnSortedArray(int[] numbers)
        {
            HashSet<int> seen = new HashSet<int>();
            List<int> result = new List<int>();

            foreach(int n in numbers)
            {
                if (!seen.Contains(n))
                {
                    seen.Add(n);
                    result.Add(n);
                }
            }
            return result.ToArray();
        }
    }
}
