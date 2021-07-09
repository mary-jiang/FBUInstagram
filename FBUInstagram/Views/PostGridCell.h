//
//  PostGridCell.h
//  FBUInstagram
//
//  Created by Mary Jiang on 7/9/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostGridCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
