//
//  PPBodyFatModel.h
//  PPBlueToothDemo
//
//  Created by 彭思远 on 2020/7/31.
//  Copyright © 2020 彭思远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPBluetoothDefine.h"


@class PPBluetoothAdvDeviceModel;
@class PPBluetoothDeviceSettingModel;

///错误类型(针对输入的参数)
typedef NS_ENUM(NSInteger, PPBodyfatErrorType){

    PP_ERROR_TYPE_NONE = 0,
    PP_ERROR_TYPE_AGE ,
    PP_ERROR_TYPE_HEIGHT,
    PP_ERROR_TYPE_WEIGHT,
    PP_ERROR_TYPE_SEX,
    PP_ERROR_TYPE_PEOPLE_TYPE,
    PP_ERROR_TYPE_IMPEDANCE_TWO_LEGS,
    PP_ERROR_TYPE_IMPEDANCE_TWO_ARMS,
    PP_ERROR_TYPE_IMPEDANCE_LEFT_BODY,
    PP_ERROR_TYPE_IMPEDANCE_LEFT_ARM,
    PP_ERROR_TYPE_IMPEDANCE_RIGHT_ARM,
    PP_ERROR_TYPE_IMPEDANCE_LEFT_LEG,
    PP_ERROR_TYPE_IMPEDANCE_RIGHT_LEG,
    PP_ERROR_TYPE_IMPEDANCE_TRUNK,
    
};


//肥胖等级
typedef NS_ENUM(NSInteger, PPBodyFatGrade) {
    
    PPBodyGradeFatThin,             // 偏瘦
    PPBodyGradeFatStandard,      // 标准
    PPBodyGradeFatOverwight,         // 超重
    PPBodyGradeFatOne,             // 肥胖1级
    PPBodyGradeFatTwo,            // 肥胖2级
    PPBodyGradeFatThree,           // 肥胖3级
 
};
//健康评估
typedef NS_ENUM(NSInteger, PPBodyHealthAssessment) {
    
    PPBodyAssessment1,          // 健康存在隐患
    PPBodyAssessment2,          // 亚健康
    PPBodyAssessment3,          // 一般
    PPBodyAssessment4,          // 良好
    PPBodyAssessment5,          // 非常好
};

// 身体类型
typedef NS_ENUM(NSUInteger, PPBodyDetailType) {
    
     PPBodyTypeThin,             // 偏瘦型
     PPBodyTypeThinMuscle,      // 偏瘦肌肉型
     PPBodyTypeMuscular,         // 肌肉发达型
    
     PPBodyTypeLackofexercise,   // 缺乏运动型
     PPBodyTypeStandard,         // 标准型
     PPBodyTypeStandardMuscle,   // 标准肌肉型
    
     PPBodyTypeObesFat,          // 浮肿肥胖型
     PPBodyTypeFatMuscle,       // 偏胖肌肉型
     PPBodyTypeMuscleFat,        // 肌肉型偏胖
};

NS_ASSUME_NONNULL_BEGIN

@interface PPBodyFatModel : NSObject

#pragma mark - 用户信息

