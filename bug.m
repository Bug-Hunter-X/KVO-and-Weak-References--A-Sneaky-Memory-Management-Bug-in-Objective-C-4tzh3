In Objective-C, a tricky bug can arise from the interaction between KVO (Key-Value Observing) and memory management, especially when dealing with weak references. If an object is deallocated while it's still being observed, it can lead to crashes or unexpected behavior.  The observer might try to access the deallocated object, resulting in a EXC_BAD_ACCESS error.  This is particularly insidious because the crash might not happen immediately, making it difficult to track down.

Example:

```objectivec
@interface MyObservedObject : NSObject
@property (nonatomic, strong) NSString *observedProperty;
@end

@implementation MyObservedObject
- (void)dealloc {
    NSLog(@"MyObservedObject deallocated");
}
@end

@interface MyObserver : NSObject
@end

@implementation MyObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@