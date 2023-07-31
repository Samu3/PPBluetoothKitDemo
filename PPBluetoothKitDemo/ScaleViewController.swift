//
//  ScaleViewController.swift
//  PPBluetoothKitDemo
//
//  Created by  lefu on 2023/7/3.
//

import UIKit

class ScaleViewController: UIViewController {

    @IBOutlet weak var consoleView: UITextView!

    @IBOutlet weak var weightLbl: UILabel!
    
    var XM_Torre: PPBluetoothPeripheralTorre?
    
    var conslogStr = ""

    var isBabyMode = false
    
    var step = 0
    
    var weight:Float = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.XM_Torre?.scaleDataDelegate = self

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.XM_Torre?.codeStopMeasure { statu in
        
        }
        
        self.XM_Torre?.codeExitBabyModel { statu in
            
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func scaleBtnClick(_ sender: Any) {
        
        
        self.XM_Torre?.codeStopMeasure { statu in
        
        }
        
        self.XM_Torre?.codeExitBabyModel { statu in
            
        }
        
        self.isBabyMode = false
        
        self.addBleCmd(ss: "codeUpdateMTU")

        
        self.XM_Torre?.codeUpdateMTU({[weak self] status in
            
            guard let `self` = self else{
                return
            }
            
            self.addStatusCmd(ss: "\(status)")
            
            self.addBleCmd(ss: "codeStartMeasure")

            self.XM_Torre?.codeStartMeasure({ status in
                
                self.addStatusCmd(ss: "\(status)")

            })
            
        })
    }
    
    @IBAction func babyWeightBtnClick(_ sender: Any) {
        
        self.XM_Torre?.codeStopMeasure { statu in
        
        }
        
        self.XM_Torre?.codeExitBabyModel { statu in
            
        }
        
        self.step = 0
        
        self.weight = 0
        
        self.isBabyMode = true
        
        let semaphore = DispatchSemaphore(value: 0)
        
        DispatchQueue.global().async {
            
            self.addBleCmd(ss: "codeEnableBabyModel 0")


            self.XM_Torre?.codeEnableBabyModel(0, weight: 0, withHandler: { statu in
                
                self.addStatusCmd(ss: "\(statu)")

                semaphore.signal()
            })
            
            _ = semaphore.wait(timeout: DispatchTime.now() + 1)

            self.addBleCmd(ss: "codeStartMeasure")

            self.XM_Torre?.codeStartMeasure({ statu in
                self.addStatusCmd(ss: "\(statu)")

            })
            
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

extension ScaleViewController:PPBluetoothScaleDataDelegate{
    
    func monitorProcessData(_ model: PPBluetoothScaleBaseModel!) {
        
        DispatchQueue.main.async {
            self.weightLbl.text = String.init(format: "weight process:%0.2f", Float(model.weight) / 100.0)
            
            self.weightLbl.textColor = UIColor.red
            
        }
        
     
        self.addConsoleLog(ss: "monitorProcessData")
        
        self.addStatusCmd(ss: model.description)
        
    }
    
    func monitorLockData(_ model: PPBluetoothScaleBaseModel!) {
        
        DispatchQueue.main.async {
            self.weight = Float(model.weight) / 100.0

            
            self.weightLbl.text = String.init(format: "weight lock:%0.2f", Float(model.weight) / 100.0)
            
            if model.heartRate > 0{
                
                self.weightLbl.text = String.init(format: "weight lock:%0.2f    heartRate:%ld", Float(model.weight) / 100.0,model.heartRate)

            }
            
            self.weightLbl.textColor = UIColor.green
            
            self.addConsoleLog(ss: "monitorLockData")
            
            self.addStatusCmd(ss: model.description)
            
            
            if self.isBabyMode{
                
                if self.step == 0{
                    self.addBleCmd(ss: "codeEnableBabyModel  1")
                    self.XM_Torre?.codeEnableBabyModel(1, weight: model.weight, withHandler: { statu in
                        
                        self.addStatusCmd(ss: "\(statu)")
                    })
                    
                    self.step = 1
                }
                
                
                if self.step == 1{
                    
                    self.weightLbl.text = String.init(format: "weight lock:%0.2f", Float(model.weight) / 100.0 - self.weight)

                }
               
            }


        }
            
        }
        
      
    
    
    
}


extension ScaleViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardIdentifier: String {
        return "ScaleViewController"
    }
    
    
    
}


extension ScaleViewController{
    
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
        
        DispatchQueue.main.async {
            self.consoleView.text = self.conslogStr
            
            let bottomOffset = CGPoint(x: 0, y: self.consoleView.contentSize.height - self.consoleView.bounds.size.height)
              if bottomOffset.y > 0 {
                  self.consoleView.setContentOffset(bottomOffset, animated: true)
              }
        }
      
    }
}
