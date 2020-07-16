﻿$PBExportHeader$n_cst_setting_numberofitindays.sru
forward
global type n_cst_setting_numberofitindays from n_cst_syssettings_sle
end type
end forward

global type n_cst_setting_numberofitindays from n_cst_syssettings_sle
end type
global n_cst_setting_numberofitindays n_cst_setting_numberofitindays

forward prototypes
public function string of_getvalue ()
public function integer of_savevalue (any aa_value)
end prototypes

public function string of_getvalue ();String 	ls_Value
Any 		la_Value

n_cst_Settings lnv_settings

lnv_settings.of_GetSetting(177,la_Value)

ls_Value = String(la_Value)
IF isNull ( ls_Value ) THEN
	ls_Value = "0"
END IF

Return ls_Value

end function

public function integer of_savevalue (any aa_value);Int li_ReturnValue = 1
String ls_Value
Int	li_value
n_cst_Settings lnv_settings

ls_Value = String(aa_Value)

IF Not IsNull(ls_Value) And IsNumber ( ls_Value ) THEN
	li_Value = Integer ( ls_Value )
	IF li_Value >= 0 AND li_Value < 365 THEN	
		This.of_SetSetting(177,ls_Value,lnv_settings.cs_datatype_string)
	ELSE
		li_ReturnValue = -1
	END IF
ELSE
	li_ReturnValue = -1 
END IF

Return li_ReturnValue





end function

event constructor;call super::constructor;is_PropertyTextlabel = "# of itinerary days to look ahead"
end event

on n_cst_setting_numberofitindays.create
call super::create
end on

on n_cst_setting_numberofitindays.destroy
call super::destroy
end on
