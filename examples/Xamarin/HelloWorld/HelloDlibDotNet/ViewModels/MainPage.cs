using System;
using System.Windows.Input;
using Prism.Commands;
using Prism.Navigation;

using HelloDlibDotNet.Services.Interfaces;

namespace HelloDlibDotNet.ViewModels
{

    public class MainPageViewModel : ViewModelBase
    {

        #region Fields

        private readonly IDlibService _DlibService;

        #endregion

        #region Constructors

        public MainPageViewModel(INavigationService navigationService, IDlibService dlibService)
            : base(navigationService)
        {
            this._DlibService = dlibService;
        }

        #endregion

        #region Properties

        private ICommand _GetDlibVersionCommand;
 
        public ICommand GetDlibVersionCommand
        {
            get
            {
                return this._GetDlibVersionCommand ?? (this._GetDlibVersionCommand = new DelegateCommand(() =>
                {
                    this.Version = this._DlibService.GetVersion();
                }));
            }
        }

        private string _Version;

        public string Version
        {
            get => this._Version;
            private set => this.SetProperty(ref this._Version, value);
        }

        #endregion


    }

}
