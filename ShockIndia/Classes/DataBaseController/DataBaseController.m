//
//  DataBaseController.m
//  MrsDash
//
//  Created by shahnwaz on 1/17/13.
//  Copyright (c) 2013 Kiwitech. All rights reserved.
//
#import "ServerController.h"
#import "DataBaseController.h"
#import "LoadingViewFB.h"
#import "AppDelegate.h"
#import "User.h"
#import "UserManagedObject.h"
#import "StoryManagedObject.h"
#import "Story.h"
#import "QuestionsManagedObject.h"
#import "Question.h"
#import "QuizManagedObject.h"
#import "Quiz.h"
#import "PartiesManagedObject.h"
#import "Parties.h"
#import "LeadersManagedObject.h"
#import "Leaders.h"
#import "CampaignManagedObject.h"
#import "Campaign.h"
#import "PostManagedObject.h"
#import "Post.h"
#import "OptionsManagedObject.h"
#import "Options.h"
#import "DiscussionManagedObject.h"
#import "Discussion.h"
#import "FactsManagedObject.h"
#import "Fact.h"
#import "PhotosManagedObject.h"
#import "Photos.h"
#import "VideosManagedObject.h"
#import "Videos.h"
#import "Parties.h"
@interface DataBaseController ()
{
    NSManagedObjectContext* context;
}
@end

@implementation DataBaseController
#pragma mark -
#pragma mark User Define Method

static DataBaseController* _dataBaseController;
+ (DataBaseController*)sharedController
{
	@synchronized(self)
    {
        if (_dataBaseController == nil)
        {
            _dataBaseController=[[self alloc] init];
        }
    }
    return _dataBaseController;
}

-(void)allocatingObjectContext
{
    if (context==nil)
        context= [appDelegate managedObjectContext];
}
- (User *)getMyProfileData;
{
    NSArray *fetchResults;
    NSString *entityName=@"UserManagedObject";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchResults = [NSArray arrayWithArray:[context executeFetchRequest:fetchRequest error:nil]];
    User *obj = [[User alloc]init];

    for (UserManagedObject *user in fetchResults)
    {
        obj.user_twitter_link = user.user_twitter_link;
        obj.user_name = user.user_name;
        obj.user_phone = user.user_phone;
        obj.user_political_view = user.user_political_view;
        obj.user_photo = user.user_photo;
        obj.user_gender = user.user_gender;
        obj.user_fb_link = user.user_fb_link;
        obj.user_id = [user.user_id integerValue];
        obj.user_country = user.user_country;
        obj.user_age = user.user_age;
        obj.user_address = user.user_address;
        obj.user_email = user.user_email;

    }
    
    return obj;

    
}

