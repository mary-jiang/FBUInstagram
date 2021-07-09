//
//  ProfileView.m
//  FBUInstagram
//
//  Created by Mary Jiang on 7/8/21.
//

#import "ProfileView.h"

@interface ProfileView ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

@implementation ProfileView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) updateUsername:(NSString *) username {
    self.usernameLabel.text = username;
}

- (void) updateProfilePicture:(UIImage *) image{
    self.profileImageView.image = image;
}

- (void)createProfileTapGestureRecognizer{
    // create and configure tap recognizer
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapUserProfile)];
    [self.profileImageView addGestureRecognizer:profileTapGestureRecognizer];
    [self.profileImageView setUserInteractionEnabled:true];
}

- (void)didTapUserProfile {
    // tell the delegate that the user profile was tapped
    [self.delegate didTapProfilePicture];
}

@end
