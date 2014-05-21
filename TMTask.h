//
//  TMTask.h
//  TODO Application
//
//  Created by Edwin Cowart on 5/20/14.
//  Copyright (c) 2014 Edwin Cowart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMTask : NSObject

@property NSString* name;
@property NSString* description;
// nil means that there exist no deadline (default)
@property NSDate* deadline;

/** Setup Up with new fields */
- (id) initWithNewFields;


@end
