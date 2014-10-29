//
//  PDDBManager.m
//  DoctorDoc
//
//  Created by ifwang on 14-9-27.
//  Copyright (c) 2014年 ifwang. All rights reserved.
//

#import "PDDBManager.h"
#import "FMDB.h"
#import "PDDBConstanst.h"

static NSString *kPatientTableName = @"Patient";
static NSString *kDailyRecordTableName = @"DailyRecord";
static NSString *kBSugarTableName = @"BSugar";
static NSString *kAntibioticsTableName = @"Antibiotics";
static NSString *kHealRecordTableName = @"HealRecord";

@interface PDDBManager()

@property (nonatomic ,strong) FMDatabase *fmdb;

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

- (BOOL)start
{
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* dbpath = [docsdir stringByAppendingPathComponent:@"user.sqlite"];
    
    self.fmdb = [FMDatabase databaseWithPath:dbpath];
    
    if (_fmdb == nil)
    {
        NSLog(@"数据库路径连接失败,[%@]",[_fmdb lastError]);
        return NO;

    }
    
    if([_fmdb open])
    {
        NSLog(@"数据库打开成功");
    }
    else
    {
        NSLog(@"数据库打开失败，[%@]",[_fmdb lastError]);
        return NO;
    }
    
    BOOL createdTag = [[NSUserDefaults standardUserDefaults] boolForKey:kDBCreatedTag];
    if (!createdTag)
    {
        [self createTables];
    }
    
    return YES;
}

- (NSError*)lastError
{
    return [_fmdb lastError];
}

- (NSUInteger)lastIncrementID
{
    
    
    NSInteger lastID = sqlite3_last_insert_rowid([_fmdb sqliteHandle]);
    
    return lastID;
}


