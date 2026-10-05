using System;
namespace Practice;
class Program
{
    public static void ReverseArray(int[] numbers)
    {
        int left = 0;
        int right = numbers.Length - 1;

        while(left < right)
        {
            int temp = numbers[left];
            numbers[left] = numbers[right];
            numbers[right] = temp;

            left++;
            right--;
        }
    }
}