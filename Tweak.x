#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

%hook SBFFlexibleSystemRateSettings

- (void)setPreferredFramesPerSecond:(NSInteger)fps {
    %orig(120);
}

%end

%hook _UIWindowSceneDisplayLinkTargetedProxy

- (void)setPreferredFramesPerSecond:(NSInteger)fps {
    %orig(120);
}

%end
