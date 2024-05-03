# SunmiPrinterTaskDemo

### Steps I think would help me build the demo
- Read the documentation at section **10.Cloud Printer SDK for iOS** > **SDK Quick Start**.
- Download **SMPrinterSDKProject V1.6.3.zip**:
    - Open `SMPrinterSDKProject.xcworkspace` with Xcode.
    - Run the project, and take a look at their demo & the code.
- Download **SunmiPrinterSDK.xcframework V1.6.3.zip**, then to integrate it with demo Swift project:
    - Create new Swift project `SunmiPrinterTaskDemo` (UIKit).
    - Add Bluetooth permissions to the [info.plist] file:  
      `Privacy - Bluetooth Always Usage Description`  
      `Privacy - Bluetooth Peripheral Usage Description`  
    - (Follow step from doc) Start using the TCP/IP Ethernet printer, need to increase the iOS network discovery permission control.
    - Import the `SunmiPrinterSDK.framework` into the Xcode project directory.
    - Generate Objective-C bridging header `SunmiPrinterTaskDemo-Bridging-Header.h` using help of Xcode, then import the SDK:  
      ```objc
      #import <SunmiPrinterSDK/SunmiPrinterSDK.h>
      ```
    - Use `SunmiPrinterIPManager` class to find the printer and communicate with it.
        ```swift
        final class ViewController: UIViewController {

            // MARK: - Properties

            private let ip: String = "192.168.9.9"
            private lazy var sunmiManager = SunmiPrinterIPManager.shared()

            // MARK: - Subviews

            @IBOutlet weak var ipLabel: UILabel!

            // MARK: - LifeCycle

            override func viewDidLoad() {
                super.viewDidLoad()
                // Do any additional setup after loading the view.

                
                ipLabel.text = ip
                sunmiManager?.delegate = self

                sunmiManager?.deviceDisConnect({ error in
                    let error = error! as NSError
                    print(#function, "deviceDisConnect", error.debugDescription)
                })
                sunmiManager?.startSearchPrinter(withIp: ip)
            }

            // MARK: - Actions

            @IBAction func onConnect(_ sender: UIButton) {
                if sunmiManager?.isConnectedIPService() == true {
                    sunmiManager?.disConnectIPService()
                    print(#function, "disConnectIPService is done")
                }

                sunmiManager?.connectSocket(withIP: ip)
                print(#function, "connectSocket is done")
            }
        }

        // MARK: - IPPrinterManagerDelegate

        extension ViewController: IPPrinterManagerDelegate {
            func finshedSearchPrinter() {
                print(#function)
            }

            func didConnectedIPPrinter() {
                print(#function)
            }

            func didConnectedIPPrinterWithError(_ error: (any Error)!) {
                let error = error as NSError
                print(#function, error.debugDescription)
            }
        }
        ```
