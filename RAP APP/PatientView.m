//
//  Patient View.m
//  RAP APP
//
//  Created by Anil Prasad on 4/14/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import "PatientView.h"

@implementation PatientView


-(NSDictionary *)getPatientListForId:(NSString *)ID FirstName:(NSString *)Pt_First LastName:(NSString *)Pt_Last  Stauts:(NSString *)Status Facilty:(NSString *)Dr_Facility Insurance:(NSString *)Pri_Ins Doctor:(NSString *)dr Ref_MOn_F:(NSString *)Ref_MonthF Ref_Day_f:(NSString *)Ref_DayF Ref_Year_F:(NSString *)Ref_YearF Ref_Mon_T:(NSString *)Ref_MonthT Ref_Day_T:(NSString *)Ref_DayT Ref_Year_T:(NSString *)Ref_YearT Ref_DataRange:(NSString *)Ref_range  App_MOn_F:(NSString *)App_MonthF App_Day_F:(NSString *)App_DayF  App_Year_F:(NSString *)App_YearF  App_Mon_T:(NSString *)App_MonthT  App_Day_T:(NSString *)App_DayT  App_Year_T:(NSString *)App_YearT  App_DateRange:(NSString *)App_range Den_MOn_F:(NSString *)Den_MonthF  Den_Day_F:(NSString *)Den_DayF  Den_Year_F:(NSString *)Den_YearF  Den_MOn_T:(NSString *)Den_MonthT  Den_Day_T:(NSString *)Den_DayT  Den_YEar_T:(NSString *)Den_YearT  Den_DateRange:(NSString *)Den_range  Set_MOn_F:(NSString *)SU_MonthF   Set_Day_F:(NSString *)SU_DayF  Set_Year_F:(NSString *)SU_YearF  Set_MOnth_T:(NSString *)SU_MonthT  Set_Day_T:(NSString *)SU_DayT  Set_Year_T:(NSString *)SU_YearT  Set_DAteRange:(NSString *)SU_range  RefD_MOn_F:(NSString *)Not_SU_MonthF  RefD_Day_F:(NSString *)Not_SU_DayF  RefD_Year_F:(NSString *)Not_SU_YearF  RefD_MOn_T:(NSString *)Not_SU_MonthT RefD_Day_T:(NSString *)Not_SU_DayT  RefD_Year_T:(NSString *)Not_SU_YearT  RefD_DateRange:(NSString *)Not_SU_range;

{
    dictionary=nil;
    NSString *urlString = [NSString stringWithFormat:url_patientSearch,Pt_First,Pt_Last,Status,Dr_Facility,Pri_Ins,dr,Ref_MonthF,Ref_DayF,Ref_YearF,Ref_MonthT,Ref_DayT,Ref_YearT,Ref_range,App_MonthF,App_DayF,App_YearF,App_MonthT,App_DayT,App_YearT,App_range,Den_MonthF,Den_DayF,Den_YearF,Den_MonthT,Den_DayT,Den_YearT,Den_range,SU_MonthF,SU_DayF,SU_YearF,SU_MonthT,SU_DayT,SU_YearT,SU_range,Not_SU_MonthF,Not_SU_DayF,Not_SU_YearF,Not_SU_MonthT,Not_SU_DayT,Not_SU_YearT,Not_SU_range,ID];
    
    
    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }];
    return dictionary;
    
}
-(NSDictionary *)getDetailListForId:(NSString *)ID
{
    dictionary=nil;
    NSString *urlString = [NSString stringWithFormat:url_detailListing,ID];

    [WebserviceClass getParseDataFromUrl:urlString :^(id result, NSError *error)
     {
         if (error) {
             dictionary =nil;
         }
         else
         {
             dictionary= result;
         }
     }];
    return dictionary;
    
}


@end
