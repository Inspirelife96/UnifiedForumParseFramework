//
//  UFPFService+UFPFBlock.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/21.
//

#import "UFPFService+UFPFBlock.h"

#import "UFPFDefines.h"

#import "UFPFBlock.h"

@implementation UFPFService (UFPFBlock)

+ (UFPFBlock *)addBlockFromUser:(UFPFUser *)fromUser toUser:(UFPFUser *)toUser error:(NSError **)error {
    UFPFBlock *block = [[UFPFBlock alloc] init];
    block.fromUser = fromUser;
    block.toUser = toUser;
    
    BOOL succeeded = [block save:error];
    
    if (succeeded) {
        return block;
    } else {
        return nil;
    }
}

+ (PFQuery *)buildBlockQueryWhereFromUserIs:(UFPFUser *)user {
    PFQuery *query = [PFQuery queryWithClassName:UFPFBlockKeyClass];
    [query whereKey:UFPFBlockKeyFromUser equalTo:user];
    return query;
}

// 逻辑删除
+ (BOOL)deleteBlock:(UFPFBlock *)block error:(NSError **)error {
    return [UFPFService _updateBlock:block isDeleted:YES error:error];
}

+ (BOOL)_updateBlock:(UFPFBlock *)block isDeleted:(BOOL)isDeleted error:(NSError **)error {
    block.isDeleted = isDeleted;
    return [block save:error];
}

// 逻辑删除
+ (BOOL)deleteBlockFromUser:(UFPFUser *)fromUser toUser:(UFPFUser *)toUser error:(NSError **)error {
    NSArray *blockArray = [UFPFService _findBlockFromUser:fromUser toUser:toUser isDeleted:NO error:error];
    
    if (*error) {
        return NO;
    } else {
        // 理论上应该只找到一条记录
        if (blockArray.count > 0) {
            // 删除所有
            for (NSInteger i = 0; i < blockArray.count; i++) {
                UFPFBlock *block = blockArray[i];
                BOOL succeeded = [UFPFService _updateBlock:block isDeleted:YES error:error];
                if (!succeeded) {
                    return NO;
                }
            }
            return YES;
        } else {
            return YES;//没找到，证明没有关注，不需要删除了
        }
    }
}

+ (NSArray *)_findBlockFromUser:(UFPFUser *)fromUser toUser:(UFPFUser *)toUser isDeleted:(BOOL)isDeleted error:(NSError **)error {
    PFQuery *query = [PFQuery queryWithClassName:UFPFBlockKeyClass];
    [query whereKey:UFPFBlockKeyFromUser equalTo:fromUser];
    [query whereKey:UFPFBlockKeyToUser equalTo:toUser];
    [query whereKey:UFPFBlockKeyIsDeleted equalTo:@(isDeleted)];
    
    return [query findObjects:error];
}

@end
