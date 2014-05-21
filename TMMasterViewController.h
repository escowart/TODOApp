//
//  TMMasterViewController.h
//  TODO Application
//
//  Created by Edwin Cowart on 5/20/14.
//  Copyright (c) 2014 Edwin Cowart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMTask.h"

@class TMDetailViewController;

@interface TMMasterViewController : UITableViewController
{
    NSInteger selectedTaskIndex;
}

@property (strong, nonatomic) TMDetailViewController *detailViewController;

/** Set the value at the given index path to the given value */
- (void) setValue:(TMTask*)value atIndexPath:(NSIndexPath*)indexPath;

/** Update the Cells of self */
- (void) updateCell:(NSIndexPath*) indexPath;

/** Update All Cells of self */
- (void) updateCells;

/** Select Item to be moved with Long Press */
- (IBAction)longPressGestureClicked:(UILongPressGestureRecognizer*)longPressGestureRecognizer;


/** Move the Entry at the given index path up 1 position */
- (void) moveEntryAtPositionUp:(NSIndexPath*) indexPath;


/** Move the Entry at the given index path down 1 position */
- (void) moveEntryAtPositionDown:(NSIndexPath*) indexPath;

@end
