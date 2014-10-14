#import <Cocoa/Cocoa.h>

//this is just something that is storable
@interface OverlayWindowDefaults : NSObject <NSCoding> {
@public
	CGFloat originX;
	CGFloat originY;
}
@property (assign) NSString *imageLocation;
@property (assign) CGFloat defaultAlpha;
@property (assign) BOOL alwaysOnTop;

-(void)setOrigin:(NSPoint)origin;
@end
