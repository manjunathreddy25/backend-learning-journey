using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practice
{
    class FindDuplicates
    {
        public static List<int> Duplicates(int[] numbers)
        {
            Dictionary<int,int> frequency = new Dictionary<int,int>();

            List<int> duplicates = new List<int>();

            for(int i = 0; i < numbers.Length; i++)
            {
                if (frequency.ContainsKey(numbers[i]))
                {
                    frequency[numbers[i]]++;
                }
                else
                {
                    frequency.Add(numbers[i], 1);
                }
            }
            foreach(var f in frequency)
            {
                if(f.Value > 1)
                {
                    duplicates.Add(f.Key);
                }
            }
            return duplicates;
        }

    }

}
