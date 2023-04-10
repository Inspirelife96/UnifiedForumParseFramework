//
//  UFPFService+UFPFUser.h
//  UnifiedForumParseFramework
//
//  Created by XueFeng Chen on 2023/4/9.
//

#import "UFPFService.h"

NS_ASSUME_NONNULL_BEGIN

@interface UFPFService (UFPFUser)

+ (PFQuery *)buildUserQueryWhereUserIsDeletedOrLocked;

+ (PFQuery *)buildUserQueryWhereUserIsDeleted;

+ (PFQuery *)buildUserQueryWhereUserIsLocked;

@end

NS_ASSUME_NONNULL_END
