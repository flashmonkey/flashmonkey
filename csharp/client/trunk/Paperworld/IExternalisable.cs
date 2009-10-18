using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace Paperworld
{
    public interface IExternalisable
    {
        void WriteExternal(IDataOutput iutput);

        void ReadExternal(IDataInput input);
    }

    public enum ByteOrder
    {
        BIG_ENDIAN,
        LITTLE_ENDIAN
    }

    public interface IDataOutput
    {
        /**
	     * Return the byteorder used when storing values.
	     * 
	     * @return the byteorder
	     */
        ByteOrder getEndian();

        /**
         * Set the byteorder to use when storing values.
         * 
         * @param endian the byteorder to use
         */
        void setEndian(ByteOrder Endian);

        /**
         * Write boolean value.
         * 
         * @param value the value
         */
        void WriteBoolean(bool Value);

        /**
         * Write signed byte value.
         * 
         * @param value the value
         */
        void WriteByte(byte Value);

        /**
         * Write multiple bytes.
         *  
         * @param bytes the bytes
         */
        void WriteBytes(byte[] Bytes);

        /**
         * Write multiple bytes from given offset.
         * 
         * @param bytes the bytes
         * @param offset offset in bytes to start writing from
         */
        void WriteBytes(byte[] Bytes, int Offset);

        /**
         * Write given number of bytes from given offset.
         * 
         * @param bytes the bytes
         * @param offset offset in bytes to start writing from
         * @param length number of bytes to write
         */
        void WriteBytes(byte[] Bytes, int Offset, int Length);

        /**
         * Write double-precision floating point value.
         * 
         * @param value the value
         */
        void WriteDouble(double Value);

        /**
         * Write single-precision floating point value.
         * 
         * @param value the value
         */
        void WriteFloat(float Value);

        /**
         * Write signed integer value.
         * 
         * @param value the value
         */
        void WriteInt(int Value);

        /**
         * Write string in given character set.
         * 
         * @param value the string
         * @param encoding the character set
         */
        void WriteMultiByte(String Value, String Encoding);

        /**
         * Write arbitrary object.
         * 
         * @param value the object
         */
        void WriteObject(Object Value);

        /**
         * Write signed short value.
         * 
         * @param value the value
         */
        void WriteShort(short Value);

        /**
         * Write unsigned integer value.
         * 
         * @param value the value
         */
        void WriteUnsignedInt(uint Value);

        /**
         * Write UTF-8 encoded string.
         * 
         * @param value the string
         */
        void WriteUTF(String Value);

        /**
         * Write UTF-8 encoded string as byte array. This string is stored without informations
         * about its length, so {@link IDataInput#readUTFBytes(int)} must be used to load it.
         * 
         * @param value the string
         */
        void WriteUTFBytes(String Value);
    }

    public interface IDataInput
    {
        /**
         * Return the byteorder used when loading values.
         * 
         * @return the byteorder
         */
        ByteOrder getEndian();

        /**
         * Set the byteorder to use when loading values.
         * 
         * @param endian the byteorder to use
         */
        void setEndian(ByteOrder Endian);

        /**
         * Read boolean value.
         * 
         * @return the value
         */
        bool ReadBoolean();

        /**
         * Read signed single byte value.
         * 
         * @return the value
         */
        int ReadByte();

        /**
         * Read list of bytes.
         * 
         * @param bytes destination for read bytes
         */
        void ReadBytes(byte[] Bytes);

        /**
         * Read list of bytes to given offset.
         * 
         * @param bytes destination for read bytes
         * @param offset offset in destination to write to
         */
        void ReadBytes(byte[] Bytes, int Offset);

        /**
         * Read given number of bytes to given offset.
         * 
         * @param bytes destination for read bytes
         * @param offset offset in destination to write to
         * @param length number of bytes to read
         */
        void ReadBytes(byte[] Bytes, int Offset, int Length);

        /**
         * Read double-precision floating point value.
         * 
         * @return the value
         */
        double ReadDouble();

        /**
         * Read single-precision floating point value.
         * 
         * @return the value
         */
        float ReadFloat();

        /**
         * Read signed integer value.
         * 
         * @return the value
         */
        int ReadInt();

        /**
         * Read multibyte string.
         * 
         * @param length length of string to read
         * @param charSet character set of string to read
         * @return the string
         */
        String ReadMultiByte(int Length, String CharSet);

        /**
         * Read arbitrary object.
         * 
         * @return the object
         */
        Object ReadObject();

        /**
         * Read signed short value.
         * 
         * @return the value
         */
        short ReadShort();

        /**
         * Read unsigned single byte value.
         * 
         * @return the value
         */
        int ReadUnsignedByte();

        /**
         * Read unsigned integer value.
         * 
         * @return the value
         */
        uint ReadUnsignedInt();

        /**
         * Read unsigned short value.
         * 
         * @return the value
         */
        int ReadUnsignedShort();

        /**
         * Read UTF-8 encoded string.
         * 
         * @return the string
         */
        String ReadUTF();

        /**
         * Read UTF-8 encoded string with given length.
         * 
         * @param length the length of the string
         * @return the string
         */
        String ReadUTFBytes(int Length);

    }
}
