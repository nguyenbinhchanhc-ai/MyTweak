#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Tối ưu hóa FPS và hiển thị thông số kỹ thuật cho game Liên Quân
// Chú thích: Sử dụng các Class phổ biến trong engine SGame (Arena of Valor)

%hook SGameSettings
// Mở khóa tùy chọn FPS cao trong menu cài đặt
- (bool)get_HighFrameRate {
    return YES;
}

// Ép game nhận giá trị FPS cao nhất (thường là 120 trên các thiết bị hỗ trợ)
- (int)get_FrameRate {
    return 120;
}

// Tối ưu hóa độ phân giải hiển thị để giữ FPS ổn định
- (int)get_ModelLOD {
    return 1; // Mức độ chi tiết trung bình để tăng hiệu năng
}
%end

%hook GameSettingManager
// Thiết lập mức FPS ở mức "Cực cao" (Ultra)
- (int)GetFrameRateLevel {
    return 2;
}

// Ngăn chặn game tự động hạ FPS khi thiết bị nóng
- (void)SetFrameRateLevel:(int)arg1 {
    %orig(2);
}
%end

%hook SGameGlobalConfig
// Kích hoạt tính năng hiển thị FPS nội bộ của nhà phát triển
- (bool)isShowFPS {
    return YES;
}

// Hiển thị thêm các thông số tài nguyên hệ thống (Ping, Memory)
- (bool)isShowDebugInfo {
    return YES;
}
%end

%hook UIWindow
// Đồng bộ tần số quét màn hình với phần cứng (ProMotion 120Hz)
- (void)makeKeyAndVisible {
    %orig;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(setMaximumFramesPerSecond:)]) {
        [[UIScreen mainScreen] setMaximumFramesPerSecond:120];
    }
}
%end

// Thông báo: Mã nguồn chỉ dành cho mục đích nghiên cứu tối ưu hóa hiệu năng cá nhân.
// Không bao gồm các chức năng can thiệp dữ liệu, gian lận hoặc qua mặt bảo mật game.
