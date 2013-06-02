//
//  BJLRSSAppStore.m
//  DefaultRSSAppSwitcher
//
//  Created by Bryan Luby on 6/1/13.
//  Copyright (c) 2013 Bryan Luby. All rights reserved.
//

#import "BJLRSSAppStore.h"
#import "BJLRSSApp.h"

@interface BJLRSSAppStore ()
@property CFStringRef feedScheme;
@end

@implementation BJLRSSAppStore

- (id)init
{
    self = [super init];
    if (self) {
        _feedScheme = (__bridge CFStringRef)@"feed";
    }
    return self;
}

- (NSArray *)allAvailableRSSApps
{
    NSMutableArray *availableRSSApps = [[NSMutableArray alloc] init];
    
    NSArray *rssApps = (__bridge_transfer NSArray *)LSCopyAllHandlersForURLScheme(self.feedScheme);
    NSString *defaultRSSClientString = (__bridge_transfer NSString *)LSCopyDefaultHandlerForURLScheme(self.feedScheme);
    
    for (NSString *appIDString in rssApps) {
        NSString *appPath = [[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:appIDString];
        if (appPath) {
            BJLRSSApp *newApp = [[BJLRSSApp alloc] init];
            newApp.bundleID = appIDString;
            newApp.appName = [[NSFileManager defaultManager] displayNameAtPath:appPath];;
            newApp.appIcon = [[NSWorkspace sharedWorkspace] iconForFile:appPath];;
            
            if ([appIDString isEqualToString:defaultRSSClientString]) {
                newApp.defaultRSSApp = YES;
            }
            
            [availableRSSApps addObject:newApp];
        }
    }
    
    [availableRSSApps sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"appName"
                                                                           ascending:YES]]];
    
    return [availableRSSApps copy];
}

- (void)changeDefaultRSSAppWithID:(NSString *)bundleID
{
    CFStringRef bundleIDString = (__bridge CFStringRef)bundleID;
    LSSetDefaultHandlerForURLScheme(self.feedScheme, bundleIDString);
}

@end
