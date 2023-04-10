//
//  UFPFService+PFUser.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "UFPFService+UFPFUser.h"

#import <Parse/Parse-umbrella.h>
#import <Parse/PFErrorUtilities.h>

#import "UFPFDefines.h"
#import "UFPFUser.h"
#import "UFPFBadgeCount.h"

#import "UFPFService+PFInstallation.h"
#import "UFPFService+PFSession.h"

@implementation UFPFService (User)

+ (void)logInWithUsername:(NSString *)userName password:(NSString *)password error:(NSError **)error {
    // 使用Parse Server提供的登录API进行登录
    PFUser *account = [PFUser logInWithUsername:userName password:password error:error];
    
    if (*error) {
        return;
    } else {
        // 登录成功后，进行后续的处理
        BOOL succeeded = [UFPFService _configAcountAfterLogin:account error:error];
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
            PFUser *account = task.result;
            
            if (account) {
                BOOL succeeded = NO;
                if (account.isNew) {
                    // 第一次登录，则按注册走
                    succeeded = [UFPFService _configAccountAfterSignUp:account error:&loginError];
                } else {
                    // 非第一次登录，则按登录走
                    succeeded = [UFPFService _configAcountAfterLogin:account error:&loginError];
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
            PFUser *account = task.result;
            
            if (account) {
                BOOL succeeded = NO;
                if (account.isNew) {
                    // 如果是第一次登录，那么等同于注册，进行注册的后续处理
                    succeeded = [UFPFService _configAccountAfterSignUp:account error:&loginError];
                } else {
                    // 如果不是第一次登录，那么等同于登录，进行登录的后续处理
                    succeeded = [UFPFService _configAcountAfterLogin:account error:&loginError];
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

+ (void)upgradeCurrentAnonymousAccountWithUsername:(NSString *)userName password:(NSString *)password email:(NSString *)email error:(NSError **)error {
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
    PFUser *account = [PFUser user];
    account.username = userName;
    account.password = password;
    account.email = email;
    
    // 调用signUp注册
    BOOL succeeded = [account signUp:error];
    
    if (succeeded) {
        succeeded = [UFPFService _configAccountAfterSignUp:account error:error];
        if (!succeeded) {
            [UFPFService logOut];
        }
    } else {
        return;
    }
}

+ (void)logOut {
    [UFPFService _configAccountBeforeLogout];
    [PFUser logOut];
}

+ (void)unsubscribe:(NSError **)error {
    [UFPFService _unsubscribeAccount:[PFUser currentUser] error:error];
    [UFPFService logOut];
}

+ (void)requestPasswordResetForEmail:(NSString *)email error:(NSError **)error {
    [PFUser requestPasswordResetForEmail:email error:error];
}

#pragma mark Private Methods

+ (BOOL)_configAcountAfterLogin:(PFUser *)account error:(NSError **)error {
    // 提取statisticsInfo
    BOOL succeeded =  [UFPFService _fetchUserForAccount:account error:error];
    
    // 提取BadgeCount
    if (succeeded) {
        succeeded = [UFPFService _fetchBadgeCountForAccount:account error:error];
    }
    
    // 将当前用户和当前设备进行关联
    if (succeeded) {
        succeeded = [UFPFService linkCurrentInstalltionWithCurrentAccount:error];
    }
        
    // 当前Session为激活的session，删除其他过期的Session
    if (succeeded) {
        succeeded = [UFPFService removeInvalidSessions:error];
    }
    
    UFPFUser *user = [account objectForKey:PFUserKeyUser];

    // 判断该用户是否被锁定
    if ([user objectForKey:UFPFUserKeyIsLocked]) {
        *error = [PFErrorUtilities errorWithCode:kUFPFErrorUserIsLocked message:@"The User is Locked"];
        return NO;
    }
    
    // 判断该用户是否被注销
    if ([user objectForKey:UFPFUserKeyIsDeleted]) {
        *error = [PFErrorUtilities errorWithCode:kUFPFErrorUserIsDeleted message:@"The User is Deleted"];
        return NO;
    }
    
    return succeeded;
}

+ (BOOL)_configAccountAfterSignUp:(PFUser *)account error:(NSError **)error {
    // 创建UFPFUser并关联
    BOOL succeeded = [UFPFService _createUserForAccount:account error:error];
    
    // 创建BadgeCount并关联
    if (succeeded) {
        succeeded = [UFPFService _createBadgeCountForAccount:account error:error];
    }
    
    // 将当前用户和当前设备进行关联
    if (succeeded) {
        succeeded = [UFPFService linkCurrentInstalltionWithCurrentAccount:error];
    }    
    
    return succeeded;
}

// 用户退出登录之前，解除登录用户和当前设备的绑定。这样就不会推送和登录用户相关的信息。
+ (void)_configAccountBeforeLogout {
    NSError *error = nil;
    [UFPFService unlinkCurrentInstalltionWithCurrentAccount:&error];
    return;
}

+ (BOOL)_unsubscribeAccount:(PFUser *)account error:(NSError **)error {
    UFPFUser *user = [account objectForKey:PFUserKeyUser];
    [user setObject:@(YES) forKey:UFPFUserKeyIsDeleted];
    return [user save:error];
}

+ (BOOL)_createUserForAccount:(PFUser *)account error:(NSError **)error {
    UFPFUser *user = [[UFPFUser alloc] init];
    
    user.account = account;
    user.nickName = account.username;
    user.avatar = nil;
    user.backgroundImage = nil;
    user.bio = nil;
    user.preferredLanguage = [[[NSBundle mainBundle] preferredLocalizations] firstObject];;
    user.isLocked = NO;
    user.isDeleted = NO;
    user.profileViews = @(0);
    user.reputation = @(0);
    user.topicCount = @(0);
    user.postCount = @(0);
    user.followerCount = @(0);
    user.followingCount = @(0);
    user.likedCount = @(0);
    
    BOOL succeeded = [user save:error];
    
    if (succeeded) {
        [user setObject:user forKey:PFUserKeyUser];
        return [user save:error];
    } else {
        return NO;
    }
}

+ (BOOL)_fetchUserForAccount:(PFUser *)account error:(NSError **)error {
    UFPFUser *user = [account objectForKey:PFUserKeyUser];
    if (user) {
        return [user fetchIfNeeded:error];
    } else {
        return [UFPFService _createUserForAccount:account error:error];
    }
}

+ (BOOL)_createBadgeCountForAccount:(PFUser *)account error:(NSError **)error {
    UFPFBadgeCount *badgeCount = [[UFPFBadgeCount alloc] init];
    
    badgeCount.account = account;
    badgeCount.totalCount = @(0);
    badgeCount.postCount = @(0);
    badgeCount.likeCount = @(0);
    badgeCount.followCount = @(0);
    badgeCount.messageCount = @(0);
    badgeCount.otherCount = @(0);
    
    BOOL succeeded = [badgeCount save:error];
    
    if (succeeded) {
        [account setObject:badgeCount forKey:PFUserKeyBadgeCount];
        return [account save:error];
    } else {
        return NO;
    }
}

+ (BOOL)_fetchBadgeCountForAccount:(PFUser *)account error:(NSError **)error {
    UFPFBadgeCount *badgeCount = [account objectForKey:PFUserKeyBadgeCount];
    if (badgeCount) {
        return [badgeCount fetchIfNeeded:error];
    } else {
        return [UFPFService _createBadgeCountForAccount:account error:error];
    }
}

// 绑定用户和设备，重置badge
//+ (BOOL)_linkPushWithUser:(PFUser *)account error:(NSError **)error {
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
//+ (BOOL)_removeSessions:(PFUser *)account error:(NSError **)error {
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
