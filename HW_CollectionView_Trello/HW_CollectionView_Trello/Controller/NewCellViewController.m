//
//  NewCardViewController.m
//  HW_CollectionView_Trello
//
//  Created by Давид on 15/11/2019.
//  Copyright © 2019 David. All rights reserved.
//

#import "NewCellViewController.h"
#import "HW_CollectionView_Trello-Swift.h"

@interface NewCellViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NewCellViewController *presentView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIButton *button2;

@end

@implementation NewCellViewController

- (NewCellViewController *)viewForTask
{
    CGRect myRect = [UIScreen mainScreen].bounds;
    _presentView = [[NewCellViewController alloc]
                                   initWithFrame:CGRectMake(0, 0,
                                                            CGRectGetWidth(myRect) - 60 ,
                                                            CGRectGetHeight(myRect) - 200)];
    _presentView.backgroundColor = UIColor.redColor;
    [_presentView.layer setCornerRadius:10];
    
    _textView = [UITextView new];
    _textView.backgroundColor = UIColor.whiteColor;
    [_textView.layer setCornerRadius:10];
    _textView.frame = CGRectMake(40, 20,
                                 CGRectGetWidth(myRect) - 140 ,
                                 CGRectGetHeight(myRect) - 500);
    
    _button = [UIButton new];
    [_button setTitle:@"Save it" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button layer].cornerRadius = 10;
    _button.backgroundColor = [UIColor whiteColor];
    
    self.button.frame = CGRectMake(40, 480,
                                   CGRectGetWidth(myRect) - 320 ,
                                   CGRectGetHeight(myRect) - 820);
    [self.button addTarget:self
                    action:@selector(tapButton)
          forControlEvents:UIControlEventTouchDown];
    
    _button2 = [UIButton new];
    [_button2 setTitle:@"Cancel" forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button2 layer].cornerRadius = 10;
    _button2.backgroundColor = [UIColor whiteColor];
    
    self.button2.frame = CGRectMake(220, 480,
                                   CGRectGetWidth(myRect) - 320 ,
                                   CGRectGetHeight(myRect) - 820);
    [self.button2 addTarget:self
                    action:@selector(tapButton2)
          forControlEvents:UIControlEventTouchDown];
    
    [self.presentView addSubview:_button];
    [self.presentView addSubview:_button2];
    [self.presentView addSubview:_textView];
    return _presentView;
}

#pragma mark

- (void) didMoveToSuperview
{
    self.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height + CGRectGetHeight(self.frame)/2);
    [UIView animateWithDuration:0.5 animations:^{
        self.center = CGPointMake(self.center.x, [UIScreen mainScreen].bounds.size.height/2);
    }];
}

- (void)tapButton
{
    
}

- (void)tapButton2
{
//    CollectionViewController *collection = [CollectionViewController new];
    NSArray *viewsToRemove = [UICollectionView.alloc subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
}

@end
