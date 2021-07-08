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

- (void) updateUsername:(NSString *) username{
    self.usernameLabel.text = username;
}

@end
