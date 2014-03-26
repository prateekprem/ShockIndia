//
//  WEPopoverContentViewController.m
//  WEPopover
//
//  Created by Werner Altewischer on 06/11/10.
//  Copyright 2010 Werner IT Consultancy. All rights reserved.
//

#import "WEPopoverContentViewController.h"
#import "Comment.h"


@implementation WEPopoverContentViewController

@synthesize dataSource =dataSource_;
#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
      

    if ((self = [super initWithStyle:style])) {
        
        if ([self respondsToSelector:@selector(setPreferredContentSize:)]) {
            self.preferredContentSize = CGSizeMake(100, 5 * 44 - 1);
        } else {
            self.contentSizeForViewInPopover = CGSizeMake(100, 5 * 44 - 1);
        }
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	self.tableView.rowHeight = 44.0;
	self.view.backgroundColor = [UIColor clearColor];

    NSLog(@"datasource count is %d",[dataSource_ count]);
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
{
    UIView* footer = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)] autorelease];
    footer.backgroundColor = [UIColor whiteColor];
    
    UITextField* field = [[[UITextField alloc] initWithFrame:footer.frame] autorelease];
    field.returnKeyType = UIReturnKeySend;
    field.placeholder = @"Write comment here..";
    [field setBorderStyle:UITextBorderStyleBezel];
    [footer addSubview:field];
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 44;
}
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.dataSource count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	cell.textLabel.text = [NSString stringWithFormat:@"Item %d", [indexPath row]]; 
	cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

