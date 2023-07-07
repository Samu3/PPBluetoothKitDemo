//
//  CoconutViewController.swift
//  PPBluetoothKitDemo
//
//  Created by  lefu on 2023/7/4.
//

import UIKit

class CoconutViewController: UIViewController {
    @IBOutlet weak var deviceLbl: UILabel!

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    
    var XM_Coconut : PPBluetoothPeripheralCoconut?
    
    lazy var scaleManager:PPBluetoothConnectManager = PPBluetoothConnectManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.deviceLbl.text = "Deivce:Disconnect"

        // Do any additional setup after loading the view.
        self.title = selectDevice!.0.deviceName
        
        self.scaleManager.updateStateDelegate = self;
        self.scaleManager.surroundDeviceDelegate = self;
    }
    
    
    deinit{
        
        // 恢复设备的默认行为
        UIApplication.shared.isIdleTimerDisabled = false
        
        
        self.scaleManager.stopSearch()
        if let peripheral = self.XM_Coconut?.peripheral{
            
            self.scaleManager.disconnect(peripheral)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension CoconutViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardIdentifier: String {
        return "CoconutViewController"
    }
    
    
    
}

extension CoconutViewController: PPBluetoothScaleDataDelegate{
    
    
    func monitorProcessData(_ model: PPBluetoothScaleBaseModel!) {
        
        self.weightLbl.text = "weight:\(Float(model.weight)/100.0)kg"
        self.statusLbl.text = "status:process"
        
    }
    
    func monitorLockData(_ model: PPBluetoothScaleBaseModel!) {
        self.weightLbl.text = "weight:\(Float(model.weight)/100.0)kg"
        self.statusLbl.text = "status:lock"
       let fatModel = CalcuteObj.XM_SaveScaleMeasurementData(model: model)

        print("weight:\(fatModel.ppWeightKg),fat:\(fatModel.ppFat)")
    }
    
    func monitorHistoryData(_ model: PPBluetoothScaleBaseModel!) {
        
    }
    
}

extension CoconutViewController:PPBluetoothUpdateStateDelegate{
    
    func centralManagerDidUpdate(_ state: PPBluetoothState) {
        
        if (state == .poweredOn){
            self.scaleManager.searchSurroundDevice()
        }
        
    }
    
}


extension CoconutViewController:PPBluetoothSurroundDeviceDelegate{
    
    func centralManagerDidFoundSurroundDevice(_ device: PPBluetoothAdvDeviceModel!, andPeripheral peripheral: CBPeripheral!) {
        
        
        if (device.deviceMac == selectDevice!.0.deviceMac){
            
            self.scaleManager.connectDelegate = self
            self.scaleManager.connect(peripheral, withDevice: device)
            
            self.XM_Coconut = PPBluetoothPeripheralCoconut(peripheral: peripheral, andDevice: device)
            self.XM_Coconut?.serviceDelegate = self
            self.XM_Coconut?.cmdDelegate = self
            
            self.deviceLbl.text = "Deivce:connected"

        }
        
    }
    
    
}

extension CoconutViewController:PPBluetoothConnectDelegate{
    
    func centralManagerDidConnect() {
        
        //        self.XM_Coconut?.discoverDeviceInfoService()
        
        self.XM_Coconut?.discoverFFF0Service()
    }
    
    func centralManagerDidDisconnect() {
        
        self.deviceLbl.text = "Deivce:Disconnect"

        guard let peripheral = self.XM_Coconut?.peripheral else{
            return
        }
        
        let device = selectDevice!.0
        self.scaleManager.connect(peripheral, withDevice: device)
    }
    
}


extension CoconutViewController: PPBluetoothServiceDelegate{
    
    func discoverFFF0ServiceSuccess() {
        
        self.XM_Coconut?.scaleDataDelegate = self
        
        self.deviceLbl.text = "Deivce:recevie data"

    }
}


extension CoconutViewController:PPBluetoothCMDDataDelegate{
    func syncDeviceHistorySuccess() {
        
        
    }
    
}
