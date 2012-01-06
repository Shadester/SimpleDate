#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBWeeAppController-Protocol.h"

static NSBundle *_SimpleDateWeeAppBundle = nil;

float VIEW_HEIGHT = 24.0f;

@interface SimpleDateController: NSObject <BBWeeAppController> {
	UIView *_view;
    
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
    [formatter setDateFormat:@"EEEE, MMMM d, yyyy"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    timeLabel.text = dateString;
    
    [formatter release];
    
}

- (UIView *)view
{
	if (!_view)
	{
        _view = [[UIView alloc] initWithFrame:CGRectMake(2.0f, 0.0f, 316.0f, VIEW_HEIGHT)];
        
        UIImage *bgImg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/StocksWeeApp.bundle/WeeAppBackground.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(4.0f, 4.0f, 4.0f, 4.0f)];
        UIImageView *bg = [[UIImageView alloc] initWithImage:bgImg];
        bg.frame = CGRectMake(0.0f, 0.0f, 316.0f, VIEW_HEIGHT); //450 = x on teh iPad

        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(4.0f, 0.0f, 316.0f, VIEW_HEIGHT)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textAlignment = UITextAlignmentCenter;
        timeLabel.lineBreakMode = UILineBreakModeWordWrap;
        timeLabel.numberOfLines = 0;
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.minimumFontSize = 16;
        [timeLabel setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16]];
        timeLabel.adjustsFontSizeToFitWidth = YES;
        
        [_view addSubview:bg];
        [_view addSubview:timeLabel];
        [bg release];
    }
    [self getDate];
    
    return _view;
}

- (void)unloadView {
	[_view release];
	_view = nil;
	[timeLabel release];
	timeLabel = nil;
	// Destroy any additional subviews you added here. Don't waste memory :(.
}

- (float)viewHeight {
	return VIEW_HEIGHT;
}

@end
