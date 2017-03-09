//
//  ViewController.m
//  FMDBLearn
//
//  Created by Metallic  on 17/3/8.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"
#import "FLStudent.h"
#import "FLDatabaseManager.h"

@interface ViewController ()

@property (nonatomic, strong) FLDatabaseManager *dbManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *students = [self.dbManager findAllStudent];
    for (FLStudent *student in students) {
        NSLog(@"%ld, %@, %lu, %lu", (long)student.uid, student.name, (unsigned long)student.gender, (unsigned long)student.age);
    }
    
    FLStudent *student = [self.dbManager findStudentById:3];
    student.name = @"Jack";
    [self.dbManager updateStudent:student];
}

- (FLDatabaseManager *)dbManager
{
    if (!_dbManager) {
        _dbManager = [FLDatabaseManager shareManager];
    }
    return _dbManager;
}

@end
