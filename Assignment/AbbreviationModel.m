//
//  AbbreviationModel.m
//  Assignment
//
//  Created by Raghavendher on 26/04/16.
//  Copyright © 2016 J. All rights reserved.
//

#import "AbbreviationModel.h"
#import "LFModel.h"

@implementation AbbreviationModel

-(instancetype)initWithArray:(NSArray *)array {
    if (self = [super init]) {
        _shortForm = [array firstObject][@"sf"];
        _longForms = [self longFormsArray:[array firstObject][@"lfs"]];
        
    }
    return self;
}

-(NSArray <LFModel*>*)longFormsArray:(NSArray *)lfs {
    NSMutableArray <LFModel*>* longForms = [@[]mutableCopy];
    for (NSDictionary *object in lfs) {
        [longForms addObject:[[LFModel alloc] initWithDictionary:object]];
    }
    return longForms;
}

-(NSString *)description {
    return [self.longForms componentsJoinedByString:@"&"];
}

@end
