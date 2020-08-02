using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xamarin.Forms;
using HelloDlibDotNet.Services.Interfaces;
using DlibDotNet;

namespace HelloDlibDotNet.iOS.Services
{

    public class DlibService : IDlibService
    {

        public string GetVersion()
        {
            return DlibDotNet.Dlib.GetNativeVersion();
        }

    }

}
