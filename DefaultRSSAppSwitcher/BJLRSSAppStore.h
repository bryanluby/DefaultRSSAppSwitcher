//
//  BJLRSSAppStore.h
//  DefaultRSSAppSwitcher
//
//  Created by Bryan Luby on 6/1/13.
//  Copyright (c) 2013 Bryan Luby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJLRSSAppStore : NSObject

- (NSArray *)allAvailableRSSApps;
- (void)changeDefaultRSSAppWithID:(NSString *)bundleID;

@end
