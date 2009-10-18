using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace Paperworld
{
    public class UDPPacket : IExternalisable
    {
        private UDPHeader MHeader;

        private Object MMessage;

        public UDPPacket()
        {
        }

        public void ReadExternal(IDataInput input)
        {
            MHeader = (UDPHeader) input.ReadObject();
        }

        public void WriteExternal(IDataOutput output)
        {
            output.WriteObject(MHeader);
        }       

        public UDPHeader Header
        {
            get { return MHeader; }
            set { MHeader = value; }
        }

        public Object Message
        {
            get { return MMessage; }
            set { MMessage = value; }
        }
    }
}
