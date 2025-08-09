using System.IO.Compression;

namespace Assemble_binaries
{
    public partial class Form1 : Form
    {
        ToolTip tooltip = new();
        int lastIndex = -1;
        public Form1()
        {
            InitializeComponent();
            checkedListBox1.Items.Clear();
            PopulateList();
            checkedListBox1.MouseMove += checkedListBox1_MouseMove;
        }

        private void checkedListBox1_MouseMove(object sender, MouseEventArgs e)
        {
            int index = checkedListBox1.IndexFromPoint(e.Location);

            if (index != ListBox.NoMatches && index != lastIndex)
            {
                string tooltipText = GetTooltipForItem(index);
                tooltip.SetToolTip(checkedListBox1, tooltipText);
                lastIndex = index;
            }
            else if (index == ListBox.NoMatches)
            {
                tooltip.Hide(checkedListBox1);
                lastIndex = -1;
            }
        }
        private string GetTooltipForItem(int index) 
        {
            return toolTips[index];
        }
        private async void OKbutton_Click(object sender, EventArgs e)
        {
            using (var progressForm = new ProgressForm())
            {
                progressForm.Show(); // Non-modal
                progressForm.SetStatus("Starting...");

                var progress = new Progress<(string status, int percent)>(update =>
                {
                    progressForm.SetStatus(update.status);
                    progressForm.SetProgress(update.percent);
                });

                await Task.Run(() => PerformDownloadInstall(progress));

                progressForm.SetStatus("Done!");
                await Task.Delay(1000);
                progressForm.Close();
            }

            MessageBox.Show("Operation complete.");
        }
        private void PerformDownloadInstall(IProgress<(string, int)> progress)
        {
            string url = "https://example.com/file.zip";
            string tempZip = Path.Combine(Path.GetTempPath(), "downloaded.zip");
            string extractPath = Path.Combine(Path.GetTempPath(), "extracted");
            string targetPath = @"C:\MyApp";

            DownloadFile(url, tempZip, progress);
            progress.Report(("Extracting files...", 0));
            ExtractZip(tempZip, extractPath);
            CopyFiles(extractPath, targetPath, progress);
        }
        private void DownloadFile(string url, string outputPath, IProgress<(string, int)> progress)
        {
            using (HttpClient client = new HttpClient())
            using (var response = client.GetAsync(url, HttpCompletionOption.ResponseHeadersRead).Result)
            {
                response.EnsureSuccessStatusCode();
                var total = response.Content.Headers.ContentLength ?? -1L;

                using (var input = response.Content.ReadAsStreamAsync().Result)
                using (var output = File.Create(outputPath))
                {
                    var buffer = new byte[81920];
                    long readTotal = 0;
                    int read;
                    while ((read = input.Read(buffer, 0, buffer.Length)) > 0)
                    {
                        output.Write(buffer, 0, read);
                        readTotal += read;
                        if (total > 0)
                        {
                            int percent = (int)((readTotal * 100) / total);
                            progress.Report(("Downloading...", percent));
                        }
                    }
                }
            }
        }

        private void CopyFiles(string sourceDir, string destDir, IProgress<(string, int)> progress)
        {
            var files = Directory.GetFiles(sourceDir, "*", SearchOption.AllDirectories);
            int total = files.Length;
            int copied = 0;

            foreach (var file in files)
            {
                string relative = Path.GetRelativePath(sourceDir, file);
                string dest = Path.Combine(destDir, relative);
                Directory.CreateDirectory(Path.GetDirectoryName(dest));
                File.Copy(file, dest, true);

                copied++;
                int percent = (int)((copied * 100) / total);
                progress.Report(($"Copying files... ({copied}/{total})", percent));
            }
        }

        void PopulateList() 
        {
            for (int i = 0; i < AvailableItems.Length; i++) 
            { 
                checkedListBox1.Items.Add(AvailableItems[i]);
            }
        }
        string[] AvailableItems = 
        { 
            "FreeDOS Edit",
            "CuteMouse (CTMOUSE)",
            "HIMEMSX",
            "SBEMU"
        };
        string[] toolTips = 
        { 
            "A text editor for real-mode DOS environments.\nLicense: GPLv2",
            "A lightweight DOS mouse driver. \nLicense: GPLv2",
            "An XMS memory manager used for extended memory access, allows for more thn 4GB of RAM. \nLicense: GPLv2",
            "A Sound Blaster emulator for modern sound cards. \nLicense: GPLv2"
        };
        string[] binariesDownload = 
        { 
            "https://www.google.com",   // TODO: add an actual URL
            "http://cutemouse.sourceforge.net/download/cutemouse21b4.zip",
            "https://github.com/Baron-von-Riedesel/HimemSX/releases/download/v3.54/HimemSX_v354.zip",
            "https://github.com/crazii/SBEMU/releases/download/Release_1.0.0-beta.5/SBEMU.zip"
        };
        /*
        private async Task DownloadFileAsync(string url, string outputPath)
        {
            using (HttpClient client = new HttpClient())
            using (var response = await client.GetAsync(url, HttpCompletionOption.ResponseHeadersRead))
            {
                response.EnsureSuccessStatusCode();
                var totalBytes = response.Content.Headers.ContentLength ?? -1L;
                var canReportProgress = totalBytes != -1;

                using (var inputStream = await response.Content.ReadAsStreamAsync())
                using (var outputStream = new FileStream(outputPath, FileMode.Create, FileAccess.Write, FileShare.None))
                {
                    var buffer = new byte[81920];
                    long totalRead = 0;
                    int read;

                    while ((read = await inputStream.ReadAsync(buffer, 0, buffer.Length)) > 0)
                    {
                        await outputStream.WriteAsync(buffer, 0, read);
                        totalRead += read;

                        if (canReportProgress)
                        {
                            int progress = (int)((totalRead * 100) / totalBytes);
                             progress));
                        }
                    }
                }
            }*/
        //}

        private void ExtractZip(string zipFilePath, string extractToFolder)
        {
            if (Directory.Exists(extractToFolder))
                Directory.Delete(extractToFolder, true);

            ZipFile.ExtractToDirectory(zipFilePath, extractToFolder);
        }

/*        private async Task CopyFilesWithProgress(string sourceDir, string targetDir)
        {
            var files = Directory.GetFiles(sourceDir, "*", SearchOption.AllDirectories);
            int totalFiles = files.Length;
            int copied = 0;

            foreach (var file in files)
            {
                var relativePath = Path.GetRelativePath(sourceDir, file);
                var targetPath = Path.Combine(targetDir, relativePath);

                Directory.CreateDirectory(Path.GetDirectoryName(targetPath));
                File.Copy(file, targetPath, true);

                copied++;
                int progress = (int)((copied * 100) / totalFiles);
                await Task.Delay(10); // simulate I/O delay if copying is too fast
                progressBar1.Invoke((Action)(() => progressBar1.Value = progress));
            }
        }*/
    }
}
