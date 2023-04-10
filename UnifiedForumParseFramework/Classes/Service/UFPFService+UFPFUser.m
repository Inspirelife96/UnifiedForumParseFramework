//
//  UFPFService+UFPFUser.m
//  UnifiedForumParseFramework
//
//  Created by XueFeng Chen on 2023/4/9.
//

#import "UFPFService+UFPFUser.h"

#import "UFPFDefines.h"

@implementation UFPFService (UFPFUser)

+ (PFQuery *)buildUserQueryWhereUserIsDeletedOrLocked {
    PFQuery *deletedUserQuery = [PFQuery queryWithClassName:UFPFUserKeyClass];
    [deletedUserQuery whereKey:UFPFUserKeyIsDeleted equalTo:@(YES)];
    
    PFQuery *lockedUserQuery = [PFQuery queryWithClassName:UFPFUserKeyClass];
    [lockedUserQuery whereKey:UFPFUserKeyIsLocked equalTo:@(YES)];
    
    return [PFQuery orQueryWithSubqueries:@[deletedUserQuery, lockedUserQuery]];
}

+ (PFQuery *)buildUserQueryWhereUserIsDeleted {
    PFQuery *query = [PFQuery queryWithClassName:UFPFUserKeyClass];
    [query whereKey:UFPFUserKeyIsDeleted equalTo:@(YES)];
    return query;
}

+ (PFQuery *)buildUserQueryWhereUserIsLocked {
    PFQuery *query = [PFQuery queryWithClassName:UFPFUserKeyClass];
    [query whereKey:UFPFUserKeyIsLocked equalTo:@(YES)];
    return query;
}

@end
