using System;
using System.Diagnostics;

namespace Assemble_binaries
{
    internal static class Program
    {
        static int versionNo = 1;
        [STAThread]
        static void Main()
        {
            // To customize application configuration such as set high DPI settings or default font,
            // see https://aka.ms/applicationconfiguration.
            ApplicationConfiguration.Initialize();
            Console.WriteLine($"tripartiteOS binaries assembler v{versionNo.ToString()}");
            MessageBox.Show($"Welcome to tripartiteOS binaries assembler v{versionNo.ToString()}!");
            DialogResult result = MessageBox.Show($"To install and use tripartiteOS, you must provide your own copy of MS-DOS 5.00 or 6.22 (6.22 is preferred) installed onto your target USB stick. An online guide is available.\nOpen the guide in your browser?", "MS-DOS requirement", MessageBoxButtons.YesNoCancel, MessageBoxIcon.Warning);
            if (result == DialogResult.Yes)
            {
                ProcessStartInfo psi = new()
                {
                    UseShellExecute = true,
                    FileName = "https://www.google.com"    // TODO: add an actual URL
                };
                Process.Start(psi);
            }
            if (result == DialogResult.Cancel) return;

            // Otherwise...
            GetUserChosenComponents();
        }
        static void GetUserChosenComponents() 
        {
            Application.Run(new Form1());
        }
    }
}