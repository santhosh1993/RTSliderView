//
//  SliderView.m
//  Fetch
//
//  Created by Santhosh on 23/12/15.
//  Copyright © 2015 Santhosh. All rights reserved.
//

#import "RTSliderView.h"

@interface RTSliderView()
{
    UIView *tapView,*leftTapView,*rightTapView;

    UIImageView *leftSliderImg;
    UIImageView *rightSliderImg;
    UIView *barView;
    
    UIView *sliderBgView,*selectedBarVw;
    IBInspectable NSInteger noOfSliders;
    
}

@end

@implementation RTSliderView
@synthesize sliderType = sliderType;
@synthesize sliderImg = sliderImg;
@synthesize sliderValue,leftSliderValue,rightSliderValue;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame ForSlider:(SliderType)noOfSlider
{
    self = [super initWithFrame:frame];
    sliderType = noOfSlider;
    
    [self initializer];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

-(void)awakeFromNib {
    
    sliderType = (noOfSliders == 1) ? SliderTypeSingleSlider : SliderTypeDoubleSlider;
    [self initializer];
    
}


- (void) initializer {
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.userInteractionEnabled = YES;
    
    [self addSubview:(sliderType == SliderTypeSingleSlider) ? [self createSingleSlider] : [self createDoubleSlider]];
    self.sliderImg = [UIImage imageNamed:@"slider_thumb"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeOrientation:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

#pragma mark - SINGLE SLIDER METHODS

- (UIView *)createSingleSlider
{
    sliderBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height)];
    sliderBgView.backgroundColor = [UIColor clearColor];
    sliderBgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    barView = [[UIView alloc] initWithFrame:CGRectMake(20 , sliderBgView.frame.size.height/2 - 2 , sliderBgView.frame.size.width - 40 , 4)];
    barView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    barView.backgroundColor = [UIColor grayColor];
    barView.layer.cornerRadius = CGRectGetHeight(barView.bounds)/2.0;
    [sliderBgView addSubview:barView];
    
    selectedBarVw = [[UIView alloc] initWithFrame:CGRectMake(0,0,barView.frame.size.width,barView.frame.size.height)];
    selectedBarVw.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    selectedBarVw.backgroundColor = [UIColor blueColor];
    selectedBarVw.layer.cornerRadius = CGRectGetHeight(selectedBarVw.bounds)/2.0;
    [barView addSubview:selectedBarVw];
    
    tapView = [[UIView alloc] initWithFrame:CGRectMake(0 , barView.frame.origin.y - 18 , 40 , 40)];
    tapView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    tapView.backgroundColor = [UIColor clearColor];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognised:)];
    [tapView addGestureRecognizer:panRecognizer];
    
    leftSliderImg = [[UIImageView alloc] initWithFrame:CGRectMake(tapView.frame.size.width/2 - 10 , tapView.frame.size.height/2 - 10 , 20 , 20 )];
    leftSliderImg.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    
    [tapView addSubview:leftSliderImg];
    [sliderBgView addSubview:tapView];

    return sliderBgView;
}

#pragma mark - DOUBLE SLIDER METHODS

