//
//  WebserviceURL.h
//  RAP APP
//
//  Created by Anil Prasad on 5/28/14.
//  Copyright (c) 2014 Anil Prasad. All rights reserved.
//

#ifndef RAP_APP_WebserviceURL_h
#define RAP_APP_WebserviceURL_h

/*
 ************* SVN **************
 Anil.Prasad
 
**************** Profile Details. ******************
DEBUG
 Bundle Identifier: com.QDiBrand.a1
 Provisioning Profile: iBrandPP_Debug
 Team: Mobile Programming LLC
 Signing Certificate: Ishwari Singh
 
DISTRIBUTION
 Bundle Identifier: com.a1distribute.RT
 Provisioning Profile: DistributeA1
 Team: A-1 Technology Inc
 Signing Certificate: A-1 Technology Inc
 
AIR WATCH
 com.distribution.RT

*************** APP Login Creds. *******************
 username: hani_jereis
 password: Password@1
 
******************** VPN Creds. ********************
 cscsslvpn.classicsleepcare.com
 username: redhatadmin1
 password: 7O@;:)Qoxh
 domain: csc
****************************************************

 */


// Development Server: http://192.168.10.88/WebServices/
// QA Server: http://192.168.10.190/WebServices/
// Live Server:  https://pc-live.classicsleepcare.com/WebServices/


#define url_server @"http://192.168.10.190/WebServices/"
//****************  NIV URLS ********************************************************************************//

#define url_nivSetupTicket                  (url_server@"rt_niv_setup_ticket.php")
#define url_nivRespCare                     (url_server@"rt_niv_consent_clinical_services.php")
#define url_nivTrilogyCareComp              (url_server@"rt_niv_competency_checklist_trilogy.php")
#define url_nivAstralCareComp               (url_server@"rt_niv_competency_checklist_astral.php")
#define url_nivHomeSafe                     (url_server@"rt_niv_home_safety_assessment.php")
#define url_nivNewPtHistory                 (url_server@"rt_niv_new_patient_medical_history.php")
#define url_nivPtDis                        (url_server@"rt_niv_patient_discharge_summary.php")
#define url_nivTrilogyVentPerf              (url_server@"rt_niv_vent_performance_record_trilogy.php")
#define url_nivAstralVentPerf               (url_server@"rt_niv_ventilator_performance_record_resmed_astral.php")
#define url_nivPtProg                       (url_server@"rt_niv_patient_progress_notes.php")
#define url_nivTakeCOPD                     (url_server@"rt_niv_copd_assessment_test.php")
#define url_nivNewPtProfile                 (url_server@"rt_niv_new_patient_medication_profile.php")
#define url_nivSetupTicketList              (url_server@"rt_niv_setup_ticket_list.php")
#define url_nivSetupTicketDetail            (url_server@"rt_niv_setup_ticket_detail.php")
#define url_nivPatientListing               (url_server@"rt_patient_listing.php")
#define url_nivRTListing                    (url_server@"rt_listing.php")

#define url_nivImage                        (url_server@"niv_setup_ticket/%@")

//****************  NEW ONES ********************************************************************************//

#define url_rtLogin                         (url_server@"rt_login.php?username=%@&password=%@")

//#define url_inventory                       (url_server@"rt_inventory_on_hand.php?id=%@") //rt id = 74
#define url_inventory                       (url_server@"rt_inventory_on_hand.php?id=%@&page=%@&limit=%@") //rt id = 74


#define url_setupTicketListing              (url_server@"rt_setup_ticket_list.php?id=%@&option=%@")

#define url_arraysRT_Patient_Machine_Mask   (url_server@"rt_listing.php?id=%@")

#define url_itemsListOfSelectedTicket       (url_server@"rt_ticket_itemlist.php?id=%@") // ticket id

#define url_availableItemsList              (url_server@"rt_item_list.php?id=%@") // rt id
#define url_rtPatientList                   (url_server@"rt_patient_listing.php?id=%@") //rt id = 74

#define url_scheduleDetails                 (url_server@"rt_Schedule_Details_Screen.php?id=%@") // patient id

#define url_updateSchedule                  (url_server@"rt_patient_schedule_update.php?id=%@&sch_date=%@&sch_hr=%@&sch_min=%@&time_type=%@&sch_type=%@&notes=%@") // patient id

