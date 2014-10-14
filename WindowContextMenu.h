#import <Cocoa/Cocoa.h>
#import "Window.h"

@interface OverlayWindowContextMenu : NSMenu

@property (assign) NSMenuItem *alwaysOnTopItem;
@property (assign) NSMenuItem *closeItem;
@property (assign) NSMenuItem *showAlphaSliderItem;
@property (assign) OverlayWindow *parentWindow;

- (OverlayWindowContextMenu *)initWithWindow:(OverlayWindow *)callingWindow;
- (void)overlayWindowAlwaysOnTopChanged:(id)sender;
- (void)overlayWindowAlphaSliderVisibleChanged:(id)sender;

@end
