using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace Paperworld
{
    public class Input : MemoryStream, IDataInput
    {
        public Input()
        {
        }

        public ByteOrder getEndian()
        {
            return ByteOrder.LITTLE_ENDIAN;
        }

        public void setEndian(ByteOrder Endian)
        {
        }

        public bool ReadBoolean()
        {
            return BitConverter.ToBoolean(GetBuffer(), (int)Position);
        }

        public void ReadBytes(byte[] bytes)
        {
            Read(bytes, 0, bytes.Length);
        }

        public void ReadBytes(byte[] bytes, int offset)
        {
            Read(bytes, offset, bytes.Length);
        }

        public void ReadBytes(byte[] bytes, int offset, int length)
        {
            Read(bytes, offset, length);
        }

        public double ReadDouble()
        {
            return BitConverter.ToDouble(GetBuffer(), (int)Position);
        }

        public float ReadFloat()
        {
            return 0f;
        }

        public int ReadInt()
        {
            return BitConverter.ToInt32(GetBuffer(), (int)Position);
        }

        public String ReadMultiByte(int Length, String CharSet)
        {
            return "";
        }

        public Object ReadObject()
        {
            Type type = Converter.GetRegisteredClass(ReadShort());
            IExternalisable instance = (IExternalisable) Activator.CreateInstance(type);
            instance.ReadExternal(this);

            return instance;
        }

        public short ReadShort()
        {
            return 0;
        }

        public int ReadUnsignedByte()
        {
            return 0;
        }

        public uint ReadUnsignedInt()
        {
            return (uint) BitConverter.ToInt32(GetBuffer(), (int)Position);
        }

        public int ReadUnsignedShort()
        {
            return 0;
        }

        public String ReadUTF()
        {
            return "";
        }

        public String ReadUTFBytes(int Length)
        {
            return "";
        }
    }
}
