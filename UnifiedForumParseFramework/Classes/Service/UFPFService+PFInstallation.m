//
//  UFPFService+PFInstallation.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/6/8.
//

#import "UFPFService+PFInstallation.h"

#import "UFPFDefines.h"

@implementation UFPFService (PFInstallation)

+ (BOOL)linkCurrentInstalltionWithCurrentAccount:(NSError **)error {
    if ([PFUser currentUser]) {
        
        // 查询installation表，先移除当前用户和其他设备的链接
        // 不允许客户端对Install表进行查询，因此这部分代码建议放在服务器里
//        PFQuery *query = [PFQuery queryWithClassName:PFInstalltionKeyClass];
//        [query whereKey:PFInstalltionKeyLinkedAccount equalTo:[PFUser currentUser]];
//
//        NSArray *installtionRecords = [query findObjects:error];
//
//        if (*error) {
//            return NO;
//        } else {
//            for (NSInteger i = 0; i < installtionRecords.count; i++) {
//                PFInstallation *instllation = installtionRecords[i];
//                [instllation removeObjectForKey:PFInstalltionKeyLinkedAccount];
//                [instllation save]; // 这边不需要调用[instllation save:error]，尝试清空，失败也没有关系
//            }
//        }
        
        // 将当前设备和当前用户进行关联
        [[PFInstallation currentInstallation] setObject:[PFUser currentUser] forKey:PFInstalltionKeyLinkedAccount];
        return [[PFInstallation currentInstallation] save:error];
    }
    
    return NO;
}

+ (BOOL)unlinkCurrentInstalltionWithCurrentAccount:(NSError **)error {
    [[PFInstallation currentInstallation] removeObjectForKey:PFInstalltionKeyLinkedAccount];
    return [[PFInstallation currentInstallation] save:error];
}

@end
