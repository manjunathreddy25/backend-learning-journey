using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practice
{
    class ArrayDeletion
    {
        public static int[] DeleteElement(int[] numbers, int index)
        {
            int[] result = new int[numbers.Length - 1];

            for(int i = 0;i < index;i++)
            {
                result[i] = numbers[i];
            }

            for(int i = index; i < numbers.Length - 1;i++)
            {
                result[i] = numbers[i + 1];
            }
            return result;
        }
    }
}
