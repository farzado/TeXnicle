//
//  MHThreePaneSplitViewController.m
//  TeXnicle
//
//  Created by Martin Hewitson on 25/11/11.
//  Copyright (c) 2011 bobsoft. All rights reserved.
//

#import "MHThreePaneSplitViewController.h"

#define kSplitViewLeftMinSize 230.0
#define kSplitViewCenterMinSize 400.0
#define kSplitViewRightMinSize 400.0


@implementation MHThreePaneSplitViewController

@synthesize leftView;
@synthesize centerView;
@synthesize rightView;
@synthesize mainSplitView;

- (void)splitView:(NSSplitView *)sender resizeSubviewsWithOldSize:(NSSize)oldSize
{
  //  NSLog(@"Resize with old size %@", NSStringFromSize(oldSize));
  
  NSSize splitViewSize = [sender frame].size;  
  NSSize leftSize = [leftView frame].size;
  leftSize.height = splitViewSize.height;
  
  NSSize centerSize = [centerView frame].size;
  centerSize.height = splitViewSize.height;
  
  NSSize rightSize;
  rightSize.width = splitViewSize.width - centerSize.width;
  rightSize.width -= 2.0*[sender dividerThickness];
  
  if (![sender isSubviewCollapsed:leftView]) {
    rightSize.width -= leftSize.width;
  }
  
  rightSize.height = splitViewSize.height;
  
  if (![sender isSubviewCollapsed:leftView]) {
    [leftView setFrameSize:leftSize];
  }
  [centerView setFrameSize:centerSize];
  if (![sender isSubviewCollapsed:rightView]) {
    [rightView setFrameSize:rightSize];
  }
  
  [sender adjustSubviews];
}

- (BOOL)splitView:(NSSplitView *)splitView shouldAdjustSizeOfSubview:(NSView *)subview
{
  
  if (subview == leftView || subview == centerView)
    return NO;
  
  
  if (subview == rightView) {
    NSRect b = [rightView bounds];
    if (b.size.width < kSplitViewRightMinSize) {
      return NO;
    }
  }
  
  return YES;
}


- (BOOL)splitView:(NSSplitView *)splitView canCollapseSubview:(NSView *)subview
{
  if (subview == centerView) {
    return NO;
  }
  
  return YES;
}

- (CGFloat)splitView:(NSSplitView *)splitView constrainMaxCoordinate:(CGFloat)proposedMax ofSubviewAt:(NSInteger)dividerIndex
{
  if (dividerIndex == 0) {
    NSRect b = [splitView bounds];
    NSRect rb = [rightView bounds];
    CGFloat max =  b.size.width - rb.size.width - kSplitViewCenterMinSize;
    return max;
  }
  
  if (dividerIndex == 1) {
    NSRect b = [splitView bounds];
    return b.size.width-kSplitViewRightMinSize;
  }
  
  return proposedMax;
}


- (CGFloat)splitView:(NSSplitView *)splitView constrainMinCoordinate:(CGFloat)proposedMin ofSubviewAt:(NSInteger)dividerIndex
{
  if (dividerIndex == 0) {
    return kSplitViewLeftMinSize;
  }
  
  if (dividerIndex == 1) {
    NSRect lb = [leftView bounds];
    
    if ([splitView isSubviewCollapsed:leftView]) {
      return kSplitViewCenterMinSize;
    }
    return lb.size.width + kSplitViewCenterMinSize;
  }
  
  
  
  return proposedMin;
}

- (NSSize)windowWillResize:(NSWindow *)sender toSize:(NSSize)frameSize
{
  NSSize leftSize = [leftView frame].size;
  NSSize centerSize = [centerView frame].size;  
  NSSize rightSize = [rightView frame].size;
  
  //  NSLog(@"Left %@", NSStringFromSize(leftSize));
  //  NSLog(@"Center %@", NSStringFromSize(centerSize));
  //  NSLog(@"Right %@", NSStringFromSize(rightSize));
  
  CGFloat w = 0.0;
  
  if (![mainSplitView isSubviewCollapsed:leftView]) {
    w += leftSize.width;
    w += [mainSplitView dividerThickness];
  }
  if (![mainSplitView isSubviewCollapsed:centerView]) {
    w += centerSize.width;
    w += [mainSplitView dividerThickness];
  }
  
  if (![mainSplitView isSubviewCollapsed:rightView]) {
    if ((frameSize.width - w) < 200.0) {
      frameSize.width = w + 200.0;
    }  
  }
  
  return frameSize; 
}

@end
