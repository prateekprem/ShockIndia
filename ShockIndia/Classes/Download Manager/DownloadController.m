//
//  DownloadController.m
//  
//
//  Created by Ishu on 29/03/11.
//  Copyright 2011 Kiwitech. All rights reserved.
//

#import "DownloadController.h"
#import "DownloadFiles.h"
#import "ZipArchive.h"


@interface DownloadController()

@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,strong) DownloadFiles *filesdown;

-(void)startDownloadingFromDataSource;
-(BOOL)DownloadFilesForSourceUrl:(NSString*)sourceUrl withPdfName:(NSString*)zipFileName ;
-(void)startNextDownload;
-(void)prepareForDownload;
-(BOOL)isFileAlreadyDownloaded:(NSString*)fileName;

@end

@implementation DownloadController
@synthesize dataSorceForDownload = dataSorceForDownload_;
@synthesize baseUrlString = baseUrlString_;
@synthesize currentIndex = currentIndex_;
@synthesize delegate = delegate_;
@synthesize downloadedCount = downloadedCount_;
@synthesize percentDownload = percentDownload_;
@synthesize filesdown = filesdown_;
@synthesize folderName=folderName_;
@synthesize senderObj=senderObj_;
@synthesize restartBool=restartBool_;
NSURLConnection *connection;
NSString *serverUrl;
double expectedRecivingData=0.0;
double downloadedData;


static DownloadController* _sharedDownloadController;
#pragma mark -
#pragma mark Singleton Methods

+ (id)allocWithZone:(NSZone *)zone {	
    @synchronized(self) {
        if (_sharedDownloadController == nil) {
            _sharedDownloadController = [super allocWithZone:zone];	
            
            return _sharedDownloadController;
        }
    }
	
    return nil; 
}

- (id)copyWithZone:(NSZone *)zone {
    return self;	
}


+ (DownloadController*)sharedController {
	@synchronized(self) {
        if (_sharedDownloadController == nil) {
            _sharedDownloadController=[[self alloc] init];
           
        }
    }
    //_sharedDownloadController.folderName=nil;
    return _sharedDownloadController;
}


-(void)setDelegate:(id<DownloadingDelegate>)delegate
{
    //self.delegate = delegate;
    if(!delegates)
        delegates = [[NSMutableArray alloc]init];
    if (restartBool_) {
        [delegates insertObject:delegate atIndex:0];
    }
    else
        [delegates addObject:delegate];
    
}

-(void)setDataSorceForDownload:(__strong NSMutableArray *)dataSorceForDownload
{
    //self.dataSorceForDownload = dataSorceForDownload;
    if(!requests)
        requests = [[NSMutableArray alloc]init];
    if (restartBool_) {
        [requests insertObject:[dataSorceForDownload copy] atIndex:0];
    }
    else
    [requests addObject:[dataSorceForDownload copy]];
}

-(NSMutableArray* )getDataSorceForDownload
{
    return requests;
}
-(void)removeDownloadArray
{
    [folders removeAllObjects];
    [delegates removeAllObjects];
    [senderObjects removeAllObjects];
    [requests removeAllObjects];
    dataSorceForDownload_ = nil;
    
}
-(void)setFolderName:(NSString *)folderName
{
    if(!folders)
        folders = [[NSMutableArray alloc]init];
    if (restartBool_) 
        [folders insertObject:folderName atIndex:0];
    else 
        [folders addObject:folderName];
}

-(void)setSenderObj:(id)senderObj
{
    if(!senderObjects)
        senderObjects = [[NSMutableArray alloc]init];
    if (restartBool_)
        [senderObjects insertObject:senderObj atIndex:0];
    else if (![senderObjects containsObject:senderObj])
        [senderObjects addObject:senderObj];
}

-(void)startDownloading
{
    if(requestNo == 0)
    {
        if([requests count])
        {
            dataSorceForDownload_ = [requests objectAtIndex:0];
            [requests removeObjectAtIndex:0];
        }
        if([delegates count])
        {
            delegate_ = [delegates objectAtIndex:0];
            [delegates removeObjectAtIndex:0];
        }
        if([folders count])
        {
            folderName_ = [folders objectAtIndex:0];
            [folders removeObjectAtIndex:0];
        }
        if([senderObjects count])
        {
            senderObj_ = [senderObjects objectAtIndex:0];
            [senderObjects removeObjectAtIndex:0];
        }
    
       
        currentIndex_=-1;
        [self startDownloadingFromDataSource];
        
    }
    
     requestNo++; 
    
}

