ASHStatusItemPopover
====================

Show an NSPopover from the status bar. Looks and feels like you'd expect.

Why?
====

There are lots of status bar + NSPopover projects on GitHub, but for me they suffer from one or more of the following problems:

1. They don't use NSPopover, so don't have the right look and feel, or animation.

2. They use a regular NSViewController with an NSPopover, which you'd expect, but that has these problems:

  a. Application gets focus when controls are used.
  
  b. Controls become disabled when you try to prevent focus.
  
Goal
====

I want to have a usable status item + NSPopover solution that looks/feels like the menu bar apps you're used to using.
