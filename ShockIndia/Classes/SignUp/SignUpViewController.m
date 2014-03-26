//
//  SignUpViewController.m
//  ShockIndia
//
//  Created by Divya Sharma on 05/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "ServerController.h"
#import "SignUpViewController.h"
#import "Global.h"
#import "LoadingViewFB.h"
#import "HomeViewController.h"
#define kOFFSET_FOR_KEYBOARD 90.0+kMarginIphone5
#import "SWRevealViewController.h"
#import "TermAndConditionController.h"
#define kAlertMsg @"passwords should be same  "
#import "User.h"
@interface SignUpViewController ()
- (void)callSignUpService;
- (void)callLoginService;
- (void)loadHomeView;
@end

@implementation SignUpViewController
@synthesize splashView = splashView_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)cancelNumberPad{
    [self.txtPhone resignFirstResponder];
    self.txtPhone.text = @"";
}

-(void)doneWithNumberPad{
    [self.txtEmailId becomeFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.txtPhone.inputAccessoryView = numberToolbar;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"launch"]) {
        [self showSplash];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"launch"];
    }
    [self updateView];
    
       if (!appDelegate.session.isOpen) {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                // we recurse here, in order to update buttons and labels
                [self updateView];
            }];
        }
    }
    // Do any additional setup after loading the view from its nib.
}
// FBSample logic
// main helper method to update the UI to reflect the current state of the session.
- (void)updateView {
    // get the app delegate, so that we can reference the session property
    
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = TRUE;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.txtName) {
        [self.txtPassword becomeFirstResponder];
    }
   else if(textField==self.txtPassword ) {
        [self.txtConfirnPassword becomeFirstResponder];
        
    }
   else if (textField==self.txtConfirnPassword) {
       if ([self.txtPassword.text isEqualToString:self.txtConfirnPassword.text]) {
          
           [self.txtPhone becomeFirstResponder];
       }
       else if (textField==self.txtPhone) {
          
               
               [self.txtPhone becomeFirstResponder];
       }
       else
       {
           UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:kAlertMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
           [alertView show];
       }
       

        }
    else if (textField==self.txtEmailId)
    {
        
        [textField resignFirstResponder];
    
    }
   
  
    
        
    
    return YES;
   
   

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];

}
-(BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; //  return 0;
    return [emailTest evaluateWithObject:candidate];
}

- (IBAction)signUp:(id)sender
{
    if ([self.txtName.text length]&&[self.txtPassword.text length]&&[self.txtConfirnPassword.text length]&&([self.txtPhone.text length]||[self.txtEmailId.text length]) )
   {
       if ([self.txtEmailId.text length]) {
           if (![self validateEmail:self.txtEmailId.text]) {
               UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter a valid email id." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
               [alertView show];
               return;
           }
       }
        [self callSignUpService];
   }
   else
   {
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the required information." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
       [self loadHomeView];
    }

}
- (void)callSignUpService
{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.txtName.text,@"name",self.txtPassword.text,@"password",self.txtPhone.text,@"mobile",self.txtEmailId.text,@"email",kActionSignUp,@"action", nil];
    [dict setObject:[NSString stringWithFormat:@"%d",SignUp] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kUserUrl userInfo:dict withSelector:@selector(loadHomeView) delegate:self];
    
}
- (void)callLoginService
{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.txtName.text,@"name",self.txtPassword.text,@"password",@"",@"mobile",self.txtEmailId.text,@"email",@"login",@"action", nil];
    [dict setObject:[NSString stringWithFormat:@"%d",LoginService] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kUserUrl userInfo:dict withSelector:@selector(loadHomeView) delegate:self];
}

