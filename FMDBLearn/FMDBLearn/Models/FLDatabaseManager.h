//
//  FLDatabaseManger.h
//  FMDBLearn
//
//  Created by Metallic  on 17/3/8.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLStudent, FMDatabase;

@interface FLDatabaseManager : NSObject

+ (instancetype)shareManager;

//student operations

- (BOOL)insertStudent:(FLStudent *)student;

- (BOOL)deleteStudent:(FLStudent *)student;

- (BOOL)updateStudent:(FLStudent *)student;

- (FLStudent *)findStudentById:(NSInteger)uid;

- (NSArray<FLStudent *> *)findAllStudent;

@end
