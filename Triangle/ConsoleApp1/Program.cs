using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Triangle
{
    enum ErrorType
    {
        OK,
        WrongArgumentsAmount,
        EmprtyString,
        NotNumber,
        Overflow,
        MoreThanOneSeparator,
        LessThanZero
    }

    class Program
    {
        const byte AMOUNT_OFaRGUMENTS = 3;
        const byte MAX_ARGUMENT_LENGTH = 9;

        static bool ChcekAmountOfArguments(string[] args)
        {
            return (args.Length == AMOUNT_OFaRGUMENTS);
        }

        static bool IsDigitsOnly(string str)
        {
            var regex = new Regex(@"^[0-9]*(?:(\.|\,)[0-9]*)?$");
            return regex.IsMatch(str);
        }
        
        static ErrorType IsArgumentsEmpty(string[] args, List<Double> parameters, ref int counter)
        {
            if (!ChcekAmountOfArguments(args))
            {
                return ErrorType.WrongArgumentsAmount;
            }
            else
            {

                counter = 1;
                for (byte i = 0; i < args.Length; ++i, counter++)
                {
                    if (args[i] == "")
                    {
                        return ErrorType.EmprtyString;
                    }
                    else if (args[i].Length > MAX_ARGUMENT_LENGTH)
                    {
                        return ErrorType.Overflow;
                    }
                    else if(!IsDigitsOnly(args[i]))
                    {
                        return ErrorType.NotNumber;
                    }
                    else if(args[i].Count(c => (c == '.' || c == ',')) > 1)
                    {
                        return ErrorType.MoreThanOneSeparator;                        
                    }
                    else
                    {
                        Regex rgx = new Regex("\\.");
                        args[i] = rgx.Replace(args[i], ",");
                        Double tempNumber = Convert.ToDouble(args[i]);
                        
                        if (tempNumber <= 0)
                        {
                            return ErrorType.LessThanZero;
                        }
                        parameters.Add(tempNumber);
                    }
                }
            }
            return ErrorType.OK;
        }

        static bool IsEquilateral(double a, double b, double c)
        {
            return (a == b
                && a == c
                && b == c);
        }

        static bool IsIsosceles(double a, double b, double c)
        {
            return (a == b
                || a == c
                || b == c);
        }

        static bool IsNotTriangle(double a, double b, double c)
        {
            return ((a + b) < c
                || (a + c) < b
                || (c + b) < a);
        }

        static int Main(string[] args)
        {
            int counter = 0;
            List<Double> castedParametrs = new List<Double>();

            switch (IsArgumentsEmpty(args, castedParametrs, ref counter))
            {
                case (ErrorType.WrongArgumentsAmount):
                    Console.WriteLine("Неверное количество аргументов ( " + args.Length + " ) должно быть: " + AMOUNT_OFaRGUMENTS);
                    return 1;
                case (ErrorType.EmprtyString):
                    Console.WriteLine(counter + "-й параметр пустой");
                    return 1;
                case (ErrorType.LessThanZero):
                    Console.WriteLine(counter + "-й параметр меньше либо равен нулю");
                    return 1;
                case (ErrorType.MoreThanOneSeparator):
                    Console.WriteLine(counter + "-й параметр содержит более одного разделителя целой и дробной части");
                    return 1;
                case (ErrorType.NotNumber):
                    Console.WriteLine(counter + "-й параметр не является числом");
                    return 1;
                case (ErrorType.Overflow):
                    Console.WriteLine(counter + "-й параметр больше допустимого размера: " + MAX_ARGUMENT_LENGTH + " чисел");
                    return 1;
                case (ErrorType.OK):
                    if (IsNotTriangle(castedParametrs[0], castedParametrs[1], castedParametrs[2]))
                    {
                        Console.WriteLine("Не является трегольником");
                    }
                    else if (IsEquilateral(castedParametrs[0], castedParametrs[1], castedParametrs[2]))
                    {
                        Console.WriteLine("Трегольник является равносторонним");                        
                    }
                    else if (IsIsosceles(castedParametrs[0], castedParametrs[1], castedParametrs[2]))
                    {
                        Console.WriteLine("Трегольник является равнобедренным");                        
                    }
                    else
                    {
                        Console.WriteLine("Является обычным треугольником");
                    }
                    break;
            }
            return 0;
        }
    }
}
