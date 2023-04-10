//
//  UFPFService+PFInstallation.h
//  UFPFParse
//
//  Created by XueFeng Chen on 2022/6/8.
//

#import "UFPFService.h"

NS_ASSUME_NONNULL_BEGIN

@interface UFPFService (PFInstallation)

+ (BOOL)linkCurrentInstalltionWithCurrentAccount:(NSError **)error;

+ (BOOL)unlinkCurrentInstalltionWithCurrentAccount:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
