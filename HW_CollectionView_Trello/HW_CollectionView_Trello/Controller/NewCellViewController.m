//
//  NewCellViewController.m
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
@property (nonatomic, strong) NSString *text;

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
    [_presentView becomeFirstResponder];
    [_presentView.layer setCornerRadius:10];
    
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = UIColor.whiteColor;
    [self.textView.layer setCornerRadius:10];
    _text = _textView.text;
    self.textView.translatesAutoresizingMaskIntoConstraints = false;
    
    _button = [UIButton new];
    [_button setTitle:@"Save it" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button layer].cornerRadius = 10;
    _button.backgroundColor = [UIColor whiteColor];
    _button.translatesAutoresizingMaskIntoConstraints = false;
    [self.button addTarget:self
                    action:@selector(tapButton)
          forControlEvents:UIControlEventTouchDown];
    
    _button2 = [UIButton new];
    [_button2 setTitle:@"Cancel" forState:UIControlStateNormal];
    [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button2 layer].cornerRadius = 10;
    _button2.backgroundColor = [UIColor whiteColor];
    _button2.translatesAutoresizingMaskIntoConstraints = false;
    [self.button2 addTarget:self
                    action:@selector(tapButton2)
          forControlEvents:UIControlEventTouchDown];
    
    [self.presentView addSubview:self.textView];
    [self.presentView addSubview:_button2];
    [self.presentView addSubview:_button];
    
    [_textView.topAnchor constraintEqualToAnchor:_presentView.topAnchor constant: 10].active = true;
    [_textView.leadingAnchor constraintEqualToAnchor:_presentView.leadingAnchor constant:10].active = true;
    [_textView.trailingAnchor constraintEqualToAnchor:_presentView.trailingAnchor constant:-10].active = true;
    [_textView.bottomAnchor constraintEqualToAnchor:_presentView.bottomAnchor constant: -_presentView.frame.size.height / 2 + 200].active = true;
    
    
    
    [_button2.topAnchor constraintEqualToAnchor:_textView.bottomAnchor constant: 30].active = true;
    [_button2.trailingAnchor constraintEqualToAnchor:_presentView.trailingAnchor constant: -10].active = true;
    [_button2.widthAnchor constraintEqualToConstant:150].active = true;
    [_button2.heightAnchor constraintEqualToConstant:80].active = true;
    
    
    
    [_button.topAnchor constraintEqualToAnchor:_textView.bottomAnchor constant: 30].active = true;
    [_button.leadingAnchor constraintEqualToAnchor:_presentView.leadingAnchor constant: 10].active = true;
    [_button.widthAnchor constraintEqualToConstant:150].active = true;
    [_button.heightAnchor constraintEqualToConstant:80].active = true;
    
    
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
    [self.textView becomeFirstResponder];
    NSString *string = _text;
    [self.delegate cellViewDidTapSave:self saveText:_textView.text];
}

- (void)tapButton2
{
    [self.delegate cellViewDidTapClose:self];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.textView becomeFirstResponder];
    NSString *string = self.textView.text;
}

@end
