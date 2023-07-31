//
//  Device8ACViewController.swift
//  PPBluetoothKitDemo
//
//  Created by  lefu on 2023/7/29.
//

import UIKit


enum menuType:String{
    
    case connectDevice = "connect Device"
    case checkBindState = "check bindState"
    case deviceInfo = "device info"
    case startMeasure = "start measure"
    case SyncTime = "Sync time"
    case SyncUserList = "Sync user list"
    case ImpedanceSwitch = "Impedance Switch"
    case HeartRateSwitch = "HeartRate Switch"

    case FetchHistory = "Fetch History"
    case changeUnit = "Change unit"
    case clearDeviceData = "Clear DeviceData"
    case ScreenLuminance50 = "ScreenLuminance(50)"
    case ScreenLuminance100 = "ScreenLuminance(100)"
    case keepAlive = "keep connect alive"


}

class Device8ACViewController: UIViewController {
    @IBOutlet weak var consoleView: UITextView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var XM_Torre: PPBluetoothPeripheralTorre?
    
    var deviceModel : PPBluetoothAdvDeviceModel!

    lazy var scaleManager:PPBluetoothConnectManager = PPBluetoothConnectManager()
    
    @IBOutlet weak var connectStateLbl: UILabel!
    
    @IBOutlet weak var weightLbl: UILabel!
    var conslogStr = ""
    var unit = PPDeviceUnit.unitKG

    var XM_IsConnect: Bool = false
    var array = [menuType.connectDevice,menuType.checkBindState,menuType.deviceInfo,menuType.startMeasure,menuType.SyncTime,.SyncUserList,.ImpedanceSwitch,.changeUnit,.HeartRateSwitch,.clearDeviceData,.ScreenLuminance50,.ScreenLuminance100,.keepAlive]
    
    let user : PPTorreSettingModel = {
        
        let uu = PPTorreSettingModel()
        
        uu.isAthleteMode = false
        uu.isPregnantMode = false
        
        uu.height = 180
        uu.age = 20
        uu.gender = PPDeviceGenderType.female
        uu.unit = .unitKG
        
        uu.memberID = "1234567890"
        
        uu.userID = "abcdefghijklmn"
        
        uu.userName = "Tom"
        
        uu.targetWeight = 60
        
        uu.idealWeight = 50
        
        return uu
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.XM_Torre?.scaleDataDelegate = self

    }
  

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        consoleView.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        
        consoleView.layer.borderWidth = 1
        
        consoleView.layer.cornerRadius = 12
        
        consoleView.layer.masksToBounds = true
        
