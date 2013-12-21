//
//  ASHStatusItemPopover.m
//  ASHStatusItemPopover
//
//  Created by Adam Hartford on 12/19/13.
//  Copyright (c) 2013 Adam Hartford. All rights reserved.
//

#import "ASHStatusItemPopover.h"

@interface ASHStatusItemPopover ()
{
    BOOL _active;
    NSStatusItem *_statusItem;
    NSPopover *_popover;
    NSMenu *_dummyMenu;
    id _popoverTransiencyMonitor;
}
- (void)showPopover;
- (void)hidePopover;
- (void)toggleImage;
@end

@implementation ASHStatusItemPopover

- (id)init
{
    CGRect frame = CGRectMake(0, 0, STATUS_ITEM_WIDTH, [NSStatusBar systemStatusBar].thickness);
    
    if (self = [super initWithFrame:frame]) {
        // No dock icon, don't become active, don't focus.
        [NSApp setActivationPolicy:NSApplicationActivationPolicyProhibited];
        
        _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        _statusItem.view = self;
        
        _popover = [[NSPopover alloc] init];
        _popover.delegate = self;
        
        // We have the status item show a dummy menu to force other menu bar apps to close.
        _dummyMenu = [[NSMenu alloc] init];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    NSColor *color = _active ? [NSColor selectedMenuItemColor] : [NSColor clearColor];
    [color setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

- (void)setWindowController:(NSWindowController *)windowController
{
    windowController.window.level = NSPopUpMenuWindowLevel;
    [windowController.window setOpaque:NO];
    windowController.window.backgroundColor = [NSColor clearColor];
    _windowController = windowController;
}

- (void)mouseDown:(NSEvent *)theEvent
{
    if (!_active) [self showPopover];
    else [self hidePopover];
    [self setNeedsDisplay:YES];
}

- (void)showPopover
{
    _active = YES;
    [self toggleImage];
    [_statusItem popUpStatusItemMenu:_dummyMenu];
    
    // Copy the contents of the panel to an NSView
    NSData *archivedView = [NSKeyedArchiver archivedDataWithRootObject:_windowController.window.contentView];
    NSView *viewCopy = [NSKeyedUnarchiver unarchiveObjectWithData:archivedView];
    
    // We want to show the NSView with the panel's contents so that the NSPopover animation looks correct.
    // Once the popover is shown, we'll remove the subviews from the NSView and be left with the panel overlay.
    NSViewController *viewController = [[NSViewController alloc] init];
    viewCopy.window.level = NSSubmenuWindowLevel;
    viewController.view = viewCopy;
    _popover.contentViewController = viewController;
    [_popover showRelativeToRect:self.frame ofView:self preferredEdge:NSMinYEdge];
    
    // Close the popover if we click anywhere outside the view.
    _popoverTransiencyMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:NSLeftMouseDownMask|NSRightMouseDownMask handler:^(NSEvent* event) {
        [self hidePopover];
    }];
}

- (void)hidePopover
{
    _active = NO;
    [self toggleImage];
    [_windowController close];
    [_popover close];
    [NSEvent removeMonitor:_popoverTransiencyMonitor];
}

- (void)toggleImage
{
    NSImage *img = self.image;
    self.image = _alternateImage;
    _alternateImage = img;
}

#pragma mark - NSPopoverDelegate methods

- (void)popoverWillShow:(NSNotification *)notification
{
    if (_popoverWillShow) _popoverWillShow();
}

- (void)popoverDidShow:(NSNotification *)notification
{
    // Place the panel over the middle of the NSPopover view.
    CGPoint p = self.window.frame.origin;
    p.y -= _windowController.window.frame.size.height + 13;
    p.x -= (_windowController.window.frame.size.width / 2) - 11;
    
    // Bring the panel over the popover
    [_windowController.window setFrameOrigin:p];
    [_windowController.window makeKeyAndOrderFront:nil];
    
    NSMutableArray *views = [NSMutableArray arrayWithArray:_popover.contentViewController.view.subviews];
    for (NSView *view in views) [view removeFromSuperview];
    
    if (_popoverDidShow) _popoverDidShow();
}

- (void)popoverWillClose:(NSNotification *)notification
{
    if (_popoverWillClose) _popoverWillClose();
}

- (void)popoverDidClose:(NSNotification *)notification
{
    if (_popoverDidClose) _popoverDidClose();
}

@end

#pragma mark - ASHStatusItemPanel

@implementation ASHStatusItemPanel
- (BOOL)canBecomeKeyWindow { return YES; }
@end