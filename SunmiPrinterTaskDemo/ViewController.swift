//
//  ViewController.swift
//  SunmiPrinterTaskDemo
//
//  Created by Ahmed Shendy on 02/05/2024.
//

import UIKit
import SunmiPrinterSDK

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
