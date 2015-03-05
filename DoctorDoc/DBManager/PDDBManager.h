//
//  PDDBManager.h
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AntibioticsVO.h"
#import "PatientRecord.h"
#import "PDDBConstanst.h"

@class YTKKeyValueStore;

@interface PDDBManager : NSObject

+ (PDDBManager*)shareInstance;

- (YTKKeyValueStore*)originalStore;

- (BOOL)start;
/**
 *  删除该id病人的所有资料
 *
 *  @param pid 病人id
 */
- (void)deletePid:(NSString*)pid;
/**
 *  更新或插入key/value信息
 *
 *  @param object    value
 *  @param key       key
 *  @param tableName 表名
 *
 *  @return 是否成功
 */
- (void)putObject:(PDObject*)object key:(NSString*)key inTable:(NSString*)tableName;
/**
 *  更新或插入string
 *
 *  @param string    字符串值
 *  @param key       key值
 *  @param tableName 表名
 */
- (void)putString:(NSString*)string key:(NSString*)key inTable:(NSString*)tableName;


- (NSString*)stringForKey:(NSString*)key inTable:(NSString*)tableName;

- (NSDictionary*)dictionaryWithKey:(NSString*)key inTable:(NSString*)tableName;
/**
 *  获取单表的所有数据
 *
 *  @param tableName 表名
 *
 *  @return YTKKeyValueItem为元素的所有元素
 */
- (NSArray*)objectListInTable:(NSString*)tableName;

@end
