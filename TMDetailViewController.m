//
//  TMDetailViewController.m
//  TODO Application
//
//  Created by Edwin Cowart on 5/20/14.
//  Copyright (c) 2014 Edwin Cowart. All rights reserved.
//

#import "TMDetailViewController.h"

@interface TMDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation TMDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(TMTask*)task
{
    if (_task != task) {
        _task = task;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

/** Configure the view of the User interface */
- (void)configureView
{
    if (self.task) {
        displayName.text = self.task.name;
        // Set Up Display with border
        displayDescription.text = self.task.description;
        displayDescription.layer.borderWidth = 3.0f;
        displayDescription.layer.borderColor = [[UIColor grayColor] CGColor];
        
        // Setup Up Save Button with border
        saveButton.layer.borderWidth = 1.0f;
        saveButton.layer.borderColor = [[UIColor grayColor] CGColor];
        
        // Setup Up Edit Button with border
        editButton.layer.borderWidth = 1.0f;
        editButton.layer.borderColor = [[UIColor grayColor] CGColor];
        
        // Set up Edit Mode
        inEditMode = YES;
        [self clickEdit:nil];
        
        if (self.task.deadline) {
            deadlineDatePicker.date = self.task.deadline;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}


/** Set the Task with the given indexpath */
- (void) setTask:(TMTask *)task withIndexPath:(NSIndexPath*)indexPath withMasterView:(TMMasterViewController*)masterView
{
    self.task = task;
    self.indexPath = indexPath;
    self.masterView = masterView;
}

/** Update the Name Text Field Display */
- (IBAction) save:(id) sender
{
    self.task.name = displayName.text;
    self.task.description = displayDescription.text;
    self.task.deadline = deadlineDatePicker.date;
    [self.masterView setValue:self.task atIndexPath:self.indexPath];
    [self.masterView updateCells];
}

/** Action preformed upon clicking the edit Button */
- (IBAction)clickEdit:(id)sender
{
    inEditMode = !inEditMode;
    [displayName setEnabled:inEditMode];
    [displayDescription setEditable:inEditMode];
    [deadlineDatePicker setEnabled:inEditMode];
}


/** Move Up One position in the directory and refresh */
- (IBAction)moveUpPosition:(id)sender
{
    [self.masterView moveEntryAtPositionUp:self.indexPath];
}


/** Move Down One position in the directory and refresh */
- (IBAction)moveDownPosition:(id)sender
{
    [self.masterView moveEntryAtPositionDown:self.indexPath];
}

@end
