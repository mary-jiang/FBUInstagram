//
//  FeedViewController.m
//  FBUInstagram
//
//  Created by Mary Jiang on 7/6/21.
//

#import "FeedViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "PostCell.h"
#import "DetailsViewController.h"

@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *posts;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic) int numOfPostsToLoad;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // initally we want to load 20 posts to start
    self.numOfPostsToLoad = 5;
    
    [self fetchPosts];
    
    //setup refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (IBAction)didTapLogout:(id)sender {
    // log out the user from parse server
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
    // create instance of scene delegate
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    
    // use scene delegate instance to set root view controller to be a new instance of LoginViewController
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    myDelegate.window.rootViewController = loginViewController;
}

- (void)fetchPosts {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = self.numOfPostsToLoad;
    [query orderByDescending:@"createdAt"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // set posts array to be the posts we have just fetched from the server
            self.posts = posts;
            // reload tableview to update the posts that we are seeing
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    cell.post = self.posts[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

// this method tells the delegate the table view is about to draw a cell for a particular row
// we can use this to detect when we are getting to the end of the data we have so we can load ore
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row + 1 == self.posts.count) {
        self.numOfPostsToLoad += 20; // increase the number of posts we want to load
        [self fetchPosts];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual:@"detailSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = post;
    }
}


@end
