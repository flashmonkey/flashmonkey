using Paperworld;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace PaperworldConsole
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("creating Paperworld console test");

            new SocketConnection();

            Console.ReadLine();
        }
    }

    public class SocketConnection
    {
        private Socket MSocket;

        public AsyncCallback MSocketCallback;

        private byte[] Buffer;

        private EndPoint MRemoteEndPoint;

        public SocketConnection()
        {
            Console.WriteLine("Creating SocketConnection");

            NetConnection MNetConnection = new NetConnection("127.0.0.1", 5150);
            MNetConnection.Connect();
            Console.WriteLine("connected!");

            UDPPacket Packet = new UDPPacket();
            Packet.Header = new UDPHeader();

            MNetConnection.Send(Packet);

           /* MSocket = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
            MSocketCallback = new AsyncCallback(OnDataReceived);
            IPEndPoint EndPoint = new IPEndPoint(IPAddress.Parse("127.0.0.1"), 5150);
            MRemoteEndPoint = (EndPoint)EndPoint;
            Buffer = new byte[1024];
            Console.WriteLine("Creating SocketConnection");
            IPEndPoint IPEP = new IPEndPoint(IPAddress.Any, 9150);

            MSocket.Bind(IPEP);

            Console.WriteLine("Creating SocketConnection");
            Connect();
            WaitForData();
            Console.WriteLine("Creating SocketConnection");*/
        }
        /*
        public void Connect()
        {
            Console.WriteLine("Sending Data...");
            MSocket.BeginSendTo(Buffer, 0, Buffer.Length, SocketFlags.None, MRemoteEndPoint, new AsyncCallback(OnDataSent), MSocket);
        }

        public void OnDataSent(IAsyncResult Asyn)
        {
            Console.WriteLine("Data Sent...");
           
        }

        public void WaitForData()
        {
            Console.WriteLine("Waiting for Data...");
            MSocket.BeginReceiveFrom(Buffer, 0, Buffer.Length, SocketFlags.None, ref MRemoteEndPoint, MSocketCallback, MSocket);
        }

        public void OnDataReceived(IAsyncResult Asyn)
        {
            Console.WriteLine("Data Received...");
            MSocket.EndReceive(Asyn);

            WaitForData();
        }*/
    }
}