@property (nonatomic,assign) PPBodyfatErrorType   errorType;
/// 性别
@property (nonatomic,assign) PPDeviceGenderType   ppSex;
/// 身高(cm)
@property (nonatomic,assign) NSInteger            ppHeightCm;
/// 年龄(岁)
@property (nonatomic,assign) NSInteger            ppAge;
/// 体重(kg)
@property (nonatomic,assign) CGFloat              ppWeightKg;
/// 双脚阻抗加密值(下位机上传值)
@property (nonatomic,assign) NSInteger            ppZTwoLegsEnCode;
///100KHz左手阻抗加密值(下位机上传值)
@property (nonatomic,assign) NSInteger   ppZ100KhzLeftArmEnCode;
///100KHz左腳阻抗加密值(下位机上传值)
@property (nonatomic,assign) NSInteger   ppZ100KhzLeftLegEnCode;
///100KHz右手阻抗加密值(下位机上传值)
@property (nonatomic,assign) NSInteger   ppZ100KhzRightArmEnCode;
///100KHz右腳阻抗加密值(下位机上传值)
@property (nonatomic,assign) NSInteger   ppZ100KhzRightLegEnCode;
///100KHz軀幹阻抗加密值(下位机上传值)
@property (nonatomic,assign) NSInteger   ppZ100KhzTrunkEnCode;
///20KHz左手阻抗加密值(下位机上传值)
@property (nonatomic,assign) NSInteger   ppZ20KhzLeftArmEnCode;
///20KHz左腳阻抗加密值(下位机上传值)
@property (nonatomic,assign) NSInteger   ppZ20KhzLeftLegEnCode;
///20KHz右手阻抗加密值(下位机上传值)
@property (nonatomic,assign) NSInteger   ppZ20KhzRightArmEnCode;
///20KHz右腳阻抗加密值(下位机上传值)
@property (nonatomic,assign) NSInteger   ppZ20KhzRightLegEnCode;
///20KHz軀幹阻抗加密值(下位机上传值)
@property (nonatomic,assign) NSInteger   ppZ20KhzTrunkEnCode;


@property (nonatomic, strong) NSString *showDic;
#pragma mark - 设备相关

/// 秤端单位
@property (nonatomic,assign) PPDeviceUnit          ppUnit;
/// 计算库版本号
@property (nonatomic,copy) NSString                *ppSDKVersion;
/// 产生设备的蓝牙MAC
@property (nonatomic,copy) NSString                *ppDeviceMac;


#pragma mark - 普通构造方法，用于秤端计算

- (instancetype)initWithUserModel:(PPBluetoothDeviceSettingModel *)userModel
                        andWeight:(CGFloat)weight;

#pragma mark - 四电极算法

@property (nonatomic,strong) NSArray<NSNumber *>* ppWeightKgList;

/// Body Mass Index
@property (nonatomic,assign) CGFloat              ppBMI;
@property (nonatomic,strong) NSArray<NSNumber *>* ppBMIList;

/// 脂肪率(%)
@property (nonatomic,assign) CGFloat              ppFat;
@property (nonatomic,strong) NSArray<NSNumber *>* ppFatList;

/// 脂肪量(kg)
@property (nonatomic,assign) CGFloat               ppBodyfatKg;
@property (nonatomic,strong) NSArray<NSNumber *>* ppBodyfatKgList;

/// 肌肉率(%)
@property (nonatomic,assign) CGFloat               ppMusclePercentage;
@property (nonatomic,strong) NSArray<NSNumber *>* ppMusclePercentageList;

/// 肌肉量(kg)
@property (nonatomic,assign) CGFloat               ppMuscleKg;
@property (nonatomic,strong) NSArray<NSNumber *>* ppMuscleKgList;

/// 骨骼肌率(%)
@property (nonatomic,assign) CGFloat               ppBodySkeletal;
@property (nonatomic,strong) NSArray<NSNumber *>* ppBodySkeletalList;

/// 骨骼肌量(kg)
@property (nonatomic,assign) CGFloat               ppBodySkeletalKg;
@property (nonatomic,strong) NSArray<NSNumber *>* ppBodySkeletalKgList;

/// 水分率(%), 分辨率0.1,
@property (nonatomic,assign) CGFloat               ppWaterPercentage;
@property (nonatomic,strong) NSArray<NSNumber *>* ppWaterPercentageList;

///水分量(Kg)
@property (nonatomic,assign) CGFloat               ppWaterKg;
@property (nonatomic,strong) NSArray<NSNumber *>* ppWaterKgList;

/// 蛋白质率(%)
@property (nonatomic,assign) CGFloat               ppProteinPercentage;
@property (nonatomic,strong) NSArray<NSNumber *>* ppProteinPercentageList;

///蛋白质量(Kg)
@property (nonatomic,assign) CGFloat               ppProteinKg;
@property (nonatomic,strong) NSArray<NSNumber *>* ppProteinKgList;
 
/// 去脂体重(kg)
@property (nonatomic,assign) CGFloat               ppLoseFatWeightKg;

