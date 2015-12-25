//
//  OKWUtility.m
//  OKWShareSDK
//
//  Created by Labanotation on 15/12/25.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "OKWUtility.h"
#import <UIKit/UIKit.h>
@implementation OKWUtility
+(NSData *)compressData:(NSData *)origin length:(NSInteger)length
{
    UIImage *image = [UIImage imageWithData:origin];
    NSData * compressImageData = origin;
    NSInteger maxData = length;
    
    @autoreleasepool {
        CGFloat compression = 1.0f;
        while ([compressImageData length] > maxData)
        {
            compression -= 0.05;
            compressImageData = UIImageJPEGRepresentation(image, compression);
        }
    }
    return compressImageData;
}
@end
