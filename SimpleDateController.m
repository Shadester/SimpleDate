#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BBWeeAppController-Protocol.h"

static NSBundle *_SimpleDateWeeAppBundle = nil;

float VIEW_HEIGHT = 24.0f;
float VIEW_WIDTH_PORTRAIT = 316.0f;
float VIEW_WIDTH_LANDSCAPE = 476.0f;

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

- (void)willRotateToInterfaceOrientation:(int)orientation
{
    if(orientation == UIInterfaceOrientationPortrait) {
        isPortrait = YES;
    }
    else {
        isPortrait = NO;
    }
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
        _view = [[UIView alloc] initWithFrame:CGRectMake(2.0f, 0.0f, VIEW_WIDTH_PORTRAIT, VIEW_HEIGHT)];
        
        UIImage *bgImg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/StocksWeeApp.bundle/WeeAppBackground.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(4.0f, 4.0f, 4.0f, 4.0f)];
        bg = [[UIImageView alloc] initWithImage:bgImg];

        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(4.0f, 0.0f, VIEW_WIDTH_PORTRAIT, VIEW_HEIGHT)];
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
    }
    [self getDate];
    
    return _view;
}

- (void)viewWillAppear
{
    if(isPortrait) {
        _view.frame = CGRectMake(2.0f, 0.0f, VIEW_WIDTH_PORTRAIT, VIEW_HEIGHT);
        bg.frame = CGRectMake(0.0f, 0.0f, VIEW_WIDTH_PORTRAIT, VIEW_HEIGHT);
        timeLabel.frame = CGRectMake(0.0f, 0.0f, VIEW_WIDTH_PORTRAIT, VIEW_HEIGHT);
    }
    else {
        _view.frame = CGRectMake(2.0f, 0.0f, VIEW_WIDTH_LANDSCAPE, VIEW_HEIGHT);
        bg.frame = CGRectMake(0.0f, 0.0f, VIEW_WIDTH_LANDSCAPE, VIEW_HEIGHT);
        timeLabel.frame = CGRectMake(0.0f, 0.0f, VIEW_WIDTH_LANDSCAPE, VIEW_HEIGHT);
    }
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