#define url_rtTransferListings              (url_server@"rt_transfer_list.php?id=%@") // rt id
#define url_rtSendReceiveTransferList       (url_server@"rt_new_transfer_list.php?id=%@")
#define url_rtAcknowledge                   (url_server@"rt_item_ack_update.php?id=%@&transfer_id=%@&acknowledge=%@")
#define url_rtOrderListings                 (url_server@"rt_order_list.php?id=%@") // rt id

#define url_rtTransferDetails               (url_server@"rt_transfer_detail.php?rt_id=%@&id=%@") // rt id
#define url_rtOrderDetails                  (url_server@"rt_order_detail.php?rt_id=%@&id=%@") // rt id

#define url_rtReceiveOrder                  (url_server@"rt_receive_items.php?rt_id=%@&transfer_id=%@&from_id=%@&json_request=%@")
#define url_rtReceiveItems                  (url_server@"rt_receive_items_all.php?rt_id=%@&transfer_id=%@&order_id=%@&from_id=%@&testing_emails=0&json_request=%@")
#define url_rtNewTransfer                   (url_server@"rt_new_transfers.php?rt_id=%@&to_location=%@&transfer_date=%@&json_items_request=%@")
#define url_rtNewTransferItems              (url_server@"rt_items_with_onhand.php?id=%@")

#define url_image                           (url_server@"ticket_pdf/%@")

#define url_TicketSubmit                    (url_server@"rt_setup_ticket.php")
#define url_TicketInitials                  (url_server@"rt_setup_ticket_sign.php")

#define url_setupTicketSubmit               (url_server@"rt_setup_ticket.php?status=%@&rt_id=%@&pt_id=%@&pt_first=%@&pt_last=%@&pt_gender=%@&pt_spanish=%@&pt_add=%@&pt_city=%@&pt_state=%@&pt_zip=%@&pt_home=%@&pt_cell=%@&pt_work=%@&pt_email=%@&machine=%@&cpap1=%@&level1=%@&cpap=%@&level=%@&manufacturer=%@&model=%@&serial=%@&cm=%@&ramp_time=%@&rate=%@&modem=%@&modem_type=%@&modem_serial=%@&hum_modem=%@&hum_manufacturer=%@&hum_serial=%@&mask=%@&mask_type=%@&mask_name=%@&mask_id=%@&date=%@&care_first=%@&care_last=%@&care_address=%@&care_city=%@&care_state=%@&care_zip=%@&care_phone=%@&care_email=%@&cpap_item_id=%@&modem_item_id=%@&hum_item_id=%@&place_of_service_text=%@&other_instructed=%@&rt_trainer_name=%@&reason_for_visit=%@&goal1=%@&goal2=%@&goal3=%@&goal4=%@&goal5=%@&goal6=%@&goal7=%@&goal8=%@&goal9=%@&goal10=%@&goal11=%@&goal12=%@&goal13=%@&goal14=%@&goal15=%@&goal16=%@&goal17=%@&goal18=%@&goal19=%@&goal20=%@&goal21=%@&goal22=%@&rt_summary=%@&patient_caregiver=%@&relationship=%@&rt_trainer_date=%@&patient_date=%@&json_item=%@&json_discarded_item=%@&json_adtnl_item=%@&notes=%@&machine_type=%@&pt_dob=%@&cpap_cm=%@&cpap_ramp_time=%@&cpap_auto_ramp_time=%@&cpap_auto_low_pressure=%@&cpap_auto_high_pressure=%@&bi_st_ramp_time=%@&bi_st_ipap=%@&bi_st_epap=%@&bi_auto_ramp_time=%@&bi_auto_epap_min=%@&bi_auto_epap_max=%@&bi_auto_pressure_support_min=%@&bi_auto_pressure_support_max=%@&bi_auto_sv_ramp_time=%@&bi_auto_sv_epap_min=%@&bi_auto_sv_ipap_max=%@&bi_auto_sv_pressure_support_min=%@&bi_auto_sv_pressure_support_max=%@&bi_auto_sv_backup_rate=%@&bi_auto_sv_max_pressure_support=%@&bi_auto_st_ramp_time=%@&bi_auto_st_ipap=%@&bi_auto_st_epap=%@&bi_auto_st_backup_rate=%@&auth_person=%@&auth_person_name=%@&email_to_patient=%@&picked_machine=%@&picked_machine_name=%@&picked_manufacturer=%@&picked_machine_serial=%@&picked_hum_serial=%@&picked_modem_serial=%@&isFinalSubmit=%@")

