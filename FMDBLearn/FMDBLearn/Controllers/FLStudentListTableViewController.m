//
//  FLStudentListTableViewController.m
//  FMDBLearn
//
//  Created by Metallic  on 17/3/11.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import "FLStudentListTableViewController.h"
#import "FLDatabaseManager.h"
#import "FLStudentTableViewCell.h"
#import "FLStudent.h"
#import "FLAddStudentViewController.h"

@interface FLStudentListTableViewController ()

@property (nonatomic, strong) FLDatabaseManager *dbManager;//数据库管理对象

@property (nonatomic, strong) NSArray<FLStudent *> *students;//数据库中的学生数据

@end

@implementation FLStudentListTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.students = nil;//更新学生数据
}

#pragma mark - Properties

- (FLDatabaseManager *)dbManager
{
    if (!_dbManager) {
        _dbManager = [FLDatabaseManager shareManager];
    }
    return _dbManager;
}

- (NSArray<FLStudent *> *)students
{
    if (!_students) {
        _students = [self.dbManager findAllStudent];
    }
    return _students;
}

#pragma mark - Event

- (IBAction)doneButtonClicked:(UIStoryboardSegue *)segue
{
    if ([segue.identifier isEqualToString:@"Add Student"]) {
        if ([segue.sourceViewController isKindOfClass:[FLAddStudentViewController class]]) {
            FLAddStudentViewController *addStudentVC = (FLAddStudentViewController *)segue.sourceViewController;
            
            //没有学生信息，直接返回
            if (!addStudentVC.student) return;
            
            if (addStudentVC.editing) {
                
                //更新学生信息
                [self.dbManager updateStudent:addStudentVC.student];
            } else {
                
                //向数据库中插入学生信息
                [self.dbManager insertStudent:addStudentVC.student];
            }
            
            //刷新数据源和列表
            self.students = nil;
            [self.tableView reloadData];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.students.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Student Cell";
    FLStudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    FLStudent *student = self.students[indexPath.row];
    [self configureCell:cell withStudent:student];
    
    return cell;
}

- (void)configureCell:(FLStudentTableViewCell *)cell
          withStudent:(FLStudent *)student
{
    cell.uidLabel.text = student.uid;
    cell.nameLabel.text = student.name;
    cell.genderLabel.text = student.genderString;
    cell.ageLabel.text = [NSString stringWithFormat:@"%lu岁", (unsigned long)student.age];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //取出要删除的模型对象
        FLStudent *student = self.students[indexPath.row];
        
        //从数据库中删除学生
        [self.dbManager deleteStudent:student];
        
        //从数组中删除学生
        NSMutableArray *mutableArray = [self.students mutableCopy];
        [mutableArray removeObject:student];
        self.students = [mutableArray copy];
        
        //删除行
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Edit Student Info"]) {
        if ([segue.destinationViewController isKindOfClass:[FLAddStudentViewController class]]) {
            FLAddStudentViewController *addStudentVC = (FLAddStudentViewController *)segue.destinationViewController;
            if ([sender isKindOfClass:[FLStudentTableViewCell class]]) {
                FLStudentTableViewCell *cell = (FLStudentTableViewCell *)sender;
                NSInteger index = [self.tableView indexPathForCell:cell].row;
                addStudentVC.student = self.students[index];
            }
        }
    }
}

@end
