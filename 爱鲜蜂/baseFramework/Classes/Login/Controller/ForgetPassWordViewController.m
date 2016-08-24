//
//  ForgetPassWordViewController.m
//  baseFramework
//
//  Created by chenangel on 16/5/26.
//  Copyright © 2016年 chuhan. All rights reserved.
//

#import "ForgetPassWordViewController.h"

@interface ForgetPassWordViewController()<UITextFieldDelegate>
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

@implementation ForgetPassWordViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden =YES;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
}
- (void)viewDidLoad{
    //初始化加入所有的控件
    [self setupAllView];
}
- (void)setupAllView{
    _backImgV =[UIImageView addImgWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) AndImage:@"ditu" isuserInteractionEnabled:YES];
    [self.view addSubview:_backImgV];
    _backImgV.userInteractionEnabled = YES;
    _backView =[UIImageView addImgWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) AndImage:@"zuizhongbanquan" isuserInteractionEnabled:YES];
    [self.view addSubview:_backView];
    _backView.userInteractionEnabled = YES;
    
    _loginBtnReturn =[UIButton addBtnImage:@"login_Return_Left" AndFrame:CGRectMake(20*Height, 30*Height, 25*Width, 25*Height) WithTarget:self action:@selector(returnLoginBtn)];
    [_backView addSubview:_loginBtnReturn];
    
    _phoneTextField =[self addtextFieldWithHeight:150 AndImgStr:nil AndStr:@"请输入手机号码"];
    _phoneTextField.keyboardType =UIKeyboardTypeNumberPad;
    [_backView addSubview:_phoneTextField];
    
    _passwordText =[self addtextFieldWithHeight:200 AndImgStr:nil AndStr:@"请输入新的密码"];
    [_backView addSubview:_passwordText];
    
    _loginBtn =[UIButton addBtnImage:@"forgetPassWord" AndFrame:CGRectMake(30*Width, 300*Height, 260*Width, 36*Height) WithTarget:self action:@selector(loginAccountButton)];
    [_backView addSubview:_loginBtn];
    
    _yanzhengTextF =[self textWithH:250 AndW:140 AndStr:@"输入验证码"];
    _yanzhengTextF.keyboardType =UIKeyboardTypeNumberPad;
    [_backView addSubview:_yanzhengTextF];
    
    
    _huoquBtn =[UIButton addBtnImage:nil AndFrame:CGRectMake(180*Width, 250*Width, 110*Width, 36*Height) WithTarget:self action:@selector(registVerify)];
    [_huoquBtn setBackgroundImage:[UIImage imageNamed:@"register_huoqu"] forState:UIControlStateNormal];
    
    [_huoquBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_huoquBtn setTitleColor:whitesColor forState:UIControlStateNormal];
    _huoquBtn.titleLabel.font =[UIFont systemFontOfSize:12*Width weight:1];
    [_backView addSubview:_huoquBtn];
    
    //验证提交之后的跑秒提示防止用户的重复提交数据有效时间60秒
    _tipLabel=[[UILabel alloc ]initWithFrame:CGRectMake(180*Width, 250*Height, 110*Width, 35*Height)];
    _tipLabel =[UILabel addLabelWithFrame:CGRectMake(180*Width, 250*Height, 110*Width, 35*Height) AndText:[[NSString alloc]initWithFormat:@"%ds",timeCount] AndFont:14 AndAlpha:1 AndColor:whitesColor AndAlignment:NSTextAlignmentCenter];
    _tipLabel.textAlignment=NSTextAlignmentCenter;
    timeCount = 60;
    _tipLabel.layer.cornerRadius=3;
    _tipLabel.clipsToBounds=YES;
    _tipLabel.backgroundColor=[UIColor lightGrayColor];
    _tipLabel.hidden=YES;

    [_backView addSubview:_tipLabel];

}
#pragma mark -- 忘记密码->修改密码->登陆的接口处理方法
//1、根据手机请求第三方接口获取正确验证码
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
//2、输入验证码，点击修改账号按钮事件--》进入数据修改请求方法
- (void)loginAccountButton{
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
        float regi =self.registStr.floatValue;
        float yanzen =_yanzhengTextF.text.floatValue;
        //验证码正确则请求修改
        if (regi == yanzen) {
            [self sureData];
        }else{
            [FormValidator showAlertWithStr:@"验证码输入不正确，请重新输入"];
        }
    }
    
}
//3、验证码通过后，请求修改账号和密码
-(void)sureData
{
    AFNDebug
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"number"] = _phoneTextField.text;
    dict[@"password"] = [NSString string_md5:_passwordText.text];
    [CHNetWorking postWithUrl:forgetPassW refreshCache:YES params:dict success:^(id response) {
        if ((BOOL)response[@"success"] == TRUE) {
            //保存账号模型和归档
            
            //接着直接进入跳转页面
            
            [FormValidator showAlertWithStr:@"修改成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            //返回注册失败信息
        }
        
    } fail:^(NSError *error) {
        CHLog(@"失败%@",error);
    }];
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