- (NSArray *)getStoryData
{
    
    NSMutableArray *fetchResults = [[NSMutableArray alloc]init];
    NSString *entityName=@"StoryManagedObject";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *array = [[NSArray arrayWithArray:[context executeFetchRequest:fetchRequest error:nil]]mutableCopy];
    for (StoryManagedObject *story in array)
    {
        Story *obj = [[Story alloc]init];
        obj.story_name = story.story_name;
        obj.story_pic = story.story_pic;
        obj.story_posted_by = story.story_posted_by;
        obj.story_posted_on = story.story_posted_on;
        obj.story_shares = story.story_shares;
        obj.story_shocks = story.story_shocks;
        obj.story_video_link = story.story_video_link;
        obj.story_id = [story.story_id integerValue];
        obj.story_detail = story.story_detail;
        obj.story_comments = story.story_comments;
        [fetchResults addObject:obj];
    }
    return fetchResults;
}
- (NSArray *)getQuestionData
{
    NSMutableArray *fetchResults;
    NSString *entityName=@"QuestionsManagedObject";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchResults = [[NSArray arrayWithArray:[context executeFetchRequest:fetchRequest error:nil]]mutableCopy];
    
    return fetchResults;
}
- (NSArray *)getQuizData
{
    NSMutableArray *fetchResults;
    NSString *entityName=@"QuizManagedObject";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchResults = [[NSArray arrayWithArray:[context executeFetchRequest:fetchRequest error:nil]]mutableCopy];
    
    return fetchResults;
}
- (NSArray *)getPartiesData
{
    NSMutableArray *fetchResults = [[NSMutableArray alloc]init];
    NSString *entityName=@"PartiesManagedObject";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *array = [[NSArray arrayWithArray:[context executeFetchRequest:fetchRequest error:nil]]mutableCopy];

    for (PartiesManagedObject *parties in array)
    {
        Parties *partiesManagedObject = [[Parties alloc]init];
        partiesManagedObject.parties_id=[parties.parties_id integerValue];
        partiesManagedObject.parties_name=parties.parties_name;
        partiesManagedObject.parties_short_name=parties.parties_short_name;
        partiesManagedObject.parties_type = parties.parties_type;
        partiesManagedObject.parties_images=parties.parties_images;
        
        partiesManagedObject.parties_icon=parties.parties_icon;
        partiesManagedObject.parties_detail=parties.parties_detail;
        partiesManagedObject.parties_fb=parties.parties_fb;
        partiesManagedObject.parties_twitter=parties.parties_twitter;
        partiesManagedObject.parties_website=parties.parties_website;
        [fetchResults addObject:partiesManagedObject];
    }
    
    return fetchResults;
}
- (NSArray *)getLeadersData
{
    NSMutableArray *fetchResults = [[NSMutableArray alloc]init];
    NSString *entityName=@"LeadersManagedObject";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *array = [[NSArray arrayWithArray:[context executeFetchRequest:fetchRequest error:nil]]mutableCopy];
    for (LeadersManagedObject *leader in array)
    {
        Leaders *leadersManagedObject = [[Leaders alloc]init];
        leadersManagedObject.leaders_id=[leader.leaders_id integerValue];
        leadersManagedObject.leaders_name=leader.leaders_name;
        leadersManagedObject.leaders_images=leader.leaders_images;
        leadersManagedObject.leaders_icon=leader.leaders_icon;
        leadersManagedObject.leaders_detail=leader.leaders_detail;
        leadersManagedObject.leaders_fb=leader.leaders_fb;
        leadersManagedObject.leaders_twitter=leader.leaders_twitter;
        leadersManagedObject.leaders_website=leader.leaders_website;
        [fetchResults addObject:leadersManagedObject];
    }
    
    return fetchResults;
}
- (NSArray *)getCampaignData
{
    NSMutableArray *fetchResults = [[NSMutableArray alloc]init];
    NSString *entityName=@"CampaignManagedObject";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchResults = [[NSArray arrayWithArray:[context executeFetchRequest:fetchRequest error:nil]]mutableCopy];
    
    return fetchResults;
}
- (NSArray *)getPostData
{
    NSMutableArray *fetchResults = [[NSMutableArray alloc]init];
    NSString *entityName=@"PostManagedObject";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchResults = [[NSArray arrayWithArray:[context executeFetchRequest:fetchRequest error:nil]]mutableCopy];
    
    return fetchResults;
}
- (NSArray *)getOptionData
{
    NSMutableArray *fetchResults = [[NSMutableArray alloc]init];
    NSString *entityName=@"OptionsManagedObject";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchResults = [[NSArray arrayWithArray:[context executeFetchRequest:fetchRequest error:nil]]mutableCopy];
    
    return fetchResults;
}
- (NSArray *)getDiscussionData
{
    NSMutableArray *fetchResults = [[NSMutableArray alloc]init];
    NSString *entityName=@"DiscussionManagedObject";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchResults = [[NSArray arrayWithArray:[context executeFetchRequest:fetchRequest error:nil]]mutableCopy];
    
    return fetchResults;
}
- (NSArray *)getFactData
{
    NSMutableArray *fetchResults = [[NSMutableArray alloc]init];
    NSString *entityName=@"FactsManagedObject";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *array = [[NSArray arrayWithArray:[context executeFetchRequest:fetchRequest error:nil]]mutableCopy];
    
    for (FactsManagedObject *facts in array)
    {
        Fact *fact = [[Fact alloc]init];
        fact.fact_id=[facts.fact_id integerValue];
        fact.fact_name=facts.fact_name;
        fact.fact_comments=facts.fact_comments;
        
        fact.fact_detail=facts.fact_detail;
        fact.fact_pics=facts.fact_pics;
        fact.fact_posted_by=facts.fact_posted_by;
        fact.fact_posted_on=facts.fact_posted_on;
        fact.fact_shares=facts.fact_shares;
        [fetchResults addObject:fact];
        if ([fetchResults count]==50) {
            break;
        }
    }
    return fetchResults;
}
- (NSArray *)getPhotosData
{
    NSMutableArray *fetchResults;
    NSString *entityName=@"PhotosManagedObject";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchResults = [[NSArray arrayWithArray:[context executeFetchRequest:fetchRequest error:nil]]mutableCopy];
    
    return fetchResults;
}
- (NSArray *)getVideosData
{
    NSMutableArray *fetchResults;
    NSString *entityName=@"VideosManagedObject";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchResults = [[NSArray arrayWithArray:[context executeFetchRequest:fetchRequest error:nil]]mutableCopy];
    
    return fetchResults;
}