- (UIView *)createDoubleSlider
{
    sliderBgView = [[UIView alloc] initWithFrame:self.bounds];
    sliderBgView.backgroundColor = [UIColor clearColor];
    sliderBgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    barView = [[UIView alloc] initWithFrame:CGRectMake(20 , sliderBgView.frame.size.height/2 - 2 , sliderBgView.frame.size.width - 40 , 4)];
    barView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth;
    barView.backgroundColor = [UIColor blackColor];
    barView.layer.cornerRadius = CGRectGetHeight(barView.bounds)/2.0;
    [sliderBgView addSubview:barView];
    
    selectedBarVw = [[UIView alloc] initWithFrame:CGRectMake(0,0,barView.frame.size.width,barView.frame.size.height)];
    selectedBarVw.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    selectedBarVw.backgroundColor = [UIColor blueColor];
    selectedBarVw.layer.cornerRadius = CGRectGetHeight(selectedBarVw.bounds)/2.0;
    [barView addSubview:selectedBarVw];
    
    leftTapView = [[UIView alloc] initWithFrame:CGRectMake(0 , barView.frame.origin.y - 18 , 40 , 40)];
    leftTapView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    leftTapView.backgroundColor = [UIColor clearColor];
    
    UIPanGestureRecognizer *leftRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognisedForLeftSlider:)];
    [leftTapView addGestureRecognizer:leftRecognizer];
    
    rightTapView = [[UIView alloc] initWithFrame:CGRectMake(barView.frame.size.width,barView.frame.origin.y - 18, 40 , 40 )];
    rightTapView.backgroundColor = [UIColor clearColor];
    rightTapView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    
    UIPanGestureRecognizer *rightRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognisedForRightSlider:)];
    [rightTapView addGestureRecognizer:rightRecognizer];
    
    leftSliderImg = [[UIImageView alloc] initWithFrame:CGRectMake(leftTapView.frame.size.width/2 - 10 , leftTapView.frame.size.height/2 - 10 , 20 , 20 )];
    leftSliderImg.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    [leftTapView addSubview:leftSliderImg];
    
    rightSliderImg = [[UIImageView alloc] initWithFrame:CGRectMake(rightTapView.frame.size.width/2 - 10 , rightTapView.frame.size.height/2 - 10 , 20 , 20 )];
    rightSliderImg.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    [rightTapView addSubview:rightSliderImg];
    
    [sliderBgView addSubview:leftTapView];
    [sliderBgView addSubview:rightTapView];
    
    return sliderBgView;
}

#pragma mark - GESTURE RECOGNISED

- (void)panGestureRecognised:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self];
    
    if (tapView.frame.origin.x + translation.x >= 0 && tapView.frame.origin.x + translation.x <= barView.bounds.size.width)
    {
        tapView.frame = CGRectMake(tapView.frame.origin.x + translation.x, tapView.frame.origin.y, tapView.frame.size.width, tapView.frame.size.height);
        selectedBarVw.frame = CGRectMake(selectedBarVw.frame.origin.x,selectedBarVw.frame.origin.y,tapView.frame.origin.x,selectedBarVw.frame.size.height);
        
        double value = (tapView.frame.origin.x)/barView.bounds.size.width;
        sliderValue = value*(self.maximumValue-self.minimumValue) + self.minimumValue;
        
        [self valueChanged:(recognizer.state == UIGestureRecognizerStateEnded) ? YES : NO];
    }
    
    [recognizer setTranslation:CGPointZero inView:self];
}

- (void)panGestureRecognisedForLeftSlider:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self];
    translation = (leftTapView.frame.origin.x + translation.x < 0) ? CGPointMake(-leftTapView.frame.origin.x, translation.y) :translation ;
    
    if (leftTapView.frame.origin.x + translation.x >= 0 && leftTapView.frame.origin.x + translation.x <= rightTapView.frame.origin.x)
    {
        [self moveTheView:leftTapView WithTranslation:translation withGestureState:recognizer.state];
    }

    [recognizer setTranslation:CGPointZero inView:self];
}

- (void)panGestureRecognisedForRightSlider:(UIPanGestureRecognizer *)recognizer
{
    
    CGPoint translation = [recognizer translationInView:self];
    translation = (rightTapView.frame.origin.x + translation.x > barView.bounds.size.width) ? CGPointMake(barView.frame.size.width - rightTapView.frame.origin.x, translation.y) :translation ;
    
    translation = (rightTapView.frame.origin.x + translation.x < leftTapView.frame.origin.x) ? CGPointMake(leftTapView.frame.origin.x - rightTapView.frame.origin.x, translation.y) :translation ;

    if (rightTapView.frame.origin.x + translation.x <= barView.bounds.size.width && rightTapView.frame.origin.x + translation.x >= leftTapView.frame.origin.x)
    {
        [self moveTheView:rightTapView WithTranslation:translation withGestureState:recognizer.state];
    }
    
    [recognizer setTranslation:CGPointZero inView:self];
}

