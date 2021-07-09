//
//  PostCell.m
//  FBUInstagram
//
//  Created by Mary Jiang on 7/6/21.
//

#import "PostCell.h"
#import "UIKit+AFNetworking.h"
#import "FBUInstagramHelper.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    
    // get the post image's url and use that to set the imageview's image
    PFFileObject *image = self.post[@"image"];
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.postImageView setImageWithURL:imageURL];

    self.timestampLabel.text = [FBUInstagramHelper getRelativeTimeStampString:[self.post createdAt]];
    
    self.captionLabel.text = self.post[@"caption"];
    self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", self.post[@"likeCount"]];
    
}

- (void)setUsername:(NSString *)username {
    _username = username;
    
    self.usernameLabel.text = self.username;
    self.headerUsernameLabel.text = self.username;
}

- (void)updateProfileImage:(UIImage *)image {
    self.profileImageView.image = image;
}

@end
