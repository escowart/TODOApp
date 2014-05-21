//
//  TMTask.m
//  TODO Application
//
//  Created by Edwin Cowart on 5/20/14.
//  Copyright (c) 2014 Edwin Cowart. All rights reserved.
//

#import "TMTask.h"

@implementation TMTask


/** Setup Up with new fields */
- (id) initWithNewFields
{
    self.name = @"New TODO";
    self.description = @"";
    self.deadline = nil;
    return self;
}




@end
