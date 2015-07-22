//
//  ProfileVC.m
//  ZebramoReview
//
//  Created by aybek can kaya on 22/07/15.
//  Copyright (c) 2015 aybek can kaya. All rights reserved.
//

#import "ProfileVC.h"

@interface ProfileVC ()

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    
    [self initializeGUI];
    [self initializePickerViews];
    

  //  [self testUIWithPresuppliedUserObject:self.user];
    
  //  [self networkQueryForUserProfileInfoUserID:self.user.ID];
    
    [self initializeTestData];
    
    
}

// test data
-(void)initializeTestData
{
    DAL *oo = [[DAL alloc]initwithPlistName:@"JsonDataString"];
    NSString *json = [oo ReadFromPlistWithKey:@"sampleProfileJSON"];
    
    jsonDct = [TFJson JsonToObject:json];
    
    NSDictionary *dctUser = jsonDct[@"user_profile"];
    // set Up
    self.user = [[User alloc]initWithDictionary:dctUser];
    
    [self autoFillInputAreas];
}


-(void)testUIWithPresuppliedUserObject:(User *)user
{
    
}




#pragma mark GUI INIT

-(void)initializeGUI
{
    // view Show Surname BG Colors
    UIColor *offColor = [UIColor grayColor];
    UIColor *onColor = [UIColor colorWithR:54 G:215 B:183 A:1.0];
    arrColorsForShowSurname = @[offColor , onColor];
    
    
    // profile Image Borders
    self.imViewProfile.layer.borderColor = [UIColor grayColor].CGColor;
    self.imViewProfile.layer.borderWidth = 1.5;
    
    // textView
    self.twDescription.layer.borderWidth = 1.2;
    self.twDescription.layer.borderColor =[[UIColor grayColor]CGColor];
    
    
    // hud
    CHUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:CHUD];
    
    
    
    // tap gestures
    UITapGestureRecognizer *recTapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(profileImageDidTapped)];
    recTapImage.numberOfTapsRequired = 1;
    recTapImage.numberOfTouchesRequired = 1;
    [self.imViewProfile addGestureRecognizer:recTapImage];
    
    UITapGestureRecognizer *recTapViewSurname = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showSurnameDidTapped)];
    recTapViewSurname.numberOfTouchesRequired = 1;
    recTapViewSurname.numberOfTapsRequired = 1;
    [self.viewShowSurname addGestureRecognizer:recTapViewSurname];
    
    UITapGestureRecognizer *recTapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollViewOnTap)];
    recTapScroll.numberOfTapsRequired = 1;
    recTapScroll.numberOfTouchesRequired = 1;
    [self.scrollContents addGestureRecognizer:recTapScroll];
    
    
}


-(void)initializePickerViews
{
    pickerOverGarments = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    pickerOverGarments.delegate = self;
    pickerOverGarments.dataSource = self;
    
    
    pickerShoeSizes =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    pickerShoeSizes.delegate = self;
    pickerShoeSizes.dataSource = self;
    
    
    pickerUnderGarments = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
    pickerUnderGarments.delegate = self;
    pickerUnderGarments.dataSource = self;
    
    self.tfOvergarments.inputView = pickerOverGarments;
    self.tfUndergarments.inputView = pickerUnderGarments;
    self.tfShoeSize.inputView = pickerShoeSizes;
    
    
}


