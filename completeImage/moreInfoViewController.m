//
//  moreInfoViewController.m
//  completeImage
//
//  Created by 张力 on 14-8-17.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "moreInfoViewController.h"
#import <MessageUI/MessageUI.h>

@interface moreInfoViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation moreInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 50, 36)];
    UIButton *goAppstore = [[UIButton alloc] initWithFrame:CGRectMake(110, self.view.frame.size.height/2-70,100 , 51)];
    UIButton *submitEmail = [[UIButton alloc] initWithFrame:CGRectMake(110, self.view.frame.size.height/2+210,100, 51)];



    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
        [backBtn setFrame:CGRectMake(15, 12, 50, 36)];
        [goAppstore setFrame:CGRectMake(110, self.view.frame.size.height/2-70, 100, 51)];
        [submitEmail setFrame:CGRectMake(110, self.view.frame.size.height/2+170, 100, 51)];

    }
    
    
    [backBtn setImage:[UIImage imageNamed:@"returnToLevel"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"returnTapped"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *fullScreen = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    fullScreen.contentMode = UIViewContentModeScaleAspectFit;
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
        [fullScreen setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"morePage460" ofType:@"png"]]];

    }else
    {
        [fullScreen setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"morePage" ofType:@"png"]]];

    }
    [self.view addSubview:fullScreen];
    [self.view addSubview:backBtn];
    [self.view bringSubviewToFront:backBtn];
    
    [goAppstore setImage:[UIImage imageNamed:@"goComment"] forState:UIControlStateNormal];
    [goAppstore addTarget:self action:@selector(gotoStore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goAppstore];
    [self.view bringSubviewToFront:goAppstore];
    
    [submitEmail setImage:[UIImage imageNamed:@"goSubmit"] forState:UIControlStateNormal];
    [submitEmail addTarget:self action:@selector(emailMe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitEmail];
    [self.view bringSubviewToFront:submitEmail];

    
}


//- (IBAction)selectForAlbumButtonClick:(UIButton *)sender
//{
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    [self presentViewController:imagePickerController animated:YES completion:nil];
//    imagePickerController.allowsEditing = YES;
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//}
//
//
//- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
//{
//    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
//    
//    // 获取沙盒目录
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
//                          stringByAppendingPathComponent:imageName];
//    
//    // 将图片写入文件
//    [imageData writeToFile:fullPath atomically:NO];
// 
//}
//
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//	[picker dismissViewControllerAnimated:YES completion:^{}];
//    
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    NSString *UUID = [[NSUUID UUID] UUIDString];
//    NSString *name = [NSString stringWithFormat:@"%@.png", UUID];
//    
//    [self saveImage:image withName: name];
//    
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:name];
//    
//    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
//    int index = 0;
//    if ([self.imageName isEqualToString:@""] || self.imageName == nil) {
//        self.imageName = name;
//    } else {
//        self.imageName = [NSString stringWithFormat:@"%@;%@", self.imageName, name];
//        index = (int)[[self.imageName componentsSeparatedByString:@";"] count] - 1;
//    }
//    // [[self.imageView objectAtIndex:index] setImage:savedImage];
//    //button for every imageView
//    
//    //[[self.imageViewButton objectAtIndex:index] setFrame:[[self.imageView objectAtIndex:index] frame]];
//    // [self.view addSubview:[self.imageViewButton objectAtIndex:index]];
//    // [[self.imageViewButton objectAtIndex:index] setTag:index+IMAGEBUTTON_TAG_BASE];
//    //  //NSLog(@"button tag is :%d",((UIButton *)self.imageViewButton[index]).tag );
//    [[self.imageAttach objectAtIndex:index] setImage:savedImage forState:UIControlStateNormal];
//    [[self.imageAttach objectAtIndex:index] addTarget:self action:@selector(pictureTapped:) forControlEvents:UIControlEventTouchUpInside];
//    
//}
//

-(void)emailMe
{
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"投稿"];
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"sheepcao1986@163.com"];
    
    
    [picker setToRecipients:toRecipients];
//    
//    // Attach an image to the email
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"" ofType:@"png"];
//    NSData *myData = [NSData dataWithContentsOfFile:path];
//    [picker addAttachmentData:myData mimeType:@"image/png" fileName:@""];
    
    // Fill out the email body text
    NSString *emailBody = (@"hi sheepcao,this is your own test!");
    [picker setMessageBody:emailBody isHTML:NO];
    [self presentViewController:picker animated:YES completion:nil];
    

}

-(NSString*)currentLanguage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLang = [languages objectAtIndex:0];
    return currentLang;
}


-(void)gotoStore
{
    if([[self currentLanguage] compare:@"zh-Hans" options:NSCaseInsensitiveSearch]==NSOrderedSame || [[self currentLanguage] compare:@"zh-Hant" options:NSCaseInsensitiveSearch]==NSOrderedSame)
    {
        NSLog(@"current Language == Chinese");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/daysinline/id844914780?mt=8"]];
        
        
    }else{
        NSLog(@"current Language == English");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/us/app/daysinline/id844914780?mt=8"]];
        
    }
    
}


-(void)backTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertWithTitle: (NSString *)_title_ msg: (NSString *)msg

{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_

                                                    message:msg

                                                   delegate:nil
                                          cancelButtonTitle:@"Sure"

                                          otherButtonTitles:nil];

    [alert show];
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error

{
    
        NSString *title = @"Mail";
    
        NSString *msg;
    
        switch (result)
    
        {
    
            case MFMailComposeResultCancelled:
    
                msg = @"Mail canceled";//@"邮件发送取消";
    
                break;
    
            case MFMailComposeResultSaved:
    
                msg = @"Mail saved";//@"邮件保存成功";
    
                [self alertWithTitle:title msg:msg];
    
                break;
    
            case MFMailComposeResultSent:
    
                msg = @"Mail sent";//@"邮件发送成功";
    
                [self alertWithTitle:title msg:msg];
    
                break;
    
            case MFMailComposeResultFailed:
    
                msg = @"Mail failed";//@"邮件发送失败";
    
                [self alertWithTitle:title msg:msg];
    
                break;
    
            default:
    
                msg = @"Mail not sent";
    
                [self alertWithTitle:title msg:msg];
    
               break;
    
        }
    
    [self  dismissViewControllerAnimated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
