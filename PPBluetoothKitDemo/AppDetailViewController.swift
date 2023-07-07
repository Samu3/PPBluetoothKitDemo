//
//  AppDetailViewController.swift
//  PPBluetoothKitDemo
//
//  Created by  lefu on 2023/7/3.
//

import UIKit

class AppDetailViewController: UIViewController {
    
    var XM_Apple : PPBluetoothPeripheralApple?
    @IBOutlet weak var deviceLbl: UILabel!

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    lazy var scaleManager:PPBluetoothConnectManager = PPBluetoothConnectManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.isIdleTimerDisabled = true

        self.deviceLbl.text = "Deivce:Disconnect"

        self.scaleManager.updateStateDelegate = self;
        self.scaleManager.surroundDeviceDelegate = self;
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    deinit{
        
        // 恢复设备的默认行为
        UIApplication.shared.isIdleTimerDisabled = false
        
        self.scaleManager.stopSearch()
        if let peripheral = self.XM_Apple?.peripheral{
            
            self.scaleManager.disconnect(peripheral)
        }
       
    }

}



extension AppDetailViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardIdentifier: String {
        return "AppDetailViewController"
    }
    
    
    
}

extension AppDetailViewController: PPBluetoothScaleDataDelegate{
    
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

extension AppDetailViewController:PPBluetoothUpdateStateDelegate,PPBluetoothSurroundDeviceDelegate{
    func centralManagerDidUpdate(_ state: PPBluetoothState) {
        
        if (state == .poweredOn){
            self.scaleManager.searchSurroundDevice()
        }
    }
    
    
    func centralManagerDidFoundSurroundDevice(_ device: PPBluetoothAdvDeviceModel!, andPeripheral peripheral: CBPeripheral!) {
        
        
        if (device.deviceMac == selectDevice!.0.deviceMac){
            
            self.scaleManager.connectDelegate = self
            
            self.scaleManager.connect(peripheral, withDevice: selectDevice!.0)
            
            
            self.XM_Apple = PPBluetoothPeripheralApple(peripheral: peripheral, andDevice: device)
            
            self.XM_Apple?.serviceDelegate = self
            self.XM_Apple?.cmdDelegate = self
            
            self.deviceLbl.text = "Deivce:connected"

        }
        
      

    }
}


extension AppDetailViewController:PPBluetoothConnectDelegate{
    
    func centralManagerDidConnect() {
        self.XM_Apple?.discoverDeviceInfoService({[weak self] model in
            
            guard let `self` = self else {return}
            
            self.XM_Apple?.discoverFFF0Service()
            
            self.deviceLbl.text = "Deivce:receviedData"

        })
        
        
    }
    
    
    
    
    func centralManagerDidDisconnect() {
        
        
        self.deviceLbl.text = "Deivce:Disconnect"

        guard let peripheral = self.XM_Apple?.peripheral else{
            
            return
        }
        
        self.scaleManager.connect(peripheral, withDevice: selectDevice!.0)
    }
    
    func centralManagerDidFail(toConnect error: Error!) {
        
    }
    
    
}


extension AppDetailViewController: PPBluetoothServiceDelegate{
    
    func discoverFFF0ServiceSuccess() {
        
        
        self.XM_Apple?.scaleDataDelegate = self
        
      
        let funcType : PPDeviceFuncType = selectDevice!.0.deviceFuncType

        if PPBluetoothManager.hasHistoryFunc(funcType){
            
            self.XM_Apple?.syncDeviceTime()
        }
    }
    
  
}


extension AppDetailViewController: PPBluetoothCMDDataDelegate{
    

    
    func syncDeviceHistorySuccess() {
      
      

        
    }
    
}

