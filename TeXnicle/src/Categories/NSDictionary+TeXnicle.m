//
//  NSDictionary+TeXnicle.m
//  TeXnicle
//
//  Created by Martin Hewitson on 29/7/11.
//  Copyright 2011 bobsoft. All rights reserved.
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

#import "NSDictionary+TeXnicle.h"
#import "externs.h"
#import "NSArray+Color.h"
#import "TPThemeManager.h"

@implementation NSDictionary (TeXnicle)

+ (NSDictionary*)currentTypingAttributes
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  TPThemeManager *tm = [TPThemeManager sharedManager];
  TPTheme *theme = tm.currentTheme;
  NSFont *font = theme.editorFont;
  NSColor *color = theme.documentTextColor;
  
  NSMutableParagraphStyle *ps = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
  CGFloat lineHeightMultiple = [[defaults valueForKey:TEDocumentLineHeightMultiple] floatValue];
  //NSLog(@"Setting line height multiple %f", lineHeightMultiple);
  [ps setLineHeightMultiple:lineHeightMultiple];
  return @{NSFontAttributeName: font, NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName : [ps copy]};
}

@end
