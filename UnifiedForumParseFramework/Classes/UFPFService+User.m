//
//  UFPFService+User.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "UFPFService+User.h"

#import <Parse/Parse-umbrella.h>
#import <Parse/PFErrorUtilities.h>

#import "UFPFDefines.h"
#import "UFPFUserProfile.h"
#import "UFPFBadgeCount.h"

#import "UFPFService+Installation.h"
#import "UFPFService+Session.h"

@implementation UFPFService (User)

+ (void)logInWithUsername:(NSString *)userName password:(NSString *)password error:(NSError **)error {
    // 使用Parse Server提供的登录API进行登录
    PFUser *user = [PFUser logInWithUsername:userName password:password error:error];
    
    if (*error) {
        return;
    } else {
        // 登录成功后，进行后续的处理
        BOOL succeeded = [UFPFService _configUserAfterLogin:user error:error];
        if (!succeeded) {
            [UFPFService logOut];
        }
    }
}

+ (BOOL)loginWithAppleAuthType:(NSString *)authType authData:(NSDictionary<NSString *, NSString *> *)authData error:(NSError **)error {
    __block BFTask *appleAuthTask;
    
    __block NSError *loginError = nil;
    
    // 调用由Parse Server 提供的第三方登录API
    [[[PFUser logInWithAuthTypeInBackground:authType authData:authData] continueWithBlock:^id _Nullable(BFTask<__kindof PFUser *> * _Nonnull task) {
        appleAuthTask = task;
        loginError = task.error;
        if (!task.isCancelled && !task.error) {
            PFUser *user = task.result;
            
            if (user) {
                BOOL succeeded = NO;
                if (user.isNew) {
                    // 第一次登录，则按注册走
                    succeeded = [UFPFService _configUserAfterSignUp:user error:&loginError];
                } else {
                    // 非第一次登录，则按登录走
                    succeeded = [UFPFService _configUserAfterLogin:user error:&loginError];
                }
 
                if (!succeeded) {
                    [UFPFService logOut];
                }
            }
        }
        
        return task;
    }] waitUntilFinished];
    
    *error = loginError;
    
    return appleAuthTask.isCompleted;
}

+ (void)logInWithAnonymous:(NSError **)error {
    __block NSError *loginError = nil;
    // 调用Parse Server的API进行匿名登录
    [[[PFAnonymousUtils logInInBackground] continueWithBlock:^id _Nullable(BFTask<PFUser *> * _Nonnull task) {
        loginError = task.error;
        if (!task.isCancelled && !task.error) {
            PFUser *user = task.result;
            
            if (user) {
                BOOL succeeded = NO;
                if (user.isNew) {
                    // 如果是第一次登录，那么等同于注册，进行注册的后续处理
                    succeeded = [UFPFService _configUserAfterSignUp:user error:&loginError];
                } else {
                    // 如果不是第一次登录，那么等同于登录，进行登录的后续处理
                    succeeded = [UFPFService _configUserAfterLogin:user error:&loginError];
                }
                
                if (!succeeded) {
                    [UFPFService logOut];
                }
            }
        }
        
        return task;
    }] waitUntilFinished];
    
    *error = loginError;
}

+ (void)upgradeCurrentAnonymousUserWithUsername:(NSString *)userName password:(NSString *)password email:(NSString *)email error:(NSError **)error {
    NSAssert([PFUser currentUser], @"Current User Must Exists");
    NSAssert([PFAnonymousUtils isLinkedWithUser:[PFUser currentUser]], @"Current User Must a Anonymous User");
    
    PFUser *user = [PFUser currentUser];
    
    user.username = userName;
    user.password = password;
    user.email = email;
    
    [user signUp:error];
    
    return;
}

+ (void)signUpWithUsername:(NSString *)userName password:(NSString *)password email:(NSString *)email error:(NSError **)error {
    // 创建user
    PFUser *user = [PFUser user];
    user.username = userName;
    user.password = password;
    user.email = email;
    
    // 调用signUp注册
    BOOL succeeded = [user signUp:error];
    
    if (succeeded) {
        succeeded = [UFPFService _configUserAfterSignUp:user error:error];
        if (!succeeded) {
            [UFPFService logOut];
        }
    } else {
        return;
    }
}

+ (void)logOut {
    [UFPFService _configUserBeforeLogout];
    [PFUser logOut];
}

+ (void)unsubscribe:(NSError **)error {
    [UFPFService _unsubscribeUser:[PFUser currentUser] error:error];
    [UFPFService logOut];
}

+ (void)requestPasswordResetForEmail:(NSString *)email error:(NSError **)error {
    [PFUser requestPasswordResetForEmail:email error:error];
}

#pragma mark Private Methods

+ (BOOL)_configUserAfterLogin:(PFUser *)user error:(NSError **)error {
    // 提取statisticsInfo
    BOOL succeeded =  [UFPFService _fetchUserProfileForUser:user error:error];
    
    // 提取BadgeCount
    if (succeeded) {
        succeeded = [UFPFService _fetchBadgeCountForUser:user error:error];
    }
    
    // 将当前用户和当前设备进行关联
    if (succeeded) {
        succeeded = [UFPFService linkCurrentInstalltionWithCurrentUser:error];
    }
        
    // 当前Session为激活的session，删除其他过期的Session
    if (succeeded) {
        succeeded = [UFPFService removeInvalidSessions:error];
    }
    
    UFPFUserProfile *userProfile = [user objectForKey:UFPFUserKeyUserProfile];

    // 判断该用户是否被锁定
    if ([userProfile objectForKey:UFPFUserProfileKeyIsLocked]) {
        *error = [PFErrorUtilities errorWithCode:kUFPFErrorUserIsLocked message:@"The User is Locked"];
        return NO;
    }
    
    // 判断该用户是否被注销
    if ([userProfile objectForKey:UFPFUserProfileKeyIsDeleted]) {
        *error = [PFErrorUtilities errorWithCode:kUFPFErrorUserIsDeleted message:@"The User is Deleted"];
        return NO;
    }
    
    return succeeded;
}