-(void)insertingDataIntoMyProfileTable:(User *)user
{
        UserManagedObject* userManagedObject=(UserManagedObject*)[NSEntityDescription insertNewObjectForEntityForName:@"UserManagedObject" inManagedObjectContext:context];
       userManagedObject.user_id=[NSNumber numberWithInt:user.user_id];
       userManagedObject.user_name=user.user_name;
       userManagedObject.user_age= user.user_age;
       userManagedObject.user_address=user.user_address;
       userManagedObject.user_country=user.user_country;
       userManagedObject.user_email=user.user_email;
       userManagedObject.user_phone=user.user_phone;
       userManagedObject.user_political_view=user.user_political_view;
       userManagedObject.user_gender=user.user_gender;
       userManagedObject.user_photo=user.user_photo;
       userManagedObject.user_fb_link=user.user_fb_link;
       userManagedObject.user_twitter_link=user.user_twitter_link;
        NSError *error;
       [context save:&error];
}
-(void)insertingDataIntoStoryTable:(Story*)story
{
    if (!story.story_id) {
        return;
    }
    
    StoryManagedObject* storyManagedObject=(StoryManagedObject*)[NSEntityDescription insertNewObjectForEntityForName:@"StoryManagedObject" inManagedObjectContext:context];
    storyManagedObject.story_id=[NSNumber numberWithInt:story.story_id];
     storyManagedObject.story_name=story.story_name;
     storyManagedObject.story_detail=story.story_detail;
     storyManagedObject.story_comments=story.story_comments;
     storyManagedObject.story_pic=story.story_pic;
     storyManagedObject.story_posted_by=story.story_posted_by;
     storyManagedObject.story_posted_on=story.story_posted_on;
     storyManagedObject.story_shocks=story.story_shocks;
     storyManagedObject.story_video_link=story.story_video_link;
     storyManagedObject.story_shares=story.story_shares;
    NSError*error;
    [context save:&error];


}
-(void)insertingDataIntoQuestionTable:(Question*)question
{
    QuestionsManagedObject *questionManagedObject=(QuestionsManagedObject*)[NSEntityDescription insertNewObjectForEntityForName:@"QuestionsManagedObject" inManagedObjectContext:context];
    questionManagedObject.question_id=[NSNumber numberWithInt:question.question_id];
    questionManagedObject.quiz_id=[NSNumber numberWithInt:question.quiz_id];
    questionManagedObject.question_name=question.question_name;
    questionManagedObject.question_photo=question.question_photo;
    NSError *error;
    [context save:&error];
    


}
-(void)insertingDataIntoQuizTable:(Quiz*)quiz
{

    QuizManagedObject* quizManagedObject=(QuizManagedObject*)[NSEntityDescription insertNewObjectForEntityForName:@"QuizManagedObject" inManagedObjectContext:context];
    quizManagedObject.quiz_id=[NSNumber numberWithInt:quiz.quiz_id];
    quizManagedObject.quiz_name=quiz.quiz_name;
    quizManagedObject.quiz_no_of_questions=[NSNumber numberWithInt:quiz.quiz_no_of_questions];

    quizManagedObject.quiz_photos=quiz.quiz_photos;
    quizManagedObject.quiz_posted_by=quiz.quiz_posted_by;
    quizManagedObject.quiz_posted_on=quiz.quiz_posted_on;
    
    NSError*error;
    [context save:&error];

}
-(void)insertingDataIntoPartiesTable:(Parties*)parties
{
    
    PartiesManagedObject* partiesManagedObject=(PartiesManagedObject*)[NSEntityDescription insertNewObjectForEntityForName:@"PartiesManagedObject" inManagedObjectContext:context];
    partiesManagedObject.parties_id=[NSNumber numberWithInt:parties.parties_id];
    partiesManagedObject.parties_name=parties.parties_name;
    partiesManagedObject.parties_images=parties.parties_images;
    partiesManagedObject.parties_short_name = parties.parties_short_name;
    partiesManagedObject.parties_type = parties.parties_type;
    partiesManagedObject.parties_icon=parties.parties_icon;
    partiesManagedObject.parties_detail=parties.parties_detail;
        partiesManagedObject.parties_fb=parties.parties_fb;
        partiesManagedObject.parties_twitter=parties.parties_twitter;
        partiesManagedObject.parties_website=parties.parties_website;
    NSError*error;
    [context save:&error];
    
}
-(void)insertingDataIntoLeaderTable:(Leaders*)leader
{
     LeadersManagedObject* leadersManagedObject=(LeadersManagedObject*)[NSEntityDescription insertNewObjectForEntityForName:@"LeadersManagedObject" inManagedObjectContext:context];
    leadersManagedObject.leaders_id=[NSNumber numberWithInt:leader.leaders_id];
    leadersManagedObject.leaders_name=leader.leaders_name;
    leadersManagedObject.leaders_images=leader.leaders_images;
    leadersManagedObject.leaders_icon=leader.leaders_icon;
    leadersManagedObject.leaders_detail=leader.leaders_detail;
    leadersManagedObject.leaders_fb=leader.leaders_fb;
    leadersManagedObject.leaders_twitter=leader.leaders_twitter;
    leadersManagedObject.leaders_website=leader.leaders_website;
    NSError*error;
    [context save:&error];
}
-(void)insertingDataIntoCampaignTable:(Campaign*)campaign
{
    CampaignManagedObject* campaignManagedObject=(CampaignManagedObject*)[NSEntityDescription insertNewObjectForEntityForName:@"CampaignManagedObject" inManagedObjectContext:context];
    
    campaignManagedObject.campaign_id=[NSNumber numberWithInt:campaign.campaign_id];
    campaignManagedObject.campaign_name=campaign.campaign_name;
    campaignManagedObject.campaign_icon=campaign.campaign_icon;
    campaignManagedObject.campaign_photos=campaign.campaign_photos;
    campaignManagedObject.campaign_strength=campaign.campaign_strength;
    campaignManagedObject.campaign_time=campaign.campaign_time;
    campaignManagedObject.campaign_venue=campaign.campaign_venue;
    campaignManagedObject.campaign_host=campaign.campaign_host;
    campaignManagedObject.campaign_detail=campaign.campaign_detail;
    campaignManagedObject.campaign_video=campaign.campaign_video;
    campaignManagedObject.campaign_cause=campaign.campaign_cause;
    NSError*error;
    [context save:&error];
}
-(void)insertingDataIntoPostTable:(Post*)post
{
  PostManagedObject* postManagedObject=(PostManagedObject*)[NSEntityDescription insertNewObjectForEntityForName:@"PostManagedObject" inManagedObjectContext:context];
    postManagedObject.post_id=[NSNumber numberWithInt:post.post_id];
    postManagedObject.discussion_id=[NSNumber numberWithInt:post.discussion_id];
    postManagedObject.post_name=post.post_name;
    
    postManagedObject.post_detail=post.post_detail;

    postManagedObject.post_on=post.post_on;

    postManagedObject.post_by=post.post_by;
    NSError*error;
    [context save:&error];
   }
