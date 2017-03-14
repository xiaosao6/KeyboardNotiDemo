//
//  ViewController.m
//  KeyboardNotiDemo
//
//  Created by sischen on 17/3/13.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "ViewController.h"
#import "KeyBoardNotiUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < 7; i++) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake((320-100)*0.5, (i+1)*80, 100,30)];
        tf.backgroundColor = [UIColor grayColor];
        [self.view addSubview:tf];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [KeyBoardNotiUtil sharedUtil].targetView = self.view;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}

-(void)dealloc{
    NSLog(@"%@被销毁了", self);
}

@end
