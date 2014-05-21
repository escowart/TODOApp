//
//  TMDirectory.m
//  TODO Application
//
//  Created by Edwin Cowart on 5/20/14.
//  Copyright (c) 2014 Edwin Cowart. All rights reserved.
//

#import "TMDirectory.h"

@implementation TMDirectory

/** Add the given task to self */
- (void) addTask:(TMTask*) task
{
    if (!self.tasks) {
        self.tasks = [[NSMutableArray alloc] init];
    }
    [self.tasks insertObject:task atIndex:0];
}


/** Add a new add task */
- (void) addNewTask
{
    [self addTask:[[TMTask alloc] initWithNewFields]];
}

/** Does this contain a Task With the given name */
- (BOOL) containsTaskWithName:(NSString*) name
{
    for (TMTask* tmTask in self.tasks) {
        if ([tmTask.name isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

/** Does this contain a Task With the same name */
- (BOOL) containsTaskWithSameName:(TMTask*) task
{
    return [self containsTaskWithName:task.name];
}


/** Get the task at the given index */
- (TMTask*) getTaskAtIndex:(NSUInteger) index
{
    return self.tasks[index];
}


/** Remove the object at the given index */
- (void) removeObjectAtIndex:(NSUInteger) index
{
    [self.tasks removeObjectAtIndex:index];
}

/** Set the name of the given Task according with its version */
+ (TMTask*) setNameOfTask:(TMTask*) task withTheVersion:(NSUInteger)version
{
    task.name = [task.name stringByAppendingFormat:@"%i",version];
    return task;
}

/** Get the size of mutable array */
- (NSUInteger) size
{
    return [self.tasks count];
}


/** Move the given Task From the given fromIndex to the given toIndex */
- (void) moveTaskFrom:(NSUInteger) fromIndex toIndex:(NSUInteger) toIndex
{
    if (fromIndex < toIndex) {
        TMTask* task = [self getTaskAtIndex:fromIndex];
        [self.tasks insertObject:task atIndex:toIndex];
        [self removeObjectAtIndex:fromIndex+1];
    } else if (fromIndex > toIndex) {
        TMTask* task = [self getTaskAtIndex:fromIndex];
        [self removeObjectAtIndex:fromIndex];
        [self.tasks insertObject:task atIndex:toIndex];
    }
}


/** Set the value at the given index to the given value */
- (void) setValue:(TMTask*)value atIndex:(NSUInteger) index
{
    self.tasks[index] = value;
}


/** Move the Task at the given index to the end of the directroy */
- (void) moveTaskToEndFrom:(NSUInteger) fromIndex
{
    TMTask* task = [self getTaskAtIndex:fromIndex];
    [self removeObjectAtIndex:fromIndex];
    [self.tasks addObject:task];
}


/** Push the entry at the given index Up one */
- (void)  pushEntryAtIndexUp:(NSUInteger)index
{
    if (index != 0) {
        TMTask* taskAtIndex = [self.tasks[index] copy];
        TMTask* taskAboveIndex = [self.tasks[index-1] copy];
        self.tasks[index] = taskAboveIndex;
        self.tasks[index-1] = taskAtIndex;
    }
}

/** Push the entry at the given index Down one */
- (void)  pushEntryAtIndexDown:(NSUInteger)index
{
    if (index < [self size] - 1) {
        TMTask* taskAtIndex = [self.tasks[index] copy];
        TMTask* taskBelowIndex = [self.tasks[index+1] copy];
        self.tasks[index] = taskBelowIndex;
        self.tasks[index+1] = taskAtIndex;
    }
}

@end
