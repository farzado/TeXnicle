//
//  TPStatusViewController.m
//  TeXnicle
//
//  Created by Martin Hewitson on 9/11/11.
//  Copyright (c) 2011 bobsoft. All rights reserved.
//

#import "TPStatusViewController.h"

@implementation TPStatusViewController

@synthesize editorStatusTextField;
@synthesize filenameTextField;
@synthesize editorStatusText = _editorStatusText;
@synthesize filenameText = _filenameText;
@synthesize showRevealButton;
@synthesize revealButton;
@synthesize rightPanel;

- (id) init
{
  self = [super initWithNibName:@"TPStatusViewController" bundle:nil];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

- (void) dealloc
{
  self.editorStatusText = nil;
  self.filenameText = nil;
  [super dealloc];
}

- (void)awakeFromNib
{
  [[self.editorStatusTextField cell] setBackgroundStyle:NSBackgroundStyleRaised];
  [[self.filenameTextField cell] setBackgroundStyle:NSBackgroundStyleRaised];
  
  [self.view setPostsFrameChangedNotifications:YES];
  
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  [nc addObserver:self
         selector:@selector(handleBoundsDidChangeNotification:) 
             name:NSViewFrameDidChangeNotification 
           object:self.view];
  
  [self.rightPanel setStrokeLeftSide:YES];
  
}

- (void)setFilenameText:(NSString *)filenameText
{
  if (_filenameText) {
    [_filenameText release];
  }
  _filenameText = [filenameText copy];
  
  if (_filenameText) {
    [self.filenameTextField setStringValue:_filenameText];
    [self resizeLabels];
  }
  
}

- (void) handleBoundsDidChangeNotification:(NSNotification*)aNote
{
  [self resizeLabels];
  [self.rightPanel setNeedsDisplay:YES];
}

- (void) resizeLabels
{
  NSRect br = [self.revealButton frame];
  // size to fit
  NSRect cr = [self.rightPanel frame];
  NSSize s = [[self.filenameTextField attributedStringValue] size];
  NSRect r = [self.filenameTextField frame];
  CGFloat w = MIN(10.0 + s.width, cr.size.width - br.size.width - 2.0 - 10.0);
  
  [self.filenameTextField setFrameSize:NSMakeSize(w, r.size.height)];
  // move button
  r = [self.filenameTextField frame];
  [self.revealButton setFrameOrigin:NSMakePoint(r.origin.x + r.size.width + 2.0, br.origin.y)];
}

- (NSString*)filenameText
{
  return _filenameText;
}

- (void)setEditorStatusText:(NSString *)editorStatusText
{
  if (_editorStatusText) {
    [_editorStatusText release];
  }
  _editorStatusText = [editorStatusText copy];
  if (_editorStatusText) {
    [self.editorStatusTextField setStringValue:_editorStatusText];
//    NSSize s = [[self.editorStatusTextField attributedStringValue] size];
//    NSRect r = [self.editorStatusTextField frame];
//    [self.editorStatusTextField setFrameSize:NSMakeSize(s.width, r.size.height)];
  }
}

- (NSString*)editorStatusText
{
  return _editorStatusText;
}

- (void)setShowRevealButton:(BOOL)state
{
  _showRevealButton = state;
  [self.revealButton setHidden:!state];
}

- (void) enable:(BOOL)state
{
  [self.revealButton setHidden:!state];
  [self.editorStatusTextField setHidden:!state];
  [self.filenameTextField setHidden:!state];
}

- (BOOL)showRevealButton
{
  return _showRevealButton;
}

- (IBAction)revealFile:(id)sender
{
  
	NSWorkspace *ws = [NSWorkspace sharedWorkspace];
	[ws selectFile:self.filenameText inFileViewerRootedAtPath:[self.filenameText stringByDeletingLastPathComponent]];
  
}

@end
