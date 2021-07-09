//
//  ProfileView.h
//  FBUInstagram
//
//  Created by Mary Jiang on 7/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ProfileViewDelegate

- (void) didTapProfilePicture;

@end

@interface ProfileView : UIView

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) id<ProfileViewDelegate> delegate;

- (void) updateUsername:(NSString *) username;
- (void) updateProfilePicture:(UIImage *) image;
- (void) createProfileTapGestureRecognizer;

@end

NS_ASSUME_NONNULL_END