        DispatchQueue.main.asyncAfter(wallDeadline: DispatchWallTime.now() + 2) {
            self.collectionView.reloadData()

        }
        
    }
    
    func connectDevice(){
        
        self.scaleManager = PPBluetoothConnectManager()
        
        self.scaleManager.updateStateDelegate = self;
        
        self.scaleManager.surroundDeviceDelegate = self;
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
 
extension Device8ACViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let title = self.array[indexPath.row]
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        
        
        cell.titleLbl.text = title.rawValue
        
        if title == .changeUnit{
            
            cell.titleLbl.text = "\(title.rawValue)(\(self.unit == PPDeviceUnit.unitKG ? "lb" : "kg"))"
        }
        
        if title == .startMeasure{
            
            cell.titleLbl.textColor = UIColor.green
        }else{
            cell.titleLbl.textColor = UIColor.black

        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake((UIScreen.main.bounds.size.width - 40) / 3,40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let title = self.array[indexPath.row]

        
        if title == .connectDevice{
            
            if self.XM_IsConnect{
                
                return
            }
            
            self.connectDevice()
            
            return
        }
        
        if !self.XM_IsConnect{
            
            self.addStatusCmd(ss: "device disconnect")
            
            
            
            return
        }
        
        if title == .startMeasure{
            
            
            let vc = ScaleViewController.instantiate()
            
            vc.XM_Torre = self.XM_Torre
            
            self.navigationController?.pushViewController(vc, animated: true)
            
//            self.addBleCmd(ss: "codeStartMeasure")
//            
//            self.XM_Torre?.codeStartMeasure { status in
//                
//                self.addStatusCmd(ss: "\(status)")
//
//            }
            
            return
            
        }
        
        if title == .checkBindState{
            
            self.addBleCmd(ss: "codeFetchBindingState")

            self.XM_Torre?.codeFetchBindingState({ status in
                self.addStatusCmd(ss: "\(status)")

            })
        }
        
        if title == .deviceInfo{
            
            self.addBleCmd(ss: "discoverDeviceInfoService")

            self.XM_Torre?.discoverDeviceInfoService({ model in
                self.addStatusCmd(ss: "modelNumber:\(model.modelNumber),firmwareRevision:\(model.firmwareRevision),hardwareRevision:\(model.hardwareRevision)")

            })
        }
        
        if title == .SyncTime{
            
            self.addBleCmd(ss: "codeSyncTime")
            
            self.XM_Torre?.codeSyncTime({ status in
                self.addStatusCmd(ss: "\(status)")

                
            })

        }
        
        
        if title == .SyncUserList{
            
        
            
            self.addBleCmd(ss: "dataSyncUserList")
            
            self.XM_Torre?.dataSyncUserList([user], withHandler: { status in
                self.addStatusCmd(ss: "\(status)")

            })

        }
        
        if title == .ImpedanceSwitch{
            
            self.addBleCmd(ss: "codeFetchImpedanceSwitch")

            self.XM_Torre?.codeFetchImpedanceSwitch({ status in
                
                self.addStatusCmd(ss: "\(status)")

            })
            
        }
        
        if title == .HeartRateSwitch{
            
            self.addBleCmd(ss: "codeFetchHeartRateSwitch")

            self.XM_Torre?.codeFetchHeartRateSwitch({ status in
                
                self.addStatusCmd(ss: "\(status)")

            })
            
        }
        
        if title == .FetchHistory{
            self.addBleCmd(ss: "dataFetchHistoryData")
            
            self.XM_Torre?.dataFetchHistoryData(user, withHandler: {models in
                
                models.forEach { bb in
                    
                    self.addStatusCmd(ss: "histroty---weight:\(bb.weight)")
                    
                }
                
            })

        }
        
        if title == .changeUnit{
            self.addBleCmd(ss: "codeChange")

            self.unit = self.unit == PPDeviceUnit.unitKG ? PPDeviceUnit.unitLB  : PPDeviceUnit.unitKG
            self.XM_Torre?.codeChange(self.unit , withHandler: { status in
                
                self.addStatusCmd(ss: "\(status)")
                
                self.collectionView.reloadData()

            })
        }
        
        if title == .clearDeviceData{
            self.addBleCmd(ss: "codeClearDeviceData")
            
            self.XM_Torre?.codeClearDeviceData(0, withHandler:{status in
                
                self.addStatusCmd(ss: "\(status)")

            })

        }
        
    
        
        if title == .ScreenLuminance50{
            self.addBleCmd(ss: "codeSetScreenLuminance")
            
            self.XM_Torre?.codeSetScreenLuminance(50, handler: { statu in
                
                self.addStatusCmd(ss: "\(statu)")

            });

        }
        
        
        if title == .ScreenLuminance100{
            self.addBleCmd(ss: "codeSetScreenLuminance")
            
            self.XM_Torre?.codeSetScreenLuminance(100, handler: { statu in
                
                self.addStatusCmd(ss: "\(statu)")

            });

        }
        
        if title == .keepAlive{
            self.addBleCmd(ss: "sendKeepAliveCode")
            self.XM_Torre?.sendKeepAliveCode()

            
        }
        
    }
    
    
}

extension Device8ACViewController:PPBluetoothUpdateStateDelegate{
    func centralManagerDidUpdate(_ state: PPBluetoothState) {
        
        
        self.addConsoleLog(ss: "centralManagerDidUpdate")
        
        self.consoleView.text = self.conslogStr
        
        self.scaleManager.searchSurroundDevice()
    }
    

    
    
    
}

extension Device8ACViewController:PPBluetoothSurroundDeviceDelegate{
    

    
    func centralManagerDidFoundSurroundDevice(_ device: PPBluetoothAdvDeviceModel!, andPeripheral peripheral: CBPeripheral!) {
        
        
        if(device.deviceMac == self.deviceModel.deviceMac){
            
            
            self.addConsoleLog(ss: "centralManagerDidFoundSurroundDevice mac:\(device.deviceMac)")

            
            self.scaleManager.stopSearch()
            
            
            self.scaleManager.connectDelegate = self;
            self.scaleManager.connect(peripheral, withDevice: device)
            
            self.XM_Torre = PPBluetoothPeripheralTorre(peripheral: peripheral, andDevice: device)
            self.XM_Torre?.serviceDelegate = self
            self.XM_Torre?.scaleDataDelegate = self
            
        }
        


    }
    
}

extension Device8ACViewController:PPBluetoothConnectDelegate{
    
    
    func centralManagerDidConnect() {
                
        
        self.addConsoleLog(ss: "centralManagerDidConnect")

        
        self.addBleCmd(ss: "discoverFFF0Service")
        
        self.XM_Torre?.discoverFFF0Service()
    }
    
    func centralManagerDidDisconnect() {
        
        self.XM_IsConnect = false
        
        self.connectStateLbl.text = "disconnect"
        
        self.connectStateLbl.textColor = UIColor.red
    }
    
    
}

extension Device8ACViewController: PPBluetoothServiceDelegate{
    
    func discoverDeviceInfoServiceSuccess(_ device: PPBluetooth180ADeviceModel!) {
        
        
    }
    
    func discoverFFF0ServiceSuccess() {
        
        
        self.addBleCmd(ss: "codeUpdateMTU")

        
        self.XM_Torre?.codeUpdateMTU({[weak self] statu in
            
            
            guard let `self` = self else {return}
            
            self.addStatusCmd(ss: "\(statu)")

            
            self.connectStateLbl.text = "connected"
            
            self.connectStateLbl.textColor = UIColor.green
            
            self.XM_IsConnect = true

        })

    }
    
}

extension Device8ACViewController:PPBluetoothScaleDataDelegate{
    func monitorProcessData(_ model: PPBluetoothScaleBaseModel!) {
        
        self.weightLbl.text = String.init(format: "weight process:%0.2f", Float(model.weight) / 100.0)
        
        self.weightLbl.textColor = UIColor.red
        
    }
    
    func monitorLockData(_ model: PPBluetoothScaleBaseModel!) {
        
        self.weightLbl.text = String.init(format: "weight lock:%0.2f", Float(model.weight) / 100.0)
        
        self.weightLbl.textColor = UIColor.green
    }
    
    
    
}

extension Device8ACViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardIdentifier: String {
        return "Device8ACViewController"
    }
    
    
    
}

extension Device8ACViewController{
    
     func addConsoleLog(ss:String){
         self.conslogStr.append("\ndelegate:\(ss)\n")
         
       
         self.scrollBottom()
    }
    
    func addBleCmd(ss:String){
        self.conslogStr.append("\nfunction:\(ss)\n")

        self.scrollBottom()

    }
    
    
    func addStatusCmd(ss:String){
        self.conslogStr.append("\nstatus:\(ss)\n")

        self.scrollBottom()

    }
    
    func scrollBottom(){
        self.consoleView.text = self.conslogStr
        
        let bottomOffset = CGPoint(x: 0, y: consoleView.contentSize.height - consoleView.bounds.size.height)
          if bottomOffset.y > 0 {
              consoleView.setContentOffset(bottomOffset, animated: true)
          }
    }
}
