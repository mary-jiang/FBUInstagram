//
//  PostCell.m
//  FBUInstagram
//
//  Created by Mary Jiang on 7/6/21.
//

#import "PostCell.h"

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
    
    // to set the username label we need to first fetch the author's user object from Parse
    PFUser *user = self.post[@"author"];
    [user fetchInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            self.usernameLabel.text = object[@"username"];
            self.headerUsernameLabel.text = object[@"username"];
        } else {
            NSLog(@"Error fetching user: %@", error.localizedDescription);
        }
    }];
    
    // similar to the username, to display the image we need to fetch the data from Parse first
    PFFileObject *image = self.post[@"image"];
    [image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error == nil) {
            self.postImageView.image = [UIImage imageWithData:data];
        } else {
            NSLog(@"Error fetching image: %@", error.localizedDescription);
        }
    }];
    
    // have not implemented profile picture feature, for now put in a placeholder
    self.profileImageView.image = [UIImage imageNamed:@"image_placeholder"];
    
    // get date the post was created at and format it
    NSDate *createdAt = [self.post createdAt];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;

    self.timestampLabel.text = [formatter stringFromDate:createdAt];
    
    self.captionLabel.text = self.post[@"caption"];
    self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", self.post[@"likeCount"]];
    
}

@end
