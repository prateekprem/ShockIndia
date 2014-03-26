//
//  QuizViewController.m
//  ShockIndia
//
//  Created by Divya Sharma on 02/03/14.
//  Copyright (c) 2014 Divya Sharma. All rights reserved.
//

#import "QuizViewController.h"
#import "Global.h"
#import "Question.h"
#import "ProfileViewController.h"
#import "AnimateViews.h"
@interface QuizViewController ()
- (void)getQuizService;
@end

@implementation QuizViewController
@synthesize questionNoArray = questionNoArray_;
@synthesize strCorrectOption = strCorrectOption_;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)getarray:(NSArray *)array
{
    self.answerbtn1.hidden = FALSE;
    self.answerbtn2.hidden = FALSE;
    self.answerbtn3.hidden = FALSE;
    self.questionLabel.hidden = FALSE;
    self.questionNoLabel.hidden = FALSE;
    self.lblpoints.hidden = FALSE;
    self.lblPointText.hidden = FALSE;
    self.questiontitleLabel.hidden = FALSE;
    self.questionNoArray = [array mutableCopy];
    [self setViewReload];
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    points = 0;
    self.lblpoints.text = @"0";
    [self getQuizService];
    [[Global sharedController]addTopBar:self];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getQuizService
{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithObjectsAndKeys:kActionQuizGet,@"action", nil];
    [dict setObject:[NSString stringWithFormat:@"%d",FetchQuiz] forKey:@"requestType"];
    [[ServerController sharedController]callWebServiceGetJsonResponse:kQuizUrl userInfo:dict withSelector:@selector(getarray:) delegate:self];

}
- (IBAction)btn1Clicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [self performSelector:@selector(goToNextQuestion:) withObject:sender afterDelay:1];
    self.answerbtn1.userInteractionEnabled=NO;
       self.answerbtn2.userInteractionEnabled=NO;
       self.answerbtn3.userInteractionEnabled=NO;
}
- (IBAction)btn2Clicked:(UIButton *)sender

{
    sender.selected = !sender.selected;
    [self performSelector:@selector(goToNextQuestion:) withObject:sender afterDelay:1];
    self.answerbtn1.userInteractionEnabled=NO;
    self.answerbtn2.userInteractionEnabled=NO;
    self.answerbtn3.userInteractionEnabled=NO;
}

- (IBAction)btn3Clicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [self performSelector:@selector(goToNextQuestion:) withObject:sender afterDelay:1];
    self.answerbtn1.userInteractionEnabled=NO;
    self.answerbtn2.userInteractionEnabled=NO;
    self.answerbtn3.userInteractionEnabled=NO;
}
- (void)setViewReload
{
    self.answerbtn1.userInteractionEnabled=YES;
    self.answerbtn2.userInteractionEnabled=YES;
    self.answerbtn3.userInteractionEnabled=YES;
    if ([self.questionNoArray count]) {
        self.questionNoLabel.text = [NSString stringWithFormat:@"Question %d:",11-[self.questionNoArray count]];
        [[AnimateViews allocate] startAnimationOnview:self.view toView:self.view animationType:PushViewAnimationType animationSubType:0];
        
        Question   *question =[self.questionNoArray objectAtIndex:0];
        self.questionLabel.text=question.question_name;
        [self.answerbtn1 setTitle:question.option1 forState:UIControlStateNormal];
        [self.answerbtn2 setTitle:question.option2 forState:UIControlStateNormal];
        [self.answerbtn3 setTitle:question.option3 forState:UIControlStateNormal];
        self.strCorrectOption = question.correctOption;
        [self.questionNoArray removeObjectAtIndex:0];
        [self performSelector:@selector(timeExpired) withObject:nil afterDelay:10];
    }
  else
  {
      UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Some unknown error occured. Please try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
      [alert show];
  
  }

    
}
- (void)timeExpired
{
    if (self.answerbtn1.userInteractionEnabled && [Global sharedController].viewController == self) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Time expired for this question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 44;
        [alert show];
    }

}
-(void)goToNextQuestion:(UIButton *)btn
{
    if ([self.strCorrectOption isEqualToString:self.answerbtn1.currentTitle]) {
        if (btn==self.answerbtn1) {
            points++;
        }
        self.answerbtn1.selected = FALSE;

        [self.answerbtn1 setBackgroundImage:[UIImage imageNamed:@"quiz-2.png"] forState:UIControlStateNormal];
    }
    else if ([self.strCorrectOption isEqualToString:self.answerbtn2.currentTitle]) {
        if (btn==self.answerbtn2) {
            points++;
        }

        self.answerbtn2.selected = FALSE;

        [self.answerbtn2 setBackgroundImage:[UIImage imageNamed:@"quiz-2.png"] forState:UIControlStateNormal];
    }
    else if ([self.strCorrectOption isEqualToString:self.answerbtn3.currentTitle]) {
        if (btn==self.answerbtn3) {
            points++;
        }

        self.answerbtn3.selected = FALSE;

        [self.answerbtn3 setBackgroundImage:[UIImage imageNamed:@"quiz-2.png"] forState:UIControlStateNormal];
    }
    self.lblpoints.text = [NSString stringWithFormat:@"%d",points];
    [self performSelector:@selector(setCorrect) withObject:nil afterDelay:1];
   
  

}
-(void)setCorrect
{
    [self.answerbtn1 setBackgroundImage:[UIImage imageNamed:@"quiz-1.png"] forState:UIControlStateNormal];
    [self.answerbtn2 setBackgroundImage:[UIImage imageNamed:@"quiz-1.png"] forState:UIControlStateNormal];
    [self.answerbtn3 setBackgroundImage:[UIImage imageNamed:@"quiz-1.png"] forState:UIControlStateNormal];
    self.answerbtn1.selected = FALSE;
    self.answerbtn2.selected = FALSE;
    self.answerbtn3.selected = FALSE;
    
    if ([self.questionNoArray count]) {
        [self setViewReload];
    }
    else{
        
        NSString *string = [NSString stringWithFormat:@"Your Quiz is Completed. You have got %d points.",points];
        int points_total = [[[NSUserDefaults standardUserDefaults]objectForKey:@"point"]integerValue];
        points_total = points_total+points;
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",points_total] forKey:@"point"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:string delegate:self cancelButtonTitle:@"Play again"  otherButtonTitles:@"View Total Points", nil];
        [alert show];
        
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag== 44) {
        [self setViewReload];
        return;
    }
      if (buttonIndex == alertView.cancelButtonIndex) {
        
       
        [self viewDidLoad];
        
    } else if (buttonIndex == alertView.firstOtherButtonIndex) {
        
        ProfileViewController *profileView =[[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
        [self.navigationController pushViewController:profileView animated:YES];
    }
}
@end
