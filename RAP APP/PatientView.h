//
//  Patient View.h
//  RAP APP
//
//  Created by Anil Prasad on 4/14/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatientView : NSObject
{
    NSDictionary *dictionary;
}

-(NSDictionary *)getPatientListForId:(NSString *)ID FirstName:(NSString *)Pt_First LastName:(NSString *)Pt_Last Stauts:(NSString *)Status Facilty:(NSString *)Dr_Facility Insurance:(NSString *)Pri_Ins Doctor:(NSString *)dr Ref_MOn_F:(NSString *)Ref_MonthF Ref_Day_f:(NSString *)Ref_DayF Ref_Year_F:(NSString *)Ref_YearF Ref_Mon_T:(NSString *)Ref_MonthT Ref_Day_T:(NSString *)Ref_DayT Ref_Year_T:(NSString *)Ref_YearT Ref_DataRange:(NSString *)Ref_range  App_MOn_F:(NSString *)App_MonthF App_Day_F:(NSString *)App_DayF  App_Year_F:(NSString *)App_YearF  App_Mon_T:(NSString *)App_MonthT  App_Day_T:(NSString *)App_DayT  App_Year_T:(NSString *)App_YearT  App_DateRange:(NSString *)App_range Den_MOn_F:(NSString *)Den_MonthF  Den_Day_F:(NSString *)Den_DayF  Den_Year_F:(NSString *)Den_YearF  Den_MOn_T:(NSString *)Den_MonthT  Den_Day_T:(NSString *)Den_DayT  Den_YEar_T:(NSString *)Den_YearT  Den_DateRange:(NSString *)Den_range  Set_MOn_F:(NSString *)SU_MonthF   Set_Day_F:(NSString *)SU_DayF  Set_Year_F:(NSString *)SU_YearF  Set_MOnth_T:(NSString *)SU_MonthT  Set_Day_T:(NSString *)SU_DayT  Set_Year_T:(NSString *)SU_YearT  Set_DAteRange:(NSString *)SU_range  RefD_MOn_F:(NSString *)Not_SU_MonthF  RefD_Day_F:(NSString *)Not_SU_DayF  RefD_Year_F:(NSString *)Not_SU_YearF  RefD_MOn_T:(NSString *)Not_SU_MonthT RefD_Day_T:(NSString *)Not_SU_DayT  RefD_Year_T:(NSString *)Not_SU_YearT  RefD_DateRange:(NSString *)Not_SU_range;


-(NSDictionary *)getDetailListForId:(NSString *)ID;

@end
