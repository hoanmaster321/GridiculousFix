#import <UIKit/UIKit.h>

%hook _UIStatusBarForegroundView

- (void)setFrame:(CGRect)frame {
    // Đặt chiều cao và chiều rộng cụ thể
    frame.size.height = 40.0; // Thay đổi giá trị này để điều chỉnh chiều cao
    frame.size.width = 375.0; // Thay đổi giá trị này để điều chỉnh chiều rộng (tùy theo kích thước màn hình)
    %orig(frame);
}

%end
