// Tweak.x

#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>

@interface SBBacklightController : NSObject
+ (id)sharedInstance;
- (void)setBacklightFactor:(float)factor source:(long long)source;
@end

@interface SBLockScreenViewController : UIViewController
@end

%hook SBLockScreenViewController

- (void)viewDidLoad {
    %orig;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapRecognizer];
}

%new
- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    SBBacklightController *backlightController = [%c(SBBacklightController) sharedInstance];
    [backlightController setBacklightFactor:1.0 source:1];
}

%end
