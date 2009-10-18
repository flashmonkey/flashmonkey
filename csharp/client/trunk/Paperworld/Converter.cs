using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Paperworld
{
    abstract public class Converter
    {
        static private Dictionary<Type, Converter> TypeToConverter = new Dictionary<Type, Converter>();
        static private Dictionary<Type, Converter> ClassToConverter = new Dictionary<Type, Converter>();

        static private Dictionary<short, Type> IdToClass = new Dictionary<short,Type>();
        static private Dictionary<Type, short> ClassToId = new Dictionary<Type,short>();

        static Converter() 
        {
            Register(new UDPHeader().GetType(), 1);
        }

        public static void Register(Type T)
        {
            short Id = GenerateId();

            while (IdToClass.ContainsKey(Id) || Id == 0)
            {
                Id = GenerateId();
            }

            Register(T, Id);
        }

        private static void Register(Type T, short Id)
        {
            Console.WriteLine("Registering Ttpe: " + T.Name);
            IdToClass.Add(Id, T);
            ClassToId.Add(T, Id);
        }

        public static void RegisterConverter(Type T, Converter ClassConverter)
        {
            TypeToConverter.Add(T, ClassConverter);
        }

        public static short GetRegisteredClassId(Type T)
        {
            short Id;

            if (ClassToId.TryGetValue(T, out Id))
            {
                return Id;
            }

            return -1;
        }

        public static Type GetRegisteredClass(short Id)
        {
            Type T;

            if (IdToClass.TryGetValue(Id, out T))
            {
                return T;
            }

            return null;
        }

        public static Converter GetConverter(Type T)
        {
            Converter converter;

            if (TypeToConverter.TryGetValue(T, out converter))
            {
                return converter;
            }

            return null;
        }

        private static short GenerateId() 
        {
            return (short) new Random().Next(1000); 
	    }

        abstract public void WriteObjectData(Object Obj);
    }
}
