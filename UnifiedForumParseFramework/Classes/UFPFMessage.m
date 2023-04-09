//
//  UFPFMessage.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/5/28.
//

#import "UFPFMessage.h"

#import <Parse/PFObject+Subclass.h>

#import "UFPFDefines.h"

@implementation UFPFMessage

@dynamic fromUserProfile;
@dynamic toUserProfile;
@dynamic content;

+ (NSString *)parseClassName {
    return UFPFMessageKeyClass;
}

@end
