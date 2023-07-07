//
//  PPBluetoothTorreDataAnalysis.h
//  PPBluetoothKit
//
//  Created by 彭思远 on 2023/4/10.
//

#import <Foundation/Foundation.h>
#import "PPBluetoothAdvDeviceModel.h"
#import "PPBluetoothScaleBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPBluetoothTorreDataAnalysis : NSObject

+ (PPBluetoothScaleBaseModel *)analysisData:(NSData *)receiveDate;

+ (NSArray <PPBluetoothScaleBaseModel *>*)torreHistoryWithData:(NSData *)data;
@end

NS_ASSUME_NONNULL_END
