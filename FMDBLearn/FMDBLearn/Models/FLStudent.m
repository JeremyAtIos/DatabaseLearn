//
//  FLStudent.m
//  FMDBLearn
//
//  Created by Metallic  on 17/3/8.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import "FLStudent.h"

@interface FLStudent ()

@property (nonatomic, copy, readwrite) NSString *genderString;

@end

@implementation FLStudent

+ (instancetype)studentWithUid:(NSString *)uid
                          name:(NSString *)name
                        gender:(FLStudentGenderType)gender
                           age:(NSUInteger)age
{
    return [[self alloc] initWithUid:uid
                                name:name
                              gender:gender
                                 age:age];
}

- (instancetype)initWithUid:(NSString *)uid
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
        [self genderStringWithType:gender];
    }
    return self;
}

- (void)setGender:(FLStudentGenderType)gender
{
    _gender = gender;
    
    _genderString = [self genderStringWithType:gender];
}

- (NSString *)genderStringWithType:(FLStudentGenderType)type
{
    switch (type) {
        case FLStudentGenderTypeUnkonwn:
            return @"未知";
            break;
        case FLStudentGenderTypeMale:
            return @"男";
            break;
        case FLStudentGenderTypeFemale:
            return @"女";
            break;
    }
}

@end
