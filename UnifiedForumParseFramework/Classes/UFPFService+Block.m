//
//  UFPFService+Block.m
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/21.
//

#import "UFPFService+Block.h"

#import "UFPFDefines.h"

#import "UFPFBlock.h"

@implementation UFPFService (Block)

+ (UFPFBlock *)addBlockFromUserProfile:(UFPFUserProfile *)fromUserProfile toUserProfile:(UFPFUserProfile *)toUserProfile error:(NSError **)error {
    UFPFBlock *block = [[UFPFBlock alloc] init];
    block.fromUserProfile = fromUserProfile;
    block.toUserProfile = toUserProfile;
    
    BOOL succeeded = [block save:error];
    
    if (succeeded) {
        return block;
    } else {
        return nil;
    }
}

+ (PFQuery *)buildBlockQueryWhereFromUserProfileIs:(UFPFUserProfile *)userProfile {
    PFQuery *query = [PFQuery queryWithClassName:UFPFBlockKeyClass];
    [query whereKey:UFPFBlockKeyFromUserProfile equalTo:userProfile];
    return query;
}

@end
