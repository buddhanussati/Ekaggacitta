#Requires AutoHotkey v2.0
#SingleInstance Ignore
#NoTrayIcon 
Persistent

; Đặt mức ưu tiên cao cho tiến trình
ProcessSetPriority "High"

; --- 1. NGĂN CHẶN VIỆC RESET (Ghi đè instance) ---
; Kiểm tra nếu script đang chạy thông qua tiêu đề cửa sổ ẩn đặc biệt
if WinExist(A_ScriptName " - Focus Mode Active") {
    MsgBox "Chế độ tập trung đang hoạt động! Bạn không thể khởi động lại để reset thời gian.", "Truy cập bị từ chối", "Icon! T3"
    ExitApp
}

; 2. Định nghĩa nhóm trình duyệt
GroupAdd "Browsers", "ahk_exe chrome.exe"
GroupAdd "Browsers", "ahk_exe msedge.exe"
GroupAdd "Browsers", "ahk_exe firefox.exe"
GroupAdd "Browsers", "ahk_exe brave.exe"
GroupAdd "Browsers", "ahk_exe coccoc.exe"

; 3. Hỏi số phút tập trung
UserResponse := InputBox("Bạn muốn tập trung trong bao nhiêu phút?", "Hẹn giờ Tập trung", "w250 h130", "20")
if (UserResponse.Result = "Cancel" or UserResponse.Value = "")
    ExitApp

; 4. Hỏi các từ khóa tiêu đề trang web được cho phép
TitleInput := InputBox("Nhập các từ khóa được phép (phân tách bằng dấu phẩy):", "Trang web được phép", "w350 h150", "Gemini, copilot, new tab, grok, deepseek, settings, github")
if (TitleInput.Result = "Cancel")
    ExitApp

; Đánh dấu instance này là đang hoạt động bằng cách đổi tên tiêu đề cửa sổ chính
A_AllowMainWindow := true 
WinSetTitle(A_ScriptName " - Focus Mode Active", A_ScriptHwnd)

AllowedTitles := StrSplit(TitleInput.Value, ",")
for index, value in AllowedTitles
    AllowedTitles[index] := Trim(value)

FocusMinutes := Number(UserResponse.Value)
FocusSeconds := FocusMinutes * 60

; --- CƠ CHẾ CHỐNG GIAN LẬN ---
SetTimer CheckTaskManager, 100

CheckTaskManager() {
    ; Tự động đóng Task Manager nếu người dùng cố mở để tắt script
    if WinExist("ahk_exe Taskmgr.exe")
        WinClose "ahk_exe Taskmgr.exe"
    ; Đóng Resource Monitor
    if WinExist("ahk_exe resmon.exe")
        WinClose "ahk_exe resmon.exe"
}

; 5. Tạo giao diện (UI) tiến trình
global FocusGui := Gui("+AlwaysOnTop -Caption +Border +ToolWindow") 
FocusGui.BackColor := "Black"
FocusGui.SetFont("s9 w700", "Segoe UI") 
FocusText := FocusGui.Add("Text", "Center w120 cWhite +0x0100", "Tập trung: " FocusMinutes "p 0s")

; --- LOGIC KÉO THẢ GIAO DIỆN ---
OnMessage(0x0201, WM_LBUTTONDOWN)
WM_LBUTTONDOWN(wParam, lParam, msg, hwnd) {
    PostMessage 0xA1, 2, , FocusGui.Hwnd 
}

; --- LOGIC TỰ ĐỘNG CĂN CHỈNH VỊ TRÍ ---
FocusGui.Show("Hide") 
FocusGui.GetPos(,, &GuiW, &GuiH) 

; Lấy vùng làm việc (không bao gồm thanh Taskbar)
MonitorGetWorkArea(1, &WL, &WT, &WR, &WB)

; Tính toán vị trí góc dưới bên phải
TargetX := WR - GuiW - 10 
TargetY := WB - GuiH - 10 

FocusGui.Show("x" TargetX " y" TargetY " NoActivate")

; 6. Vòng lặp đếm ngược và Bảo vệ trình duyệt
Loop FocusSeconds {
    if WinActive("ahk_group Browsers") {
        CurrentTitle := WinGetTitle("A")
        IsAllowed := false
        
        ; Cho phép nếu là file cục bộ hoặc tiêu đề nằm trong danh sách trắng
        if InStr(CurrentTitle, ":\") or InStr(CurrentTitle, ".html") {
            IsAllowed := true
        } else {
            for TitlePart in AllowedTitles {
                if (TitlePart != "" and InStr(CurrentTitle, TitlePart)) {
                    IsAllowed := true
                    break
                }
            }
        }
        
        ; Nếu trang web không được phép, đóng tab ngay lập tức
        if (!IsAllowed) {
            Send "^w"
            TrayTip "Chế độ Tập trung", "Đã đóng trang web gây xao nhãng!", 1
        }
    }

    RemainingSec := FocusSeconds - A_Index
    Mins := Floor(RemainingSec / 60)
    Secs := Mod(RemainingSec, 60)
    
    ; --- CẢNH BÁO TRỰC QUAN (Khi còn dưới 1 phút) ---
    if (RemainingSec <= 60) {
        FocusGui.BackColor := "Red"
        FocusText.SetFont("cBlack") 
    }

    try {
        FocusText.Value := "Nhất Tâm: " Mins "p " Secs "s"
    }
    
    Sleep 1000
}

FocusGui.Destroy()
SetTimer CheckTaskManager, 0 

; --- LOGIC KHÓA MÁY (3 PHÚT) ---
BlockInput "On" ; Chặn thao tác chuột và bàn phím
LockGui := Gui("+AlwaysOnTop -Caption +Border")
LockGui.BackColor := "Red"
LockGui.SetFont("s20 w700", "Segoe UI")
LockGui.Add("Text", "Center w380", "HẾT GIỜ RỒI!")
LockGui.SetFont("s14 w400")
DisplayText := LockGui.Add("Text", "Center w380", "Sẽ khóa máy sau: 180s")
LockGui.Show("w400 h150")

Loop 180 {
    CurrentCount := 180 - A_Index
    Sleep 1000
    DisplayText.Value := "Sẽ khóa máy sau: " CurrentCount "s"
}

BlockInput "Off"
LockGui.Destroy()

; Thực hiện đưa máy vào chế độ Sleep/Lock (Tùy thuộc vào cài đặt hệ thống)
DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 1, "Int", 0)
ExitApp