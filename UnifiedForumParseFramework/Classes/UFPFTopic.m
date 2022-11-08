//
//  UFPFTopic.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import "UFPFTopic.h"

#import <Parse/PFObject+Subclass.h>

#import "UFPFDefines.h"

@implementation UFPFTopic

@dynamic isLocked;
@dynamic isDeleted;
@dynamic isPrivate;
@dynamic isApproved;
@dynamic isPopular;
@dynamic title;
@dynamic content;
@dynamic mediaFileObjects;
@dynamic mediaFileType;
@dynamic fromUser;
@dynamic postCount;
@dynamic likeCount;
@dynamic shareCount;
@dynamic category;
@dynamic tags;

+ (NSString *)parseClassName {
    return UFPFTopicKeyClass;
}

- (instancetype)init {
    if (self = [super init]) {
        self.isLocked = NO;
        self.isDeleted = NO;
        self.isPrivate = NO;
        self.isApproved = NO;
        self.isPopular = NO;
        self.title = @"";
        self.content = @"";
        self.mediaFileObjects = @[];
        self.mediaFileType = @"unknown";
        self.fromUser = [PFUser currentUser];
        self.postCount = @(0);
        self.likeCount = @(0);
        self.shareCount = @(0);
        self.category = @"";
        self.tags = @[];
    }
    
    return self;
}

@end
