//
//  BananaViewController.swift
//  PPBluetoothKitDemo
//
//  Created by  lefu on 2023/7/4.
//

import UIKit

class BananaViewController: UIViewController {

    
    @IBOutlet weak var deviceLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    var XM_Banana : PPBluetoothPeripheralBanana!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deviceLbl.text = "Deivce:Disconnect"


        // Do any additional setup after loading the view.
        
        let banana = PPBluetoothPeripheralBanana.init(device: selectDevice!.0)
        self.XM_Banana = banana
        self.XM_Banana.updateStateDelegate = self
        self.XM_Banana.scaleDataDelegate = self
        
    }
    
    
    deinit{
        
        // 恢复设备的默认行为
        UIApplication.shared.isIdleTimerDisabled = false
        
        self.XM_Banana.scaleDataDelegate = nil;
        self.XM_Banana.updateStateDelegate = nil;
        self.XM_Banana.stopSearch()
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

extension BananaViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardIdentifier: String {
        return "BananaViewController"
    }
    
    
    
}



extension BananaViewController:PPBluetoothUpdateStateDelegate{
    
    func centralManagerDidUpdate(_ state: PPBluetoothState) {
        
        if (state == .poweredOn){
            
            self.XM_Banana.receivedDeviceData()
            self.deviceLbl.text = "Deivce:receviedData"
        }
        
      
    }
    
}


extension BananaViewController: PPBluetoothScaleDataDelegate{
    
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
    
}
