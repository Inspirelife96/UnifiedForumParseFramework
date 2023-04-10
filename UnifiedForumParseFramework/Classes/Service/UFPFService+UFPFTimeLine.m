//
//  UFPFService+UFPFTimeLine.m
//  UnifiedForumParseFramework
//
//  Created by XueFeng Chen on 2023/2/19.
//

#import "UFPFService+UFPFTimeLine.h"

#import "UFPFTimeLine.h"

#import "UFPFDefines.h"

@implementation UFPFService (UFPFTimeLine)

+ (NSArray<UFPFTimeLine *> *)findTimeLineOfUser:(PFUser *)user
                                           page:(NSInteger)page
                                      pageCount:(NSInteger)pageCount
                                          error:(NSError **)error {
    PFQuery *query = [PFQuery queryWithClassName:UFPFTimeLineKeyClass];
    [query whereKey:UFPFTimeLineKeyFromUser equalTo:user];
    [query whereKey:UFPFPostKeyIsDeleted equalTo:@(NO)];
    
    [query orderByDescending:UFPFKeyCreatedAt];
    
    [query setSkip:pageCount * page];
    [query setLimit:pageCount];
    
    return [query findObjects:error];
}

@end
