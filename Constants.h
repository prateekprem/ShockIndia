
/*
 This class is used to define various global constants used through out the project.
 */
// Contain webservices URL.


#import <UIKit/UIKit.h>
#define NSLog if(1) NSLog
//Production
#define kBaseUrl @"http://www.shockindia.co.in/"

#define kUserUrl @"user.php"
#define kStoryUrl @"story.php"
#define kFactUrl @"fact.php"
#define kPartyUrl @"party.php"
#define kLeaderUrl @"leader.php"
#define kOpinionUrl @"vote.php"
#define kQuizUrl @"question.php"
#define kLanguage @"English"
#define kShockUrl @"shock.php"
#define kShareUrl @"share.php"
#define kCommentUrl @"comment.php"
#define _APP_KEY @"612546062168079"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kActionProfileUpdate @"update"
#define kActionSignUp @"signup"
#define kActionLogin @"login"
#define kActionStoryAdd @"add_story"
#define kActionFactAdd @"add_fact"
#define kActionStoryGet @"get_story"
#define kActionFactGet @"get_fact"
#define kActionPartyGet @"get_party"
#define kActionLeaderGet @"get_leader"
#define kActionQuizGet @"get_question"
#define kActionOpinionPost @"vote"
#define kActionOpinionGet @"get_vote"
#define kActionShockPost @"add_shock"
#define kActionShockGet @"get_shock"

#define kActionSharePost @"add_share"
#define kActionshareGet @"get_share"
#define kActionCommentPost @"add_comment"
#define kActionCommentGet @"get_comment"


#define kRecipeType @"Recipes"
#define kProductType @"Products"


#define HEIGHT_IPHONE_5 568
#define HEIGHT_IPHONE_4 480
#define IS_IPHONE_5 ( [ [ UIScreen mainScreen ] bounds ].size.height == HEIGHT_IPHONE_5 )

typedef enum ServiceType
{
    None,
    ProfileUpdate,
    SignUp,
    LoginService,
    FetchStory,
    FetchFact,
    FetchParty,
    FetchLeader,
    AddStory,
    AddFact,
    AddPoll,
    FetchPoll,
    FetchQuiz,
    FetchShock,
    FetchShare,
    FetchComment,
    PostShock,
    PostShare,
    PostComment,
    
}ServiceType;

typedef enum MenuIcon
{
    Home,
    Party,
    Leader,
    Campaigns,
    MediaLibrary,
    AboutUs,
    
}MenuIcon;

