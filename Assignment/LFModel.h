//
//  LFModel.h
//  Assignment
//
//  Created by Raghavendher on 26/04/16.
//  Copyright © 2016 J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFModel : NSObject
@property (nonatomic,strong,readonly)NSString *longForm;
@property (nonatomic,strong,readonly)NSNumber *since;
@property (nonatomic,strong,readonly)NSNumber *frequency;
@property (nonatomic,strong,readonly)NSArray *variations;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
