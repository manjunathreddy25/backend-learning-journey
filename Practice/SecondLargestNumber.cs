using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practice
{
    class SecondLargestNumber
    {
        public static int FindSecondLargestDistinct(int[] numbers)
        {
            int largest = numbers[0];
            int secondLargest = numbers[0];

            for(int i = 1; i < numbers.Length; i++)
            {
                if (numbers[i] > largest)
                {
                    secondLargest = largest;
                    largest = numbers[i];
                }
                else if(numbers[i] > secondLargest)// && numbers[i] != largest)
                {
                    secondLargest = numbers[i];
                }
            }
            return secondLargest;
        }
    }
}
