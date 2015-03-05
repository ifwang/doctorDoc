//
//  PDDBManager.m
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "PDDBManager.h"
#import "YTKKeyValueStore.h"

static NSString *kPatientTableName = @"Patient";
static NSString *kDailyRecordTableName = @"DailyRecord";
static NSString *kBSugarTableName = @"BSugar";
static NSString *kAntibioticsTableName = @"Antibiotics";
static NSString *kHealRecordTableName = @"HealRecord";

@interface PDDBManager()

@property (nonatomic ,strong) YTKKeyValueStore *store;

@end

@implementation PDDBManager

+(PDDBManager*)shareInstance
{
    static PDDBManager *shareInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[PDDBManager alloc] init];
    });
    
    return shareInstance;
}

- (YTKKeyValueStore*)originalStore
{
    return _store;
}

- (BOOL)start
{
    self.store = [[YTKKeyValueStore alloc] initDBWithName:@"patient.db"];
    if(_store == nil)
    {
        return NO;
    }
    
    [_store createTableWithName:kTableNamePatient];
    [_store createTableWithName:kTableNameDateRecord];
    [_store createTableWithName:kTableNamePatientList];
    [_store createTableWithName:kTableNameDateRecordList];
    
    return YES;
}

- (void)dealloc
{
    [_store close];
}

#pragma mark - DB setter Method

- (void)deletePid:(NSString*)pid
{
    [_store deleteObjectById:pid fromTable:kTableNamePatientList];
    [_store deleteObjectById:pid fromTable:kTableNamePatient];
    [_store deleteObjectById:pid fromTable:kTableNameDateRecordList];
    
    NSString *prefix = [NSString stringWithFormat:@"%@_",pid];
    [_store deleteObjectsByIdPrefix:prefix fromTable:kTableNameDateRecord];
    
    
}

- (void)putObject:(PDObject*)object key:(NSString*)key inTable:(NSString*)tableName
{
    [_store putObject:[object dictionary] withId:key intoTable:tableName];
    
}

- (void)putString:(NSString*)string key:(NSString*)key inTable:(NSString*)tableName
{
    [_store putString:string withId:key intoTable:tableName];
}

#pragma mark - db getter Method

- (NSString*)stringForKey:(NSString*)key inTable:(NSString*)tableName
{
    return [_store getStringById:key fromTable:tableName];
}

- (NSDictionary*)dictionaryWithKey:(NSString*)key inTable:(NSString*)tableName
{
    NSDictionary *dict = [_store getObjectById:key fromTable:tableName];
    
    return dict;
}

- (NSArray*)objectListInTable:(NSString*)tableName
{
    return [_store getAllItemsFromTable:tableName];
}


@end
