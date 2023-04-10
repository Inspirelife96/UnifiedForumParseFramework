//
//  UnifiedForumParseFrameworkTests.m
//  UnifiedForumParseFrameworkTests
//
//  Created by inspirelife@hotmail.com on 11/08/2022.
//  Copyright (c) 2022 inspirelife@hotmail.com. All rights reserved.
//

#import <Parse/Parse-umbrella.h>
#import <UFPFService.h>
#import <UFPFService+UFPFTopic.h>
#import <UFPFService+UFPFUser.h>

@import XCTest;

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];

    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"oDzmpRypCHeD8K8bI8lD7yDpBGU1povw14h2dL9j";
        configuration.clientKey = @"";
        configuration.server = @"https://inspirelife2017.com/learnpaint2";
        configuration.networkRetryAttempts = 0;
        NSURLSessionConfiguration *URLSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        URLSessionConfiguration.timeoutIntervalForRequest = 60.0f;
        configuration.URLSessionConfiguration = URLSessionConfiguration;
    }]];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);

    
//    NSError *error = nil;
    
//    [UFPFService logInWithAnonymous:&error];
    
//    NSArray *array = [UFPFService findTopicsOrderBy:@"createdAt" page:0 pageCount:10 error:&error];
    
    
//    PFQuery *query = [PFQuery queryWithClassName:@"Topic"];
//
//    [query orderByDescending:@"createdAt"];
//
//    [query setLimit:5];
//
//    NSArray *array =  [query findObjects:&error];
}

@end

