using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace Assemble_binaries
{
    public partial class ProgressForm : Form
    {
        public ProgressForm()
        {
            InitializeComponent();
        }
        public void SetStatus(string message)
        {
            labelStatus.Invoke((MethodInvoker)(() => labelStatus.Text = message));
        }

        public void SetProgress(int percent)
        {
            progressBar1.Invoke((MethodInvoker)(() => progressBar1.Value = percent));
        }
    }
}
