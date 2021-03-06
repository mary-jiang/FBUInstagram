//
//  ComposeViewController.m
//  FBUInstagram
//
//  Created by Mary Jiang on 7/6/21.
//

#import "ComposeViewController.h"
#import "Post.h"
#import "FBUInstagramHelper.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImage *postImage;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *previewImage;
@property (nonatomic, strong) UIImagePickerController *imagePickerVC;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *postButton;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.postButton.enabled = true;
    
    // style text view
    self.captionTextView.layer.cornerRadius = 8;
    self.captionTextView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.captionTextView.layer.borderWidth = 1.0;
    
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
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (IBAction)didTapCancel:(id)sender {
    // dismiss this view controller
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)didTapPost:(id)sender {
    // disable the post button so that the same post isn't posted twice if user just mashes button
    self.postButton.enabled = false;
    
    // create a post with chosen image and caption and upload it to Parse server
    [Post postUserImage:self.postImage withCaption:self.captionTextView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            // dismiss this view controller
            [self dismissViewControllerAnimated:true completion:nil];
        } else {
            NSLog(@"error creating post: %@", error.localizedDescription);
            // reenable button so that user can try posting again
            self.postButton.enabled = true;
        }
    }];
}

- (IBAction)didTapPicture:(id)sender {
    [self presentViewController:self.imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    // get the edited (aka cropped) image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // resize image to make sure that the size is small enough to upload to Parse
    UIImage *resizedImage = [FBUInstagramHelper resizeImage:editedImage withSize:CGSizeMake(500.0, 500.0)];
    
    // set postImage property to be resizedImage
    self.postImage = resizedImage;
    
    // set previewImage to be the selected postImage
    self.previewImage.image = self.postImage;
    
    // dismiss UIImagePickerController to go back to original view controller
    [self dismissViewControllerAnimated:true completion:nil];
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
