//
//  FLStudent.h
//  FMDBLearn
//
//  Created by Metallic  on 17/3/8.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FLStudentGenderType) {
    FLStudentGenderTypeUnkonwn = 0,
    FLStudentGenderTypeMale = 1,
    FLStudentGenderTypeFemale = 2
};

@interface FLStudent : NSObject

@property (nonatomic, assign) NSInteger uid;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) FLStudentGenderType gender;

@property (nonatomic, assign) NSUInteger age;

+ (instancetype)studentWithUid:(NSInteger)uid
                          name:(NSString *)name
                        gender:(FLStudentGenderType)gender
                           age:(NSUInteger)age;

- (instancetype)initWithUid:(NSInteger)uid
                       name:(NSString *)name
                     gender:(FLStudentGenderType)gender
                        age:(NSUInteger)age;

@end
