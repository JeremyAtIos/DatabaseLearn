//
//  FLAddStudentViewController.m
//  FMDBLearn
//
//  Created by Metallic  on 17/3/11.
//  Copyright © 2017年 xiaowei. All rights reserved.
//

#import "FLAddStudentViewController.h"
#import "FLStudent.h"

@interface FLAddStudentViewController ()

@property (nonatomic, strong, readwrite) FLStudent *student;

@property (weak, nonatomic) IBOutlet UITextField *uidTextField;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegmentedControl;

@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end

@implementation FLAddStudentViewController

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Add Student"]) {
        if (_uidTextField.text.length) {
            self.student = [[FLStudent alloc] init];
            self.student.uid = _uidTextField.text;
            self.student.name = _nameTextField.text;
            self.student.gender = _genderSegmentedControl.selectedSegmentIndex;
            self.student.age = [_ageTextField.text integerValue];
        }
    }
}

@end
