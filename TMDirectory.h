//
//  TMDirectory.h
//  TODO Application
//
//  Created by Edwin Cowart on 5/20/14.
//  Copyright (c) 2014 Edwin Cowart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMTask.h"

@interface TMDirectory : NSObject

@property NSMutableArray* tasks;

/** Add the given task to self */
- (void) addTask:(TMTask*) task;

/** Add a new add task */
- (void) addNewTask;

/** Does this contain a Task With the given name */
- (BOOL) containsTaskWithName:(NSString*) name;

/** Does this contain a Task With the same name */
- (BOOL) containsTaskWithSameName:(TMTask*) task;

/** Get the task at the given index */
- (TMTask*) getTaskAtIndex:(NSUInteger) index;

/** Remove the task at the given index */
- (void) removeObjectAtIndex:(NSUInteger) index;

/** Set the name of the given Task according with its version */
+ (TMTask*) setNameOfTask:(TMTask*) task withTheVersion:(NSUInteger)version;

/** Get the size of mutable array */
- (NSUInteger) size;

/** Move the given Task From the given fromIndex to the given toIndex */
- (void) moveTaskFrom:(NSUInteger) fromIndex toIndex:(NSUInteger) toIndex;

/** Set the value at the given index to the given value */
- (void) setValue:(TMTask*)value atIndex:(NSUInteger) index;

/** Move the Task at the given index to the end of the directroy */
- (void) moveTaskToEndFrom:(NSUInteger) fromIndex;

/** Push the entry at the given index Up one */
- (void)  pushEntryAtIndexUp:(NSUInteger)index;

/** Push the entry at the given index Down one */
- (void)  pushEntryAtIndexDown:(NSUInteger)index;

@end
