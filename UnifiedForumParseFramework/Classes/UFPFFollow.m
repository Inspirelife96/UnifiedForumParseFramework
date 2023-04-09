//
//  UFPFFollow.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import "UFPFFollow.h"

#import <Parse/PFObject+Subclass.h>

#import "UFPFDefines.h"

@implementation UFPFFollow

@dynamic fromUserProfile;
@dynamic toUserProfile;
@dynamic isDeleted;

+ (NSString *)parseClassName {
    return UFPFFollowKeyClass;
}

@end
