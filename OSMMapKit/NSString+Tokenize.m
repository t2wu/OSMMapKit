//
//  NSString+Tokenize.m
//  OfflineSpotty
//
//  Created by Timothy Wu on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+Tokenize.h"
#import "NSMutableArray+TrimWhiteSpace.h"

@implementation NSString(Tokenize)

// This takes out white spaces
// I just can't stand how many lines I have to do this for such a conceptially trivial stuff.
-(NSMutableArray *) tokenizeByString: (NSString *) separator
{
    // Remove whitespace and quote if necessary.
    
    NSArray * tokens = [self componentsSeparatedByString: separator];
    NSMutableArray * tokens_mut = [NSMutableArray arrayWithArray:tokens];
    [tokens_mut trimWhiteSpaceIfAnyFromArrayOfString];
    [tokens_mut trimQuoteIfAtBothEnd];
    
    return tokens_mut;
}


-(NSString *) trimQuote
{
    NSUInteger length = [self length];
    if (length >= 2 &&
        [self characterAtIndex:0] == [self characterAtIndex: [self length]-1] && 
        [self characterAtIndex:0] == '"') {
        
        NSRange range = NSMakeRange(1, [self length]-2);
        return [self substringWithRange:range];
    }
    return self;
}

@end
