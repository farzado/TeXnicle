//
//  TPConsoleViewControllerViewController.h
//  TeXnicle
//
//  Created by Martin Hewitson on 10/03/12.
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
//  DISCLAIMED. IN NO EVENT SHALL MARTIN HEWITSON OR BOBSOFT SOFTWARE BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//   LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import <Cocoa/Cocoa.h>
#import "MHConsoleViewer.h"
#import "MHStrokedFiledView.h"
#import "TPTeXLogViewController.h"

@protocol TPConsoleDelegate <NSObject, TPTeXLogViewDelegate>

- (void) didChangeLogOutputLevel:(NSInteger)view;
- (void) didSelectConsoleView:(NSInteger)view;
- (void) didSelectLogInfoItems:(BOOL)state;
- (void) didSelectLogWarningItems:(BOOL)state;
- (void) didSelectLogErrorItems:(BOOL)state;

- (NSInteger)logOutputLevel;
- (NSInteger)consoleView;
- (BOOL)showLogInfoItems;
- (BOOL)showLogWarningItems;
- (BOOL)showLogErrorItems;


@end


@interface TPConsoleViewController : NSViewController <MHConsoleViewer, TPTeXLogViewDelegate, TPConsoleDelegate> {
@private
  
}

@property (assign) id<TPConsoleDelegate> delegate;

- (id) initWithDelegate:(id<TPConsoleDelegate>)aDelegate;

- (IBAction) clear:(id)sender;
- (void) clear;
- (void) appendText:(NSString*)someText;
- (void) appendText:(NSString*)someText withColor:(NSColor*)aColor;
- (void) error:(NSString*)someText;
- (void) message:(NSString*)someText;
- (void) loadLogAtPath:(NSString*)path;
- (IBAction) displayLevelChanged:(id)sender;

@end