- (void)loadHomeView
{
    
    User *obj = [[User alloc]init];
    obj.user_name = self.txtName.text;
    obj.user_phone = self.txtPhone.text;
    [[NSUserDefaults standardUserDefaults]setObject:self.txtName.text forKey:@"user_name"];
    obj.user_email = self.txtEmailId.text;
    obj.user_id = [[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]integerValue];
    [[DataBaseController sharedController]insertingDataIntoMyProfileTable:obj];
    if (IS_IPHONE_5) {
        HomeViewController *termAndCondition=[[HomeViewController alloc]initWithNibName:@"HomeViewController1" bundle:nil];
        [self.navigationController pushViewController:termAndCondition animated:YES];
    }else{
        HomeViewController *termAndCondition=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
        [self.navigationController pushViewController:termAndCondition animated:YES];
    }
    
}
    
#pragma mark facebook
//
//- (void)fbGraphCallback:(id)sender {
//	
//	if ( (self.fbGraph.accessToken == nil) || ([self.fbGraph.accessToken length] == 0) ) {
//		
//		NSLog(@"You pressed the 'cancel' or 'Dont Allow' button, you are NOT logged into Facebook...I require you to be logged in & approve access before you can do anything useful....");
//		
//		//restart the authentication process.....
//
//        [self.fbGraph authenticateUserWithCallbackObject:self andSelector:@selector(fbGraphCallback:) andExtendedPermissions:@"user_photos,user_videos,publish_stream,offline_access,user_checkins,friends_checkins,email,user_location,read_stream,share_item,status_update" andSuperView:self.view];
//		
//	}
//	else
//	{
//		
//		
//		NSLog(@"------------>CONGRATULATIONS<------------, You're logged into Facebook...  Your oAuth token is:  %@", self.fbGraph.accessToken);
//		FbGraphResponse *fb_graph_response = [self.fbGraph doGraphGet:@"me" withGetVars:nil];
//        NSError *error = nil;
//        NSDictionary *response_dict = [NSJSONSerialization JSONObjectWithData:fb_graph_response.htmlResponse options: NSJSONReadingMutableContainers error: &error];
//        self.txtName.text =[response_dict objectForKey:@"name"];
//        self.txtEmailId.text = [response_dict objectForKey:@"email"];
//        User *obj = [[User alloc]init];
//        obj.user_name = self.txtName.text;
//        if ([response_dict objectForKey:@"location"]) {
//            obj.user_address = [[response_dict objectForKey:@"location"]objectForKey:@"name"];
//        }
//        obj.user_phone = [response_dict objectForKey:@"phone"];
//        obj.user_email = self.txtEmailId.text;
//        obj.user_fb_link = [response_dict objectForKey:@"link"];
//        obj.user_gender  = [response_dict objectForKey:@"gender"];
//        obj.user_id = [[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]integerValue];
//        [[DataBaseController sharedController]insertingDataIntoMyProfileTable:obj];
//        
//       
//        
//        [self callSignUpService];
//        
//	}
//	
//}
- (void)showSplash
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0, 320, 568)];
    webView.scalesPageToFit = TRUE;
    NSString *imagePath = [[NSBundle mainBundle] pathForResource: @"splash" ofType: @"gif"];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    [webView setUserInteractionEnabled:NO];
    [webView loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    
    self.splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 568)];
    self.splashView.image = [UIImage imageNamed:@"Default-568h@2x.png"];
	[ self.splashView addSubview:webView];
    [self.view addSubview:self.splashView];
    
    [self performSelector:@selector(removeSplash) withObject:nil afterDelay:4];
    
}
- (void)removeSplash
{
    [self.splashView removeFromSuperview];
}
- (IBAction)termstap:(id)sender
{

    TermAndConditionController *termAndCondition=[[TermAndConditionController alloc]initWithNibName:@"TermAndConditionController" bundle:nil];
    [self.navigationController pushViewController:termAndCondition animated:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == self.txtName) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 20.0), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }     else if (textField==self.txtPassword) {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 20.0), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];    }
    else if (textField==self.txtConfirnPassword) {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 20.0), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    
    
    
    if (textField==self.txtEmailId) {
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 120.0), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    else if (textField==self.txtPhone) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame = CGRectMake(self.view.frame.origin.x, (self.view.frame.origin.y - 120.0), self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
    
  
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
    
}
// When the button is clicked, make sure we have a valid session and
// call sendRequests.
//
- (IBAction)loginUsingFaceBook:(id)sender {
    // FBSample logic
    // Check to see whether we have already opened a session.
    if (FBSession.activeSession.isOpen) {
        // login is integrated with the send button -- so if open, we send
        [self sendRequests];
    } else {
        [FBSession openActiveSessionWithReadPermissions:nil
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session,
                                                          FBSessionState status,
                                                          NSError *error) {
                                          // if login fails for any reason, we alert
                                          if (error) {
                                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                              message:error.localizedDescription
                                                                                             delegate:nil
                                                                                    cancelButtonTitle:@"OK"
                                                                                    otherButtonTitles:nil];
                                              [alert show];
                                              // if otherwise we check to see if the session is open, an alternative to
                                              // to the FB_ISSESSIONOPENWITHSTATE helper-macro would be to check the isOpen
                                              // property of the session object; the macros are useful, however, for more
                                              // detailed state checking for FBSession objects
                                          } else if (FB_ISSESSIONOPENWITHSTATE(status)) {
                                              // send our requests if we successfully logged in
                                              [self sendRequests];
                                          }
                                      }];
    }
}

