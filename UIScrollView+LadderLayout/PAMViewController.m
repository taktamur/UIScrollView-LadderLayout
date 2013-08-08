//
//  PAMViewController.m
//  UIScrollView+LadderLayout
//
//  Created by Takafumi Tamura on 2013/08/08.
//  Copyright (c) 2013年 田村 孝文. All rights reserved.
//

#import "PAMViewController.h"
#import "UIScrollView+LadderLayout.h"
@interface PAMViewController ()

@end

@implementation PAMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSArray *colors = @[[UIColor redColor],
                        [UIColor orangeColor],
                        [UIColor blueColor],
                        [UIColor greenColor],
                        [UIColor grayColor],
                        [UIColor whiteColor],
                        [UIColor yellowColor],
                        [UIColor purpleColor] ];
    srand((unsigned int)time(NULL)); // rand()の初期化
    
    
    // ランダムサイズのUIViewを100個作って、
    // 配列に入れておく。
    NSMutableArray *views = [[NSMutableArray alloc]init];
    for(int i=0; i<100; i++ ){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [colors objectAtIndex:i%colors.count];
        v.bounds = CGRectMake(0,0, 1+rand()%100,1+rand()%100);
        [views addObject:v];
    }
    
    // 配列をScrollViewに叩き込んで整列させる。
    UIScrollView *scrollView = (UIScrollView *)self.view;
    [scrollView layoutAndAddSubview:views];
    
    // Storyboardを使っている場合、AutoLayoutにチェックを入れると
    // スクロールしないので注意。
    // AutoLayout使うならこんな実装要らないだろうけど。
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