-(void)prepareForDownload
{

    
    if([requests count])
    {
        dataSorceForDownload_ = [requests objectAtIndex:0];
        [requests removeObjectAtIndex:0];
    }
    if([delegates count])
    {
        delegate_ = [delegates objectAtIndex:0];
        [delegates removeObjectAtIndex:0];
    }
    if([folders count])
    {
        folderName_ = [folders objectAtIndex:0];
        [folders removeObjectAtIndex:0];
    }
    if([senderObjects count])
    {
        senderObj_ = [senderObjects objectAtIndex:0];
        [senderObjects removeObjectAtIndex:0];
    }
    
    
    currentIndex_=-1;
    [self startDownloadingFromDataSource];
        
    
    
   

}

-(void)startNextDownload
{
    requestNo--;
    
    if(![requests count] || ![delegates count] || ![folders count])
        return;

    
    [self prepareForDownload];
        
}

-(void)startDownloadingFromDataSource
{
    if(currentIndex_ == -1)
    {
        [delegate_ downloadDidStart];
        [delegate_ downloadDidStartWithSenderObj:senderObj_];
        
    }
  
     downloadedCount_=currentIndex_+1;
    if(currentIndex_!=-1)
    {
       [delegate_ downloadingDidFinishForIndex:currentIndex_];
    }
    
    currentIndex_++;
    
        if (currentIndex_<[dataSorceForDownload_ count]) {
                [self DownloadFilesForSourceUrl:[NSString stringWithFormat:@"%@",baseUrlString_] withPdfName:[dataSorceForDownload_ objectAtIndex:currentIndex_]];
            
        }
        else
        {
            
            [delegate_ downloadDidFinish];
            [delegate_ downloadDidFinish:senderObj_];
            [self startNextDownload];
        }

}

-(BOOL)isFileAlreadyDownloaded:(NSString*)fileName
{
     NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@",[searchPaths objectAtIndex:0],folderName_, fileName];
   
    
    NSFileManager *myManager = [NSFileManager defaultManager];
    
    if([myManager fileExistsAtPath:url])
    {
        return TRUE;
    }
    return FALSE;
}

-(BOOL)DownloadFilesForSourceUrl: (NSString*)sourceUrl 
                     withPdfName: (NSString*)zipFileName 
{
    expectedRecivingData=0.0;
    downloadedData=0.0;
    filesdown_=nil;
		filesdown_=[[DownloadFiles alloc] init];
		NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask,YES);
		NSMutableString *documentsDirectory=[[NSMutableString alloc] initWithString:[paths objectAtIndex:0]];
     
    if([folderName_ length]>0)
    {
        [documentsDirectory appendString:[NSString stringWithFormat:@"/%@",folderName_]];
    }
		filesdown_.callBackTarget = self;

        filesdown_.callBackSelector = @selector(startDownloadingFromDataSource);

    
		[filesdown_ setFilePath:[NSString stringWithFormat:@"%@/%@",documentsDirectory,[zipFileName lastPathComponent]]];
		[filesdown_ setFileDocPath:[NSString stringWithFormat:@"%@/",documentsDirectory]];
		[filesdown_ startDownload:[NSString stringWithFormat:@"%@%@",sourceUrl,zipFileName] withOffset:0];
		
    return  TRUE;
}

-(void)forceCloseDownloading
{
     
    expectedRecivingData=0.0;
    downloadedData=0.0;
    [filesdown_ cancelDownloading];
    requestNo = 0;
    [delegate_ downloadingDidCancel];
   
}
   


-(void)setExpectedData:(double)expectedData
{
	expectedRecivingData+= expectedData;
}


-(void)appendNewDataWithDownloadedData:(double)byteData
{
	float progress = [[NSString stringWithFormat:@"%.2f", byteData]floatValue];
    int downloadnum = (int)(100.0*progress);
    percentDownload_=downloadnum;
    [delegate_ downloadingDidRecieveData:downloadnum];
    
}
-(void)restartDownloading
{
    [delegate_ restartDownload];

}

@end
