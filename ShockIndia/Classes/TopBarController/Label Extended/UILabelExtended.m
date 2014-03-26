//
//  UILabelExtendedExtended.m
//  Elsevier
//
//  Created by Tarun on 6/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UILabelExtended.h"


@implementation UILabelExtended
@synthesize selector,customDelegate, objectInfo;
@synthesize text = _text;
@synthesize title_label = _title_label;
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.selector)
        if([self.customDelegate respondsToSelector:self.selector]) {
            [self.customDelegate performSelector:self.selector withObject:self];
            return;
        }
}


- (void)dealloc {
	
	self.customDelegate = nil;
    self.selector = NULL;
    self.objectInfo = nil;
}

-(void)setText:(NSString *)text
{
    if (!text) {
        return;
    }
    _text = text;
    const char *ch = [text cStringUsingEncoding:NSISOLatin1StringEncoding];
    if (ch) {
        _text = [[NSString alloc]initWithCString:ch encoding:NSUTF8StringEncoding];
    }
    [super setText:_text];
    
}


@end


@implementation UILabelExtended(UILabelExtendedCategory)




- (void)setHeightOfLabel {
    UILabelExtended* label = self;
    
	//get the height of label content
	CGFloat height = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, 99999) lineBreakMode:NSLineBreakByWordWrapping].height;
	//set the frame according to calculated height
	CGRect frame = label.frame;
    if([label.text length] > 0) {
        
        frame.size.height = height;
    } 
    else {
        frame.size.height = 0;
    }
	label.frame = frame;
}


- (void)setWidthOfLabel {
	UILabelExtended* label = self;
    
		//get the height of label content
	CGFloat width = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(99999, label.bounds.size.height) lineBreakMode:NSLineBreakByWordWrapping].width;
		//set the frame according to calculated height
	CGRect frame = label.frame;
    if([label.text length] > 0) {
        
        frame.size.width = width+5;
    } 
    else {
        frame.size.width = 0;
    }
	label.frame = frame;
}

- (void)setHeightOfLabelWithMaxHeight:(float)maxHeight {
    UILabelExtended* label = self;
    
	//get the height of label content
	CGFloat height = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.bounds.size.width, maxHeight) lineBreakMode:NSLineBreakByWordWrapping].height;
	//set the frame according to calculated height
	CGRect frame = label.frame;
   
    if([label.text length] > 0) {
        if (height > maxHeight) {
			frame.size.height = maxHeight;
		}
		else {
			frame.size.height = height;
		}
        
    } 
    else {
        frame.size.height = 0;
    }
	label.frame = frame;
}


- (void)setWidthOfLabelWithMaxWidth:(float)maxWidth  {
	UILabelExtended* label = self;
    
	//get the height of label content
	CGFloat width = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(99999, label.bounds.size.height) lineBreakMode:NSLineBreakByWordWrapping].width;
	//set the frame according to calculated height
	CGRect frame = label.frame;
    if([label.text length] > 0) {
		
        if (width > maxWidth) {
			frame.size.width = maxWidth;
		}
		else {
			frame.size.width = width;
		}
    } 
    else {
        frame.size.width = 0;
    }
	label.frame = frame;
}



@end