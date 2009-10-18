using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace Paperworld
{
    /**
     * NetConnection represents a 'channel' over which data is transferred between server and client.
     * NetConnections are managed by a NetInterface which exposes and interface for applications to 
     * use to send data.
     */
    public class NetConnection
    {
        private static uint PROTOCOL_ID = 101;

        private EndPoint MRemoteEndPoint;

        private uint MLocalSequence = 0;

        private uint MRemoteSequence = 0;

        private Queue<uint> AckQueue = new Queue<uint>(32);

        private Socket MSocket;

        public AsyncCallback MSocketCallback;

        private byte[] MBuffer;

        public NetConnection(String Address, int Port)
        {
            IPEndPoint EndPoint = new IPEndPoint(IPAddress.Parse(Address), Port);
            MRemoteEndPoint = (EndPoint)EndPoint;            
        }

        protected void CreateSocket()
        {
            MSocket = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
            MSocketCallback = new AsyncCallback(OnDataReceived);

            MBuffer = new byte[1024];

            IPEndPoint IPEP = new IPEndPoint(IPAddress.Any, 9150);
            MSocket.Bind(IPEP);
        }

        public void Connect()
        {
            CreateSocket();

            Console.WriteLine("Connecting...");

            UDPPacket Packet = new UDPPacket();
            UDPHeader Header = new UDPHeader();

            Packet.Header = Header;

            Send(Packet);

            WaitForData();
        }

        public void Send(UDPPacket Packet)
        {
            Console.WriteLine("Sending Packet");

            Packet.Header.Protocol = PROTOCOL_ID;
            Packet.Header.Sequence = MLocalSequence++;
            Packet.Header.Ack = MRemoteSequence;
            Packet.Header.AckBitfield = AckBitfield;

            Output Out = new Output(MBuffer);
            Packet.WriteExternal(Out);

            MSocket.BeginSendTo(MBuffer, 0, MBuffer.Length, SocketFlags.None, MRemoteEndPoint, new AsyncCallback(OnDataSent), MSocket);
        }

        public void OnDataSent(IAsyncResult Asyn)
        {
            Console.WriteLine("Data Sent...");
           
        }

        public void WaitForData()
        {
            Console.WriteLine("Waiting for Data...");
            MSocket.BeginReceiveFrom(MBuffer, 0, MBuffer.Length, SocketFlags.None, ref MRemoteEndPoint, MSocketCallback, MSocket);
        }

        public void OnDataReceived(IAsyncResult Asyn)
        {
            Console.WriteLine("Data Received...");
            MSocket.EndReceive(Asyn);

            WaitForData();
        }

        public EndPoint RemoteEndPoint
        {
            get { return MRemoteEndPoint; }
            set { MRemoteEndPoint = value; }
        }

        public uint AckBitfield
        {
            get { return 0; }
        }
    }
}
