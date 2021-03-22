//
//  PolygonAPI.m
//  Polygon_App
//
//  Created by admin on 12/8/15.
//  Copyright © 2015 admin. All rights reserved.
//

#import "PolygonAPI.h"

@implementation PolygonAPI

+ (PolygonAPI *) sharedManager {
    
    static PolygonAPI *sharedManager = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.HTTPAdditionalHeaders = @{@"X-Access-Token":@"ed0b3ea57b15d0a211ec14bf9411bf8b5def6eae" , @"Device-ID":@"sample"};
        sharedManager = [[PolygonAPI alloc] initWithBaseURL:[NSURL URLWithString:PolygonApiBaseUrl] sessionConfiguration:configuration];
        sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [sharedManager.requestSerializer setTimeoutInterval:15.0];
        sharedManager.responseSerializer = [AFJSONResponseSerializer serializer];
    });
    return sharedManager;
}

- (void) RestricID:(NSString *)latitude longtitude:(NSString *)longtitude onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"lat":latitude, @"long":longtitude}];
    NSString *url = [NSString stringWithFormat:@"%@%@",PolygonApiBaseUrl,PolygonApiRestricID];
    [self GET:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
}

- (void) BusinessList:(NSString *)DistricID Sort:(NSString *)sortBy latitude:(NSString *)latitude longtitude:(NSString *)longtitude onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"district_id":DistricID , @"sort_by":sortBy , @"latitude":latitude , @"longitude":longtitude}];
    NSString *url = [NSString stringWithFormat:@"%@%@" ,PolygonApiBaseUrl,PolygonApiBusinessList];
    [self GET:url parameters:parameters onSuccess:completionBlock onFailure:failureBlock];
}

- (void) BusinessDetail:(NSString *)businessID onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{

    NSString *url = [NSString stringWithFormat:@"%@%@%@" ,PolygonApiBaseUrl,PolygonApiBusinessDetail,businessID];
    [self GET:url parameters:nil onSuccess:completionBlock onFailure:failureBlock];
}

- (void) SetCrowd:(NSString *)businessID crowdRate:(NSString *)crowdRate userID:(NSString *)userID onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    NSError *error;
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@" ,PolygonApiBaseUrl,PolygonApiCrowd,businessID,PolygonApiSetCrowd];
       
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"PUT" URLString:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSMutableData *data1= [[NSMutableData alloc] init];
        [data1 appendData:[crowdRate dataUsingEncoding:NSUTF8StringEncoding]];
        [formData appendPartWithFormData:data1 name:@"new_crowd_rate"];
        NSMutableData *data2= [[NSMutableData alloc] init];
        [data2 appendData:[userID dataUsingEncoding:NSUTF8StringEncoding]];
        [formData appendPartWithFormData:data2 name:@"user_id"];
    } error:&error];
    
    NSURLSessionDataTask *dataTask = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"asdfasdf %@" ,responseObject);
    }];
    [dataTask resume];

}

- (void) ActivityGraph:(NSString *)businessID onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock{
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@",PolygonApiBaseUrl,PolygonApiCrowd,businessID,PolygonActivityGraph];
    [self GET:url parameters:nil onSuccess:completionBlock onFailure:failureBlock];
}

- (void) SetComment:(NSString *)businessID comment:(NSString *)comment commenterID:(NSString *)commenterID image:(NSData *)image onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock{
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@",PolygonApiBaseUrl,PolygonApiCrowd,businessID,PolygonApiSetComment];
    [self POSTImage:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSMutableData *commentdata = [[NSMutableData alloc] init];
        [commentdata appendData:[comment dataUsingEncoding:NSUTF8StringEncoding]];
        NSMutableData *commentid = [[NSMutableData alloc] init];
        [commentid appendData:[commenterID dataUsingEncoding:NSUTF8StringEncoding]];
        
        [formData appendPartWithFormData:commentdata name:@"comment[text]"];
        [formData appendPartWithFormData:commentid name:@"comment[commenter_id]"];
        [formData appendPartWithFileData:image name:@"comment[picture_attributes][image]" fileName:@"Polygon" mimeType:@"image/jpeg"];
    } onSuccess:completionBlock onFailure:failureBlock];
}

