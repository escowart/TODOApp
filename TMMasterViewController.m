//
//  TMMasterViewController.m
//  TODO Application
//
//  Created by Edwin Cowart on 5/20/14.
//  Copyright (c) 2014 Edwin Cowart. All rights reserved.
//

#import "TMMasterViewController.h"

#import "TMDetailViewController.h"
#import "TMDirectory.h"

@interface TMMasterViewController () {
    TMDirectory* directory;
}
@end

@implementation TMMasterViewController

/** Awake From Nib */
- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

/** Set up the view with the edit and add buttons and gesture recognizer */
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Add the edit button
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    // Add the Button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (TMDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    // Long Press Recognizer
    /**
    [self.tableView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureClicked:)]];*/
    // Set to invalid
    selectedTaskIndex = -1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** Insert a New Task into the directory */
- (void)insertNewObject:(id)sender
{
    if (!directory) {
        directory = [[TMDirectory alloc] init];
    }
    [directory addNewTask];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self updateCells];
}

#pragma mark - Table View

/** Get the number of sections in the given TableView */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/** Get the number of rows in given section in the TableView */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [directory size];
}

/** Get the Cell from the TableView at the given IndexPath */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    TMTask *task = [directory getTaskAtIndex:indexPath.row];
    cell.textLabel.text = task.name;
    return cell;
}

/** Can The Cell at the given index path be edit (Always YES) */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

/** Enable the given tableview editingstyle for the given index path */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [directory removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

/* Move the Cell from the fromIndexPath to the toIndexPath */
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [directory moveTaskFrom:fromIndexPath.row toIndex:toIndexPath.row];
    [tableView moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
}

/* Whether a Cell in the TableView can be moved */
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

/** Whether the given Index Path is selected */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        TMTask *task = directory.tasks[indexPath.row];
        self.detailViewController.task = task;
    }
}


/** Set the value at the given index path to the given value */
- (void) setValue:(TMTask*)value atIndexPath:(NSIndexPath*)indexPath
{
    [directory setValue:value atIndex:indexPath.row];
    [self updateCell:indexPath];
}

/** Prepare for a Segue in the detailed view */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TMTask *task = [directory getTaskAtIndex:indexPath.row];
        [[segue destinationViewController] setTask:task withIndexPath:indexPath withMasterView:self];
    }
}

/** Update the Cells of self */
- (void) updateCell:(NSIndexPath*) indexPath
{
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

/** Update All Cells of self */
- (void) updateCells
{
    [self.tableView beginUpdates];
    for (int i = 0; i < [directory size]; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [self.tableView endUpdates];
}


/** Select Item to be moved with Long Press */
- (IBAction)longPressGestureClicked:(UILongPressGestureRecognizer*)longPressGestureRecognizer
{/** TODO: Non-functional
    NSLog(@"Selected Task Index: %i", selectedTaskIndex);
    // Get the location of click
    CGPoint location = [longPressGestureRecognizer locationInView:self.view];
    NSLog(@"Click Location: %f\tCell #: %i", location.y, [self indexOfClickedCell:location]);
    switch (longPressGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            // Set up the selected task index
            selectedTaskIndex = [self indexOfClickedCell:location];
            if (selectedTaskIndex < 0 || selectedTaskIndex > [directory size]) {
                selectedTaskIndex = -1;
            }
            NSLog(@"Cell #: %i Has Been Selected", selectedTaskIndex);
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"!!!");
            // Move
            if (selectedTaskIndex < 0) {
                NSLog(@"Cannot Recognize Files Because Selected Value is -1");
                break;
            }
            NSInteger toLocation = [self indexOfClickedCell:location];
            NSLog(@"toLocation: %i", toLocation);
            if (selectedTaskIndex == toLocation) {
                // Do nothing if the location is the same
                break;
            } else if (toLocation < 0) {
                // Move to Beginning if less than 0
                [directory moveTaskFrom:selectedTaskIndex toIndex:toLocation];
                selectedTaskIndex = 0;
            } else if (toLocation >= [directory size]) {
                // Move to End if greater than or equal to the size
                [directory moveTaskToEndFrom:selectedTaskIndex];
                selectedTaskIndex = [directory size];
            } else {
                // Move to the given location
                [directory moveTaskFrom:selectedTaskIndex toIndex:toLocation];
                selectedTaskIndex = toLocation;
            }
            [self updateCells];
            break;
        case UIGestureRecognizerStateEnded:
            selectedTaskIndex = -1;
            break;
            
        default:
            break;
    } */
}

/** Get the index number of the currently clicked cell. Returns -1 for no cell */
- (NSInteger) indexOfClickedCell:(CGPoint)point
{
    if ([directory size] < 2) {
        return 0;
    }
    CGFloat pointY = point.y;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    CGFloat zeroCenter = [[self.tableView cellForRowAtIndexPath:indexPath] center].y;
    indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    CGFloat firstCenter = [[self.tableView cellForRowAtIndexPath:indexPath] center].y;
    CGFloat heightOfCell = fabsf(firstCenter - zeroCenter);
    return (pointY - zeroCenter - heightOfCell/2) / heightOfCell;
}

/** Move the Entry at the given index path up 1 position */
- (void) moveEntryAtPositionUp:(NSIndexPath*) indexPath
{
    [directory pushEntryAtIndexUp:indexPath.row];
}


/** Move the Entry at the given index path down 1 position */
- (void) moveEntryAtPositionDown:(NSIndexPath*) indexPath
{
    [directory pushEntryAtIndexDown:indexPath.row];
}

@end
