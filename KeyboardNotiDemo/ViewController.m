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
    
    for (int i = 0; i < 8; i++) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-130)*0.5, (i+1)*70, 130, 30)];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.placeholder = @"placeholder";
        [self.view addSubview:tf];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStylePlain target:self action:@selector(rightBbiClick)];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [KeyBoardNotiUtil sharedUtil].targetView = self.view;
}

-(void)rightBbiClick{
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)dealloc{
    NSLog(@"%@被销毁了", self);
}

@end
