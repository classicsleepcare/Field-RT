//
//  OperationPDF.h
//  Prometheus
//
//  Created by Lokesh Kumar on 12/1/15.
//  Copyright © 2015 Neelesh.Rai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OperationMarketingPDFDelegate <NSObject>

-(void)DidCompleteWithIndex:(NSIndexPath *)indexPath
                    andData:(NSData *)data;

-(void)didOccuredAtIndex:(NSIndexPath *)indexPath;


@end
@interface OperationMarketingPDF : NSOperation <NSURLSessionDataDelegate>

@property(nonatomic,strong) NSString *myname;
@property (readwrite) BOOL isExecuting;
@property (readwrite) BOOL isFinished;
@property (nonatomic,strong) NSURLSessionDataTask *downloadtask;
@property (nonatomic,strong)NSMutableData *data_pdf;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,strong)NSString *urlStr;

@property (nonatomic,weak) id<OperationMarketingPDFDelegate> delegate;

-(void)FinishDownload;
@end
