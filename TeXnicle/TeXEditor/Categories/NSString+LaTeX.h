//
//  NSString+LaTeX.h
//  TeXnicle
//
//  Created by Martin Hewitson on 28/2/10.
//  Copyright 2010 bobsoft. All rights reserved.
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


@interface NSString (LaTeX) 

+ (NSString *)pathForTemporaryFileWithPrefix:(NSString *)prefix;
- (NSInteger) beginsWithElementInArray:(NSArray*)terms;
- (NSArray*) referenceLabels;
- (NSArray*) citations;
- (NSArray*) citationsFromBibliographyIncludedFromPath:(NSString*)sourceFile;
+ (NSString *)stringWithControlsFilteredForString:(NSString *)str ;
- (NSString *)nextWordStartingAtLocation:(NSUInteger*)loc;
- (NSString*)argument;
- (NSString*)command;
- (NSString*)parseOptionStartingAtIndex:(NSInteger)start;
- (NSString*)parseArgumentAroundIndex:(NSInteger*)loc;
- (NSString*)parseArgumentStartingAt:(NSInteger*)loc;
- (BOOL)characterIsEscapedAtIndex:(NSInteger)anIndex;
- (BOOL)isInArgumentAtIndex:(NSInteger)anIndex;
- (BOOL)isCommentLineBeforeIndex:(NSInteger)anIndex commentChar:(NSString*)commChar;
- (BOOL)isCommandBeforeIndex:(NSInteger)anIndex;
- (BOOL)isInCommandAtIndex:(NSInteger)anIndex;
- (BOOL)isInMathAtIndex:(NSInteger)anIndex;
- (NSString*)commandAtIndex:(NSInteger)index;
- (BOOL)isArgumentOfCommandAtIndex:(NSInteger)anIndex;
- (NSString*)texString;
- (BOOL)wordIsIncludeCommand;
- (NSArray*)commandRanges;
+ (BOOL)isArgumentAtIndex:(NSInteger)index forCommandsAtRanges:(NSArray*)ranges;

@end
