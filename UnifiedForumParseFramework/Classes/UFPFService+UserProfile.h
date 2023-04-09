//
//  UFPFService+UserProfile.h
//  UnifiedForumParseFramework
//
//  Created by XueFeng Chen on 2023/4/9.
//

#import "UFPFService.h"

NS_ASSUME_NONNULL_BEGIN

@interface UFPFService (UserProfile)

+ (PFQuery *)buildUserProfileQueryWhereUserIsDeletedOrLocked;

+ (PFQuery *)buildUserProfileQueryWhereUserIsDeleted;

+ (PFQuery *)buildUserProfileQueryWhereUserIsLocked;

@end

NS_ASSUME_NONNULL_END