-(void)insertingDataIntoOptionTable:(Options*)options
{

    OptionsManagedObject* optionManagedObject=(OptionsManagedObject*)[NSEntityDescription insertNewObjectForEntityForName:@"OptionsManagedObject" inManagedObjectContext:context];
    optionManagedObject.option_id=[NSNumber numberWithInt:options.option_id];
    optionManagedObject.question_id=[NSNumber numberWithInt:options.question_id];
    optionManagedObject.option_name=options.option_name;
    optionManagedObject.option_photo=options.option_photo;
    optionManagedObject.is_answer=options.is_answer;
    NSError*error;
    [context save:&error];

}

-(void)insertingDataIntoDiscussionTable:(Discussion*)discussion
{
    
    
    DiscussionManagedObject* discussionManagedObject=(DiscussionManagedObject*)[NSEntityDescription insertNewObjectForEntityForName:@"DiscussionManagedObject" inManagedObjectContext:context];
    discussionManagedObject.discussion_id=[NSNumber numberWithInt:discussion.discussion_id];
    discussionManagedObject.discussion_detail=discussion.discussion_detail;
       discussionManagedObject.discussion_icon=discussion.discussion_icon;
       discussionManagedObject.discussion_topic=discussion.discussion_topic;
       discussionManagedObject.discussion_users=discussion.discussion_users;
       discussionManagedObject.discussion_created_on=discussion.discussion_created_on;
       discussionManagedObject.discussion_by=discussion.discussion_by;
    NSError*error;
    [context save:&error];
    
    
}

