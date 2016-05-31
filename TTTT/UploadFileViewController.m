//
//  UploadFileViewController.m
//  TTTT
//
//  Created by wxy on 16/1/4.
//  Copyright © 2016年 wuxianying. All rights reserved.
//

#import "UploadFileViewController.h"
#import "Utils.h"
#import <UIButton+WebCache.h>

@interface UploadFileViewController () <UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIButton *btnOpen;
@property (nonatomic,strong) UIImageView *ivDown;
@property (nonatomic,strong) UIButton *btnUp;
@property (nonatomic,strong) UIButton *btnDown;
@property (nonatomic,strong) NSString *filePath;

@end

@implementation UploadFileViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark initPro

-(UIButton *)btnOpen
{
    if (!_btnOpen) {
        _btnOpen = [UIButton new];
        [_btnOpen setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btnOpen setTitle:@"点击添加图片" forState:UIControlStateNormal];
        [_btnOpen addTarget:self action:@selector(openFile) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_btnOpen];
    }
    return _btnOpen;
}

-(UIButton *)btnUp
{
    if (!_btnUp) {
        _btnUp = [UIButton new];
        [_btnUp setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btnUp setTitle:@"上传" forState:UIControlStateNormal];
        [_btnUp addTarget:self action:@selector(openup) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_btnUp];
    }
    return _btnUp;
}

-(UIButton *)btnDown
{
    if (!_btnDown) {
        _btnDown = [UIButton new];
        [_btnDown setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_btnDown setTitle:@"下载" forState:UIControlStateNormal];
        [_btnDown addTarget:self action:@selector(opendown) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_btnDown];
    }
    return _btnDown;
}

-(UIImageView *)ivDown
{
    if (!_ivDown) {
        _ivDown = [UIImageView new];
        [self.view addSubview:_ivDown];
        
    }
    return _ivDown;
}

-(void)initView
{
    
    [self.btnOpen makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view).offset(SCREEN_W*0.1);
        make.size.equalTo(CGSizeMake(SCREEN_W*0.4, SCREEN_W*0.4));
    }];
    
    [self.btnUp makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnOpen.bottom).offset(20);
        make.width.equalTo(self.btnOpen);
        make.centerX.equalTo(self.view);
        make.height.equalTo(40);
    }];
    [self.btnDown makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnUp.bottom).offset(20);
        make.width.equalTo(self.btnOpen);
        make.centerX.equalTo(self.view);
        make.height.equalTo(40);
    }];
    
    [self.ivDown makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnOpen);
        make.left.equalTo(self.btnOpen.right).offset(SCREEN_W*0.1);
        make.size.equalTo(self.btnOpen);
    }];
    
}

#pragma mark fun

-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:picker animated:YES completion:nil];
        
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (NSString *)documentFolderPath
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* imagePath = [documentsDirectory stringByAppendingPathComponent:@"UploadFleaImages"];
    
    //建立文件夹
    NSFileManager *fileManager= [NSFileManager defaultManager];
    BOOL isDir=YES;
    if(![fileManager fileExistsAtPath:imagePath isDirectory:&isDir])
        if(![fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:NULL])
            NSLog(@"Error: Create folder failed");
    
    return imagePath;
}

-(void)deleteDir
{
    NSString *imagePath = [self documentFolderPath];
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSError *error;
    if ( [fileManager fileExistsAtPath:imagePath] ) {
        if (![fileManager removeItemAtPath:imagePath error:&error]) {
            NSLog(@"File Folder Delete Error: %@",[error localizedDescription]);
        }
    }
    
}

#pragma mark selector

-(void)openFile
{
    UIActionSheet  *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [sheet showInView:self.view];
}

-(void)openup
{
    [[ServerManager instance] FleaNewEX:@"tetet" Pictures:self.filePath withSuccessBlock:^(NSDictionary *dictionary) {
        NSLog(@"%@",dictionary);
        [self deleteDir];
        
    } fileBlock:
     ^(NSString *errDescription) {
         NSLog(@"%@",errDescription);
     } ProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
         NSLog(@"%lld tttt",totalBytesWritten/totalBytesExpectedToWrite);
         
     }];
}

-(void)opendown
{
    [[ServerManager instance] callAPI:@"http://192.168.1.15:8080/getImage" CallType:POST Param:nil bShowHUD:YES inView:self.view text:@"加载中" withSuccessBlock:^(NSDictionary *dictionary) {
       
        NSString *str = [dictionary objectForKey:@"tttt"];
        NSURL *url = [[NSURL alloc] initWithString:str];
        [self.ivDown sd_setImageWithURL:url];
        
    } fileBlock:^(NSString *errDescription) {
        
        
    }];
}

#pragma mark delegate

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (image == nil) {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
            
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data;
            if (UIImagePNGRepresentation(image) == nil)
            {
                data = UIImageJPEGRepresentation(image, 1.0);
            }
            else
            {
                data = UIImagePNGRepresentation(image);
            }
            NSString * DocumentsPath = [self documentFolderPath];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"2.jpg"]
                                 contents:data attributes:nil];
            _filePath = [DocumentsPath stringByAppendingString:@"2.jpg"];
           
        });
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        [self.btnOpen setBackgroundImage:image forState:UIControlStateNormal];

    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
            
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}

@end
