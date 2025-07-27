using System;
using System.IO;

class WrapBinAsExe
{
    static void Main(string[] args)
    {
        if (args.Length != 2) { Console.WriteLine("Usage: WrapBinAsExe [source] [dest]"); return; }
        byte[] bin = File.ReadAllBytes(args[0]);

        using (var fs = new FileStream(args[1], FileMode.Create))
        using (var bw = new BinaryWriter(fs))
        {
            // MZ header: 0x4D 0x5A ("MZ")
            bw.Write((ushort)0x5A4D);         // e_magic
            bw.Write((ushort)(bin.Length % 512 == 0 ? 0 : 1)); // e_cblp (last page size)
            bw.Write((ushort)((bin.Length + 511) / 512)); // e_cp (pages)
            bw.Write((ushort)0);              // e_crlc
            bw.Write((ushort)0x0004);         // e_cparhdr (4*16 = 64 bytes header)
            bw.Write((ushort)0xFFFF);         // e_minalloc
            bw.Write((ushort)0xFFFF);         // e_maxalloc
            bw.Write((ushort)0);              // e_ss
            bw.Write((ushort)0x0100);         // e_sp
            bw.Write((ushort)0);              // e_csum
            bw.Write((ushort)0);              // e_ip
            bw.Write((ushort)0);              // e_cs
            bw.Write((ushort)0x40);           // e_lfarlc (header ends at 64)
            bw.Write((ushort)0);              // e_ovno

            for (int i = 0; i < 8; i++)       // padding to 64 bytes
                bw.Write((ushort)0);

            // Write stubless binary directly after MZ header
            bw.Write(bin);
        }

        Console.WriteLine("prog.exe created!");
    }
}
