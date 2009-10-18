using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace Paperworld
{
    public class Output : MemoryStream, IDataOutput
    {
        public Output(byte[] buffer) : base(buffer)
        {
            Console.WriteLine("Endian: " + BitConverter.IsLittleEndian);
        }

        public void Write(byte[] buffer)
        {
            base.Write(buffer, 0, buffer.Length);
        }

        public void WriteInt(int Value)
        {
            Write(BitConverter.GetBytes(Value));
        }

        public void WriteShort(short Value)
        {
            Write(BitConverter.GetBytes(Value));
        }

        public void WriteObject(Object Value)
        {
            short Id = Converter.GetRegisteredClassId(Value.GetType());

            WriteShort(Id);

            if (Value is IExternalisable)
            {
                ((IExternalisable)Value).WriteExternal(this);
            }
        }

        public ByteOrder getEndian()
        {
            return (BitConverter.IsLittleEndian) ? ByteOrder.LITTLE_ENDIAN : ByteOrder.BIG_ENDIAN;
        }

        public void setEndian(ByteOrder Endian)
        {
        }

        public void WriteBoolean(bool Value)
        {
            Write(BitConverter.GetBytes(Value));
        }

        public void WriteBytes(byte[] bytes)
        {
            Write(bytes, 0, bytes.Length);
        }

        public void WriteBytes(byte[] bytes, int offset)
        {
            Write(bytes, offset, bytes.Length);
        }

        public void WriteBytes(byte[] bytes, int offset, int length)
        {
            Write(bytes, offset, length);
        }

        public void WriteDouble(double Value)
        {
            Write(BitConverter.GetBytes(Value));
        }

        public void WriteFloat(float Value)
        {
            Write(BitConverter.GetBytes(Value));
        }

        public void WriteMultiByte(String Value, String Encoding)
        {
        }

        public void WriteUnsignedInt(uint Value)
        {
            Write(BitConverter.GetBytes(Value));
        }

        public void WriteUTF(String Value)
        {
        }

        public void WriteUTFBytes(String Value)
        {
        }
    }
}
