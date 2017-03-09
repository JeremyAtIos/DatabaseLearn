//
//  FLStudent.m
//  FMDBLearn
//
//  Created by Metallic  on 17/3/8.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import "FLStudent.h"

@implementation FLStudent

+ (instancetype)studentWithUid:(NSInteger)uid
                          name:(NSString *)name
                        gender:(FLStudentGenderType)gender
                           age:(NSUInteger)age
{
    return [[self alloc] initWithUid:uid
                                name:name
                              gender:gender
                                 age:age];
}

- (instancetype)initWithUid:(NSInteger)uid
                       name:(NSString *)name
                     gender:(FLStudentGenderType)gender
                        age:(NSUInteger)age
{
    self = [super init];
    if (self) {
        _uid = uid;
        _name = name;
        _gender = gender;
        _age = age;
    }
    return self;
}

@end
