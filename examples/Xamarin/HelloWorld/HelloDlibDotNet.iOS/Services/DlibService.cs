using HelloDlibDotNet.Services.Interfaces;

namespace HelloDlibDotNet.iOS.Services
{

    public class DlibService : IDlibService
    {

        public string GetVersion()
        {
            return DlibDotNet.Dlib.GetNativeVersion();
            //return NativeSharp.Native.Add(10, 20).ToString();
        }

    }

}
