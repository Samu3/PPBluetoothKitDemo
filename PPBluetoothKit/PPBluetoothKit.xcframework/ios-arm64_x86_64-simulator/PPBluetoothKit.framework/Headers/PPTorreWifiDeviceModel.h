//
//  PPTorreWifiDeviceModel.h
//  PPBluetoothKit
//
//  Created by 彭思远 on 2023/4/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPTorreWifiDeviceModel : NSObject

@property (nonatomic, copy) NSString *ssid;
@property (nonatomic, assign) NSInteger strength;
@end

NS_ASSUME_NONNULL_END
