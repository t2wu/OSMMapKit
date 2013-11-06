//
//  NSMutableArray+TrimWhiteSpace.m
//  OfflineSpotty
//
//  Created by Timothy Wu on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSMutableArray+TrimWhiteSpace.h"
#import "NSString+Tokenize.h"

@implementation NSMutableArray(TrimWhiteSpace)

-(void) trimWhiteSpaceIfAnyFromArrayOfString
{
    for (NSUInteger i = 0; i < [self count]; i++) {
        NSString * object = [self objectAtIndex:i];
        NSString * trimmed = [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [self replaceObjectAtIndex: i withObject: trimmed];
    }
}

-(void) trimQuoteIfAtBothEnd
{
    for (NSUInteger i = 0; i < [self count]; i++) {
        NSString * object = [self objectAtIndex:i];
        [self replaceObjectAtIndex:i withObject:[object trimQuote]];
    }
}

@end
