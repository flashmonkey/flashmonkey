using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Paperworld
{
    public class UDPHeader : IExternalisable
    {
        private uint MProtocol = 0;

        private uint MSequence = 9;

        private uint MAck = 0;

        private uint MAckBitfield = 0;

        public UDPHeader()
        {
        }

        public void ReadExternal(IDataInput input)
        {
            MProtocol = input.ReadUnsignedInt();
            MSequence = input.ReadUnsignedInt();
            MAck = input.ReadUnsignedInt();
            MAckBitfield = input.ReadUnsignedInt();
        }

        public void WriteExternal(IDataOutput output)
        {
            output.WriteUnsignedInt(MProtocol);
            output.WriteUnsignedInt(MSequence);
            output.WriteUnsignedInt(MAck);
            output.WriteUnsignedInt(MAckBitfield);
        }

        public uint Protocol
        {
            get { return MProtocol; }
            set { MProtocol = value; }
        }

        public uint Sequence
        {
            get { return MSequence; }
            set { MSequence = value; }
        }

        public uint Ack
        {
            get { return MAck; }
            set { MAck = value; }
        }

        public uint AckBitfield
        {
            get { return MAckBitfield; }
            set { MAckBitfield = value; }
        }
    }
}