//&mrr_medical_agreement=%@&mrr_legal_auth_name=%@&mrr_legal_auth_sign_date=%@&mrr_witness_sign_date=%@&pip_email=%@&pip_phone=%@&pip_notification=%@&pip_legal_auth_rep_sign_date=%@&pip_legal_auth_rep_name=%@&csc_clinician_name=%@&ordering_physician_name=%@&pap_location=%@&goal23=%@&goal24=%@&add_item_need=%@


#define url_setupTicketEdit                 (url_server@"rt_setup_ticket_edit.php?ticket_id=%@&status=%@&rt_id=%@&pt_id=%@&pt_first=%@&pt_last=%@&pt_gender=%@&pt_spanish=%@&pt_add=%@&pt_city=%@&pt_state=%@&pt_zip=%@&pt_home=%@&pt_cell=%@&pt_work=%@&pt_email=%@&machine=%@&cpap1=%@&level1=%@&cpap=%@&level=%@&manufacturer=%@&model=%@&serial=%@&cm=%@&ramp_time=%@&rate=%@&modem=%@&modem_type=%@&modem_serial=%@&hum_modem=%@&hum_manufacturer=%@&hum_serial=%@&mask=%@&mask_type=%@&mask_name=%@&mask_id=%@&date=%@&care_first=%@&care_last=%@&care_address=%@&care_city=%@&care_state=%@&care_zip=%@&care_phone=%@&care_email=%@&cpap_item_id=%@&modem_item_id=%@&hum_item_id=%@&place_of_service_text=%@&other_instructed=%@&rt_trainer_name=%@&reason_for_visit=%@&goal1=%@&goal2=%@&goal3=%@&goal4=%@&goal5=%@&goal6=%@&goal7=%@&goal8=%@&goal9=%@&goal10=%@&goal11=%@&goal12=%@&goal13=%@&goal14=%@&goal15=%@&goal16=%@&goal17=%@&goal18=%@&goal19=%@&goal20=%@&goal21=%@&goal22=%@&rt_summary=%@&patient_caregiver=%@&relationship=%@&rt_trainer_date=%@&patient_date=%@&json_item=%@&json_discarded_item=%@&json_adtnl_item=%@&notes=%@&machine_type=%@&pt_dob=%@&cpap_cm=%@&cpap_ramp_time=%@&cpap_auto_ramp_time=%@&cpap_auto_low_pressure=%@&cpap_auto_high_pressure=%@&bi_st_ramp_time=%@&bi_st_ipap=%@&bi_st_epap=%@&bi_auto_ramp_time=%@&bi_auto_epap_min=%@&bi_auto_epap_max=%@&bi_auto_pressure_support_min=%@&bi_auto_pressure_support_max=%@&bi_auto_sv_ramp_time=%@&bi_auto_sv_epap_min=%@&bi_auto_sv_ipap_max=%@&bi_auto_sv_pressure_support_min=%@&bi_auto_sv_pressure_support_max=%@&bi_auto_sv_backup_rate=%@&bi_auto_sv_max_pressure_support=%@&bi_auto_st_ramp_time=%@&bi_auto_st_ipap=%@&bi_auto_st_epap=%@&bi_auto_st_backup_rate=%@&auth_person=%@&auth_person_name=%@&email_to_patient=%@&picked_machine=%@&picked_machine_name=%@&picked_manufacturer=%@&picked_machine_serial=%@&picked_hum_serial=%@&picked_modem_serial=%@&isFinalSubmit=%@")

#define url_showHistory                     (url_server@"rt_ticket_history.php?id=%@")

#define url_viewTicket                      (url_server@"rt_get_ticket_id.php?item_id=%@&ser_no=%@")

