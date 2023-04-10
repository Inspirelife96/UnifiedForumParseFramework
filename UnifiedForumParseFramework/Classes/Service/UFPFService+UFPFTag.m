//
//  UFPFService+UFPFTag.m
//  UnifiedForumParseFramework
//
//  Created by XueFeng Chen on 2023/3/4.
//

#import "UFPFService+UFPFTag.h"

#import "UFPFTag.h"
#import "UFPFDefines.h"

@implementation UFPFService (UFPFTag)

+ (UFPFTag *)addTagWithName:(NSString *)name error:(NSError **)error {
    UFPFTag *tag = [[UFPFTag alloc] init];
    tag.name = name;
    
    BOOL succeeded = [tag save:error];
    
    if (succeeded) {
        return tag;
    } else {
        return nil;
    }
}

+ (UFPFTag *)findTagWithName:(NSString *)name error:(NSError **)error {
    PFQuery *query = [PFQuery queryWithClassName:UFPFTagKeyClass];
    [query whereKey:UFPFCategoryKeyName equalTo:name];
    
    NSArray<UFPFTag *> *tags = [query findObjects:error];
    
    if (*error) {
        return nil;
    } else {
        if (tags.count > 0) {
            return tags[0];
        } else {
            return nil;
        }
    }
}

+ (NSArray<UFPFTag *> *)findAllTags:(NSError **)error {
    PFQuery *query = [PFQuery queryWithClassName:UFPFTagKeyClass];
    return [query findObjects:error];
}

@end
