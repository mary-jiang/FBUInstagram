//
//  DetailsViewController.m
//  FBUInstagram
//
//  Created by Mary Jiang on 7/7/21.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // to set the username label we need to first fetch the author's user object from Parse
    PFUser *user = self.post[@"author"];
    [user fetchInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (error == nil) {
            self.usernameLabel.text = object[@"username"];
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
    
    // get date the post was created at and format it
    NSDate *createdAt = [self.post createdAt];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;

    self.timestampLabel.text = [formatter stringFromDate:createdAt];
    
    self.captionLabel.text = self.post[@"caption"];
    self.likesLabel.text = [NSString stringWithFormat:@"%@ Likes", self.post[@"likeCount"]];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
