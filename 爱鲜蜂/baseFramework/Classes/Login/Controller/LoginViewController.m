//
//  LoginViewController.m
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPassWordViewController.h"

@interface LoginViewController()<UITextFieldDelegate>
/** 头像 */
@property(nonatomic,strong)UIImageView *headImgV;
/** 背景图 */
@property(nonatomic,strong)UIImageView *backImgV;
/** 返回图 */
@property(nonatomic,strong)UIImageView *backView;
/** 电话账号文本框 */
@property(nonatomic,strong)UITextField *phoneTextField;
/** 密码文本框 */
@property(nonatomic,strong)UITextField *passwordText;
/** 登陆按钮 */
@property(nonatomic,strong)UIButton *loginBtn;
/** 忘记密码按钮 */
@property(nonatomic,strong)UIButton *forgetPassWordBtn;
/** 注册按钮 */
@property(nonatomic,strong)UIButton *registBtn;
/** 返回顶部按钮 */
@property(nonatomic,strong)UIButton *returnTopBtn;
@end

@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [super viewWillDisappear:animated];

}
/** 初始化加载 */
-(void)viewDidLoad{
    //初始化创建登陆界面
    [self setupLoginVC];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)setupLoginVC{
    _backImgV =[UIImageView addImgWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) AndImage:@"ditu" isuserInteractionEnabled:YES];
    [self.view addSubview:_backImgV];
    
    _backView =[UIImageView addImgWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) AndImage:@"zuizhongbanquan" isuserInteractionEnabled:YES];
    [self.view addSubview:_backView];
    
    _headImgV =[UIImageView addImgWithFrame:CGRectMake(125*Width, 90*Height, 70*Width, 70*Height) AndImage:@"touxiang" isuserInteractionEnabled:NO];
    [_backView addSubview:_headImgV];
    
    _phoneTextField =[self addtextFieldWithHeight:200 AndImgStr:nil AndStr:@"请输入手机号码"];
    _phoneTextField.keyboardType =UIKeyboardTypeNumberPad;
    [_backView addSubview:_phoneTextField];
    
    _passwordText =[self addtextFieldWithHeight:250 AndImgStr:nil AndStr:@"请输入密码"];
    _passwordText.secureTextEntry = YES;
    [_backView addSubview:_passwordText];
    
    _loginBtn =[UIButton addBtnImage:@"loginBtn" AndFrame:CGRectMake(30*Width, 300*Height, 260*Width, 36*Height) WithTarget:self action:@selector(loginAccountButton)];
    [_backView addSubview:_loginBtn];
    
    _forgetPassWordBtn =[UIButton addBtnImage:nil AndFrame:CGRectMake(215*Width, 340*Height, 90*Width, 20*Height) WithTarget:self action:@selector(forgetPasswordClick)];
    [_forgetPassWordBtn setTitle:@"忘记密码 ?" forState:UIControlStateNormal];
    _forgetPassWordBtn.titleLabel.font =[UIFont systemFontOfSize:12*Width weight:0.5];
    [_backView addSubview:_forgetPassWordBtn];

    _registBtn =[UIButton addBtnImage:@"register_loginBtn" AndFrame:CGRectMake(110*Width, 380*Height, 100*Width, 15*Height) WithTarget:self action:@selector(registAccountInterface)];
    [_backView addSubview:_registBtn];
    
}
#pragma mark -- 登陆接口处理
-(void)loginAccountButton{
    NSString *userName =[FormValidator checkMobile:_phoneTextField.text];
    NSString *passWord=[FormValidator checkPassword:_passwordText.text];
    if ([_phoneTextField.text isEqualToString:@""]||_phoneTextField.text == nil||[_passwordText.text isEqualToString:@""]||_passwordText.text == nil) {
        [FormValidator showAlertWithStr:@"用户名或密码不能为空"];
        return;
    }else{
        if (userName) {
            [FormValidator showAlertWithStr:userName];
            return;
        }
        if (passWord) {
            [FormValidator showAlertWithStr:passWord];
            return;
        }
    }
    [self loginAccountInter];
    
}
//登陆接口
-(void)loginAccountInter{
    [self.view endEditing:YES];
    AFNDebug
    NSString *url = @"";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"number"] = _phoneTextField.text;
    params[@"password"] = [NSString string_md5:_passwordText.text];
    
    [CHNetWorking postWithUrl:url refreshCache:YES params:params success:^(id response) {
        if ([response[@"id"] isEqualToString:@"false"]) {
            [FormValidator showAlertWithStr:@"用户或者账号密码错误"];
        }else{
            //登陆正确直接跳转---》登陆页更新全局登陆状态
            
        }
        CHLog(@"response---%@",response);
    } fail:^(NSError *error) {
        [FormValidator showAlertWithStr:failTipe];
        CHLog(@"error---%@",error);
    }];
}
#pragma mark -- 跳转控制的系列方法
//退出登陆界面
-(void)returnLoginBtnsss
{
    [self.navigationController popViewControllerAnimated:YES];
}
//忘记密码按钮
-(void)forgetPasswordClick{
    ForgetPassWordViewController *forgetPasswordVC = [[ForgetPassWordViewController alloc]init];
    [self presentViewController:forgetPasswordVC animated:YES completion:nil];
}
//注册账号按钮
-(void)registAccountInterface{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self presentViewController:registerVC animated:YES completion:nil];
}
#pragma mark -- private 私有工具
//创建输入框和输入框背景图的方法
-(UITextField *)addtextFieldWithHeight:(CGFloat)heigh AndImgStr:(NSString *)imgStr AndStr:(NSString *)str
{
    UIImageView *imgBack =[UIImageView addImgWithFrame:CGRectMake(30*Width, heigh*Height, 260*Width, 36*Height) AndImage:@"login_Register_Bord" isuserInteractionEnabled:NO];
    [_backView addSubview:imgBack];
    
    UITextField *textF =[UITextField addTextFieldWithFrame:CGRectMake(30*Width+5, (heigh+0.5)*Height, 260*Width-5, 35*Height) AndStr:str AndFont:14 AndTextColor:whitesColor];
    textF.delegate = self;
    [_backView addSubview:textF];
    
    return textF;
}

#pragma mark -- 文本框占位符选中高亮交替的配置
//选中的话当前的占位字符串会高亮
- (void)selectTextField{
    for (UIView *tf in self.backView.subviews) {
        if ([tf isKindOfClass:[UITextField class]]) {
            UITextField *textF = (UITextField *)tf;
            if (textF.editing) {
                textF.placeholderColor = [UIColor whiteColor];
            }else{
                textF.placeholderColor = [UIColor blackColor];
            }
        }
    }
}
//文本框编辑的代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self selectTextField];
}

@end
