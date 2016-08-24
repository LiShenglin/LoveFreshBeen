//
//  RegisterViewController.m
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController()<UITextFieldDelegate>
{
    int timeCount;
    NSTimer*timer;
}

@property(nonatomic,strong)UILabel *tipLabel;
@property(nonatomic,strong)UIButton *loginBtnReturn;
@property(nonatomic,strong)UIImageView *backImgV;
@property(nonatomic,strong)UIImageView *backView;
@property(nonatomic,strong)UITextField *phoneTextField;
@property(nonatomic,strong)UIImageView *phoneImgV;
@property(nonatomic,strong)UITextField *passwordText;
@property(nonatomic,strong)UIImageView *passwordImgV;
@property(nonatomic,strong)UIButton *loginBtn;

@property(nonatomic,strong)UITextField *yanzhengTextF;
@property(nonatomic,strong)UIButton *huoquBtn;
@property(nonatomic,copy)NSString *registStr;

@end

@implementation RegisterViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewDidLoad{
    [self setupAllview];
    
    //[self readSecond];
}
//配置所有的视图组件
- (void)setupAllview{
    _backImgV =[UIImageView addImgWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) AndImage:@"ditu" isuserInteractionEnabled:YES];
    [self.view addSubview:_backImgV];

    _backView =[UIImageView addImgWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) AndImage:@"zuizhongbanquan" isuserInteractionEnabled:YES];
    [self.view addSubview:_backView];
    
    _loginBtnReturn =[UIButton addBtnImage:@"login_Return_Left" AndFrame:CGRectMake(20*Height, 30*Height, 25*Width, 25*Height) WithTarget:self action:@selector(returnLoginBtn)];
    [_backView addSubview:_loginBtnReturn];
    
    _phoneTextField =[self addtextFieldWithHeight:150 AndImgStr:nil AndStr:@"请输入手机号码"];
    _phoneTextField.keyboardType =UIKeyboardTypeNumberPad;
    [_backView addSubview:_phoneTextField];
    
    _passwordText =[self addtextFieldWithHeight:200 AndImgStr:nil AndStr:@"请输入密码"];
    [_backView addSubview:_passwordText];
    
    _loginBtn =[UIButton addBtnImage:@"registerBtn" AndFrame:CGRectMake(30*Width, 300*Height, 260*Width, 36*Height) WithTarget:self action:@selector(registAccountButton)];
    [_backView addSubview:_loginBtn];
    
    _yanzhengTextF =[self textWithH:250 AndW:140 AndStr:@"输入验证码"];
    _yanzhengTextF.keyboardType =UIKeyboardTypeNumberPad;
    _yanzhengTextF.delegate = self;
    [_backView addSubview:_yanzhengTextF];
    
    
    _huoquBtn =[UIButton addBtnImage:nil AndFrame:CGRectMake(180*Width, 250*Width, 110*Width, 36*Height) WithTarget:self action:@selector(registVerify)];
    [_huoquBtn setBackgroundImage:[UIImage imageNamed:@"register_huoqu"] forState:UIControlStateNormal];
    [_huoquBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_huoquBtn setTitleColor:whitesColor forState:UIControlStateNormal];
    _huoquBtn.titleLabel.font =[UIFont systemFontOfSize:12*Width weight:1];
    [_backView addSubview:_huoquBtn];
    
    //验证提交之后的跑秒提示防止用户的重复提交数据有效时间60秒
    timeCount = 60;
    UILabel *tiplabel=[[UILabel alloc ]initWithFrame:CGRectMake(180*Width, 250*Height, 110*Width, 35*Height)];
    _tipLabel = tiplabel;
    _tipLabel.textAlignment=NSTextAlignmentCenter;
    _tipLabel.text=[[NSString alloc]initWithFormat:@"%ds",timeCount];
    _tipLabel.textColor=[UIColor whiteColor];
    _tipLabel.layer.cornerRadius=3;
    _tipLabel.clipsToBounds=YES;
    _tipLabel.backgroundColor=[UIColor lightGrayColor];
    _tipLabel.hidden=YES;
    _tipLabel.font=[UIFont systemFontOfSize:14];
    [_backView addSubview:_tipLabel];
}
#pragma mark -- 注册的接口处理方法
//注册账号按钮点击事件
- (void)registAccountButton{
    if ([_phoneTextField.text isEqualToString:@""]||_phoneTextField.text ==nil ||[_passwordText.text isEqualToString:@""]||_passwordText.text == nil|| [_yanzhengTextF.text isEqualToString:@""]||_yanzhengTextF.text == nil) {
        [FormValidator showAlertWithStr:@"手机号、昵称或者密码不能为空"];
        return;
    }else if(!([_yanzhengTextF.text intValue]==[self.registStr intValue])){
        //NSLog(@"%@,%@",_registYZ.text,_registStr);
        [FormValidator showAlertWithStr:@"请输入正确验证码"];
        return;
        
    }else if(_passwordText.text.length <6 ){
        [FormValidator showAlertWithStr:@"密码必须6位以上"];
    }else{
        [self registAccountInterface];
    }
}
//注册接口
- (void)registAccountInterface{
    [self.view endEditing:YES];
    AFNDebug
    NSString *url = @"";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"number"] = _phoneTextField.text;
    params[@"password"] = [NSString string_md5:_passwordText.text];
    
    [CHNetWorking postWithUrl:url refreshCache:YES params:params success:^(id response) {
        if ([response[@"id"] isEqualToString:@"false"]) {
            [FormValidator showAlertWithStr:@"该手机号已被注册"];
        }else{
            [FormValidator showAlertWithStr:@"注册成功"];
            //注册正确直接跳转---》更新全局登陆状态--》注册成功后延时跳转
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
            });
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        CHLog(@"response---%@",response);
    } fail:^(NSError *error) {
        [FormValidator showAlertWithStr:failTipe];
        CHLog(@"error---%@",error);
    }];
}

