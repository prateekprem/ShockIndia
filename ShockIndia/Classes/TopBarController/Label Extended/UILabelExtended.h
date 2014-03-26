//
//  UILabelExtendedExtended.h
//  Elsevier
//
//  Created by Tarun on 6/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

/*  **********************************************************************************************
        This class inherit the class UILabelExtended and extend the features of UILabelExtended. 
    ********************************************************************************************** */
@interface UILabelExtended : UILabel {
   __unsafe_unretained id  customDelegate;
    id  objectInfo;
    SEL selector;
    
}
@property (nonatomic, copy) NSString *text;
@property (nonatomic,assign) SEL selector;
@property (nonatomic,assign) BOOL title_label;
@property (nonatomic,assign) id  customDelegate;
@property (nonatomic,retain) id  objectInfo;
@end

@interface UILabelExtended(UILabelExtendedCategory)
- (void)setHeightOfLabel;
- (void)setWidthOfLabel;
- (void)setHeightOfLabelWithMaxHeight:(float)maxHeight;
- (void)setWidthOfLabelWithMaxWidth:(float)maxWidth ;

@end