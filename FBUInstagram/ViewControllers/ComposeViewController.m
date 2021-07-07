//
//  ComposeViewController.m
//  FBUInstagram
//
//  Created by Mary Jiang on 7/6/21.
//

#import "ComposeViewController.h"
#import "Post.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImage *postImage;
@property (weak, nonatomic) IBOutlet UITextView *captionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *previewImage;
@property (nonatomic, strong) UIImagePickerController *imagePickerVC;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    // create a post with chosen image and caption and upload it to Parse server
    [Post postUserImage:self.postImage withCaption:self.captionTextView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            // dismiss this view controller
            [self dismissViewControllerAnimated:true completion:nil];
        } else {
            NSLog(@"error creating post: %@", error.localizedDescription);
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
    UIImage *resizedImage = [self resizeImage:editedImage withSize:CGSizeMake(500.0, 500.0)];
    
    // set postImage property to be resizedImage
    self.postImage = resizedImage;
    
    // set previewImage to be the selected postImage
    self.previewImage.image = self.postImage;
    
    // dismiss UIImagePickerController to go back to original view controller
    [self dismissViewControllerAnimated:true completion:nil];
}

// returns a resized UIImage of a specified size
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