+ (BOOL)_configUserAfterSignUp:(PFUser *)user error:(NSError **)error {
    // 创建UFPFUserProfile并关联
    BOOL succeeded = [UFPFService _createUserProfileForUser:user error:error];
    
    // 创建BadgeCount并关联
    if (succeeded) {
        succeeded = [UFPFService _createBadgeCountForUser:user error:error];
    }
    
    // 将当前用户和当前设备进行关联
    if (succeeded) {
        succeeded = [UFPFService linkCurrentInstalltionWithCurrentUser:error];
    }    
    
    return succeeded;
}

// 用户退出登录之前，解除登录用户和当前设备的绑定。这样就不会推送和登录用户相关的信息。
+ (void)_configUserBeforeLogout {
    NSError *error = nil;
    [UFPFService unlinkCurrentInstalltionWithCurrentUser:&error];
    return;
}

+ (BOOL)_activeUser:(PFUser *)user error:(NSError **)error {
    [user setObject:@(NO) forKey:UFPFUserProfileKeyIsLocked];
    [user setObject:@(NO) forKey:UFPFUserProfileKeyIsDeleted];
    return [user save:error];
}

+ (BOOL)_unsubscribeUser:(PFUser *)user error:(NSError **)error {
    [user setObject:@(YES) forKey:UFPFUserProfileKeyIsDeleted];
    return [user save:error];
}

+ (BOOL)_createUserProfileForUser:(PFUser *)user error:(NSError **)error {
    UFPFUserProfile *userProfile = [[UFPFUserProfile alloc] init];
    
    userProfile.user = user;
    userProfile.nickName = user.username;
    userProfile.avatar = nil;
    userProfile.backgroundImage = nil;
    userProfile.bio = nil;
    userProfile.preferredLanguage = [[[NSBundle mainBundle] preferredLocalizations] firstObject];;
    userProfile.isLocked = NO;
    userProfile.isDeleted = NO;
    userProfile.profileViews = @(0);
    userProfile.reputation = @(0);
    userProfile.topicCount = @(0);
    userProfile.postCount = @(0);
    userProfile.followerCount = @(0);
    userProfile.followingCount = @(0);
    userProfile.likedCount = @(0);
    
    BOOL succeeded = [userProfile save:error];
    
    if (succeeded) {
        [user setObject:userProfile forKey:UFPFUserKeyUserProfile];
        return [user save:error];
    } else {
        return NO;
    }
}

+ (BOOL)_fetchUserProfileForUser:(PFUser *)user error:(NSError **)error {
    UFPFUserProfile *userProfile = [user objectForKey:UFPFUserKeyUserProfile];
    if (userProfile) {
        return [userProfile fetchIfNeeded:error];
    } else {
        return [UFPFService _createUserProfileForUser:user error:error];
    }
}

+ (BOOL)_createBadgeCountForUser:(PFUser *)user error:(NSError **)error {
    UFPFBadgeCount *badgeCount = [[UFPFBadgeCount alloc] init];
    
    badgeCount.user = user;
    badgeCount.totalCount = @(0);
    badgeCount.commentCount = @(0);
    badgeCount.likeCount = @(0);
    badgeCount.followCount = @(0);
    badgeCount.messageCount = @(0);
    badgeCount.otherCount = @(0);
    
    BOOL succeeded = [badgeCount save:error];
    
    if (succeeded) {
        [user setObject:badgeCount forKey:UFPFUserKeyBadgeCount];
        return [user save:error];
    } else {
        return NO;
    }
}

+ (BOOL)_fetchBadgeCountForUser:(PFUser *)user error:(NSError **)error {
    UFPFBadgeCount *badgeCount = [user objectForKey:UFPFUserKeyBadgeCount];
    if (badgeCount) {
        return [badgeCount fetchIfNeeded:error];
    } else {
        return [UFPFService _createBadgeCountForUser:user error:error];
    }
}

// 绑定用户和设备，重置badge
//+ (BOOL)_linkPushWithUser:(PFUser *)user error:(NSError **)error {
//    [[PFInstallation currentInstallation] setObject:user forKey:@"user"];
//    [[PFInstallation currentInstallation] setBadge:0];
//    return [[PFInstallation currentInstallation] save:error];
//}
//
//// 解除用户和设备绑定，重置badge
//+ (void)_unlinkPushWithUser {
//    [[PFInstallation currentInstallation] removeObjectForKey:@"user"];
//    [[PFInstallation currentInstallation] setBadge:0];
//    [[PFInstallation currentInstallation] saveEventually];
//}

// 一个用户仅允许一个session登录。查询当前用户的其他session，然后删除。
//+ (BOOL)_removeSessions:(PFUser *)user error:(NSError **)error {
//    PFQuery *querySession = [PFQuery queryWithClassName:@"_Session"];
//    [querySession whereKey:@"user" equalTo:user];
//    [querySession whereKey:@"sessionToken" notEqualTo:user.sessionToken];
//
//    NSArray *sessionArray = [querySession findObjects:error];
//
//    if (*error) {
//        return NO;
//    } else {
//        for (NSInteger i = 0; i < sessionArray.count; i++) {
//            PFSession *sessionObject = sessionArray[i];
//            [sessionObject delete:error];
//
//            if (*error) {
//                return NO;
//            }
//        }
//
//        return YES;
//    }
//}

@end
