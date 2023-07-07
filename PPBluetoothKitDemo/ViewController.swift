//
//  ViewController.swift
//  PPBluetoothKitDemo
//
//  Created by  lefu on 2023/6/3.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.title = "not bind"
        
        if selectDevice != nil{
            self.title = "binded:\(selectDevice!.0.deviceName) mac:\(selectDevice!.0.deviceMac)"

            
        }
    }
    @IBAction func scaleClick(_ sender: Any) {
        
        
        
        if let device = selectDevice{
            //直连秤
            if device.0.deviceConnectType == .bleConnect{
                //v2版本
                if device.0.deviceProtocolType == .V2{
                    // 秤端计算
                    if device.0.deviceCalcuteType == .inScale{
                        
                        let vc = DurianViewController.instantiate()
                        
                        self.navigationController?.pushViewController(vc
                                                                      , animated:true)
                        
                        return
                    }else{
                        //其他
                        
                        let vc = AppDetailViewController.instantiate()
                        
                        self.navigationController?.pushViewController(vc
                                                                      , animated:true)
                        
                        return
                        
                    }
                }
                
                if device.0.deviceProtocolType == .V3{
                    //v3版本

                    let vc = CoconutViewController.instantiate()
                    
                    self.navigationController?.pushViewController(vc
                                                                  , animated:true)
                    
                    return
                }
                
            }else{
                //广播秤
                
                let vc = BananaViewController.instantiate()
                
                self.navigationController?.pushViewController(vc
                                                              , animated:true)
                
                return
            }
        }else{
            
          let alert =  UIAlertController.init(title: "not binded", message: "please bindDevice", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style: .cancel))
            
            self.present(alert, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }


}

