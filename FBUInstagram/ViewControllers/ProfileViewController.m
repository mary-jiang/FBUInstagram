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

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet ProfileView *profileView;
@property (strong, nonatomic) NSArray *posts;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PFUser *user = [PFUser currentUser];
    
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
    [self.profileView updateUsername:user.username];
    [self.profileView updateProfilePicture:[UIImage imageNamed:@"image_placeholder"]]; //image placeholder for until profile image feature is completed
    
    [self fetchPostsByUser:user];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
