//
//  LoginVC.m
//  ZebramoReview
//
//  Created by aybek can kaya on 22/07/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    CHUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:CHUD];
    
    
    // Login test
    
   // [self loginWithMail:@"aybekcankaya@icloud.com" password:@"ackack123"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark TEXTFIELD DELEGATES 

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.view endEditing:YES];
    
    [self loginWithMail:self.tfEmail.text password:self.tfPassword.text];
    
    return YES;
}




/**
   @ look at LoginTests.m
 */
-(BOOL)validateInputsEmail:(NSString *)emailAddress password:(NSString *)passwordString
{
    NSString *email = emailAddress;
    NSString *password = passwordString;
    
    NSString *emailTrimmed = [email trimWhitespacesInString];
    NSString *passwordTrimmed = [password trimWhitespacesInString];
    
    
    if(emailTrimmed.length == 0)
    {
        NSString *message = @"Lütfen mail adresinizi boş bırakmayınız. ";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Zebramo" message:message delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    else if(passwordTrimmed.length == 0)
    {
        NSString *message = @"Lütfen şifre alanını boş bırakmayınız. ";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Zebramo" message:message delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    
    BOOL isValidEmail = [emailTrimmed isValidEmail];
    
    if(!isValidEmail)
    {
        NSString *message = @"Lütfen doğru bir e-posta adresi giriniz.";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Zebramo" message:message delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    
    return YES;
}


-(void)loginWithMail:(NSString *)email password:(NSString *)password
{
    
    if(![self validateInputsEmail:email password:password])
    {
        // if the inputs did not valid then stop. !!!
        return;
    }
    
    // User inputs
    
    NSString *emailTrimmed = [email trimWhitespacesInString];
    NSString *passwordTrimmed = [password trimWhitespacesInString];
    
    
   TFNetwork *network = [[TFNetwork alloc]init];
   
    
    
    NSDictionary *dctPost = @{@"email":emailTrimmed , @"password" : passwordTrimmed};
    
    
    [CHUD show:YES];
    
    __weak typeof(self) weakSelf = self;
    
    [network postQueryWithBlock:@"https://development.zebramo.com/auth/login" postDictionary:dctPost success:^(NSString *theUrlStr, NSHTTPURLResponse *response, NSString *JSONString) {
        
        [weakSelf handleLoginDataString:JSONString];
        
        
        [CHUD hide:YES];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        NSDictionary *userInfo = error.userInfo;
        NSDictionary *recovery = userInfo[@"NSLocalizedRecoverySuggestion"];
       
        if(recovery == nil)
        {
            NSString *message = @"Bir hata oluştu . Lütfen tekrar deneyiniz.";
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Zebramo" message:message delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            
            NSDictionary *dctData = [TFJson JsonToObject:recovery];
            NSDictionary *dctNotifications = dctData[@"notifications"];
            
            NSString *message = dctNotifications[@"message"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Zebramo" message:message delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
            [alert show];
        }
        
        
       
        
         [CHUD hide:YES];
        
    } timeOut:^(NSURLRequest *request, id JSON, float timeOutSeconds) {
        
        NSString *message = @"Bir hata oluştu . Lütfen tekrar deneyiniz.";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Zebramo" message:message delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        [alert show];
        
         [CHUD hide:YES];
    } reachabilityError:^(NSURLRequest *request, id JSON, float timeOutSeconds, NSError *err) {
        
        NSString *message = @"Lütfen internet bağlantınızı kontrol ederek tekrar deneyiniz. ";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Zebramo" message:message delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles: nil];
        [alert show];
        
         [CHUD hide:YES];
    }];

}


/**
    Look at LoginTests.m
 */
-(void)handleLoginDataString:(NSString *)dataString
{
    NSDictionary *dctAll = [TFJson JsonToObject:dataString];
    NSDictionary *dctUser = dctAll[@"user"];
    User *user = [[User alloc]initWithDictionary:dctUser];
    
    
    // next page
       
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginOnTap:(id)sender
{
    [self loginWithMail:self.tfEmail.text password:self.tfPassword.text];
    
    
}
@end
