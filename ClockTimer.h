#import <Foundation/Foundation.h>

@interface ClockTimer : NSObject

@property (nonatomic, assign) NSTimer *repeatingTimer;
@property (nonatomic, assign)NSObject* barObject;
@property SEL updateTextSelector;

- (void)startRepeatingTimer;
- (void) testMethod;

@end
