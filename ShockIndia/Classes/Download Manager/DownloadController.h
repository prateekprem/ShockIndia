//
//  DownloadController.h
//  
//
//  Created by Ishu on 29/03/11.
//  Copyright 2011 Kiwitech. All rights reserved.
//



@class DownloadFiles;

@protocol DownloadingDelegate

@required
-(void)downloadDidFinish;
-(void)downloadingDidCancel;

@optional
-(void)restartDownload;
-(void)downloadDidStart;
-(void)downloadDidStartWithSenderObj:(id)sender;
-(void)downloadDidFinish:(id)sender;

-(void)downloadingDidRecieveData:(int)percentComplete;
 -(void)downloadingDidFinishForIndex: (NSInteger)index;
-(void)downloadingDidFinishForIndex: (NSInteger)index AndObject:(id)sender;

@end


@interface DownloadController : NSObject 
{
    @private 
    int requestNo;
    NSMutableArray *requests;
    NSMutableArray *delegates;
    NSMutableArray *folders;
    NSMutableArray *senderObjects;
}
@property (nonatomic) BOOL restartBool;
@property (nonatomic,retain) NSString *folderName;
@property (nonatomic,assign) NSInteger percentDownload;
@property (nonatomic,assign) NSInteger downloadedCount;
@property (nonatomic,retain) NSString *baseUrlString;
@property(nonatomic,strong)  NSMutableArray *dataSorceForDownload;
@property(nonatomic,strong)id <DownloadingDelegate> delegate;
@property (strong, nonatomic) id senderObj;

-(void)restartDownloading;
-(void)setExpectedData:(double_t)expectedData;
-(void)appendNewDataWithDownloadedData:(double)byteData;
+ (DownloadController*)sharedController ;
-(void)forceCloseDownloading;
-(void)startDownloading;
-(void)removeDownloadArray;
-(NSMutableArray* )getDataSorceForDownload;
@end
