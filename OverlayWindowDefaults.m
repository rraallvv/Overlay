#import "OverlayWindowDefaults.h"

@implementation OverlayWindowDefaults {
	NSString *imageLocation;
	CGFloat defaultAlpha;
	BOOL alwaysOnTop;
}

@synthesize imageLocation;
@synthesize defaultAlpha;
@synthesize alwaysOnTop;

-(void)dealloc {
	[imageLocation release];
	[super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:self->imageLocation forKey:@"imageLocation"];
    [coder encodeFloat:defaultAlpha forKey:@"defaultAlpha"];
    [coder encodeFloat:originX forKey:@"originX"];
    [coder encodeFloat:originY forKey:@"originY"];
	[coder encodeBool:alwaysOnTop forKey:@"alwaysOnTop"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [[OverlayWindowDefaults alloc] init];
    if (self != nil)
    {
        [self setImageLocation:[[NSString alloc] initWithString: [coder decodeObjectForKey:@"imageLocation"]]];
        [self setDefaultAlpha:[coder decodeFloatForKey:@"defaultAlpha"]];
		originX = [coder decodeFloatForKey:@"originX"];
		originY = [coder decodeFloatForKey:@"originY"];
		[self setAlwaysOnTop:[coder decodeBoolForKey:@"alwaysOnTop"]];
    }   
	//NSLog(@"Init with Coder detected; %@ %f %i", imageLocation, defaultAlpha, alwaysOnTop);
    return self;
}

-(void)setOrigin:(NSPoint)origin {
	originX = origin.x;
	originY = origin.y;
}

@end
