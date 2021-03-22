//
//  PolygonAPI.h
//  Polygon_App
//
//  Created by admin on 12/8/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Foundation/Foundation.h>
#import "Reachability.h"

#define PolygonApiBaseUrl                       @"http://104.237.158.58:80/api/v1"
#define PolygonApiRestricID                     @"/locations/get_location"
#define PolygonApiBusinessList                  @"/businesses/sorted_businesses"
#define PolygonApiBusinessDetail                @"/businesses/business_details/"
#define PolygonApiCrowd                         @"/businesses/"
#define PolygonApiSetCrowd                      @"/set_crowd"
#define PolygonApiGetComment                    @"/get_business_comments"
#define PolygonApiSetComment                    @"/set_comment"
#define PolygonActivityGraph                    @"/activity_graph"
#define PolygonSignUp                           @"/users/signup"

typedef void (^SuccessBlock)(id json);
typedef void (^FailureBlock)(NSInteger statusCode, id json);
typedef void (^constructingBodyWithBlock) (id<AFMultipartFormData> formData);

@interface PolygonAPI : AFHTTPSessionManager


+ (PolygonAPI *) sharedManager;

- (void) RestricID : (NSString *) latitude
        longtitude : (NSString *) longtitude
         onSuccess : (SuccessBlock) completionBlock
         onFailure : (FailureBlock) failureBlock;

- (void) BusinessList : (NSString *) DistricID
                 Sort : (NSString *) sortBy
             latitude : (NSString *) latitude
           longtitude : (NSString *) longtitude
            onSuccess : (SuccessBlock) completionBlock
            onFailure : (FailureBlock) failureBlock;

- (void) BusinessDetail : (NSString *) businessID
              onSuccess : (SuccessBlock) completionBlock
              onFailure : (FailureBlock) failureBlock;

- (void) SetCrowd : (NSString *) businessID
        crowdRate : (NSString *) crowdRate
           userID : (NSString *) userID
        onSuccess : (SuccessBlock) completionBlock
        onFailure : (FailureBlock) failureBlock;

- (void) GetComment : (NSString *) businessID
          onSuccess : (SuccessBlock) completionBlock
          onFailure : (FailureBlock) failureBlock;

- (void) SetComment : (NSString *) businessID
            comment : (NSString *) comment
        commenterID : (NSString *) commenterID
              image : (NSData *) image
          onSuccess : (SuccessBlock) completionBlock
          onFailure : (FailureBlock) failureBlock;

- (void) ActivityGraph : (NSString *) businessID
             onSuccess : (SuccessBlock) completionBlock
             onFailure : (FailureBlock) failureBlock;

- (void) SignUp : (NSString *) phoneNumber deviceID : (NSString *) deviceID
      onSuccess : (SuccessBlock) completionBlock
      onFailure : (FailureBlock) failureBlock;

- (void)POST:(NSString *)url
  parameters:(NSMutableDictionary*)parameters
   onSuccess:(SuccessBlock)completionBlock
   onFailure:(FailureBlock)failureBlock;


@end
