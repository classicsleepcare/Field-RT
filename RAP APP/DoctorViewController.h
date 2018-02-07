//
//  DoctorViewController.h
//  RAP APP
//
//  Created by Anil Prasad on 4/5/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSVerticalTabBarController.h"
#import <MessageUI/MessageUI.h>
#import "StockTake.h"
#import "NIVRespCare.h"
#import "NIVCareComp.h"
#import "NIVNewPatientProfile.h"
#import "NIVSetupTicket.h"
#import "NIVTrilogyVentPerf.h"

@protocol TabBarTextSearchDelegate <NSObject>

-(void)searchedDataFromText:(NSString*)text;

@required
- (void)searchBarClearButtonClicked:(NSString *)seTxt;

@end

@interface DoctorViewController :FSVerticalTabBarController<UITabBarControllerDelegate,FSTabBarControllerDelegate,UITextFieldDelegate>
{
    UIImageView *img;
    
}
@property(nonatomic,weak)id<TabBarTextSearchDelegate>searchDelagate;
@property(nonatomic,strong)NSMutableString*str_username;

@property (nonatomic, strong) UIButton *btn_Clear;
@end


