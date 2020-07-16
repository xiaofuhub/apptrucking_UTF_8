$PBExportHeader$w_password.srw
forward
global type w_password from window
end type
type cb_cancel from commandbutton within w_password
end type
type cb_ok from commandbutton within w_password
end type
type sle_2 from singlelineedit within w_password
end type
type st_1 from statictext within w_password
end type
type sle_1 from singlelineedit within w_password
end type
end forward

global type w_password from window
integer x = 1120
integer y = 1004
integer width = 1335
integer height = 384
boolean titlebar = true
string title = "Change Password"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
cb_cancel cb_cancel
cb_ok cb_ok
sle_2 sle_2
st_1 st_1
sle_1 sle_1
end type
global w_password w_password

on w_password.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_2=create sle_2
this.st_1=create st_1
this.sle_1=create sle_1
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.sle_2,&
this.st_1,&
this.sle_1}
end on

on w_password.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_2)
destroy(this.st_1)
destroy(this.sle_1)
end on

event open;if g_privs.emp[7] = 0 then
	messagebox("Passwords", "Your current user settings do not allow you to change " +&
	"passwords.")
	close(this)	
	return
end if

string codename
codename = message.stringparm

if len(codename) > 0 and len(codename) <= 8 then this.title = "Password for " + codename
end event

type cb_cancel from commandbutton within w_password
integer x = 978
integer y = 148
integer width = 247
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
boolean cancel = true
end type

event clicked;closewithreturn(parent, null_str)
end event

type cb_ok from commandbutton within w_password
integer x = 978
integer y = 40
integer width = 247
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "OK"
boolean default = true
end type

event clicked;string rejstr
integer pwd_a_len, pwd_b_len
pwd_a_len = len(sle_1.text)
pwd_b_len = len(sle_2.text)

if pwd_a_len > 0 or pwd_b_len > 0 then
	if pwd_a_len < 3 then rejstr = "must be at least 3 letters long"
	if not match(sle_1.text, "^[A-Z0-9]+$") then
		if len(rejstr) > 0 then rejstr += " and "
		rejstr += "must contain only letters and/or numbers (no special characters "+&
			"and no spaces)."
	end if
	if len(rejstr) > 0 then
		rejstr = "The password you specify " + rejstr + "  Please adjust your "+&
			"entry."
	elseif sle_1.text = sle_2.text then
		rejstr = rejstr
	elseif pwd_a_len = 0 or pwd_b_len = 0 then
		rejstr = "You must type the password in both boxes in order "+&
			"to verify your entry."
	else
		rejstr = "Your password entries do not match.  Please retype them."
	end if
end if

if len(rejstr) > 0 then
	messagebox("Set New Password", rejstr, exclamation!)
	sle_1.post setfocus()
	return
end if

closewithreturn(parent, sle_1.text)
end event

type sle_2 from singlelineedit within w_password
event enchange pbm_enchange
event keydown pbm_keydown
integer x = 507
integer y = 152
integer width = 379
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
boolean password = true
textcase textcase = upper!
integer limit = 8
borderstyle borderstyle = stylelowered!
end type

event enchange;if len(this.text) > 0 and len(sle_1.text) > 0 then cb_ok.enabled = true &
	else cb_ok.enabled = false
end event

event keydown;if keydown(keyenter!) then sle_1.post setfocus()
end event

event getfocus;this.selecttext(1, len(this.text))
end event

type st_1 from statictext within w_password
integer x = 96
integer y = 56
integer width = 814
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Type Twice for Verification"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_password
event enchange pbm_enchange
event keydown pbm_keydown
integer x = 101
integer y = 152
integer width = 379
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
boolean password = true
textcase textcase = upper!
integer limit = 8
borderstyle borderstyle = stylelowered!
end type

event enchange;if len(this.text) > 0 and len(sle_2.text) > 0 then cb_ok.enabled = true &
	else cb_ok.enabled = false
end event

event keydown;if keydown(keyenter!) then
	if keydown(keyshift!) then cb_cancel.post setfocus() else sle_2.post setfocus()
end if
end event

event getfocus;this.selecttext(1, len(this.text))
end event

