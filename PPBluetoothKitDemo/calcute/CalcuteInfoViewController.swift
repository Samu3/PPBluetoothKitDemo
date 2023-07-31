//
//  CalcuteInfoViewController.swift
//  PPBluetoothKitDemo
//
//  Created by  lefu on 2023/7/28.
//

import UIKit

enum calcuteType{
    case calcuteType4DC
    case calcuteType4AC
    case calcuteType8AC
}

struct UserModel:Codable{
    
    var sex = 0
    var impedance = 1000
    var weight : Float  = 60
    var age = 20
    var height = 160

    public var z100KhzLeftArmEnCode : Int = 0
    public var z100KhzLeftLegEnCode : Int = 0
    public var z100KhzRightArmEnCode : Int = 0
    public var z100KhzRightLegEnCode : Int = 0
    public var z100KhzTrunkEnCode : Int = 0
    public var z20KhzLeftArmEnCode : Int = 0
    public var z20KhzLeftLegEnCode : Int = 0
    public var z20KhzRightArmEnCode : Int = 0
    public var z20KhzRightLegEnCode : Int = 0
    public var z20KhzTrunkEnCode : Int = 0
    
    var isAthleteMode  = 0
    
    enum CodingKeys: String, CodingKey {
           case sex, impedance, weight, age, height
           case z100KhzLeftArmEnCode
           case z100KhzLeftLegEnCode
           case z100KhzRightArmEnCode
           case z100KhzRightLegEnCode
           case z100KhzTrunkEnCode
           case z20KhzLeftArmEnCode
           case z20KhzLeftLegEnCode
           case z20KhzRightArmEnCode
           case z20KhzRightLegEnCode
           case z20KhzTrunkEnCode
        case isAthleteMode
       }
    
    
    // 实现Decodable协议的init(from decoder: Decoder)方法
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sex = try container.decode(Int.self, forKey: .sex)
        impedance = try container.decode(Int.self, forKey: .impedance)
        age = try container.decode(Int.self, forKey: .age)
        height = try container.decode(Int.self, forKey: .height)
        
        // 将weight属性从Double类型解码为CGFloat类型
        weight = try container.decode(Float.self, forKey: .weight)
        
        z100KhzLeftArmEnCode = try container.decode(Int.self, forKey: .z100KhzLeftArmEnCode)
        z100KhzLeftLegEnCode = try container.decode(Int.self, forKey: .z100KhzLeftLegEnCode)
        z100KhzRightArmEnCode = try container.decode(Int.self, forKey: .z100KhzRightArmEnCode)
        z100KhzRightLegEnCode = try container.decode(Int.self, forKey: .z100KhzRightLegEnCode)
        z100KhzTrunkEnCode = try container.decode(Int.self, forKey: .z100KhzTrunkEnCode)
        z20KhzLeftArmEnCode = try container.decode(Int.self, forKey: .z20KhzLeftArmEnCode)
        z20KhzLeftLegEnCode = try container.decode(Int.self, forKey: .z20KhzLeftLegEnCode)
        z20KhzRightArmEnCode = try container.decode(Int.self, forKey: .z20KhzRightArmEnCode)
        z20KhzRightLegEnCode = try container.decode(Int.self, forKey: .z20KhzRightLegEnCode)
        z20KhzTrunkEnCode = try container.decode(Int.self, forKey: .z20KhzTrunkEnCode)
        
        isAthleteMode = try container.decode(Int.self, forKey: .isAthleteMode)

        
    }
    
    

}

class CalcuteInfoViewController: UIViewController {

    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var impedenceTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
    
    
    @IBOutlet weak var z100KhzLeftArmEnCode: UITextField!
    @IBOutlet weak var z100KhzLeftLegEnCode: UITextField!
    @IBOutlet weak var z100KhzRightArmEnCode: UITextField!
    @IBOutlet weak var z100KhzRightLegEnCode: UITextField!
    @IBOutlet weak var z100KhzTrunkEnCode: UITextField!
    @IBOutlet weak var z20KhzLeftArmEnCode: UITextField!
    @IBOutlet weak var z20KhzLeftLegEnCode: UITextField!
    @IBOutlet weak var z20KhzRightArmEnCode: UITextField!
    @IBOutlet weak var z20KhzRightLegEnCode: UITextField!
    @IBOutlet weak var z20KhzTrunkEnCode: UITextField!

    
    let jsonData = """
        {
            "sex": 0,
             "impedance": 1000,
             "weight":65,
             "age": 20,
             "height": 160,
            "isAthleteMode":0,
             "z100KhzLeftArmEnCode": 275714227,
             "z100KhzLeftLegEnCode": 570158928,
             "z100KhzRightArmEnCode":817852360,
             "z100KhzRightLegEnCode": 1910601986,
             "z100KhzTrunkEnCode": 1344363263,
             "z20KhzLeftArmEnCode": 544018656,
             "z20KhzLeftLegEnCode": 1637003200,
             "z20KhzRightArmEnCode": 1078788052,
             "z20KhzRightLegEnCode": 1617721244,
             "z20KhzTrunkEnCode": 1615863103
        }
    """.data(using: .utf8)!
    
