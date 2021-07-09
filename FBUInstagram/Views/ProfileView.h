//
//  ProfileView.h
//  FBUInstagram
//
//  Created by Mary Jiang on 7/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileView : UIView

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void) updateUsername:(NSString *) username;
- (void) updateProfilePicture:(UIImage *) image;

@end

NS_ASSUME_NONNULL_END
