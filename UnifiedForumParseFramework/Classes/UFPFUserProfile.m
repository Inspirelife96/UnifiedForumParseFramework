//
//  UFPFUserProfile.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import "UFPFUserProfile.h"

#import "UFPFDefines.h"

@implementation UFPFUserProfile

@dynamic user;
@dynamic nickName;
@dynamic isLocked;
@dynamic isDeleted;
@dynamic avatar;
@dynamic backgroundImage;
@dynamic bio;
@dynamic preferredLanguage;
@dynamic profileViews;
@dynamic reputation;
@dynamic topicCount;
@dynamic postCount;
@dynamic followerCount;
@dynamic followingCount;
@dynamic likedCount;

+ (NSString *)parseClassName {
    return UFPFUserProfileKeyClass;
}

@end