/// 皮下脂肪率(%)
@property (nonatomic,assign) CGFloat               ppBodyFatSubCutPercentage;
@property (nonatomic,strong) NSArray<NSNumber *>* ppBodyFatSubCutPercentageList;

/// 皮下脂肪量
@property (nonatomic,assign) CGFloat               ppBodyFatSubCutKg;
@property (nonatomic,strong) NSArray<NSNumber *>* ppBodyFatSubCutKgList;

/// 心律(bmp)
@property (nonatomic,assign) NSInteger             ppHeartRate;
@property (nonatomic,strong) NSArray<NSNumber *>* ppHeartRateList;

/// 基础代谢
@property (nonatomic,assign) NSInteger             ppBMR;
@property (nonatomic,strong) NSArray<NSNumber *>* ppBMRList;

/// 内脏脂肪等级
@property (nonatomic,assign) NSInteger             ppVisceralFat;
@property (nonatomic,strong) NSArray<NSNumber *>* ppVisceralFatList;

/// 骨量(kg)
@property (nonatomic,assign) CGFloat               ppBoneKg;
@property (nonatomic,strong) NSArray<NSNumber *>* ppBoneKgList;


/// 肌肉控制量(kg)
@property (nonatomic,assign) CGFloat              ppBodyMuscleControl;
/// 脂肪控制量(kg)
@property (nonatomic,assign) CGFloat              ppFatControlKg;
/// 标准体重
@property (nonatomic,assign) CGFloat              ppBodyStandardWeightKg;
/// 理想体重(kg)
@property (nonatomic,assign) CGFloat              ppIdealWeightKg;
/// 控制体重(kg)
@property (nonatomic,assign) CGFloat              ppControlWeightKg;
/// 身体类型
@property (nonatomic,assign) PPBodyDetailType     ppBodyType;

/// 肥胖等级
@property (nonatomic,assign) PPBodyFatGrade       ppFatGrade;
@property (nonatomic,strong) NSArray<NSNumber *>* ppFatGradeList;

/// 健康评估
@property (nonatomic,assign) PPBodyHealthAssessment   ppBodyHealth;
@property (nonatomic,strong) NSArray<NSNumber *>* ppBodyHealthList;

/// 身体年龄
@property (nonatomic,assign) NSInteger            ppBodyAge;
@property (nonatomic,strong) NSArray<NSNumber *>* ppBodyAgeList;

/// 身体得分
@property (nonatomic,assign) NSInteger            ppBodyScore;
@property (nonatomic,strong) NSArray<NSNumber *>* ppBodyScoreList;



- (instancetype)initWithUserModel:(PPBluetoothDeviceSettingModel *)userModel
                deviceCalcuteType:(PPDeviceCalcuteType)deviceCalcuteType
                        deviceMac:(NSString *)deviceMac
                           weight:(CGFloat)weight
                        heartRate:(NSInteger)heartRate
                     andImpedance:(NSInteger)impedance;


#pragma mark - 八电极算法独有


///輸出參數-全身体组成:身体细胞量(kg)
@property (nonatomic,assign) CGFloat               ppCellMassKg;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppCellMassKgList;

///輸出參數-评价建议:建议卡路里摄入量 Kcal/day
@property (nonatomic,assign) NSInteger             ppDCI;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppDCIList;

///輸出參數-全身体组成:无机盐量(Kg)
@property (nonatomic,assign) CGFloat               ppMineralKg;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppMineralKgList;

///輸出參數-评价建议: 肥胖度(%)
@property (nonatomic,assign) CGFloat               ppObesity;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppObesityList;

///輸出參數-全身体组成:细胞外水量(kg)
@property (nonatomic,assign) CGFloat               ppWaterECWKg;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppWaterECWKgList;

///輸出參數-全身体组成:细胞内水量(kg)
@property (nonatomic,assign) CGFloat               ppWaterICWKg;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppWaterICWKgList;

///左手脂肪量(%), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppBodyFatKgLeftArm;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppBodyFatKgLeftArmList;

///左脚脂肪量(%), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppBodyFatKgLeftLeg;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppBodyFatKgLeftLegList;

///右手脂肪量(%), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppBodyFatKgRightArm;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppBodyFatKgRightArmList;

