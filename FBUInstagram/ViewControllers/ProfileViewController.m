//
//  ProfileViewController.m
//  FBUInstagram
//
//  Created by Mary Jiang on 7/8/21.
//

#import "ProfileViewController.h"
#import "ProfileView.h"
#import <Parse/Parse.h>
#import "PostGridCell.h"
#import "Post.h"
#import "FBUInstagramHelper.h"
#import "DetailsViewController.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource, ProfileViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet ProfileView *profileView;
@property (strong, nonatomic) NSArray *posts;
@property (strong, nonatomic) UIImagePickerController *imagePickerVC;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(self.user == nil){
        self.user = [PFUser currentUser];
    }
    
    self.profileView.collectionView.delegate = self;
    self.profileView.collectionView.dataSource = self;
    
    // format collection view
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.profileView.collectionView.collectionViewLayout;
    
    layout.minimumLineSpacing = 5; //space between each item in same column
    layout.minimumInteritemSpacing = 5; //space between each item in same row
    
    CGFloat itemsPerLine = 3;
    CGFloat itemWidth = (self.profileView.collectionView.frame.size.width - layout.minimumInteritemSpacing * (itemsPerLine - 1))  / itemsPerLine; //make the width scale with width of the screen based on how many posters in row and width of the screen
    CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    // update the UI elements not in the collection view
    [self.profileView updateUsername:self.user.username];
    
    // set profile picture if available
    PFFileObject *profilePicture = self.user[@"profilepicture"];
    if (profilePicture != nil) {
        NSURL *profileURL = [NSURL URLWithString:profilePicture.url];
        NSData *profileData = [NSData dataWithContentsOfURL:profileURL];
        [self.profileView updateProfilePicture:[UIImage imageWithData:profileData]];
    } else {
        [self.profileView updateProfilePicture:[UIImage imageNamed:@"image_placeholder"]];
    }
   
    // get posts posted by the user
    [self fetchPostsByUser:self.user];
     
    // initializes a tap gesture recognizer on the profile picture
    [self.profileView createProfileTapGestureRecognizer];
    self.profileView.delegate = self;
    
    // instantiate a new UIImagePickerController
    self.imagePickerVC = [UIImagePickerController new];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
    
    // need to check if the camera is supported on device before trying to present it
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // if the camera is available then set the image picker's source to be the camera
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        // if the camera is not available then set image picker's source to be the photo library
        NSLog(@"Camera ???? available so we will use photo library instead");
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
}


- (void) fetchPostsByUser: (PFUser *)user{
    // create query to get posts only posted by the passed in user
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"author" equalTo:user];
    [query orderByDescending:@"createdAt"];
    
    // fetch the posts
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects != nil){
            self.posts = objects;
            [self.profileView.collectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostGridCell *cell = [self.profileView.collectionView dequeueReusableCellWithReuseIdentifier:@"PostGridCell" forIndexPath:indexPath];
    Post *post = self.posts[indexPath.item];
    cell.post = post;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

- (void)didTapProfilePicture{
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    // get the edited (aka cropped) image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // resize image to make sure that the size is small enough to upload to Parse
    UIImage *resizedImage = [FBUInstagramHelper resizeImage:editedImage withSize:CGSizeMake(100.0, 100.0)];

    // update the profile picture view
    [self.profileView updateProfilePicture:resizedImage];
    
    // update the user's profile picture in Parse
    self.user[@"profilepicture"] = [Post getPFFileFromImage:resizedImage];
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Profile picture saved successfully");
        } else {
            NSLog(@"Problem saving profile picture: %@", error.localizedDescription);
        }
    }];
    
    // dismiss UIImagePickerController to go back to original view controller
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual:@"detailSegue"]) {
        UICollectionViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.profileView.collectionView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.item];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = post;
    }
}





@end