#define url_setAppointment                  (url_server@"rt_patient_apt_save.php?pt_id=%@&rt_id=%@&notes=%@&date=%@&hr=%@&min=%@&time_type=%@")
#define url_editAppointment                 (url_server@"rt_patient_apt_save.php?pt_id=%@&rt_id=%@&apt_id=%@&notes=%@&date=%@&hr=%@&min=%@&time_type=%@")
#define url_setAppointment1                 (url_server@"rt_patient_schedule_update.php?id=%@&rt_id=%@&notes=%@&sch_date=%@&sch_hr=%@&sch_min=%@&time_type=%@")


#define url_viewAppointment                 (url_server@"rt_patient_appointment_details.php?apt_id=%@")
#define url_viewAppointment1                 (url_server@"rt_Schedule_Details_Screen.php?id=%@")

#define url_machineListing                  (url_server@"rt_getMachinesByVendor.php?rt_id=%@&vendor_id=%@")

//#define url_serialNumber                    (url_server@"rt_getSerialNumberofItem.php?rt_id=%@&item_id=%@")
#define url_serialNumber                    (url_server@"rt_getSerialNumbersofItems.php?rt_id=%@&item_id=%@")

#define url_inventoryCount                  (url_server@"rt_item_inventory_count.php?id=%@&item_id=%@")

#define url_stockTakeMachines               (url_server@"rt_item_inventory_count.php?id=%@")

#define url_submitStockTake                 (url_server@"rt_stocktake_submit.php?rt_id=%@&machines=%@&humidifier=%@&modem=%@&mask=%@")

#define url_supplyList                      (url_server@"rt_supply_list.php?machine_name=%@")


//******************************  OLD ONES **************************************************************************//


#define url_login                           (url_server@"rep_login.php?username=%@&password=%@")

#define url_ChangePwd                       (url_server@"rep_change_password.php?id=%@&currentpassword=%@&newpassword=%@&confirmpassword=%@")

#define url_refferingDoctor                 (url_server@"rep_referring_doctors.php?id=%@")

                                    // WebServices/rt_pt_search.php
#define url_patientSearch                   (url_server@"rt_pt_search.php?Pt_First=%@&Pt_Last=%@&Status=%@&Dr_Facility=%@&Pri_Ins=%@&dr=%@&Ref_MonthF=%@&Ref_DayF=%@&Ref_YearF=%@&Ref_MonthT=%@&Ref_DayT=%@&Ref_YearT=%@&Ref_range=%@&App_MonthF=%@&App_DayF=%@&App_YearF=%@&App_MonthT=%@&App_DayT=%@&App_YearT=%@&App_range=%@&Den_MonthF=%@&Den_DayF=%@&Den_YearF=%@&Den_MonthT=%@&Den_DayT=%@&Den_YearT=%@&Den_range=%@&SU_MonthF=%@&SU_DayF=%@&SU_YearF=%@&SU_MonthT=%@&SU_DayT=%@&SU_YearT=%@&SU_range=%@&Not_SU_MonthF=%@&Not_SU_DayF=%@&Not_SU_YearF=%@&Not_SU_MonthT=%@&Not_SU_DayT=%@&Not_SU_YearT=%@&Not_SU_range=%@&id=%@&Submit=Search")
// Added Pt_Add1 Pt_Add2


#define url_history                         (url_server@"ref_su_history.php?days=%@&id=%@&order_by=ASC&current_date=%@")

#define url_setupAndReferral                (url_server@"rep_refAndsetup.php?id=%@&current_date=%@")

                                    // WebServices/rt_pt_detail.php?id
#define url_patientDetail                   (url_server@"rt_pt_detail.php?id=%@")

#define url_addNewDoctor                    (url_server@"rep_add_doctor.php?rep_id=%@&dr_first=%@&dr_middle=%@&dr_last=%@&dr_npi=%@&dr_license=%@&dr_phone=%@&dr_conf_fax=%@&dr_contact=%@&dr_address=%@&dr_city=%@&dr_state=%@&dr_zip=%@&dr_upin=%@&dr_nuance=%@&dr_notes=%@&dr_fac_id=%@&dr_ref_type=%@&dr_other_text=%@&dr_machine_preference=%@&dr_machine_preference_text=%@&dr_mask_preference=%@&dr_mask_preference_text=%@&dr_modem=%@&dr_md_easycare=%@&dr_14=%@&dr_25=%@&dr_30=%@&dr_45=%@&dr_60=%@&dr_90=%@&dr_120=%@&dr_other_instructions=%@&current_date=%@&dr_id=%@")

