using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace Paperworld
{
    public class NetInterface
    {
        private ArrayList MConnections;

        private Socket MSocket;

        private AsyncCallback MSocketCallback;

        private IAsyncResult MAsyncResult;

        private SocketPacket MSocketPacket;

        public NetInterface()
        {
            MConnections = new ArrayList();

            String address = "127.0.0.1";
            int port = 5122;
            IPAddress IpAddress = IPAddress.Parse(address);
            IPEndPoint EndPoint = new IPEndPoint(IpAddress, port);

            MSocket = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);

            MSocketPacket = new SocketPacket();
            MSocketPacket.Socket = MSocket;           

            // now start to listen for any data...            
            WaitForData();
        }

        public void WaitForData()
        {
            if (MSocketCallback == null)
            {
                MSocketCallback = new AsyncCallback(OnDataReceived);
            }

            MAsyncResult = MSocket.BeginReceive(MSocketPacket.Buffer, 0, MSocketPacket.Buffer.Length, SocketFlags.None, MSocketCallback, MSocketPacket);

        }

        public void OnDataReceived(IAsyncResult Asyn)
        {
            MSocket.EndReceive(Asyn);

            WaitForData();
        }

        public void UpdateConnections()
        {
            foreach (NetConnection connection in MConnections)
            {
            }
        }
    }
}
