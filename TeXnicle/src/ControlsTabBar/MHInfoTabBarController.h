//
//  MHInfoTabBarController.h
//  TeXnicle
//
//  Created by Martin Hewitson on 16/7/12.
//  Copyright (c) 2012 bobsoft. All rights reserved.
//
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//      * Redistributions of source code must retain the above copyright
//        notice, this list of conditions and the following disclaimer.
//      * Redistributions in binary form must reproduce the above copyright
//        notice, this list of conditions and the following disclaimer in the
//        documentation and/or other materials provided with the distribution.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL DAN WOOD, MIKE ABDULLAH OR KARELIA SOFTWARE BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//   LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import <Foundation/Foundation.h>

extern NSString * const TPInfoControlsTabSelectionDidChangeNotification;

@interface MHInfoTabBarController : NSResponder <NSTabViewDelegate>  {
  
  
@private
  NSArray *buttons;
  NSButton *bookmarksButton;
  NSButton *warningsButton;
  NSButton *spellingButton;
  NSTabView *tabView;
  NSSplitView *splitview;
  NSView *containerView;
}

@property (assign) IBOutlet NSButton *bookmarksButton;
@property (assign) IBOutlet NSButton *warningsButton;
@property (assign) IBOutlet NSButton *spellingButton;
@property (assign) IBOutlet NSSplitView *splitview;
@property (assign) IBOutlet NSView *containerView;
@property (assign) IBOutlet NSTabView *tabView;

- (void) toggleOn:(id)except;
- (NSInteger) indexOfSelectedTab;
- (void) selectTabAtIndex:(NSInteger)index;

- (IBAction)buttonSelected:(id)sender;

- (id) buttonForTabIndex:(NSInteger)index;
- (NSInteger)tabIndexForButton:(id)sender;

#pragma mark -
#pragma mark Control


@end
