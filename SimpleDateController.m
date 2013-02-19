#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBWeeAppController-Protocol.h"

@interface UIApplication(xxx)
-(int)activeInterfaceOrientation;
@end

@interface UIDevice (theiostream)
- (BOOL)isWildcat;
@end

static NSBundle *_SimpleDateWeeAppBundle = nil;

float VIEW_HEIGHT = 24.0f;

BOOL isPortrait;

@interface SimpleDateController: NSObject <BBWeeAppController> {
    UIView *_view;
    UIView *bg;
    UILabel *timeLabel;
    
}
@property (nonatomic, retain) UIView *view;
@end

@implementation SimpleDateController
@synthesize view = _view;

+ (void)initialize {
    _SimpleDateWeeAppBundle = [[NSBundle bundleForClass:[self class]] retain];
}

- (id)init {
    if((self = [super init]) != nil) {
        
    } return self;
}

- (void)dealloc {
    [_view release];
    [super dealloc];
}

- (void)getDate {
    
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    timeLabel.text = dateString;
    
    [formatter release];
    
}

- (UIView *)view
{
    if (!_view)
    {
        int orientation = [[UIApplication sharedApplication] activeInterfaceOrientation];
        CGSize size = [UIScreen mainScreen].bounds.size;
        CGFloat screenWidth = size.width;
        if (orientation == 3 || orientation == 4) screenWidth = size.height;

        if ([[UIDevice currentDevice] isWildcat]) screenWidth = 480.0f;

        _view = [[UIView alloc] initWithFrame:CGRectMake(2.0f, 0.0f, screenWidth-4, VIEW_HEIGHT)];
        
        UIImage *bgImg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/SocialWeeApp.bundle/Background.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(4.0f, 4.0f, 4.0f, 4.0f)];
        bg = [[UIImageView alloc] initWithImage:bgImg];
        bg.frame = CGRectMake(0.0f, 0.0f, screenWidth-4, VIEW_HEIGHT);
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, screenWidth, VIEW_HEIGHT)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.lineBreakMode = UILineBreakModeWordWrap;
        timeLabel.numberOfLines = 0;
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.shadowColor = [UIColor blackColor];
        timeLabel.shadowOffset = CGSizeMake(1,1);
        [timeLabel setFont:[UIFont boldSystemFontOfSize:16]];
        timeLabel.adjustsFontSizeToFitWidth = YES;
        
        [_view addSubview:bg];
        [_view addSubview:timeLabel];
    }
    
    [self getDate];
    
    return _view;
}

- (void)viewWillAppear
{
    int orientation = [[UIApplication sharedApplication] activeInterfaceOrientation];
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat screenWidth = size.width;
    if (orientation == 3 || orientation == 4) screenWidth = size.height;

    if ([[UIDevice currentDevice] isWildcat]) screenWidth = 480.0f;

	_view.frame = CGRectMake(2.0f, 0.0f, screenWidth-4, VIEW_HEIGHT);
    bg.frame = CGRectMake(0.0f, 0.0f, screenWidth-4, VIEW_HEIGHT);
    timeLabel.frame = CGRectMake(0.0f, 0.0f, screenWidth, VIEW_HEIGHT);
}

- (void)willRotateToInterfaceOrientation:(int)orientation
{
    [self viewWillAppear];
}

- (void)unloadView {
    [timeLabel release];
    timeLabel = nil;
    [bg release];
    bg = nil;
    [_view release];
    _view = nil;
    // Destroy any additional subviews you added here. Don't waste memory :(.
}

- (float)viewHeight {
    return VIEW_HEIGHT;
}

@end
