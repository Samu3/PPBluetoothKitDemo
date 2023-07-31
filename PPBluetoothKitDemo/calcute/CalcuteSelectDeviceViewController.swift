//
//  CalcuteSelectDeviceViewController.swift
//  PPBluetoothKitDemo
//
//  Created by  lefu on 2023/7/28.
//

import UIKit

class CalcuteSelectDeviceViewController: UIViewController {

  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func DC4Click(_ sender: Any) {
        
        let vc = CalcuteInfoViewController.instantiate()
        
        vc.selectCalcuteType = .calcuteType4DC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func AC4Cllick(_ sender: Any) {
        let vc = CalcuteInfoViewController.instantiate()
        
        vc.selectCalcuteType = .calcuteType4AC
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func AC8Cllick(_ sender: Any) {
        let vc = CalcuteInfoViewController.instantiate()
        
        vc.selectCalcuteType = .calcuteType8AC
        
        self.navigationController?.pushViewController(vc, animated: true)

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

extension CalcuteSelectDeviceViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardIdentifier: String {
        return "CalcuteSelectDeviceViewController"
    }
    
    
    
}
