using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practice
{
    class FindFirstNonRepeating
    {
        public static int BruteForce(int[] numbers)
        {
            Dictionary<int,int> frequency = new Dictionary<int,int>();

            for(int i=0; i<numbers.Length; i++ )
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
            for(int i=0;i<numbers.Length; i++)
            {
                if (frequency[numbers[i]] == 1)
                {
                    return numbers[i];
                }
            }
            return -1;
        }

        public static int[] TwoSum(int[] numbers,int target)
        {
            Dictionary<int, int> seen = new Dictionary<int, int>();

            for(int i = 0; i < numbers.Length; i++)
            {
                int currentNumber = numbers[i];

                int requiredNumber = target - currentNumber;

                if (seen.ContainsKey(requiredNumber))
                {
                    return new int[] {
                        seen[requiredNumber],i
                    };
                }
                seen.Add(currentNumber,i);
            }
            return [-1, -1];
        }
    }
}
