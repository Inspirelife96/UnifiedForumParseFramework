//
//  UFPFService+UFPFCategory.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/25.
//

#import "UFPFService.h"

NS_ASSUME_NONNULL_BEGIN

@class UFPFCategory;

@interface UFPFService (UFPFCategory)

+ (UFPFCategory *)addCategoryWithName:(NSString *)name
                             summary:(NSString *)summary
                 iconImageFileObject:(PFFileObject *)iconImageFileObject
           backgroundImageFileObject:(PFFileObject *)backgroundImageFileObject
                               error:(NSError **)error;

+ (UFPFCategory *)findCategoryWithName:(NSString *)name error:(NSError **)error;

+ (NSArray<UFPFCategory *> *)findAllCategories:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
