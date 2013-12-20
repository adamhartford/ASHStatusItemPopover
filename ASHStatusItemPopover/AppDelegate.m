//
//  AppDelegate.m
//  ASHStatusItemPopover
//
//  Created by Adam Hartford on 12/19/13.
//  Copyright (c) 2013 Adam Hartford. All rights reserved.
//

#import "AppDelegate.h"

#import "ASHStatusItemPopover.h"
#import "WindowController.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    ASHStatusItemPopover *statusItemPopover = [[ASHStatusItemPopover alloc] init];
    statusItemPopover.windowController = [[WindowController alloc] initWithWindowNibName:@"WindowController"];
    statusItemPopover.image = [NSImage imageNamed:@"statusImage"];
    statusItemPopover.alternateImage = [NSImage imageNamed:@"alternateImage"];
}

@end
