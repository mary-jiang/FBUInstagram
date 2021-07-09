//
//  FBUInstagramHelper.h
//  FBUInstagram
//
//  Created by Mary Jiang on 7/9/21.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FBUInstagramHelper : NSObject

+ (NSString *) getRelativeTimeStampString: (NSDate *)date;

+ (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
