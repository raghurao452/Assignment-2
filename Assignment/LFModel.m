//
//  LFModel.m
//  Assignment
//
//  Created by Raghavendher on 26/04/16.
//  Copyright © 2016 J. All rights reserved.
//

#import "LFModel.h"

@implementation LFModel

-(instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        _frequency = dict[@"freq"];
        _since = dict[@"since"];
        _longForm = dict[@"lf"];
    }
    return self;
}

-(NSString *)description {
    return self.longForm;
}

@end
