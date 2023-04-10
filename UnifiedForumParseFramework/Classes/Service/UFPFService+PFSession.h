//
//  UFPFService+PFSession.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/7/1.
//

#import "UFPFService.h"

NS_ASSUME_NONNULL_BEGIN

@interface UFPFService (PFSession)

+ (BOOL)removeInvalidSessions:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
