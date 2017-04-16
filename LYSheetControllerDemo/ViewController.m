//
//  ViewController.m
//  LYSheetControllerDemo
//
//  Created by Ju Liaoyuan on 17/4/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "ViewController.h"
#import "LYSheetController.h"
#import "LYSheetCustomDefaultCell.h"
#import "LYSheetCustomCancelCell.h"
#import "LYSheetCustomModel.h"

#define SWITCH 1

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
#if SWITCH
    // 普通的用法
    NSArray *models = @[[LYSheetModel initWithSheetTitle:@"sheet 1" selector:@selector(sheetAction1:)],
                        [LYSheetModel initWithSheetTitle:@"sheet 2" selector:@selector(sheetAction2:)],
                        [LYSheetModel initWithSheetTitle:@"sheet 3" selector:@selector(sheetAction3)]];
    self.sheet.dataSource = models;
#else 
    // 自定义 cell、 model
    LYSheetCustomModel *model1 = [LYSheetCustomModel new];
    model1.sheetTitle = @"sheet 1";
    model1.image = [UIImage imageNamed:@"blackmarble_2016_americas_composite"];
    model1.style = kLYSheetStyleDefault;
    
    LYSheetCustomModel *model2 = [LYSheetCustomModel new];
    model2.sheetTitle = @"sheet 2";
    model2.image = [UIImage imageNamed:@"blackmarble_2016_americas_composite"];
    model2.style = kLYSheetStyleCancel;
    
    self.sheet.dataSource = @[model1,model2];
    [self.sheet registSheetControllerCell:[LYSheetCustomDefaultCell new] forStyle:kLYSheetStyleDefault];
    [self.sheet registSheetControllerCell:[LYSheetCustomCancelCell new] forStyle:kLYSheetStyleCancel];
#endif
}

- (void)sheetController:(LYSheetController *)sheetController didSelectRowAtIndexPath:(NSInteger)indexPath {
#if SWITCH
    LYSheetModel *model = sheetController.dataSource[indexPath];
    [self performSelector:model.sheetAction withObject:model.sheetTitle afterDelay:0.f];
#else
    [self showAlert:[NSString stringWithFormat:@"%d",(int)indexPath]];
#endif
    
}

- (void)sheetAction1:(NSString *)title {
    [self showAlert:title];
}

- (void)sheetAction2:(NSString *)title {
    [self showAlert:title];
}

- (void)sheetAction3 {
    NSArray *models = @[[LYSheetModel initWithSheetTitle:@"sheet 1 new" selector:@selector(sheetAction1:)],
                        [LYSheetModel initWithSheetTitle:@"sheet 2 new " selector:@selector(sheetAction2:)]];
    self.sheet.dataSource = models;
    [self.sheet reloadSheet];
}

- (void)showAlert:(NSString *)alertTitle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:alertTitle preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
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
