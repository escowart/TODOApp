//
//  TMDetailViewController.h
//  TODO Application
//
//  Created by Edwin Cowart on 5/20/14.
//  Copyright (c) 2014 Edwin Cowart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMTask.h"
#import "TMMasterViewController.h"

@interface TMDetailViewController : UIViewController <UISplitViewControllerDelegate>
{
    IBOutlet UITextField *displayName;
    IBOutlet UITextView *displayDescription;
    IBOutlet UIButton* saveButton;
    BOOL inEditMode;
    IBOutlet UIButton* editButton;
    IBOutlet UIDatePicker* deadlineDatePicker;
}

@property (strong, nonatomic) TMTask* task;
@property (strong,nonatomic) NSIndexPath* indexPath;
@property TMMasterViewController* masterView;

/** Set the Task with the given indexpath */
- (void) setTask:(TMTask *)task withIndexPath:(NSIndexPath*)indexPath withMasterView:(TMMasterViewController*)masterView;

/** Update the Name Text Field Display */
- (IBAction) save:(id) sender;

/** Action preformed upon clicking the edit Button */
- (IBAction)clickEdit:(id)sender;


/** Move Up One position in the directory and refresh */
- (IBAction)moveUpPosition:(id)sender;


/** Move Down One position in the directory and refresh */
- (IBAction)moveDownPosition:(id)sender;

@end
