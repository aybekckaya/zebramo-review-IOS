    //
//  DAL.m
//  GSK_IpadApp
//
//  Created by mac on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DAL.h"
#import "TFJson.h"

#define ENCRYPTION_ENABLED 0

@implementation DAL



@synthesize DatabaseName; 
@synthesize DatabasePath; 

//*************************************************************************************************************************************



-(id)initwithPlistName:(NSString *)plistname
{
    PlistName=plistname;
    [self CreatePlistIfNotExist:PlistName];
    return self;
}


//*************************************************************************************************************************************

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

//*************************************************************************************************************************************

- (void)viewDidLoad {
    [super viewDidLoad];
}

//*************************************************************************************************************************************

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return NO;
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//*************************************************************************************************************************************

- (void) createDatabaseIfItIsNotExist {
	
	BOOL success; // Check if the SQL database has already been saved to the users phone, if not then copy it over
	NSFileManager *fileManager = [NSFileManager defaultManager]; // Create a FileManager object, we will use this to check the status of the database and to copy it over if required
	success = [fileManager fileExistsAtPath:self.DatabasePath]; // Check if the database has already been created in the users filesystem
	
	if(success) return; // If the database already exists then return without doing anything
	// If not then proceed to copy the database from the application to the users filesystem
	
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.DatabaseName]; // Get the path to the database in the application package
	[fileManager copyItemAtPath:databasePathFromApp toPath:self.DatabasePath error:nil]; // Copy the database from the package to the users filesystem

}

//*************************************************************************************************************************************

-(void)CreatePlistIfNotExist:(NSString*)_PlistName
{
    NSString *_PlistNameWithExtension=[NSString stringWithFormat:@"%@.plist",_PlistName];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:_PlistNameWithExtension]; //3
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path]) //4
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:_PlistName ofType:@"plist"]; //5
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
    }
}

-(void)DeleteFromPlistWithKey: (NSString*)_Key
{
    NSString *_PlistNameWithExtension=[NSString stringWithFormat:@"%@.plist",PlistName];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:_PlistNameWithExtension]; //3
    
    
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    [savedStock removeObjectForKey:_Key];
    
    [savedStock writeToFile:path atomically:YES];

}

-(void)DeleteAllFromPlist
{
    NSString *_PlistNameWithExtension=[NSString stringWithFormat:@"%@.plist",PlistName];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:_PlistNameWithExtension]; //3
    
    
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    [savedStock removeAllObjects];
    
    [savedStock writeToFile:path atomically:YES];
}


/*
-(void)WriteToPlistWithKey:(NSString*)_Key Value:(id)Value
{
    
  NSString *_PlistNameWithExtension=[NSString stringWithFormat:@"%@.plist",PlistName];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:_PlistNameWithExtension]; //3
   
    // encrypt Value
    NSString *encryptedStr;
    if(![Value isKindOfClass:[NSString class]])
    {
        
        if([Value isKindOfClass:[NSNumber class]])
        {
            NSString *strValue=[Value stringValue];
            encryptedStr = [AESCrypt encrypt:strValue password:ENCRYPTION_PASSWORD];
        }
        else
        {
            // value is not string
            NSString *jsonString =[TFJson ObjectToJson:Value];
            encryptedStr = [AESCrypt encrypt:jsonString password:ENCRYPTION_PASSWORD];
        }
       
    }
    else
    {
        // pure encrypt
         encryptedStr = [AESCrypt encrypt:Value password:ENCRYPTION_PASSWORD];
    }
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
   
    //here add elements to data file and write data to file
    if (encryptedStr==nil) {
        encryptedStr=[NSString stringWithFormat:@""];
    }
    
    
    if(ENCRYPTION_ENABLED == 1)
    {
          [data setObject:encryptedStr forKey:_Key];
    }
    else
    {
          [data setObject:Value forKey:_Key];
    }
  
    
    [data writeToFile: path atomically:YES];
    
}

*/

-(id)ReadFromPlistWithKey:(NSString *)_Key
{
  NSString *_PlistNameWithExtension=[NSString stringWithFormat:@"%@.plist",PlistName];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:_PlistNameWithExtension]; //3
    
    
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    //load from savedStock example int value
    
    NSString *encryptedString = [savedStock objectForKey:_Key];
    
    if(ENCRYPTION_ENABLED == 0)
    {
        return encryptedString;
    }
    
    NSString *value = encryptedString;
    
    return value;
    
}


-(NSArray *)AllKeysInPList
{
   // NSString *path = [[NSBundle mainBundle] pathForResource:PlistName ofType:@"plist"];
    NSString *_PlistNameWithExtension=[NSString stringWithFormat:@"%@.plist",PlistName];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:_PlistNameWithExtension]; //3
    
    NSDictionary *myDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    //NSLog(@"%@",[myDictionary description]);
    return [myDictionary allKeys];
}


-(int)NumberOfKeysInPList
{
    return [[self AllKeysInPList]count];
}

-(BOOL)KeyExists:(NSString *)Key
{
    NSArray *allkeys=[self AllKeysInPList];
    for(NSString *key in allkeys)
    {
        if([key isEqualToString:Key])
        {
            return YES;
        }
    }
    
    return NO;
}


@end
