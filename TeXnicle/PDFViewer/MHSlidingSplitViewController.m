//
//  MHSlidingSplitViewController.m
//  TestSlidingSplitView
//
//  Created by Martin Hewitson on 30/12/11.
//  Copyright (c) 2011 bobsoft. All rights reserved.
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

#import "MHSlidingSplitViewController.h"

@implementation MHSlidingSplitViewController
@synthesize rightSided;
@synthesize splitView;
@synthesize inspectorView;
@synthesize mainView;
@synthesize delegate;

#define kMinInspectorPanelWidth 64.0

- (void) awakeFromNib
{
  self.rightSided = YES;
}

- (IBAction)slideOut:(id)sender
{
  [self slideOutAnimated:YES];
}

- (void) slideOutAnimated:(BOOL)animate
{
  // Store last width so we can jump back
  lastInspectorWidth = self.inspectorView.frame.size.width;
  
  
  NSRect newMainFrame = self.mainView.frame;
  NSRect newInspectorFrame = self.inspectorView.frame;
  newMainFrame.size.width =  self.splitView.frame.size.width;
  newInspectorFrame.size.width = 0.0f;
  
  if (self.rightSided) {
    newInspectorFrame.origin.x = self.splitView.frame.size.width;
  } else {
    newMainFrame.origin.x = 0;
  }
  
  if (animate) {
    NSMutableDictionary *collapseMainAnimationDict = [NSMutableDictionary dictionaryWithCapacity:2];
    [collapseMainAnimationDict setObject:self.mainView forKey:NSViewAnimationTargetKey];
    [collapseMainAnimationDict setObject:[NSValue valueWithRect:newMainFrame] forKey:NSViewAnimationEndFrameKey];
    
    NSMutableDictionary *collapseInspectorAnimationDict = [NSMutableDictionary dictionaryWithCapacity:2];
    [collapseInspectorAnimationDict setObject:self.inspectorView forKey:NSViewAnimationTargetKey];
    [collapseInspectorAnimationDict setObject:[NSValue valueWithRect:newInspectorFrame] forKey:NSViewAnimationEndFrameKey];
    
    NSViewAnimation *collapseAnimation = [[[NSViewAnimation alloc] initWithViewAnimations:[NSArray arrayWithObjects:collapseMainAnimationDict, collapseInspectorAnimationDict, nil]] autorelease ];
    [collapseAnimation setDuration:0.25f];
    [collapseAnimation startAnimation];
  } else {
    [self.mainView setFrame:newMainFrame];
    [self.inspectorView setFrame:newInspectorFrame];
  }
}

- (IBAction)slideIn:(id)sender
{
  [self slideInAnimated:YES];
}

- (void) slideInAnimated:(BOOL)animate
{
  // NSSplitView hides the collapsed subview
  self.inspectorView.hidden = NO;
  
  NSRect newMainFrame = self.mainView.frame;
  NSRect newInspectorFrame = self.inspectorView.frame;
  newInspectorFrame.size.width = lastInspectorWidth;
  if (newInspectorFrame.size.width < kMinInspectorPanelWidth) {
    newInspectorFrame.size.width = kMinInspectorPanelWidth;
  }
  
  newMainFrame.size.width =  self.splitView.frame.size.width-lastInspectorWidth;
  if (self.rightSided) {
    newInspectorFrame.origin.x = self.splitView.frame.size.width-lastInspectorWidth;
  } else {
    newMainFrame.origin.x = lastInspectorWidth;
  }
  
  if (animate) {
    NSMutableDictionary *expandMainAnimationDict = [NSMutableDictionary dictionaryWithCapacity:2];
    [expandMainAnimationDict setObject:self.mainView forKey:NSViewAnimationTargetKey];
    [expandMainAnimationDict setObject:[NSValue valueWithRect:newMainFrame] forKey:NSViewAnimationEndFrameKey];
    
    NSMutableDictionary *expandInspectorAnimationDict = [NSMutableDictionary dictionaryWithCapacity:2];
    [expandInspectorAnimationDict setObject:self.inspectorView forKey:NSViewAnimationTargetKey];
    [expandInspectorAnimationDict setObject:[NSValue valueWithRect:newInspectorFrame] forKey:NSViewAnimationEndFrameKey];
    
    NSViewAnimation *expandAnimation = [[[NSViewAnimation alloc] initWithViewAnimations:[NSArray arrayWithObjects:expandMainAnimationDict, expandInspectorAnimationDict, nil]] autorelease];
    [expandAnimation setDuration:0.25f];
    [expandAnimation startAnimation];
  } else {
    [self.mainView setFrame:newMainFrame];
    [self.inspectorView setFrame:newInspectorFrame];
  }
  
}

- (IBAction)toggle:(id)sender 
{
  if ([self.splitView isSubviewCollapsed:self.inspectorView]) {
    [self slideInAnimated:YES];
  } else {
    [self slideOutAnimated:YES];
  }
}

- (BOOL)splitView:(NSSplitView *)aSplitView canCollapseSubview:(NSView *)subview {
  BOOL result = NO;
  if (aSplitView == self.splitView && subview == self.inspectorView) {
    result = YES;
  }
  return result;
}

- (BOOL)splitView:(NSSplitView *)aSplitView shouldCollapseSubview:(NSView *)subview forDoubleClickOnDividerAtIndex:(NSInteger)dividerIndex {
  BOOL result = NO;
  if (aSplitView == self.splitView && subview == self.inspectorView) {
    result = YES;
  }
  return result;
}

- (void)splitViewWillResizeSubviews:(NSNotification *)notification
{
}

- (void)splitViewDidResizeSubviews:(NSNotification *)aNotification
{
  // collapsing
  if (_sidePanelIsVisible == YES && [self.splitView isSubviewCollapsed:self.inspectorView]) {
    _sidePanelIsVisible = NO;
    // notify delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(splitView:didCollapseSubview:)]) {
      [self.delegate splitView:self.splitView didCollapseSubview:self.inspectorView];
    }
  }
  
  // uncollapsing
  if (_sidePanelIsVisible == NO && ![self.splitView isSubviewCollapsed:self.inspectorView]) {
    _sidePanelIsVisible = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(splitView:didUncollapseSubview:)]) {
      [self.delegate splitView:self.splitView didUncollapseSubview:self.inspectorView];
    }
    
  }
  
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMin ofSubviewAt:(NSInteger)dividerIndex
{
  if (self.rightSided == NO) {
    if (dividerIndex == 0) {
      return kMinInspectorPanelWidth;
    }
  }
  
  return proposedMin;
}

- (CGFloat)splitView:(NSSplitView *)aSplitView constrainMaxCoordinate:(CGFloat)proposedMaximumPosition ofSubviewAt:(NSInteger)dividerIndex
{
  if (self.rightSided == YES) {
    if (dividerIndex == 0) {
      NSRect r = [aSplitView bounds];
      return r.size.width - kMinInspectorPanelWidth;
    }
  }
  
  return proposedMaximumPosition;
}


@end