//
//  ViewController.m
//  LYSheetControllerDemo
//
//  Created by Ju Liaoyuan on 17/4/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "ViewController.h"
#import "LYSheetMenu.h"
#import "LYSheetCustomModel.h"
#import "LYSheetCustomTextCell.h"
#import "LYSheetCustomImageCell.h"

#define TEXT_ONLY 1

@interface ViewController ()<LYSheetControllerDelegate>

@property (nonatomic, strong) LYSheetController *sheet;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sheet = [[LYSheetController alloc] init];
    self.sheet.delegate = self;
    self.sheet.dismissHandler = ^(BOOL success){
        NSLog(@"dismiss");
    };
    self.sheet.dismissWhenSelected = YES;
    self.sheet.rowHeight = 50;
    
#if TEXT_ONLY
    // text only
    NSArray *models = @[[[LYSheetCustomModel alloc] initWithSheetTitle:@"sheet 1" selector:@selector(sheetAction1:) style:LYSheetStyleDefault],
                        [[LYSheetCustomModel alloc] initWithSheetTitle:@"sheet 2" selector:@selector(sheetAction1:) style:LYSheetStyleDefault],
                        [[LYSheetCustomModel alloc] initWithSheetTitle:@"sheet 3" selector:@selector(sheetAction1:) style:LYSheetStyleCancel]];
    self.sheet.dataSource = models;
    for (LYSheetCustomModel *model in self.sheet.dataSource) {
        NSLog(@"%@,%d",model.sheetTitle,(int)model.sheetStyle);
    }
    [self.sheet registSheetControllerCell:[LYSheetCustomTextCell class] forStyle:LYSheetStyleDefault];
    [self.sheet registSheetControllerCell:[LYSheetCustomTextCell class]  forStyle:LYSheetStyleCancel];
#else 
    // text - image
    
    LYSheetCustomModel *model1 = [LYSheetCustomModel new];
    model1.sheetTitle = @"sheet 1";
    model1.sheetImage = [UIImage imageNamed:@"15648957.jpeg"];
    model1.sheetStyle = LYSheetStyleCancel;
    
    LYSheetCustomModel *model2 = [LYSheetCustomModel new];
    model2.sheetTitle = @"sheet 2";
    model2.sheetImage = [UIImage imageNamed:@"15648957.jpeg"];
    model2.sheetStyle = LYSheetStyleDefault;
    
    
    self.sheet.dataSource = @[model1,model2];
    [self.sheet registSheetControllerCell:[LYSheetCustomImageCell class] forStyle:LYSheetStyleDefault];
    [self.sheet registSheetControllerCell:[LYSheetCustomImageCell class] forStyle:LYSheetStyleCancel];
#endif
}

- (CGFloat)headerHeightForSheetContoller:(LYSheetController *)sheetController {
    return 40;
}

- (UIView *)headerViewForSheetContoller:(LYSheetController *)sheetController {
    UILabel *label = [UILabel new];
    label.text = @"this is a header";
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    label.font = [UIFont systemFontOfSize:14.f];
    return label;
}

- (void)sheetController:(LYSheetController *)sheetController didSelectRowAtIndexPath:(NSInteger)indexPath {

    [self showAlert:[NSString stringWithFormat:@"indexPath row is %d",(int)indexPath]];
}

- (void)sheetAction1:(NSString *)title {
    [self showAlert:title];
}

- (void)sheetAction2:(NSString *)title {
    [self showAlert:title];
}

- (void)sheetAction3 {
    [self.sheet dismissSheetControllerWithAnimated:YES completionHandler:nil];
}

- (void)showAlert:(NSString *)alertTitle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:alertTitle preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (IBAction)showSheet:(id)sender {
    [self.sheet showSheetControllerWithAnimated:YES completionHandler:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
