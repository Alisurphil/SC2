//
//  LeftViewController.m
//  SC2
//
//  Created by 袁文轶 on 15/11/26.
//  Copyright © 2015年 wx. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()
- (IBAction)exitID:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)userImage:(UIButton *)sender forEvent:(UIEvent *)event;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    PFUser *currentUser = [PFUser currentUser];
    _userNameLabel.text = [NSString stringWithFormat:@"昵称：%@", currentUser[@"nickName"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)exitID:(UIButton *)sender forEvent:(UIEvent *)event {
    [PFUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)userImage:(UIButton *)sender forEvent:(UIEvent *)event {
    UIActionSheet *actionSheet =[[UIActionSheet alloc] initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    //在视图上展示
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:                                                       (NSInteger)buttonIndex {
    // 相册 0 拍照 1
    switch (buttonIndex) {         case 0:
            //从相册中读取
            [self readImageFromAlbum];
            break;
        case 1:
            //拍照
        [self readImageFromCamera];
        break;
        default:
        break;
    } }
//从相册中读取
- (void)readImageFromAlbum {
    //创建对象
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //（选择类型）表示仅仅从相册中选取照片
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //指定代理，因此我们要实现UIImagePickerControllerDelegate,UINavigationControllerDelegate协议
    imagePicker.delegate = self;
    //设置在相册选完照片后，是否跳到编辑模式进行图片剪裁。(允许用户编辑)
    imagePicker.allowsEditing = YES;
    //显示相册
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)readImageFromCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];         imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        //允许用户编辑
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
            //弹出窗口响应点击事件
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告"message:@"未检测到摄像头" delegate:         nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
//图片完成之后处理
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    //image 就是修改后的照片
    //将图片添加到对应的视图上
    [:image forState:UIControlStateNormal];
    //结束操作
    [self dismissViewControllerAnimated:YES completion:nil]; }
@end