//注册验证码
- (void)registVerify{
    if ([_phoneTextField.text isEqualToString:@""]||_phoneTextField.text == nil) {
        [FormValidator showAlertWithStr:@"请输入手机号"];
        
    }else{
        //通过第三方接口直接请求
        AFNDebug
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"userPhoneNumber"] = _phoneTextField.text;
        [CHNetWorking postWithUrl:validate refreshCache:YES params:dict success:^(id response) {
            //一请求就开始跑秒数
            [self readSecond];
            NSDictionary *dic =(NSDictionary *)response;
            self.registStr = [dic objectForKey:@"yanzheng"];
        } fail:^(NSError *error) {
            CHLog(@"失败%@",error);
        }];
    }
}
//跳转回首页
- (void)returnLoginBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark-->读秒开始\跑秒操作
-(void)readSecond{
    _huoquBtn.hidden=YES;
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
    timer.fireDate=[NSDate distantPast];
}
//跑秒操作
-(void)dealTimer{
    _tipLabel.hidden=NO;
    NSLog(@"跑秒提示");
    _tipLabel.text=[[NSString alloc]initWithFormat:@"%ds",timeCount];
    timeCount=timeCount - 1;
    if(timeCount== 0){
        timer.fireDate=[NSDate distantFuture];
        timeCount= 60;
        _tipLabel.hidden=YES;
        _huoquBtn.hidden=NO;
    }
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
//验证码输入框
-(UITextField *)textWithH:(CGFloat)heigh AndW:(CGFloat)Widh AndStr:(NSString *)str
{
    UIImageView *imgBack =[UIImageView addImgWithFrame:CGRectMake(30*Width, heigh*Height, Widh*Width, 36*Height) AndImage:@"login_Register_Bord" isuserInteractionEnabled:YES];
    [_backView addSubview:imgBack];
    UITextField *textF=[UITextField addTextFieldWithFrame:CGRectMake(30*Width+5, (heigh+0.5)*Height, Widh*Width-5, 35*Height) AndStr:str AndFont:14 AndTextColor:whitesColor];
    
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
