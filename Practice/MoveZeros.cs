using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practice
{
    class MoveZeros
    {
        public static void Processing(int[] numbers)
        {
            int insertIndex = 0;
            for (int i = 0; i < numbers.Length; i++)
            {
                if (numbers[i] != 0)
                {
                    numbers[insertIndex] = numbers[i];
                    insertIndex++;
                }
            }
            for(int i = insertIndex;i < numbers.Length; i++)
            {
                numbers[i] = 0;
            }
        }
    }
}
