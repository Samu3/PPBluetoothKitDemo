//
//  CalcuelateResultViewController.swift
//  PPBluetoothKitDemo
//
//  Created by  lefu on 2023/7/28.
//

import UIKit

class CalcuelateResultViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    var selectCalcuteType = calcuteType.calcuteType8AC
    
    var myUserModel : UserModel!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = UserDefaults.standard.data(forKey: "userInfo"){
            
            let decoder = JSONDecoder()
            if let decodedUser = try? decoder.decode(UserModel.self, from: data){
                
                self.myUserModel = decodedUser
            }
        }
        
        self.showReslut()
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
      

        // Do any additional setup after loading the view.
    }
    
    
    func showReslut(){
        let userModel =  PPBluetoothDeviceSettingModel()
        
        userModel.age = self.myUserModel.age
        userModel.height = self.myUserModel.height
        userModel.gender = PPDeviceGenderType.init(rawValue: UInt(self.myUserModel.sex))!
        userModel.isAthleteMode = self.myUserModel.isAthleteMode == 1 ?true:false
        
        
        var fatModel:PPBodyFatModel!

        if self.selectCalcuteType == .calcuteType4DC{
            
            fatModel = PPBodyFatModel(userModel: userModel,
                                      deviceCalcuteType: PPDeviceCalcuteType.direct,
                                      deviceMac: "c1:c1:c1:c1",
                                      weight: CGFloat(self.myUserModel.weight),
                                      heartRate: 0,
                                      andImpedance: self.myUserModel.impedance)
            
         
        
            

        }else if self.selectCalcuteType == .calcuteType8AC{
            
            fatModel  = PPBodyFatModel(userModel: userModel,
                                                 deviceMac: "",
                                                 weight: CGFloat(self.myUserModel.weight),
                                                 heartRate: 0,
                                                 z20KhzLeftArmEnCode: self.myUserModel.z20KhzLeftArmEnCode,
                                                 z20KhzRightArmEnCode: self.myUserModel.z20KhzRightArmEnCode,
                                                 z20KhzLeftLegEnCode: self.myUserModel.z20KhzLeftLegEnCode,
                                                 z20KhzRightLegEnCode: self.myUserModel.z20KhzRightLegEnCode,
                                                 z20KhzTrunkEnCode: self.myUserModel.z20KhzTrunkEnCode,
                                                 z100KhzLeftArmEnCode: self.myUserModel.z100KhzLeftArmEnCode,
                                                 z100KhzRightArmEnCode: self.myUserModel.z100KhzRightArmEnCode,
                                                 z100KhzLeftLegEnCode: self.myUserModel.z100KhzLeftLegEnCode,
                                                 z100KhzRightLegEnCode: self.myUserModel.z100KhzRightLegEnCode,
                                                 z100KhzTrunkEnCode: self.myUserModel.z100KhzTrunkEnCode)
        }else{
            
            fatModel =  PPBodyFatModel(userModel: userModel,
                                       deviceCalcuteType: PPDeviceCalcuteType.alternate,
                                       deviceMac: "c1:c1:c1:c1",
                                       weight: CGFloat(self.myUserModel.weight),
                                       heartRate: 0,
                                       andImpedance: self.myUserModel.impedance)

        }
        
        let arr = [ "PP_ERROR_TYPE_NONE",
                    "PP_ERROR_TYPE_AGE" ,
                    "PP_ERROR_TYPE_HEIGHT",
                    "PP_ERROR_TYPE_WEIGHT",
                    "PP_ERROR_TYPE_SEX",
                    "PP_ERROR_TYPE_PEOPLE_TYPE",
                    "PP_ERROR_TYPE_IMPEDANCE_TWO_LEGS",
                    "PP_ERROR_TYPE_IMPEDANCE_TWO_ARMS",
                    "PP_ERROR_TYPE_IMPEDANCE_LEFT_BODY",
                    "PP_ERROR_TYPE_IMPEDANCE_LEFT_ARM",
                    "PP_ERROR_TYPE_IMPEDANCE_RIGHT_ARM",
                    "PP_ERROR_TYPE_IMPEDANCE_LEFT_LEG",
                    "PP_ERROR_TYPE_IMPEDANCE_RIGHT_LEG",
                    "PP_ERROR_TYPE_IMPEDANCE_TRUNK",]
        
       let ss = """
        
        errorType = "\(arr[fatModel.errorType.rawValue])"
        
        ppWeightKgList = \(fatModel.ppWeightKgList)
        ppBMI = \(fatModel.ppBMI)
        ppBMIList = \(fatModel.ppBMIList)
        ppFat = \(fatModel.ppFat)
        ppFatList = \(fatModel.ppFatList)
        ppBodyfatKg = \(fatModel.ppBodyfatKg)
        ppBodyfatKgList = \(fatModel.ppBodyfatKgList)
        ppMusclePercentage = \(fatModel.ppMusclePercentage)
        ppMusclePercentageList = \(fatModel.ppMusclePercentageList)
        ppMuscleKg = \(fatModel.ppMuscleKg)
        ppMuscleKgList = \(fatModel.ppMuscleKgList)
        ppBodySkeletal = \(fatModel.ppBodySkeletal)
        ppBodySkeletalList = \(fatModel.ppBodySkeletalList)
        ppBodySkeletalKg = \(fatModel.ppBodySkeletalKg)
        ppBodySkeletalKgList = \(fatModel.ppBodySkeletalKgList)
        ppWaterPercentage = \(fatModel.ppWaterPercentage)
        ppWaterPercentageList = \(fatModel.ppWaterPercentageList)
        ppWaterKg = \(fatModel.ppWaterKg)
        ppWaterKgList = \(fatModel.ppWaterKgList)
        ppProteinPercentage = \(fatModel.ppProteinPercentage)
        ppProteinPercentageList = \(fatModel.ppProteinPercentageList)
        ppProteinKg = \(fatModel.ppProteinKg)
        ppProteinKgList = \(fatModel.ppProteinKgList)
        ppLoseFatWeightKg = \(fatModel.ppLoseFatWeightKg)
        ppLoseFatWeightKgList = \(fatModel.ppLoseFatWeightKgList)
        ppBodyFatSubCutPercentage = \(fatModel.ppBodyFatSubCutPercentage)
        ppBodyFatSubCutPercentageList = \(fatModel.ppBodyFatSubCutPercentageList)
        ppBodyFatSubCutKg = \(fatModel.ppBodyFatSubCutKg)
        ppBodyFatSubCutKgList = \(fatModel.ppBodyFatSubCutKgList)
        ppHeartRate = \(fatModel.ppHeartRate)
        ppHeartRateList = \(fatModel.ppHeartRateList)
        ppBMR = \(fatModel.ppBMR)
        ppBMRList = \(fatModel.ppBMRList)
        ppVisceralFat = \(fatModel.ppVisceralFat)
        ppVisceralFatList = \(fatModel.ppVisceralFatList)
        ppBoneKg = \(fatModel.ppBoneKg)
        ppBoneKgList = \(fatModel.ppBoneKgList)
        ppBodyMuscleControl = \(fatModel.ppBodyMuscleControl)
        ppFatControlKg = \(fatModel.ppFatControlKg)
        ppBodyStandardWeightKg = \(fatModel.ppBodyStandardWeightKg)
        ppIdealWeightKg = \(fatModel.ppIdealWeightKg)
        ppControlWeightKg = \(fatModel.ppControlWeightKg)
        ppBodyType = \(fatModel.ppBodyType.rawValue)
        ppFatGrade = \(fatModel.ppFatGrade.rawValue)
        ppFatGradeList = \(fatModel.ppFatGradeList)
        ppBodyHealth = \(fatModel.ppBodyHealth.rawValue)
        ppBodyHealthList = \(fatModel.ppBodyHealthList)
        ppBodyAge = \(fatModel.ppBodyAge)
        ppBodyAgeList = \(fatModel.ppBodyAgeList)
        ppBodyScore = \(fatModel.ppBodyScore)
        ppBodyScoreList = \(fatModel.ppBodyScoreList)
        
        ========calcuteType8AC=========
        
        ppCellMassKg = \(fatModel.ppCellMassKg)
        ppCellMassKgList = \(fatModel.ppCellMassKgList)
        ppDCI = \(fatModel.ppDCI)
        ppMineralKg = \(fatModel.ppMineralKg)
        ppMineralKgList = \(fatModel.ppMineralKgList)
        ppObesity = \(fatModel.ppObesity)
        ppObesityList = \(fatModel.ppObesityList)
        ppWaterECWKg = \(fatModel.ppWaterECWKg)
        ppWaterECWKgList = \(fatModel.ppWaterECWKgList)
        ppWaterICWKg = \(fatModel.ppWaterICWKg)
        ppWaterICWKgList = \(fatModel.ppWaterICWKgList)
        ppBodyFatKgLeftArm = \(fatModel.ppBodyFatKgLeftArm)
        ppBodyFatKgLeftLeg = \(fatModel.ppBodyFatKgLeftLeg)
        ppBodyFatKgRightArm = \(fatModel.ppBodyFatKgRightArm)
        ppBodyFatKgRightLeg = \(fatModel.ppBodyFatKgRightLeg)
        ppBodyFatKgTrunk = \(fatModel.ppBodyFatKgTrunk)
        ppBodyFatRateLeftArm = \(fatModel.ppBodyFatRateLeftArm)
        ppBodyFatRateLeftLeg = \(fatModel.ppBodyFatRateLeftLeg)
        ppBodyFatRateRightArm = \(fatModel.ppBodyFatRateRightArm)
        ppBodyFatRateRightLeg = \(fatModel.ppBodyFatRateRightLeg)
        ppBodyFatRateTrunk = \(fatModel.ppBodyFatRateTrunk)
        ppMuscleKgLeftArm = \(fatModel.ppMuscleKgLeftArm)
        ppMuscleKgLeftLeg = \(fatModel.ppMuscleKgLeftLeg)
        ppMuscleKgRightArm = \(fatModel.ppMuscleKgRightArm)
        ppMuscleKgRightLeg = \(fatModel.ppMuscleKgRightLeg)
        ppMuscleKgTrunk = \(fatModel.ppMuscleKgTrunk)
        
        """
        
        self.textView.text = ss
     
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

extension CalcuelateResultViewController:StoryboardInstantiable{
    static var storyboardName: String {
        return "Main"
    }
    
    static var storyboardIdentifier: String {
        return "CalcuelateResultViewController"
    }
    
    
    
}

