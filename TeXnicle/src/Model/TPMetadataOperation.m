//
//  TPMetadataOperation.m
//  TeXnicle
//
//  Created by Martin Hewitson on 16/7/12.
//  Copyright (c) 2012 bobsoft. All rights reserved.
//

#import "TPMetadataOperation.h"
#import "RegexKitLite.h"
#import "NSString+LaTeX.h"
#import "NSString+SectionsOutline.h"
#import "FileDocument.h"

@implementation TPMetadataOperation

@synthesize text;

// inputs
@synthesize file;

// metadata
@synthesize commands;
@synthesize citations;
@synthesize syntaxErrors;
@synthesize labels;

- (id) initWithFile:(FileEntity*)aFile
{
  self = [super init];
  if (self) {
    self.text = [aFile workingContentString];
    self.file = aFile;
  }
  return self;
}

- (void) dealloc
{
  self.file = nil;
  self.commands = nil;
  self.citations = nil;
  self.syntaxErrors = nil;
  self.labels = nil;
  
  [super dealloc];
}


-(void)main {
  @try {
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    
    NSMutableArray *newCommands = [NSMutableArray array];
    
    //-------------- get commands
    if ([self isCancelled]) return;
    NSArray *parsedCommands = [self.text componentsMatchedByRegex:@"\\\\newcommand\\{\\\\[a-zA-Z]*\\}"];
    for (NSString *newCommand in parsedCommands) {
      [newCommands addObject:[newCommand argument]];
    }
    
    //-------------- get citatations
    if ([self isCancelled]) return;
    NSMutableArray *newCitations = [NSMutableArray array];
    NSArray *docTags = [self.text citations];			
    [newCitations addObjectsFromArray:docTags];			
    
    // add any citations from a \bibliography{} command
    if ([self isCancelled]) return;
    [newCitations addObjectsFromArray:[self.text citationsFromBibliographyIncludedFromPath:self.file.pathOnDisk]];
        
    //--------------- Labels    
    if ([self isCancelled]) return;
    self.labels = [self.text referenceLabels];			
    
    // update metadata        
    self.commands = newCommands;
    self.citations = newCitations;
    
    [pool release];
  }
  @catch(...) {
    // Do not rethrow exceptions.
  }
}



@end
