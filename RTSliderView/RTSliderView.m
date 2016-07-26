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
    
    UIView *sliderBgView;
    
}

@end

@implementation RTSliderView
@synthesize sliderType = sliderType;
@synthesize sliderImg = sliderImg;

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
    
    [self initializer];
    
}


- (void) initializer {
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.userInteractionEnabled = YES;
    
    [self addSubview:(sliderType == SliderTypeSingleSlider) ? [self createSingleSlider] : [self createDoubleSlider]];
    self.sliderImg = [UIImage imageNamed:@"slider_thumb"];
    
}

#pragma mark - SINGLE SLIDER METHODS

- (UIView *)createSingleSlider
{
    sliderBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height)];
    sliderBgView.backgroundColor = [UIColor clearColor];
    sliderBgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    barView = [[UIView alloc] initWithFrame:CGRectMake(20 , sliderBgView.frame.size.height/2 - 2 , sliderBgView.frame.size.width - 40 , 4)];
    barView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    barView.backgroundColor = [UIColor blackColor];
    barView.layer.cornerRadius = CGRectGetHeight(barView.bounds)/2.0;
    [sliderBgView addSubview:barView];
    
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
        double value = (tapView.frame.origin.x)/barView.bounds.size.width;
        NSNumber *percentageCovered = [NSNumber numberWithDouble:value*self.maximumValue];

        if (self.isContinuous) {
            [self valueChanged:@[percentageCovered]];
        }
        else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateFailed) {
            [self valueChanged:@[percentageCovered]];
        }

    }
    
    [recognizer setTranslation:CGPointZero inView:self];
}

- (void)panGestureRecognisedForLeftSlider:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self];

    if (leftTapView.frame.origin.x + translation.x >= 0 && leftTapView.frame.origin.x + translation.x <= rightTapView.frame.origin.x)
    {
        [self moveTheView:leftTapView WithTranslation:translation withGestureState:recognizer.state];
    }
    else if (leftTapView.frame.origin.x + translation.x < 0){
        translation = CGPointMake(-leftTapView.frame.origin.x, translation.y);
        [self moveTheView:leftTapView WithTranslation:translation withGestureState:recognizer.state];
    }
    [recognizer setTranslation:CGPointZero inView:self];
}

- (void)panGestureRecognisedForRightSlider:(UIPanGestureRecognizer *)recognizer
{
    
    CGPoint translation = [recognizer translationInView:self];
    
    if (rightTapView.frame.origin.x + translation.x <= barView.bounds.size.width && rightTapView.frame.origin.x + translation.x >= leftTapView.frame.origin.x)
    {
        [self moveTheView:rightTapView WithTranslation:translation withGestureState:recognizer.state];
    }
    else if (rightTapView.frame.origin.x + translation.x < 0){
        translation = CGPointMake(-rightTapView.frame.origin.x, translation.y);
        [self moveTheView:rightTapView WithTranslation:translation withGestureState:recognizer.state];
    }
    [recognizer setTranslation:CGPointZero inView:self];
}

- (void)moveTheView:(UIView *)movableView WithTranslation:(CGPoint)translation withGestureState:(UIGestureRecognizerState)state
{
    [movableView.superview bringSubviewToFront:movableView];
    CGRect rect = movableView.frame;
    if ([movableView isEqual:leftTapView]) {
        CGRect tempRect = CGRectMake(movableView.frame.origin.x + translation.x, movableView.frame.origin.y, movableView.frame.size.width, movableView.frame.size.height);
        if (CGRectGetMaxX(tempRect) < CGRectGetMidX(rightTapView.frame)) {
            rect = tempRect;
        }
    }
    else if ([movableView isEqual:rightTapView]) {
        CGRect tempRect = CGRectMake(movableView.frame.origin.x + translation.x, movableView.frame.origin.y, movableView.frame.size.width, movableView.frame.size.height);
        
        if (CGRectGetMinX(tempRect) > CGRectGetMidX(leftTapView.frame)) {
            rect = tempRect;
        }
        
    }
    
    movableView.frame = rect;
    double leftValue = (leftTapView.frame.origin.x)/barView.bounds.size.width;
    double rightValue = (rightTapView.frame.origin.x)/barView.bounds.size.width;

    NSNumber *percentageleftCovered = [NSNumber numberWithDouble:self.minimumValue + (self.maximumValue - self.minimumValue)*leftValue];
    NSNumber *percentageRightCovered = [NSNumber numberWithDouble:self.minimumValue + (self.maximumValue - self.minimumValue)*rightValue];

    if (self.isContinuous) {
        [self valueChanged:@[percentageleftCovered,percentageRightCovered]];
    }
    else if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateFailed) {
        [self valueChanged:@[percentageleftCovered,percentageRightCovered]];
    }
    
}

#define mark - SLIDER VIEW DELEGATE

- (void)valueChanged:(NSArray *)valuesAry
{
    if ([self.delegate respondsToSelector:@selector(sliderView:valueChanged:)]) {
        [self.delegate sliderView:self valueChanged:valuesAry];
    }
}

#pragma mark - PROPERTY METHODS

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

    if (self.minimumValue < value && value < self.maximumValue) {
        double xPos = (value - self.minimumValue) * barView.bounds.size.width/(self.maximumValue - self.minimumValue);
        NSLog(@"%f",xPos);
        
        tapView.frame = CGRectMake(xPos,tapView.frame.origin.y,tapView.frame.size.width,tapView.frame.size.height);
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

    double xPos = (leftValue - self.minimumValue)*barView.bounds.size.width/(self.maximumValue - self.minimumValue);
    leftTapView.frame = CGRectMake(xPos,leftTapView.frame.origin.y,leftTapView.frame.size.width,leftTapView.frame.size.height);
    NSLog(@"left: %f",xPos);

    xPos = ((rightValue - self.minimumValue)*barView.bounds.size.width/(self.maximumValue - self.minimumValue));
    NSLog(@"right: %f",xPos);

    rightTapView.frame = CGRectMake(xPos,rightTapView.frame.origin.y,rightTapView.frame.size.width,rightTapView.frame.size.height);
}

@end
