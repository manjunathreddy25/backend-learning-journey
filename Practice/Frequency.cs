using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practice
{
    class Frequency
    {
        public static Dictionary<int, int> FindFrequency(int[] numbers)
        {
            Dictionary<int,int> frequency = new Dictionary<int, int>();

            for (int i = 0; i < numbers.Length; i++)
            {
                int number = 1;
                if (frequency.ContainsKey(numbers[i]))
                {
                    frequency[numbers[i]]++;
                }
                else
                {
                    frequency.Add(numbers[i], number);
                }
            }
            return frequency;
        }
    }
}