    var myUserModel : UserModel!
    var selectCalcuteType = calcuteType.calcuteType8AC
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = UserDefaults.standard.data(forKey: "userInfo"){
            
            let decoder = JSONDecoder()
            if let decodedUser = try? decoder.decode(UserModel.self, from: data){
                
                self.myUserModel = decodedUser
            }
        }else{
            
            
            let decoder = JSONDecoder()
            if let decodedUser = try? decoder.decode(UserModel.self, from: jsonData){
                
                self.myUserModel = decodedUser
            }
            
        }
        

        
        if self.myUserModel != nil{
            self.ageTF.text = "\(self.myUserModel.age)"
            
            self.weightTF.text = "\(self.myUserModel.weight)"
            self.heightTF.text = "\(self.myUserModel.height)"
            self.impedenceTF.text = "\(self.myUserModel.impedance)"
            self.genderSegment.selectedSegmentIndex = self.myUserModel.sex
            
            
     
            
            self.z100KhzLeftArmEnCode.text = "\(self.myUserModel.z100KhzLeftArmEnCode)"

            self.z100KhzLeftLegEnCode.text = "\(self.myUserModel.z100KhzLeftLegEnCode)"
            self.z100KhzRightArmEnCode.text = "\(self.myUserModel.z100KhzRightArmEnCode)"
            self.z100KhzRightLegEnCode.text = "\(self.myUserModel.z100KhzRightLegEnCode)"
            self.z100KhzTrunkEnCode.text = "\(self.myUserModel.z100KhzTrunkEnCode)"
            self.z20KhzLeftArmEnCode.text = "\(self.myUserModel.z20KhzLeftArmEnCode)"
            self.z20KhzLeftLegEnCode.text = "\(self.myUserModel.z20KhzLeftLegEnCode)"
            self.z20KhzRightArmEnCode.text = "\(self.myUserModel.z20KhzRightArmEnCode)"
            self.z20KhzRightLegEnCode.text = "\(self.myUserModel.z20KhzRightLegEnCode)"
            self.z20KhzTrunkEnCode.text = "\(self.myUserModel.z20KhzTrunkEnCode)"


        }
        
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.myUserModel.sex = self.genderSegment.selectedSegmentIndex
        
        if let impedence = self.impedenceTF.text{
            
            self.myUserModel.impedance = Int(impedence) ?? 500
        }

        
        if let weight = self.weightTF.text{
            
            self.myUserModel.weight = Float(weight) ?? 60
        }
        
        if let age = self.ageTF.text{
            
            self.myUserModel.age = Int(age) ?? 20
        }
        
        if let height = self.heightTF.text{
            
            self.myUserModel.height = Int(height) ?? 20
        }
        

        if let z100KhzLeftArmEnCode = self.z100KhzLeftArmEnCode.text{
            
            self.myUserModel.z100KhzLeftArmEnCode = Int(z100KhzLeftArmEnCode) ?? 500
        }
        
        if let z100KhzLeftLegEnCode = self.z100KhzLeftLegEnCode.text{
            
            self.myUserModel.z100KhzLeftLegEnCode = Int(z100KhzLeftLegEnCode) ?? 60
        }
        
        if let z100KhzRightArmEnCode = self.z100KhzRightArmEnCode.text{
            
            self.myUserModel.z100KhzRightArmEnCode = Int(z100KhzRightArmEnCode) ?? 20
        }
        
        if let z100KhzRightLegEnCode = self.z100KhzRightLegEnCode.text{
            
            self.myUserModel.z100KhzRightLegEnCode = Int(z100KhzRightLegEnCode) ?? 20
        }
        
        
        if let z100KhzTrunkEnCode = self.z100KhzTrunkEnCode.text{
            
            self.myUserModel.z100KhzTrunkEnCode = Int(z100KhzTrunkEnCode) ?? 20
        }
        
      
        
        if let z20KhzLeftArmEnCode = self.z20KhzLeftArmEnCode.text{
            
            self.myUserModel.z20KhzLeftArmEnCode = Int(z20KhzLeftArmEnCode) ?? 500
        }
        
        if let z20KhzLeftLegEnCode = self.z20KhzLeftLegEnCode.text{
            
            self.myUserModel.z20KhzLeftLegEnCode = Int(z20KhzLeftLegEnCode) ?? 60
        }
        
        if let z20KhzRightArmEnCode = self.z20KhzRightArmEnCode.text{
            
            self.myUserModel.z20KhzRightArmEnCode = Int(z20KhzRightArmEnCode) ?? 20
        }
        
        if let z20KhzRightLegEnCode = self.z20KhzRightLegEnCode.text{
            
            self.myUserModel.z20KhzRightLegEnCode = Int(z20KhzRightLegEnCode) ?? 20
        }
        
        
        if let z20KhzTrunkEnCode = self.z20KhzTrunkEnCode.text{
            
            self.myUserModel.z20KhzTrunkEnCode = Int(z20KhzTrunkEnCode) ?? 20
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let jsonData = try? encoder.encode(self.myUserModel){
            
            UserDefaults.standard.set(jsonData, forKey: "userInfo")
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
      

        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentValueChange(_ sender: Any) {
    }
    
    @IBAction func calcuteClick(_ sender: Any) {
        
        let vc = CalcuelateResultViewController.instantiate()
        vc.selectCalcuteType = self.selectCalcuteType
        
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

extension CalcuteInfoViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardIdentifier: String {
        return "CalcuteInfoViewController"
    }
    
    
    
}