- (void)moveTheView:(UIView *)movableView WithTranslation:(CGPoint)translation withGestureState:(UIGestureRecognizerState)state
{
    [movableView.superview bringSubviewToFront:movableView];

    movableView.frame = CGRectMake(movableView.frame.origin.x + translation.x, movableView.frame.origin.y, movableView.frame.size.width, movableView.frame.size.height);
    
    double leftValue = (leftTapView.frame.origin.x)/barView.bounds.size.width;
    double rightValue = (rightTapView.frame.origin.x)/barView.bounds.size.width;
    
    leftSliderValue = self.minimumValue + (self.maximumValue - self.minimumValue)*leftValue;
    rightSliderValue = self.minimumValue + (self.maximumValue - self.minimumValue)*rightValue;
 
    selectedBarVw.frame = CGRectMake(leftTapView.frame.origin.x,selectedBarVw.frame.origin.y,rightTapView.frame.origin.x-leftTapView.frame.origin.x,selectedBarVw.frame.size.height);

    [self valueChanged:(state == UIGestureRecognizerStateEnded) ? YES : NO];
}

#define mark - SLIDER VIEW DELEGATE

- (void)valueChanged:(BOOL)gestureEnded
{
    if ([self.delegate respondsToSelector:@selector(valueChangedForSliderView:)])
    {
        if (self.isContinuous)
        {
            [self.delegate valueChangedForSliderView:self];
        }
        else if(gestureEnded)
        {
            [self.delegate valueChangedForSliderView:self];
        }
    }
}

#pragma mark - PROPERTY METHODS

- (void)setSelectedPortionColor:(UIColor *)selectedPortionColor
{
    selectedBarVw.backgroundColor = selectedPortionColor;
}

- (void)setBarColor:(UIColor *)barColor
{
    barView.backgroundColor = barColor;
}


- (void)setSliderImg:(UIImage *)img
{
    leftSliderImg.image = img;
    rightSliderImg.image = img;
}

#pragma mark - PUBLIC METHODS

- (void)setSingleSliderPostion:(double)value
{
    assert(self.minimumValue <= value);
    assert(self.sliderType == SliderTypeSingleSlider);
    
    sliderValue = value;
    if (self.minimumValue <= value && value <= self.maximumValue) {
        double xPos = (value - self.minimumValue) * barView.bounds.size.width/(self.maximumValue - self.minimumValue);
        NSLog(@"%f",xPos);
        
        tapView.frame = CGRectMake(xPos,tapView.frame.origin.y,tapView.frame.size.width,tapView.frame.size.height);
        selectedBarVw.frame = CGRectMake(selectedBarVw.frame.origin.x,selectedBarVw.frame.origin.y,xPos,selectedBarVw.frame.size.height);
    }
    else {
        
    }
    
}

- (void)setleftSliderPosition:(double)leftValue andRightPosition:(double)rightValue
{
    //given values should be valid
    assert(self.minimumValue <= leftValue);
    assert(self.maximumValue >= rightValue);
    assert(leftValue < rightValue);
    assert(self.maximumValue > self.minimumValue);

    //slider should be Dual slider
    assert(self.sliderType == SliderTypeDoubleSlider);
    
    leftSliderValue = leftValue;
    rightSliderValue = rightValue;

    double xPosleft = (leftValue - self.minimumValue)*barView.bounds.size.width/(self.maximumValue - self.minimumValue);
    leftTapView.frame = CGRectMake(xPosleft,leftTapView.frame.origin.y,leftTapView.frame.size.width,leftTapView.frame.size.height);
    NSLog(@"left: %f",xPosleft);

    double xPosRight = ((rightValue - self.minimumValue)*barView.bounds.size.width/(self.maximumValue - self.minimumValue));
    NSLog(@"right: %f",xPosRight);

    rightTapView.frame = CGRectMake(xPosRight,rightTapView.frame.origin.y,rightTapView.frame.size.width,rightTapView.frame.size.height);
    selectedBarVw.frame = CGRectMake(xPosleft,selectedBarVw.frame.origin.y,xPosRight-xPosleft,selectedBarVw.frame.size.height);

}

- (void)didChangeOrientation:(NSNotification *)notification
{
    [self layoutSubviews];
    [self performSelector:@selector(updateView) withObject:nil afterDelay:0.1];
}

- (void)updateView
{
    (sliderType == SliderTypeSingleSlider) ? [self setSingleSliderPostion:sliderValue] : [self setleftSliderPosition:leftSliderValue andRightPosition:rightSliderValue];
}

@end
