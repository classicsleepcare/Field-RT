//
//  SignatureView.h
//  RT APP
//
//  Created by Anil Prasad on 06/01/15.
//  Copyright (c) 2015 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignatureView : UIView
{
    UILabel *lblSignature;
    CAShapeLayer *shapeLayer;
}

- (UIImage *)getSignatureImage;
- (void)clearSignature;



@end
