//
//  PostGridCell.m
//  FBUInstagram
//
//  Created by Mary Jiang on 7/9/21.
//

#import "PostGridCell.h"
#import "UIKit+AFNetworking.h"

@implementation PostGridCell

- (void)setPost:(Post *)post{
    _post = post;
    PFFileObject *image = self.post[@"image"];
    NSURL *imageURL = [NSURL URLWithString:image.url];
    [self.postImageView setImageWithURL:imageURL];
}

@end
