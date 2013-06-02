//
//  BJLRSSAppSwitcherWC.m
//  Default RSS App Switcher
//
//  Created by Bryan Luby on 6/1/13.
//  Copyright (c) 2013 Bryan Luby. All rights reserved.
//

#import "BJLRSSAppSwitcherWC.h"
#import "BJLRSSApp.h"
#import "BJLRSSAppStore.h"

@interface BJLRSSAppSwitcherWC ()
@property (weak) IBOutlet NSTableView *availableRSSAppsTableView;
@property (copy) NSArray *availableRSSApps;
@property (strong) BJLRSSAppStore *rssStore;
@property (weak) IBOutlet NSButton *switchDefaultAppButton;
@end

@implementation BJLRSSAppSwitcherWC

#pragma mark - Setup

- (void)windowDidLoad
{
    [super windowDidLoad];
    self.rssStore = [[BJLRSSAppStore alloc] init];
    [self refreshAppList];
    [self.availableRSSAppsTableView setDoubleAction:@selector(tableRowDoubleClicked:)];
}

- (void)refreshAppList
{
    self.availableRSSApps = [self.rssStore allAvailableRSSApps];
    [self.availableRSSAppsTableView reloadData];
    [self configureAppSwitchButtonState];
}

- (void)configureAppSwitchButtonState
{
    if ([self.availableRSSAppsTableView selectedRow] == -1) {
        [self.switchDefaultAppButton setEnabled:NO];
    } else
        [self.switchDefaultAppButton setEnabled:YES];
}

#pragma mark - IBActions

- (IBAction)setDefaultRSSPressed:(id)sender 
{
    [self changeDefaultRSSApp];
}

- (void)tableRowDoubleClicked:(id)sender
{
    [self changeDefaultRSSApp];
}

- (void)changeDefaultRSSApp
{
    NSInteger selectedRow = [self.availableRSSAppsTableView selectedRow];
    if (selectedRow == -1) return;
    
    BJLRSSApp *selectedApp = self.availableRSSApps[selectedRow];
    
    if (selectedApp) {
        [self.rssStore changeDefaultRSSAppWithID:selectedApp.bundleID];
        [self refreshAppList];
    }
    [self configureAppSwitchButtonState];
}

- (IBAction)refreshRSSListPressed:(id)sender
{
    [self refreshAppList];
}

- (void)keyDown:(NSEvent *)theEvent
{
    if ([self.availableRSSAppsTableView selectedRow] != -1 && [theEvent keyCode] == 36) {
        [self changeDefaultRSSApp];
    }
}

#pragma mark - NSTableView Data Source & Delegate

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.availableRSSApps count];
}

- (id)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *identifier = [tableColumn identifier];
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
    
    BJLRSSApp *rssApp = self.availableRSSApps[row];
    [cellView.imageView setImage:rssApp.appIcon];
    
    NSTextField *textField = cellView.textField;
    if (rssApp.isDefaultRSSApp) {
        [textField setStringValue:[NSString stringWithFormat:@"%@ (Current Default)", rssApp.appName]];
        [textField setFont:[NSFont boldSystemFontOfSize:17]];
    } else {
        [textField setStringValue:rssApp.appName];
        [textField setFont:[NSFont systemFontOfSize:17]];
    }
    
    return cellView;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    [self configureAppSwitchButtonState];
}

@end
