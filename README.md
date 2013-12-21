# ASHStatusItemPopover
Shows an NSPopover from the status bar. Uses NSWindowController with an NSPanel overlay for the look/feel and user interactions you expect in menu bar applications.

## Screenshot

![equation](https://raw.github.com/adamhartford/ASHStatusItemPopover/master/screenshot.png "AXStatusItemPopup")

## Why?

There are lots of status bar + NSPopover projects on GitHub, but for me they suffer from one or more of the following problems:

1. They don't use NSPopover, so don't have the right look and feel, or animation.
2. They use a regular NSViewController with an NSPopover, which you'd expect, but means...
3. Application gets focus when interacting with controls.
4. Controls become disabled when you try to prevent focus.
  
## Goal

A usable status item + NSPopover solution that looks/feels like the menu bar apps you're used to.

## Usage

1. Add ASHStatusItemPopover.h and ASHStatusItemPopover.m to your project.
2. Create an NSWindowController for an ASHStatusItemPanel.
3. Set window controller, image, and alternate image on ASHStatusItemPopover object.

See the demo for an example.

## Code

```objective-c
MyWindowController *windowController = [MyWindowController alloc] initWithNibName:@"MyWindowController"];
ASHStatusItemPopover *statusItemPopover = [[ASHStatusItemPopover alloc] init];
statusItemPopover.windowController = windowController;
statusItemPopover.image = [NSImage imageNamed:@"image"];
statusItemPopover.alternateImage = [NSImage imageNamed:@"alternateImage"];
```

## Blocks

```objective-c
@property (nonatomic, copy) void (^popoverWillShow)();
@property (nonatomic, copy) void (^popoverDidShow)();
@property (nonatomic, copy) void (^popoverWillClose)();
@property (nonatomic, copy) void (^popoverDidClose)();
```

## Licence

Copyright (C) 2013 Adam Hartford

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
