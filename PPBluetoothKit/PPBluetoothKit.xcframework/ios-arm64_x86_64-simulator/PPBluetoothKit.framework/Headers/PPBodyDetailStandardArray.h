//
//  PPBodyDetailStandardArray.h
//  PPBluetoothKit
//
//  Created by 彭思远 on 2023/6/20.
//

#import <Foundation/Foundation.h>
#import "PPBodyFatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPBodyDetailStandardArray : NSObject


- initWithHeightCm:(NSInteger)heightCm
            gender:(PPDeviceGenderType)gender
               age:(NSInteger)age
            weight:(CGFloat)weight;

+ (NSInteger)calculateCurrentStandardWithValue:(CGFloat)number andStandardArray:(NSArray *)array;

+ (NSArray *)sortKeysToDictionary:(NSDictionary *)dictionary;

+ (NSArray *)sortValuesToDictionary:(NSDictionary *)dictionary;

- (NSArray *)fetchPPBodyParam_Weight_StandartArray;

- (NSArray *)fetchPPBodyParam_BodyFat_StandartArray;

- (NSArray *)fetchPPBodyParam_Water_StandartArray;

- (NSArray *)fetchPPBodyParam_Mus_StandartArray;

- (NSArray *)fetchPPBodyParam_Bone_StandartArray;

- (NSArray *)fetchPPBodyParam_BMR_StandartArray;

- (NSArray *)fetchPPBodyParam_BMI_StandartArray;

- (NSArray *)fetchPPBodyParam_VisFat_StandartArray;

- (NSArray *)fetchPPBodyParam_proteinPercentage_StandartArray;

- (NSArray *)fetchPPBodyParam_BodySubcutaneousFat_StandartArray;

- (NSArray *)fetchPPBodyParam_BodySkeletal_StandartArray;

- (NSArray *)fetchPPBodyParam_heart_StandartArray;

- (NSArray *)fetchPPBodyParam_BodyHealth_StandartArray;

- (NSArray *)fetchPPBodyParam_FatGrade_StandartArray;

- (NSArray *)fetchPPBodyParam_physicalAgeValue_StandartArray;

- (NSArray *)fetchPPBodyParam_BodyScore_StandartArray;

- (NSArray *)percent2kg:(NSArray *)source;

- (NSArray *)kg2percent:(NSArray *)source;
@end

NS_ASSUME_NONNULL_END
