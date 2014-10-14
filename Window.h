#import <Cocoa/Cocoa.h>
#import "WindowDefaults.h"

@interface OverlayWindow : NSWindow

@property (assign) BOOL alwaysOnTop;
@property (assign) BOOL alphaSliderVisible;
@property (assign) OverlayWindowDefaults *defaultSettings;

+(OverlayWindow *)initWithDefaults:(OverlayWindowDefaults *)newDefaults;
+(OverlayWindow *)initWithDefaults:(OverlayWindowDefaults *)newDefaults quietly:(BOOL)silent;
-(void)setDefaultSettings:(OverlayWindowDefaults *)toDefaults;
-(void)setDefaultSettings:(OverlayWindowDefaults *)toDefaults quietly:(BOOL)silent;
-(void)toggleAlwaysOnTop;
-(void)toggleAlphaSlider;
-(void)setAlwaysOnTop:(BOOL)alwaysOnTopState withoutNotification:(BOOL)silent;

@end
