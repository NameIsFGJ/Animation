//
//  YoukuButton.h
//  01Animation
//
//  Created by fgj on 2018/9/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,youkuButtonStatus){
    youkuButtonStatusPause = 0,
    youkuButtonStattusPlay
};
@interface YoukuButton : UIButton
@property (assign, nonatomic) youkuButtonStatus buttonSatus;

- (instancetype)initWithFrame:(CGRect)frame Status:(youkuButtonStatus)status;


@end
