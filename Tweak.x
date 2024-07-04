#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

%hook _UIDisplayLinkCADisplay

- (void)setPreferredFramesPerSecond:(NSInteger)fps {
    %orig(120);
}

%end

%hook _UIScreenCADisplay

- (void)setMaximumFramesPerSecond:(NSInteger)fps {
    %orig(120);
}

%end
