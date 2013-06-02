//
//  BJLAppDelegate.m
//  Default RSS App Switcher
//
//  Created by Bryan Luby on 6/1/13.
//  Copyright (c) 2013 Bryan Luby. All rights reserved.
//

#import "BJLAppDelegate.h"
#import "BJLRSSAppSwitcherWC.h"

@interface BJLAppDelegate ()
@property (strong) BJLRSSAppSwitcherWC *windowController;
@end

@implementation BJLAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.windowController = [[BJLRSSAppSwitcherWC alloc] initWithWindowNibName:@"BJLRSSAppSwitcherWC"];
    [self.windowController showWindow:nil];
}

@end
