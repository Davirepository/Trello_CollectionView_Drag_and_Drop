//
//  NewCellViewController.h
//  HW_CollectionView_Trello
//
//  Created by Давид on 15/11/2019.
//  Copyright © 2019 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewCellViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol NewCellViewControllerDelegate <NSObject>

- (void)cellViewDidTapClose:(NewCellViewController *)view;
- (void)cellViewDidTapSave:(NewCellViewController *)view saveText:(NSString *)textview;

@end

@interface NewCellViewController : UIView

- (NewCellViewController *)viewForTask;

@property (nonatomic, nullable, weak) id<NewCellViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
