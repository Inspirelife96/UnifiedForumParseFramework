//
//  UFPFService+UserProfile.m
//  UnifiedForumParseFramework
//
//  Created by XueFeng Chen on 2023/4/9.
//

#import "UFPFService+UserProfile.h"

#import "UFPFDefines.h"

@implementation UFPFService (UserProfile)

+ (PFQuery *)buildUserProfileQueryWhereUserIsDeletedOrLocked {
    PFQuery *deletedUserQuery = [PFQuery queryWithClassName:UFPFUserProfileKeyClass];
    [deletedUserQuery whereKey:UFPFUserProfileKeyIsDeleted equalTo:@(YES)];
    
    PFQuery *lockedUserQuery = [PFQuery queryWithClassName:UFPFUserProfileKeyClass];
    [lockedUserQuery whereKey:UFPFUserProfileKeyIsLocked equalTo:@(YES)];
    
    return [PFQuery orQueryWithSubqueries:@[deletedUserQuery, lockedUserQuery]];
}

+ (PFQuery *)buildUserProfileQueryWhereUserIsDeleted {
    PFQuery *query = [PFQuery queryWithClassName:UFPFUserProfileKeyClass];
    [query whereKey:UFPFUserProfileKeyIsDeleted equalTo:@(YES)];
    return query;
}

+ (PFQuery *)buildUserProfileQueryWhereUserIsLocked {
    PFQuery *query = [PFQuery queryWithClassName:UFPFUserProfileKeyClass];
    [query whereKey:UFPFUserProfileKeyIsLocked equalTo:@(YES)];
    return query;
}

@end
