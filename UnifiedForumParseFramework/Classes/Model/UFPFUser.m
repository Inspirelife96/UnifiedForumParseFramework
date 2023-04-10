//
//  UFPFUser.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import "UFPFUser.h"

#import "UFPFDefines.h"

@implementation UFPFUser

@dynamic account;
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
    return UFPFUserKeyClass;
}

@end
