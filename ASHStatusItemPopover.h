//
//  ASHStatusItemPopover.h
//  ASHStatusItemPopover
//
//  Created by Adam Hartford on 12/19/13.
//  Copyright (c) 2013 Adam Hartford. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define STATUS_ITEM_WIDTH 22

@interface ASHStatusItemPopover : NSImageView <NSPopoverDelegate>

@property (strong, nonatomic) NSWindowController *windowController;
@property (strong, nonatomic) NSImage *alternateImage;

@property (nonatomic, copy) void (^popoverWillShow)();
@property (nonatomic, copy) void (^popoverDidShow)();
@property (nonatomic, copy) void (^popoverWillClose)();
@property (nonatomic, copy) void (^popoverDidClose)();

@end

#pragma mark - ASHStatusItemPanel

@interface ASHStatusItemPanel : NSPanel
@end
