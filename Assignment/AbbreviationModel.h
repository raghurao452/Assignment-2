//
//  AbbreviationModel.h
//  Assignment
//
//  Created by Raghavendher on 26/04/16.
//  Copyright © 2016 J. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LFModel;

@interface AbbreviationModel : NSObject

@property (nonatomic,strong,readonly) NSString *shortForm;
@property (nonatomic,strong,readonly) NSArray <LFModel *> *longForms;

-(instancetype)initWithArray:(NSArray *)array;
@end