-(void)autoFillInputAreas
{
    
    if(self.user.displaySurname == NO)
    {
        UIColor *color = arrColorsForShowSurname[0];
        self.viewShowSurname.backgroundColor = color;
    }
    else
    {
        UIColor *color = arrColorsForShowSurname[1];
        self.viewShowSurname.backgroundColor = color;
    }
    
    
    self.tfName.text = self.user.forename;
    self.tfSurname.text = self.user.surname;
    if(self.user.email != nil)
    {
        self.tfEmail.text = self.user.email;
    }
    
    
    if(![self.user.descriptionUser isKindOfClass:[NSNull class]])
    {
         self.twDescription.text = self.user.descriptionUser;
    }
   
    
    //NSString *imageURL = self.user.imageURL;
    if(![self.user.imageURL isKindOfClass:[NSNull class]])
    {
        NSString *url = self.user.imageURL;
        [self.imViewProfile setImageWithURL:[NSURL URLWithString:url]];
    }
    
    if(![self.user.overgarments isKindOfClass:[NSNull class]])
    {
        self.tfOvergarments.text = self.user.overgarments;
    }
    
    if(![self.user.undergarments isKindOfClass:[NSNull class]])
    {
         self.tfUndergarments.text = self.user.undergarments;
    }
    
    if(![self.user.shoeSize isKindOfClass:[NSNull class]])
    {
         self.tfShoeSize.text = self.user.shoeSize;
    }
    
    
   
   
    
    // set up datas
    
    NSDictionary *dctUser = jsonDct[@"user_profile"];
    undergarments =dctUser[@"undergarments_options"];
    overgarments = dctUser[@"overgarments_options"];
    shoeSizes = dctUser[@"shoe_size_options"];
  
    
    [pickerShoeSizes reloadAllComponents];
    [pickerOverGarments reloadAllComponents];
    [pickerUnderGarments reloadAllComponents];
    
}


#pragma mark GESTURES 

-(void)profileImageDidTapped
{
    // Show take photo
}


-(void)showSurnameDidTapped
{
    if(self.user.displaySurname == YES)
    {
        self.user.displaySurname = NO;
        self.tfSurname.alpha = 0;
        UIColor *color = arrColorsForShowSurname[0];
        self.viewShowSurname.backgroundColor = color;
    }
    else
    {
        self.user.displaySurname = YES;
        self.tfSurname.alpha = 1;
        UIColor *color = arrColorsForShowSurname[1];
        self.viewShowSurname.backgroundColor = color;
    
    }
}


-(void)scrollViewOnTap
{
    [self.view endEditing:YES];
}


#pragma mark PICKERVIEW DELEGATES + DATASOURCES

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if([pickerView isEqual:pickerOverGarments])
    {
        return overgarments.count;
    }
    else if([pickerView isEqual:pickerUnderGarments])
    {
        return undergarments.count;
    }
    else if([pickerView isEqual:pickerShoeSizes])
    {
        return shoeSizes.count;
    }
    
    
    return 1;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if([pickerView isEqual:pickerOverGarments])
    {
        NSString *str = overgarments[row];
        return str;
    }
    else if([pickerView isEqual:pickerUnderGarments])
    {
        NSString *str = undergarments[row];
        return str;
    }
    else if([pickerView isEqual:pickerShoeSizes])
    {
        NSString *str = shoeSizes[row];
        return str;
    }

    
    
    return @"aaa";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([pickerView isEqual:pickerOverGarments])
    {
        NSString *str = overgarments[row];
        self.tfOvergarments.text = str;
    }
    else if([pickerView isEqual:pickerUnderGarments])
    {
        NSString *str = undergarments[row];
        self.tfUndergarments.text = str;
    }
    else if([pickerView isEqual:pickerShoeSizes])
    {
        NSString *str = shoeSizes[row];
        self.tfShoeSize.text = str;
    }

}


#pragma mark TEXTFIELD DELEGATES 

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}


#pragma mark TEXTVIEW DELEGATES





#pragma mark NETWORK

/**
    @description : get info with userID from webservice 
    @testNotes : - when writing tests use userID with different Values to get differeent types of datas .
                            - you may use user object as dependency , but it is not recomended.
 */
-(void)networkQueryForUserProfileInfoUserID:(int) userID
{
    
    [CHUD show:YES];
    
    TFNetwork *network = [[TFNetwork alloc]init];
    
    NSString *query = [NSString stringWithFormat:@"https://development.zebramo.com/users/%d/profile", userID];
    
     __weak typeof(self) weakSelf = self;
    [network jsonQueryWithBlock:query success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        [CHUD hide:YES];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
         [CHUD hide:YES];
    } timeOut:^(NSURLRequest *request, id JSON, float timeOutSeconds) {
        
         [CHUD hide:YES];
    } reachabilityError:^(NSURLRequest *request, id JSON, float timeOutSeconds, NSError *err) {
        
         [CHUD hide:YES];
    }];
    
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

- (IBAction)saveOnTap:(id)sender
{
    
}
@end
