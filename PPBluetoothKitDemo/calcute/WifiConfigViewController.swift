//
//  WifiConfigViewController.swift
//  PPBluetoothKitDemo
//
//  Created by  lefu on 2023/7/31.
//

import UIKit

class WifiConfigViewController: UIViewController {
    var XM_Torre: PPBluetoothPeripheralTorre?
    
    @IBOutlet weak var consoleView: UITextView!
    var conslogStr = ""
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
      
        self.XM_Torre?.dataExitWifiConfig({ status in
            
            
        })
    }

    @IBAction func startNetwork(_ sender: Any) {
        self.addBleCmd(ss: "dataFindSurroundDevice")

        self.addStatusCmd(ss: "searching wifi lists")
        self.addStatusCmd(ss: "hold on")


        self.XM_Torre?.dataFindSurroundDevice({ models in
            
            self.addStatusCmd(ss: "\n" + models.description)

        })
        
    }
    
    @IBAction func enterWifiConfigClick(_ sender: Any) {
        
        let alertController = UIAlertController(title: "wifi config", message: "", preferredStyle: .alert)
        
        // 添加三个输入框
        alertController.addTextField { (textField) in
            textField.placeholder = "SSID"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "PASSWORD"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "DOMAIN"
        }

        // 添加取消和确定按钮
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "ok", style: .default) { (action) in
            // 获取输入框的值
            if let textField1 = alertController.textFields?[0], let textField2 = alertController.textFields?[1], let textField3 = alertController.textFields?[2] {
                let value1 = textField1.text ?? ""
                let value2 = textField2.text ?? ""
                let value3 = textField3.text ?? ""
                
                self.addStatusCmd(ss: "SSID:\(value1)")
                self.addStatusCmd(ss: "PASSWORD:\(value2)")
                self.addStatusCmd(ss: "DOMAIN:\(value3)")
                
                let wifiConfig = PPTorreConfigWifiModel()
                wifiConfig.ssid = value1
                wifiConfig.password = value2
                wifiConfig.domain = value3
                
                self.addBleCmd(ss: "dataConfigNetWork")
                self.addStatusCmd(ss: "hold on")

                self.XM_Torre?.dataConfigNetWork(wifiConfig, withHandler: { state, data in
                    
                    self.addStatusCmd(ss: "PPWIFIConfigState:\(state.rawValue)")
                    
                    
                    self.addBleCmd(ss: "dataExitWifiConfig")

                    self.XM_Torre?.dataExitWifiConfig({ status in
                        self.addStatusCmd(ss: "\(status)")

                    })
                    
                })

            }
        }

        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        // 显示 UIAlertController
        present(alertController, animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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

}

extension WifiConfigViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardIdentifier: String {
        return "WifiConfigViewController"
    }
    
    
}


extension WifiConfigViewController{
    
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