- (BOOL)deletePid:(NSUInteger)pid
{
    
    NSArray *pidArray = @[@(pid)];
    
    
    
    
    if( [_fmdb executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE PID = ?",kPatientTableName] withArgumentsInArray:pidArray] &&
    [_fmdb executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE PID = ?",kDailyRecordTableName] withArgumentsInArray:pidArray] &&
    [_fmdb executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE PID = ?",kBSugarTableName] withArgumentsInArray:pidArray] &&
    [_fmdb executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE PID = ?",kAntibioticsTableName] withArgumentsInArray:pidArray] &&
    [_fmdb executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE PID = ?",kHealRecordTableName] withArgumentsInArray:pidArray])
    {
        NSLog(@"删除 PID:%lu 成功",pid);
        
        return YES;
    }
    else
    {
        NSLog(@"删除 PID:%lu 失败[%@]",pid,[_fmdb lastError]);
        
        return NO;
    }
}


#pragma mark - Patient

- (BOOL)insertPatientVO:(PatientRecord*)record
{
    NSString *stament = [NSString stringWithFormat:@"INSERT INTO %@ (PID,diagnostic,weight,headRound,bodyLength,phototherapy,hypothermia,newbornCheck) VALUES(?,?,?,?,?,?,?,?);",kPatientTableName];
                         
    return [_fmdb executeUpdate:stament withArgumentsInArray:@[@(record.pid),record.diagnostic,record.weight,record.headRound,record.bodyLength,record.phototherapy,record.hypothermia,record.newbornCheck]];
    
}

- (BOOL)updatePatientVO:(PatientRecord*)record
{
    NSString *stament = [NSString stringWithFormat:@"UPDATE %@ SET diagnostic = ?,weight = ?,headRound = ?,bodyLength = ?,phototherapy = ?,hypothermia = ?,newbornCheck = ? WHERE PID = %@;",kPatientTableName,@(record.pid).stringValue];

    return [_fmdb executeUpdate:stament withArgumentsInArray:@[record.diagnostic,record.weight,record.headRound,record.bodyLength,record.phototherapy,record.hypothermia,record.newbornCheck]];
}

- (PatientRecord*)queryPatientVO:(NSUInteger)pid
{
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE PID = ?",kPatientTableName];
    
    FMResultSet *resultSet = [_fmdb executeQuery:query withArgumentsInArray:@[@(pid)]];
    
    return [[PatientRecord alloc] initWithResultSet:resultSet];
}


#pragma mark - DailyRecord

- (BOOL)insertDailyRecord:(DateRecordVO*)record pid:(NSUInteger)pid
{
    NSString *stament = [NSString stringWithFormat:@"INSERT INTO %@  (PID,recordDate,radio,warnBox,hotBed,heartRate,bodyTemperature,breath,lowFlowOxy,bloodOxy,urine,feed_selfSuck,feed_noseFeed,feed_famulaMilk,feed_waterMilk,feed_noSugarMilk,feed_earlyBabyMilk,feed_vomit,feed_totleValue,feed_perVlaue,stool_times,stool_isYellow,stool_isGreen,stool_isDarkGreen,stool_other,inspect_MR,inspect_ultrasound,inspect_chest,tcb_value1,tcb_value2,tcb_value3) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);",kDailyRecordTableName];
    
    
    return [_fmdb executeUpdate:stament withArgumentsInArray:@[@(pid),record.recordDate,@(record.radio),@(record.warnBox),@(record.hotBed),record.heartRate,record.bodyTemperature,record.breath,@(record.lowFlowOxy),record.bloodOxy,record.urine,@(record.feed.selfSuck),@(record.feed.noseFeed),@(record.feed.famulaMilk),@(record.feed.waterMilk),@(record.feed.noSugarMilk),@(record.feed.earlyBabyMilk),@(record.feed.vomit),record.feed.totleValue,record.feed.perVlaue,@(record.stool.times),@(record.stool.isYellow),@(record.stool.isGreen),@(record.stool.isDarkGreen),record.stool.other,@(record.inspect.MR),@(record.inspect.ultrasound),@(record.inspect.chest),record.tcb.value1,record.tcb.value2,record.tcb.value3]];
}

- (BOOL)updateDailyRecord:(DateRecordVO*)record drid:(NSUInteger)drid
{
    NSString *stament = [NSString stringWithFormat:@"UPDATE %@ SET recordDate = ?,radio = ?,warnBox = ?,hotBed = ?,heartRate = ?,bodyTemperature = ?,breath = ?,lowFlowOxy = ?,bloodOxy = ?,urine = ?,feed_selfSuck = ?,feed_noseFeed = ?,feed_famulaMilk = ?,feed_waterMilk = ?,feed_noSugarMilk = ?,feed_earlyBabyMilk = ?,feed_vomit = ?,feed_totleValue = ?,feed_perVlaue = ?,stool_times = ?,stool_isYellow = ?,stool_isGreen = ?,stool_isDarkGreen = ?,stool_other = ?,inspect_MR = ?,inspect_ultrasound = ?,inspect_chest = ?,tcb_value1 = ?,tcb_value2 = ?,tcb_value3 = ? WHERE drid = ?;",kDailyRecordTableName];

    
    
    return [_fmdb executeUpdate:stament withArgumentsInArray:@[record.recordDate,@(record.radio),@(record.warnBox),@(record.hotBed),record.heartRate,record.bodyTemperature,record.breath,@(record.lowFlowOxy),record.bloodOxy,record.urine,@(record.feed.selfSuck),@(record.feed.noseFeed),@(record.feed.famulaMilk),@(record.feed.waterMilk),@(record.feed.noSugarMilk),@(record.feed.earlyBabyMilk),@(record.feed.vomit),record.feed.totleValue,record.feed.perVlaue,@(record.stool.times),@(record.stool.isYellow),@(record.stool.isGreen),@(record.stool.isDarkGreen),record.stool.other,@(record.inspect.MR),@(record.inspect.ultrasound),@(record.inspect.chest),record.tcb.value1,record.tcb.value2,record.tcb.value3,@(record.drid)]];
}

- (NSArray*)queryDateRecordListVO:(NSUInteger)pid
{
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE PID = ?",kDailyRecordTableName];
    
    FMResultSet *resultSet = [_fmdb executeQuery:query withArgumentsInArray:@[@(pid)]];
    
    
    NSMutableArray *result = [NSMutableArray array];
    while ([resultSet next])
    {
        [result addObject:[[DateRecordVO alloc] initWithResultSet:resultSet]];
    }
    
    
    return result;
}


#pragma mark - create tables
- (void)createTables
{
    if ([self createPatientTable])
    {
        NSLog(@"创建Patient表成功");
    }
    else
    {
        NSLog(@"[%@]",[_fmdb lastError]);
    }
    
    if ([self createDailyRecordTable])
    {
        NSLog(@"创建DateRecord表成功");
    }
    else
    {
        NSLog(@"[%@]",[_fmdb lastError]);
    }
    
    if ([self createBloodSugarTable])
    {
        NSLog(@"创建BloodSugar表成功");
    }
    else
    {
        NSLog(@"[%@]",[_fmdb lastError]);
    }
    
    if ([self createAntibioticsTable])
    {
        NSLog(@"创建Antibiotics表成功");
    }
    else
    {
        NSLog(@"[%@]",[_fmdb lastError]);
    }
    
    if ([self createHealRecordTable])
    {
        NSLog(@"创建HealRecord表成功");
    }
    else
    {
        NSLog(@"[%@]",[_fmdb lastError]);
    }
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kDBCreatedTag];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)createPatientTable
{
    NSMutableString *sql = [NSMutableString stringWithFormat:@"CREATE TABLE %@",kPatientTableName];
    
    
    
    [sql appendString: @"(\
                    PID INT NOT NULL UNIQUE,\
                    diagnostic NTEXT,\
                    weight VARCHAR(255),\
                    headRound VARCHAR(255),\
                    bodyLength VARCHAR(255),\
                    phototherapy VARCHAR(255),\
                    hypothermia VARCHAR(255),\
                    newbornCheck VARCHAR(255)\
                    );"];
    
    return [_fmdb executeStatements:sql];
}

- (BOOL)createDailyRecordTable
{
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"CREATE TABLE %@",kDailyRecordTableName];

    [sql appendString: @"(\
                      PID INT,\
                      drid integer PRIMARY KEY autoincrement,\
                      recordDate TIMESTAMP,\
                      radio INT,\
                      warnBox INT,\
                      hotBed INT,\
                      heartRate VARCHAR(255),\
                      bodyTemperature VARCHAR(255),\
                      breath VARCHAR(255),\
                      lowFlowOxy INT,\
                      bloodOxy VARCHAR(255),\
                      urine VARCHAR(255),\
                      feed_selfSuck INT,\
                      feed_noseFeed INT,\
                      feed_famulaMilk INT,\
                      feed_waterMilk INT,\
                      feed_noSugarMilk INT,\
                      feed_earlyBabyMilk INT,\
                      feed_vomit INT,\
                      feed_totleValue VARCHAR(255),\
                      feed_perVlaue VARCHAR(255),\
                      stool_times INT,\
                      stool_isYellow INT,\
                      stool_isGreen INT,\
                      stool_isDarkGreen INT,\
                      stool_other NTEXT,\
                      inspect_MR INT,\
                      inspect_ultrasound INT,\
                      inspect_chest INT,\
                      tcb_value1 VARCHAR(255),\
                      tcb_value2 VARCHAR(255),\
                      tcb_value3 VARCHAR(255));"];
    
    return [_fmdb executeStatements:sql];
}

- (BOOL)createBloodSugarTable
{
    NSMutableString *sql = [NSMutableString stringWithFormat:@"CREATE TABLE %@",kBSugarTableName];
    
    [sql appendString:@"(\
                            PID INT NOT NULL UNIQUE,\
                            bsid integer PRIMARY KEY autoincrement,\
                            hour INT,\
                            min INT,\
                            value VARCHAR(255)\
     );"];
    
    return [_fmdb executeStatements:sql];
}

- (BOOL)createAntibioticsTable
{
    NSMutableString *sql = [NSMutableString stringWithFormat:@"CREATE TABLE %@",kAntibioticsTableName];
    
    [sql appendString:@"(\
    PID INT NOT NULL UNIQUE,\
     aid integer PRIMARY KEY autoincrement,\
     useDate VARCHAR(255),\
     name VARCHAR(255)\
     );"];
    
    return [_fmdb executeStatements:sql];
}

- (BOOL)createHealRecordTable
{
    NSMutableString *sql = [NSMutableString stringWithFormat:@"CREATE TABLE %@",kHealRecordTableName];
    
    [sql appendString:@"(\
     PID INT NOT NULL UNIQUE,\
     hid integer PRIMARY KEY autoincrement,\
     recordDate VARCHAR(255),\
     recordText NTEXT\
     );"];
    
    return [_fmdb executeStatements:sql];
}

@end
