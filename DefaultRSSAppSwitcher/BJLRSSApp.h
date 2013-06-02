//
//  BJLRSSApp.h
//  Default RSS App Switcher
//
//  Created by Bryan Luby on 6/1/13.
//  Copyright (c) 2013 Bryan Luby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BJLRSSApp : NSObject

@property (copy) NSString *bundleID;
@property (copy) NSString *appName;
@property (getter = isDefaultRSSApp) BOOL defaultRSSApp;
@property (strong) NSImage *appIcon;

@end
