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

- (IBAction)addBarButtonClicked:(id)sender
{
    
}

- (IBAction)editBarButtonClicked:(id)sender
{
    
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
