//
//  NSObject+PPAstonKeyValue.h
//  PPAstonExtension
//
//  Created by PPAston on 13-8-24.
//  Copyright (c) 2013年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPAstonExtensionConst.h"
#import <CoreData/CoreData.h>
#import "PPAstonProperty.h"

/**
 *  KeyValue协议
 */
@protocol PPAstonKeyValue <NSObject>
@optional
/**
 *  只有这个数组中的属性名才允许进行字典和模型的转换
 */
+ (NSArray *)PPAston_allowedPropertyNames;

/**
 *  这个数组中的属性名将会被忽略：不进行字典和模型的转换
 */
+ (NSArray *)PPAston_ignoredPropertyNames;

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)PPAston_replacedKeyFromPropertyName;

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 从字典中取值用的key
 */
+ (id)PPAston_replacedKeyFromPropertyName121:(NSString *)propertyName;

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)PPAston_objectClassInArray;


/** 特殊地区在字符串格式化数字时使用 */
+ (NSLocale *)PPAston_numberLocale;

/**
 *  旧值换新值，用于过滤字典中的值
 *
 *  @param oldValue 旧值
 *
 *  @return 新值
 */
- (id)PPAston_newValueFromOldValue:(id)oldValue property:(PPAstonProperty *)property;

/**
 *  当字典转模型完毕时调用
 */
- (void)PPAston_keyValuesDidFinishConvertingToObject PPAstonExtensionDeprecated("请使用`PPAston_didConvertToObjectWithKeyValues:`替代");
- (void)PPAston_keyValuesDidFinishConvertingToObject:(NSDictionary *)keyValues PPAstonExtensionDeprecated("请使用`PPAston_didConvertToObjectWithKeyValues:`替代");
- (void)PPAston_didConvertToObjectWithKeyValues:(NSDictionary *)keyValues;

/**
 *  当模型转字典完毕时调用
 */
- (void)PPAston_objectDidFinishConvertingToKeyValues PPAstonExtensionDeprecated("请使用`PPAston_objectDidConvertToKeyValues:`替代");
- (void)PPAston_objectDidConvertToKeyValues:(NSMutableDictionary *)keyValues;

@end

@interface NSObject (PPAstonKeyValue) <PPAstonKeyValue>
#pragma mark - 类方法
/**
 * 字典转模型过程中遇到的错误
 */
+ (NSError *)PPAston_error;

/**
 *  模型转字典时，字典的key是否参考replacedKeyFromPropertyName等方法（父类设置了，子类也会继承下来）
 */
+ (void)PPAston_referenceReplacedKeyWhenCreatingKeyValues:(BOOL)reference;

#pragma mark - 对象方法
/**
 *  将字典的键值对转成模型属性
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 */
- (instancetype)PPAston_setKeyValues:(id)keyValues;

/**
 *  将字典的键值对转成模型属性
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @param context   CoreData上下文
 */
- (instancetype)PPAston_setKeyValues:(id)keyValues context:(NSManagedObjectContext *)context;

/**
 *  将模型转成字典
 *  @return 字典
 */
- (NSMutableDictionary *)PPAston_keyValues;
- (NSMutableDictionary *)PPAston_keyValuesWithKeys:(NSArray *)keys;
- (NSMutableDictionary *)PPAston_keyValuesWithIgnoredKeys:(NSArray *)ignoredKeys;

/**
 *  通过模型数组来创建一个字典数组
 *  @param objectArray 模型数组
 *  @return 字典数组
 */
+ (NSMutableArray *)PPAston_keyValuesArrayWithObjectArray:(NSArray *)objectArray;
+ (NSMutableArray *)PPAston_keyValuesArrayWithObjectArray:(NSArray *)objectArray keys:(NSArray *)keys;
+ (NSMutableArray *)PPAston_keyValuesArrayWithObjectArray:(NSArray *)objectArray ignoredKeys:(NSArray *)ignoredKeys;

#pragma mark - 字典转模型
/**
 *  通过字典来创建一个模型
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @return 新建的对象
 */
+ (instancetype)PPAston_objectWithKeyValues:(id)keyValues;

/**
 *  通过字典来创建一个CoreData模型
 *  @param keyValues 字典(可以是NSDictionary、NSData、NSString)
 *  @param context   CoreData上下文
 *  @return 新建的对象
 */
+ (instancetype)PPAston_objectWithKeyValues:(id)keyValues context:(NSManagedObjectContext *)context;

/**
 *  通过plist来创建一个模型
 *  @param filename 文件名(仅限于mainBundle中的文件)
 *  @return 新建的对象
 */
+ (instancetype)PPAston_objectWithFilename:(NSString *)filename;

/**
 *  通过plist来创建一个模型
 *  @param file 文件全路径
 *  @return 新建的对象
 */
+ (instancetype)PPAston_objectWithFile:(NSString *)file;

#pragma mark - 字典数组转模型数组
/**
 *  通过字典数组来创建一个模型数组
 *  @param keyValuesArray 字典数组(可以是NSDictionary、NSData、NSString)
 *  @return 模型数组
 */
+ (NSMutableArray *)PPAston_objectArrayWithKeyValuesArray:(id)keyValuesArray;

/**
 *  通过字典数组来创建一个模型数组
 *  @param keyValuesArray 字典数组(可以是NSDictionary、NSData、NSString)
 *  @param context        CoreData上下文
 *  @return 模型数组
 */
+ (NSMutableArray *)PPAston_objectArrayWithKeyValuesArray:(id)keyValuesArray context:(NSManagedObjectContext *)context;

/**
 *  通过plist来创建一个模型数组
 *  @param filename 文件名(仅限于mainBundle中的文件)
 *  @return 模型数组
 */
+ (NSMutableArray *)PPAston_objectArrayWithFilename:(NSString *)filename;

/**
 *  通过plist来创建一个模型数组
 *  @param file 文件全路径
 *  @return 模型数组
 */
+ (NSMutableArray *)PPAston_objectArrayWithFile:(NSString *)file;

#pragma mark - 转换为JSON
/**
 *  转换为JSON Data
 */
- (NSData *)PPAston_JSONData;
/**
 *  转换为字典或者数组
 */
- (id)PPAston_JSONObject;
/**
 *  转换为JSON 字符串
 */
- (NSString *)PPAston_JSONString;
@end
