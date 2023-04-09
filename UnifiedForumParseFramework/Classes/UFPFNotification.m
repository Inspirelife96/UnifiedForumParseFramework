//
//  UFPFNotification.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/20.
//

#import "UFPFNotification.h"

#import <Parse/PFObject+Subclass.h>

#import "UFPFDefines.h"

@implementation UFPFNotification

@dynamic fromUserProfile;
@dynamic toUserProfile;
@dynamic type;
@dynamic subType;
@dynamic topic;
@dynamic post;
@dynamic reply;
@dynamic messageGroup;

+ (NSString *)parseClassName {
    return UFPFNotificationKeyClass;
}

@end