///右脚脂肪量(%), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppBodyFatKgRightLeg;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppBodyFatKgRightLegList;

///躯干脂肪量(%), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppBodyFatKgTrunk;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppBodyFatKgTrunkList;

///左手脂肪率(%), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppBodyFatRateLeftArm;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppBodyFatRateLeftArmList;

///左脚脂肪率(%), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppBodyFatRateLeftLeg;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppBodyFatRateLeftLegList;

///右手脂肪率(%), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppBodyFatRateRightArm;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppBodyFatRateRightArmList;

///右脚脂肪率(%), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppBodyFatRateRightLeg;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppBodyFatRateRightLegList;

///躯干脂肪率(%), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppBodyFatRateTrunk;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppBodyFatRateTrunkList;

///左手肌肉量(kg), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppMuscleKgLeftArm;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppMuscleKgLeftArmList;

///左脚肌肉量(kg), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppMuscleKgLeftLeg;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppMuscleKgLeftLegList;

///右手肌肉量(kg), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppMuscleKgRightArm;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppMuscleKgRightArmList;

///右脚肌肉量(kg), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppMuscleKgRightLeg;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppMuscleKgRightLegList;
///躯干肌肉量(kg), 分辨率0.1
@property (nonatomic,assign) CGFloat               ppMuscleKgTrunk;
 @property (nonatomic,strong) NSArray<NSNumber *>* ppMuscleKgTrunkList;

- (instancetype)initWithUserModel:(PPBluetoothDeviceSettingModel *)userModel
                        deviceMac:(NSString *)deviceMac
                           weight:(CGFloat)weight
                        heartRate:(NSInteger)heartRate
              Z20KhzLeftArmEnCode:(NSInteger)z20KhzLeftArmEnCode
             Z20KhzRightArmEnCode:(NSInteger)z20KhzRightArmEnCode
              Z20KhzLeftLegEnCode:(NSInteger)z20KhzLeftLegEnCode
             Z20KhzRightLegEnCode:(NSInteger)z20KhzRightLegEnCode
                Z20KhzTrunkEnCode:(NSInteger)z20KhzTrunkEnCode
             Z100KhzLeftArmEnCode:(NSInteger)z100KhzLeftArmEnCode
            Z100KhzRightArmEnCode:(NSInteger)z100KhzRightArmEnCode
             Z100KhzLeftLegEnCode:(NSInteger)z100KhzLeftLegEnCode
            Z100KhzRightLegEnCode:(NSInteger)z100KhzRightLegEnCode
               Z100KhzTrunkEnCode:(NSInteger)z100KhzTrunkEnCode;


#pragma mark - 8电极
- (instancetype)initWithUserModel2:(PPBluetoothDeviceSettingModel *)userModel
                        deviceMac:(NSString *)deviceMac
                           weight:(CGFloat)weight
                        heartRate:(NSInteger)heartRate
              Z20KhzLeftArmEnCode:(NSInteger)z20KhzLeftArmEnCode
             Z20KhzRightArmEnCode:(NSInteger)z20KhzRightArmEnCode
              Z20KhzLeftLegEnCode:(NSInteger)z20KhzLeftLegEnCode
             Z20KhzRightLegEnCode:(NSInteger)z20KhzRightLegEnCode
                Z20KhzTrunkEnCode:(NSInteger)z20KhzTrunkEnCode
             Z100KhzLeftArmEnCode:(NSInteger)z100KhzLeftArmEnCode
            Z100KhzRightArmEnCode:(NSInteger)z100KhzRightArmEnCode
             Z100KhzLeftLegEnCode:(NSInteger)z100KhzLeftLegEnCode
            Z100KhzRightLegEnCode:(NSInteger)z100KhzRightLegEnCode
                Z100KhzTrunkEnCode:(NSInteger)z100KhzTrunkEnCode;

#pragma mark - 闭目单脚功能
/// 闭目单脚站立时间
@property (nonatomic,assign) NSInteger           ppStandTime;

@end




NS_ASSUME_NONNULL_END
