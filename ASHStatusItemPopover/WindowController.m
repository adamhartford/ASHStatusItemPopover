//
//  WindowController.m
//  ASHStatusItemPopover
//
//  Created by Adam Hartford on 12/19/13.
//  Copyright (c) 2013 Adam Hartford. All rights reserved.
//

#import "WindowController.h"

@implementation WindowController

- (IBAction)sayIt:(id)sender
{
    _label.stringValue = _textField.stringValue;
}

@end
