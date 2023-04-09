//
//  UFPFService+Tag.h
//  UnifiedForumParseFramework
//
//  Created by XueFeng Chen on 2023/3/4.
//

#import "UFPFService.h"

@class UFPFTag;

NS_ASSUME_NONNULL_BEGIN

@interface UFPFService (Tag)

+ (UFPFTag *)addTagWithName:(NSString *)name error:(NSError **)error;

+ (UFPFTag *)findTagWithName:(NSString *)name error:(NSError **)error;

+ (NSArray<UFPFTag *> *)findAllTags:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
