//
//  PPTorreConfigWifiModel.h
//  PPBluetoothKit
//
//  Created by 彭思远 on 2023/4/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPTorreConfigWifiModel : NSObject

@property (nonatomic, copy) NSString *ssid;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *domain;


@end

NS_ASSUME_NONNULL_END
