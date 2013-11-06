//
//  NSString+Tokenize.h
//  OfflineSpotty
//
//  Created by Timothy Wu on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

// Category
@interface NSString(Tokenize)

-(NSMutableArray *) tokenizeByString: (NSString *) separator;
-(NSString *) trimQuote;

@end