- (void) GetComment:(NSString *)businessID onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@%@",PolygonApiBaseUrl,PolygonApiCrowd,businessID,PolygonApiGetComment];
    [self GET:url parameters:nil onSuccess:completionBlock onFailure:failureBlock];
}

- (void) SignUp:(NSString *)phoneNumber deviceID:(NSString *)deviceID onSuccess:(SuccessBlock)completionBlock onFailure:(FailureBlock)failureBlock{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",PolygonApiBaseUrl,PolygonSignUp];
    
    [self POSTImage:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSMutableData *phoneNum = [[NSMutableData alloc] init];
        [phoneNum appendData:[phoneNumber dataUsingEncoding:NSUTF8StringEncoding]];
        NSMutableData *deviceid = [[NSMutableData alloc] init];
        [deviceid appendData:[deviceID dataUsingEncoding:NSUTF8StringEncoding]];
        
        [formData appendPartWithFormData:phoneNum name:@"phone_no"];
        [formData appendPartWithFormData:deviceid name:@"device_id"];
        
    } onSuccess:completionBlock onFailure:failureBlock];
}

- (void)POST:(NSString *)url
  parameters:(NSMutableDictionary*)parameters
   onSuccess:(SuccessBlock)completionBlock
   onFailure:(FailureBlock)failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        //[SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        
        failureBlock(-1, nil);
        return;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"POST url : %@", url);
    NSLog(@"POST param : %@", parameters);
    
    [self POST:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        completionBlock(responseObject);
        NSLog(@"POST success %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //Error
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
        NSLog(@"POST error %@", error);
//        [SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        
        failureBlock(statusCode, nil);
    }];
}

- (void)GET:(NSString *)url
 parameters:(NSMutableDictionary*)parameters
  onSuccess:(SuccessBlock)completionBlock
  onFailure:(FailureBlock)failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        //[SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        
        failureBlock(-1, nil);
        return;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"GET url : %@", url);
    NSLog(@"GET param : %@", parameters);
    
    [self GET:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"GET success : %@", responseObject);
        completionBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //Error
        NSLog(@"GET error : %@", error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
        //[SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        
        failureBlock(statusCode, nil);
    }];
}

- (void)PUT:(NSString *)url
 parameters:(NSMutableDictionary*)parameters
  onSuccess:(SuccessBlock)completionBlock
  onFailure:(FailureBlock)failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        //[SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        
        failureBlock(-1, nil);
        return;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"PUT url : %@", url);
    NSLog(@"PUT param : %@", parameters);
    
    [self PUT:url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"PUT success : %@", responseObject);
        completionBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //Error
        NSLog(@"PUT error : %@", error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
//        [SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        
        failureBlock(statusCode, nil);
    }];
}

- (void) POSTImage : (NSString *)url
        parameters : (NSMutableDictionary *) parameters
constructingBodyWithBlock : (constructingBodyWithBlock)bodyBlock
         onSuccess : (SuccessBlock)completionBlock
         onFailure : (FailureBlock) failureBlock
{
    // Check out network connection
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        //[SHAlertHelper showOkAlertWithTitle:@"Error" message:@"We are unable to connect to our servers.\rPlease check your connection."];
        
        failureBlock(-1, nil);
        return;
    }
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"PUT url : %@", url);
    NSLog(@"PUT param : %@", parameters);
    [self POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>   formData) {
        
        bodyBlock(formData);
        
    } success:^(NSURLSessionDataTask * task, id  responseObject) {
        
        NSLog(@"PUT success : %@", responseObject);
        completionBlock(responseObject);

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"PUT error : %@", error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        
        //        [SHAlertHelper showOkAlertWithTitle:@"Connection Error" andMessage:@"Error occurs while connecting to web-service. Please try again!" andOkBlock:nil];
        
        failureBlock(statusCode, nil);

    }];
}


@end