// FBSample logic
// Read the ids to request from textObjectID and generate a FBRequest
// object for each one.  Add these to the FBRequestConnection and
// then connect to Facebook to get results.  Store the FBRequestConnection
// in case we need to cancel it before it returns.
//
// When a request returns results, call requestComplete:result:error.
//
- (void)sendRequests {
    // extract the id's for which we will request the profile
   
   
    
    // create the connection object
    FBRequestConnection *newConnection = [[FBRequestConnection alloc] init];
    
    // for each fbid in the array, we create a request object to fetch
    // the profile, along with a handler to respond to the results of the request
    
        // create a handler block to handle the results of the request for fbid's profile
        FBRequestHandler handler =
        ^(FBRequestConnection *connection, id result, NSError *error) {
            // output the results of the request
            self.fbid = @"DivyaSharma1011";
            [self requestCompleted:connection forFbID: self.fbid result:result error:error];
        };
        
        // create the request object, using the fbid as the graph path
        // as an alternative the request* static methods of the FBRequest class could
        // be used to fetch common requests, such as /me and /me/friends
        FBRequest *request = [[FBRequest alloc] initWithSession:FBSession.activeSession
                                                      graphPath: self.fbid];
        
        // add the request to the connection object, if more than one request is added
        // the connection object will compose the requests as a batch request; whether or
        // not the request is a batch or a singleton, the handler behavior is the same,
        // allowing the application to be dynamic in regards to whether a single or multiple
        // requests are occuring
        [newConnection addRequest:request completionHandler:handler];
    
    // if there's an outstanding connection, just cancel
    [self.requestConnection cancel];
    
    // keep track of our connection, and start it
    self.requestConnection = newConnection;
    [newConnection start];
}

// FBSample logic
// Report any results.  Invoked once for each request we make.
- (void)requestCompleted:(FBRequestConnection *)connection
                 forFbID:fbID
                  result:(id)result
                   error:(NSError *)error {
    // not the completion we were looking for...
    if (self.requestConnection &&
        connection != self.requestConnection) {
        return;
    }
    
    // clean this up, for posterity
    self.requestConnection = nil;
    
    
    NSString *text;
    if (error) {
        // error contains details about why the request failed
        text = error.localizedDescription;
    } else {
        // result is the json response from a successful request
        NSDictionary *dictionary = (NSDictionary *)result;
        // we pull the name property out, if there is one, and display it
        text = (NSString *)[dictionary objectForKey:@"name"];
        NSLog(@"%@",dictionary);

    }
   
}

@end
