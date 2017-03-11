//
//  FLDatabaseManger.m
//  FMDBLearn
//
//  Created by Metallic  on 17/3/8.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import "FLDatabaseManager.h"
#import "FLStudent.h"
#import "FMDB.h"

@interface FLDatabaseManager ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation FLDatabaseManager

+ (instancetype)shareManager
{
    static FLDatabaseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FLDatabaseManager alloc] init];
        [manager setupDatabase];
    });
    return manager;
}

- (void)setupDatabase
{
    _db = [FMDatabase databaseWithPath:[self dbPath]];
    NSLog(@"%@", [self dbPath]);
    
    if (![_db open]) {
        NSLog(@"数据库打开失败, %@", NSStringFromSelector(_cmd));
        return;
    } else {
        NSString *studentSql = @"create table if not exists student (uid text primary key, name text, gender integer, age integer)";
        if ([_db executeUpdate:studentSql]) {
            NSLog(@"create student table success");
        }
        [_db close];
    }
}

- (NSString *)dbPath
{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.db"];
}

#pragma mark - Database operations

- (BOOL)insertStudent:(FLStudent *)student
{
    BOOL success;
    
    if (![_db open]) {
        NSLog(@"数据库打开失败, %@", NSStringFromSelector(_cmd));
        success = NO;
    } else {
        NSString *sql = @"INSERT INTO student (uid, name, gender, age) VALUES (?, ?, ?, ?)";
        success = [_db executeUpdate:sql, student.uid, student.name, @(student.gender), @(student.age)];
        [_db close];
    }
    
    return success;
}

- (BOOL)deleteStudent:(FLStudent *)student
{
    BOOL success;
    
    [_db open];
    NSString *sql = @"DELETE FROM student WHERE uid = ?";
    success = [_db executeUpdate:sql, student.uid];
    [_db close];
    
    return success;
}

- (BOOL)updateStudent:(FLStudent *)student
{
    BOOL success;
    
    [_db open];
    NSString *sql = @"UPDATE student SET name = ?, gender = ?, age = ? where uid = ?";
    success = [_db executeUpdate:sql, student.name, @(student.gender), @(student.age), student.uid];
    [_db close];
    
    return success;
}

- (FLStudent *)findStudentById:(NSInteger)uid
{
    FLStudent *student = [[FLStudent alloc] init];
    
    [_db open];
    NSString *sql = @"SELECT * FROM student WHERE uid = ?";
    FMResultSet *result = [_db executeQuery:sql, @(uid)];
    while ([result next]) {
        student.uid = [result stringForColumnIndex:0];
        student.name = [result stringForColumnIndex:1];
        student.gender = [result intForColumnIndex:2];
        student.age = [result intForColumnIndex:3];
    }
    [_db close];
    
    return student;
}

- (NSArray<FLStudent *> *)findAllStudent
{
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:0];
    
    [_db open];
    NSString *sql = @"select * from student";
    FMResultSet *result = [_db executeQuery:sql];
    while ([result next]) {
        FLStudent *student = [[FLStudent alloc] init];
        student.uid = [result stringForColumnIndex:0];
        student.name = [result stringForColumnIndex:1];
        student.gender = [result intForColumnIndex:2];
        student.age = [result intForColumnIndex:3];
        [mutableArray addObject:student];
    }
    [_db close];
    
    return [mutableArray copy];
}


@end
