//
//  ViewController.m
//  Evaluate
//
//  Created by apple001 on 17/2/9.
//  Copyright © 2017年 Dewey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CAEmitterLayer *emitterLayer;
@property (nonatomic, strong) CAEmitterLayer *miniLayer;
@property (nonatomic, strong) CAEmitterLayer *lastLayer;

@property (nonatomic, strong) UILabel *evaluateLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    for (int i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(50 + i*5 + i*30, 100, 30, 30);
        [button setImage:[UIImage imageNamed:@"星星.png"] forState:UIControlStateNormal];
        button.tag = 100+i;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    [self layoutLizi];
    
    self.evaluateLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 100, 25)];
    self.evaluateLabel.textColor = [UIColor orangeColor];
    [self.view addSubview:self.evaluateLabel];
}

#pragma mark-按钮点击事件
-(void)clickAction:(UIButton *)button {
    
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [self.view viewWithTag:100+i];
        [btn setImage:[UIImage imageNamed:@"星星.png"] forState:UIControlStateNormal];
    }
    if (button.tag == 100) {
        
        [self animationOfClickBtn:1];
        self.evaluateLabel.text = @"Bad";
        
    }else if (button.tag == 101) {
  
        [self animationOfClickBtn:2];
        self.evaluateLabel.text = @"Bad";
        
    }else if (button.tag == 102) {
        
        [self animationOfClickBtn:3];
        self.evaluateLabel.text = @"Ok";
        
    }else if(button.tag == 103) {
        
        [self animationOfClickBtn:4];
        self.evaluateLabel.text = @"Good";
        
    }else {
        
        [self animationOfClickBtn:5];
        self.evaluateLabel.text = @"Great";
        
        CABasicAnimation *burst = [CABasicAnimation animationWithKeyPath:@"emitterCells.cell.birthRate"];
        burst.fromValue = [NSNumber numberWithFloat:30];
        burst.toValue = [NSNumber numberWithFloat:0];
        burst.duration = 0.1;
        burst.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [self.emitterLayer addAnimation:burst forKey:@"burst"];
        
        CABasicAnimation *burst1 = [CABasicAnimation animationWithKeyPath:@"emitterCells.mini.birthRate"];
        burst1.fromValue = [NSNumber numberWithFloat:30];
        burst1.toValue = [NSNumber numberWithFloat:0];
        burst1.duration = 0.1;
        burst1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [self.miniLayer addAnimation:burst1 forKey:@"burst1"];
        
        CABasicAnimation *burst2 = [CABasicAnimation animationWithKeyPath:@"emitterCells.last.birthRate"];
        burst2.fromValue = [NSNumber numberWithFloat:30];
        burst2.toValue = [NSNumber numberWithFloat:0];
        burst2.duration = 0.1;
        burst2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [self.lastLayer addAnimation:burst2 forKey:@"burst2"];
        
    }
}
//note：

-(void)animationOfClickBtn:(int)number {
    for (int i = 0; i < number; i++) {
        UIButton *btn = [self.view viewWithTag:100+i];
        [btn setImage:[UIImage imageNamed:@"星星-2.png"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.1 delay:i*0.1 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            btn.transform = CGAffineTransformScale(btn.transform, 0.01, 0.01);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                btn.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    btn.transform = CGAffineTransformScale(btn.transform, 1.2, 1.2);
                } completion:^(BOOL finished) {
                    btn.transform = CGAffineTransformIdentity;
                }];
            }];
        }];
    }
    
}

#pragma mark-粒子动画
-(void)layoutLizi {
    
    self.emitterLayer = [CAEmitterLayer layer];
    self.emitterLayer.emitterPosition = CGPointMake(190, 80);
    self.emitterLayer.emitterSize = CGSizeMake(30, 0);
    self.emitterLayer.emitterShape = kCAEmitterLayerCircle;
    self.emitterLayer.emitterMode = kCAEmitterLayerOutline;
    self.emitterLayer.renderMode = kCAEmitterLayerBackToFront;
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    [cell setName:@"cell"];
    cell.birthRate = 0;
    cell.lifetime = 1;
    cell.scale = 0.05;
    cell.velocity = 6;
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"圆点"].CGImage);
    
    self.emitterLayer.emitterCells = [NSArray arrayWithObject:cell];
    [self.view.layer addSublayer:self.emitterLayer];
    
    
    self.miniLayer = [CAEmitterLayer layer];
    self.miniLayer.emitterPosition = CGPointMake(80, 90);
    self.miniLayer.emitterSize = CGSizeMake(10, 0);
    self.miniLayer.emitterShape = kCAEmitterLayerCircle;
    self.miniLayer.emitterMode = kCAEmitterLayerOutline;
    self.miniLayer.renderMode = kCAEmitterLayerBackToFront;
    
    CAEmitterCell *miniCell = [CAEmitterCell emitterCell];
    [miniCell setName:@"mini"];
    miniCell.birthRate = 0;
    miniCell.lifetime = 1;
    miniCell.scale = 0.05;
    miniCell.velocity = 5;
    miniCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"圆点"].CGImage);
    
    self.miniLayer.emitterCells = [NSArray arrayWithObject:miniCell];
    [self.view.layer addSublayer:self.miniLayer];
    
    
    self.lastLayer = [CAEmitterLayer layer];
    self.lastLayer.emitterPosition = CGPointMake(140, 140);
    self.lastLayer.emitterSize = CGSizeMake(10, 0);
    self.lastLayer.emitterShape = kCAEmitterLayerCircle;
    self.lastLayer.emitterMode = kCAEmitterLayerOutline;
    self.lastLayer.renderMode = kCAEmitterLayerBackToFront;
    
    CAEmitterCell *lastCell = [CAEmitterCell emitterCell];
    [lastCell setName:@"last"];
    lastCell.birthRate = 0;
    lastCell.lifetime = 1;
    lastCell.scale = 0.05;
    lastCell.velocity = 5;
    lastCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"圆点"].CGImage);
    
    self.lastLayer.emitterCells = [NSArray arrayWithObject:lastCell];
    [self.view.layer addSublayer:self.lastLayer];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