-(void)insertingDataIntoFactTable:(Fact*)fact
{
    
    
    FactsManagedObject* factManagedObject=(FactsManagedObject*)[NSEntityDescription insertNewObjectForEntityForName:@"FactsManagedObject" inManagedObjectContext:context];
    factManagedObject.fact_id=[NSNumber numberWithInt:fact.fact_id];
    factManagedObject.fact_name=fact.fact_name;
    factManagedObject.fact_detail=fact.fact_detail;

    factManagedObject.fact_pics=fact.fact_pics;

    factManagedObject.fact_comments=fact.fact_comments;

    factManagedObject.fact_posted_on=fact.fact_posted_on;

    factManagedObject.fact_posted_by=fact.fact_posted_by;

    factManagedObject.fact_shares=fact.fact_shares;

    factManagedObject.fact_shocks=fact.fact_shocks;
    factManagedObject.fact_video_link=fact.fact_video_link;

    NSError*error;
    [context save:&error];
    

    
    
}

-(void)insertingDataIntoPhotosTable:(Photos*)photos
{
    
    
    PhotosManagedObject* photoManagedObject=(PhotosManagedObject*)[NSEntityDescription insertNewObjectForEntityForName:@"PhotosManagedObject" inManagedObjectContext:context];
    
    photoManagedObject.photo_id=[NSNumber numberWithInt:photos.photo_id];
    photoManagedObject.photo_name=photos.photo_name;
    photoManagedObject.photo_detail=photos.photo_detail;
    photoManagedObject.photo_link=photos.photo_link;
    photoManagedObject.photo_path=photos.photo_path;
    photoManagedObject.photo_posted_by=photos.photo_posted_by;
    photoManagedObject.photo_time=photos.photo_time;
    photoManagedObject.photo_shocks=photos.photo_shocks;
    photoManagedObject.photo_shares=photos.photo_shares;
    photoManagedObject.photo_comments=photos.photo_comments;
    NSError*error;
    [context save:&error];
    
}

-(void)insertingDataIntoVideosTable:(Videos*)videos
{
   VideosManagedObject* videoManagedObject=(VideosManagedObject*)[NSEntityDescription insertNewObjectForEntityForName:@"VideosManagedObject" inManagedObjectContext:context];
    
    videoManagedObject.video_id=[NSNumber numberWithInt:videos.video_id];
    videoManagedObject.video_name=videos.video_name;
      videoManagedObject.video_link=videos.video_link;
      videoManagedObject.video_path=videos.video_path;
      videoManagedObject.video_detail=videos.video_detail;
      videoManagedObject.video_posted_by=videos.video_posted_by;
      videoManagedObject.video_shocks=videos.video_shocks;
      videoManagedObject.video_shares=videos.video_shares;
      videoManagedObject.video_time=videos.video_time;
      videoManagedObject.video_thumbnail=videos.video_thumbnail;
      videoManagedObject.video_comments=videos.video_comments;
    NSError*error;
    [context save:&error];
}


@end
