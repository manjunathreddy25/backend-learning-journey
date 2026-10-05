using System;
namespace Practice
{
    class ArrayInsertion
    {
        public static int[] Insertion(int[] numbers, int value, int index)
        {
            int[] result = new int[numbers.Length + 1];

            for (int i = 0; i < index; i++)
            {
                result[i] = numbers[i];
            }
            result[index] = value;
            for (int i = index; i < numbers.Length; i++)
            {
                result[i + 1] = numbers[i];
            }
            return result;
        }
    }
}