#define url_addNewFacility                  (url_server@"rep_add_facility.php?rep_id=%@&fac_name=%@&fac_full_name=%@&fac_phone=%@&fac_contact=%@&fac_address=%@&fac_city=%@&fac_state=%@&fac_zip=%@&fac_nuance=%@&fac_notes=%@&fac_ref_type=%@&fac_other_text=%@&fac_machine_preference=%@&fac_machine_preference_text=%@&fac_mask_preference=%@&fac_mask_preference_text=%@&fac_modem=%@&fac_md_easycare=%@&fac_14=%@&fac_25=%@&fac_30=%@&fac_45=%@&fac_60=%@&fac_90=%@&fac_120=%@&fac_other_instructions=%@&fac_id=%@&fac_fax=%@")


#define url_addNewDoctorAndFacility         (url_server@"rep_add_doctor_add_facility.php?rep_id=%@&dr_first=%@&dr_middle=%@&dr_last=%@&dr_npi=%@&dr_license=%@&dr_phone=%@&dr_conf_fax=%@&dr_contact=%@&dr_address=%@&dr_city=%@&dr_state=%@&dr_zip=%@&dr_upin=%@&dr_nuance=%@&dr_notes=%@&dr_ref_type=%@&dr_other_text=%@&dr_machine_preference=%@&dr_machine_preference_text=%@&dr_mask_preference=%@&dr_mask_preference_text=%@&dr_modem=%@&dr_md_easycare=%@&dr_14=%@&dr_25=%@&dr_30=%@&dr_45=%@&dr_60=%@&dr_90=%@&dr_120=%@&dr_other_instructions=%@&current_date=%@&fac_name=%@&fac_full_name=%@&fac_phone=%@&fac_contact=%@&fac_address=%@&fac_city=%@&fac_state=%@&fac_zip=%@&fac_nuance=%@&fac_notes=%@&fac_ref_type=%@&fac_other_text=%@&fac_machine_preference=%@&fac_machine_preference_text=%@&fac_mask_preference=%@&fac_mask_preference_text=%@&fac_modem=%@&fac_md_easycare=%@&fac_14=%@&fac_25=%@&fac_30=%@&fac_45=%@&fac_60=%@&fac_90=%@&fac_120=%@&fac_other_instructions=%@&dr_id=%@&fac_id=%@")


#define url_allFacility                     (url_server@"rep_list_facility.php?rep_id=%@")

#define url_facilityDetail                  (url_server@"rep_view_facility.php?fac_id=%@")

#define url_allDoctors                      (url_server@"rep_list_doctor.php?rep_id=%@")

#define url_allDoctorsDetail                (url_server@"rep_view_doctor.php?dr_id=%@")


#define url_statMonth                       (url_server@"rep_monthly_tally.php?tMonth=%@&tYear=%@&access_id=%@")

#define url_statYear                        (url_server@"rep_annual_tally.php?tYear=%@&access_id=%@")

//http://209.160.65.49:1012rep_annual_tally.php?tYear=2013&amp;access_id=56

#define url_monthlyTallyUsers               (url_server@"rep_monthly_tally_users.php?tDay=%@&tMonth=%@&tYear=%@&access_id=%@")

#define url_annualTallyUsers                (url_server@"rep_annual_tally_users.php?tMonth=%@&tYear=%@&access_id=%@")


#define url_Monthally_total                 (url_server@"rep_monthly_tally_total.php?tMonth=%@&tYear=%@&access_id=%@")


#define url_Annual_total                    (url_server@"rep_annual_tally_total.php?tYear=%@&access_id=%@")

#define url_sourceAndcatagory               (url_server@"rep_referral_search.php")

#define url_detailListing                   (url_server@"rt_dd_listing.php?id=%@")


//#define url_schedule                        (url_server@"rep_rt_patient_schedule.php?rep_id=%@&start_date=%@&end_date=%@")
#define url_schedule                        (url_server@"rt_patient_schedule.php?id=%@&start_date=%@&end_date=%@")


#endif
