//
//  iQiYiButton.h
//  01Animation
//
//  Created by fgj on 2018/9/1.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,iQiYiButtonStatus){
    iQiYiButtonStatusPause = 0,
    iQiYiButtonStattusPlay
};

@interface iQiYiButton : UIButton
@property (assign, nonatomic) iQiYiButtonStatus buttonSatus;

- (instancetype)initWithFrame:(CGRect)frame Status:(iQiYiButtonStatus)status;

@end

