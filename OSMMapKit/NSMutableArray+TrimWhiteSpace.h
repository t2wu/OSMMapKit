//
//  NSMutableArray+TrimWhiteSpace.h
//  OfflineSpotty
//
//  Created by Timothy Wu on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray(TrimWhiteSpace)

-(void) trimWhiteSpaceIfAnyFromArrayOfString;
-(void) trimQuoteIfAtBothEnd;

@end
