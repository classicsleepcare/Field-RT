//
//  OperationPDF.m
//  Prometheus
//
//  Created by Lokesh Kumar on 12/1/15.
//  Copyright © 2015 Neelesh.Rai. All rights reserved.
//

#import "OperationMarketingPDF.h"



@implementation OperationMarketingPDF


- (void)start
{
    [self startDownload];
}

- (void)main
{
    
}


-(void)FinishDownload
{
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    self.isExecuting = NO;
    self.isFinished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}


#pragma mark - Downloading NSurlsession

- (void)startDownload
{
    self.data_pdf = [[NSMutableData alloc] init];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session1 = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    
    NSURL *url =[NSURL URLWithString:[self.urlStr stringByAddingPercentEscapesUsingEncoding:4]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.downloadtask = [session1 dataTaskWithRequest:request];
    
    [self.downloadtask resume];
}




#pragma mark - data task delegates

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if([challenge.protectionSpace.host isEqualToString:@"192.168.10.190"]) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust: challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [self.data_pdf appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    NSLog(@"did complete called %@",self.name);
    if (error == nil) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(DidCompleteWithIndex:andData:)])
            {
                [self.delegate DidCompleteWithIndex:self.indexPath
                                            andData:self.data_pdf];
            }
            [self FinishDownload];
        });
        
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(didOccuredAtIndex:)])
            {
                [self.delegate didOccuredAtIndex:self.indexPath];
            }
            [self FinishDownload];
        });
    }
}


@end
