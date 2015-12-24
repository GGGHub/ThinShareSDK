//
//  OKWShareActionSheet.h
//  OKWShareSDK
//
//  Created by Labanotation on 15/12/22.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKWShareActionSheet : UIView

-(instancetype)initWithTitle:(NSString *)title;

-(void)addButtonWithTitle:(NSString *)title image:(UIImage *)image handle:(void(^)(void))handle;

-(void)showInView:(UIView *)view;

@end


