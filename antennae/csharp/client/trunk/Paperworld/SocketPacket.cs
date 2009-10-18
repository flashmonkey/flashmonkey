using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;

namespace Paperworld
{
    class SocketPacket
    {
        private Socket MSocket;

        private byte[] MBuffer = new byte[1024];

        public SocketPacket()
        {
        }

        public Socket Socket
        {
            get { return MSocket; }
            set { MSocket = value; }
        }

        public byte[] Buffer
        {
            get { return MBuffer; }
            set { MBuffer = value; }
        }
    }
}
