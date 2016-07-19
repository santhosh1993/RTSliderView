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
@synthesize sliderType = __sliderType;
@synthesize sliderImg = _sliderImg;

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
    __sliderType = noOfSlider;
    
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
    [self addSubview:(__sliderType == SliderTypeSingleSlider) ? [self createSingleSlider] : [self createDoubleSlider]];
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
    
    if (tapView.frame.origin.x + translation.x >= 0 && tapView.frame.origin.x + translation.x <= self.frame.size.width - 40)
    {
        tapView.frame = CGRectMake(tapView.frame.origin.x + translation.x, tapView.frame.origin.y, tapView.frame.size.width, tapView.frame.size.height);
        double value = (tapView.frame.origin.x)/(self.frame.size.width - 40);
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
    [recognizer setTranslation:CGPointZero inView:self];
}

- (void)panGestureRecognisedForRightSlider:(UIPanGestureRecognizer *)recognizer
{
    
    CGPoint translation = [recognizer translationInView:self];
    
    if (rightTapView.frame.origin.x + translation.x <= self.frame.size.width - 40 && rightTapView.frame.origin.x + translation.x >= leftTapView.frame.origin.x)
    {
        [self moveTheView:rightTapView WithTranslation:translation withGestureState:recognizer.state];
    }
    [recognizer setTranslation:CGPointZero inView:self];
}

- (void)moveTheView:(UIView *)movableView WithTranslation:(CGPoint)translation withGestureState:(UIGestureRecognizerState)state
{
    [movableView.superview bringSubviewToFront:movableView];
    movableView.frame = CGRectMake(movableView.frame.origin.x + translation.x, movableView.frame.origin.y, movableView.frame.size.width, movableView.frame.size.height);
    double leftValue = (leftTapView.frame.origin.x)/(self.frame.size.width - 40);
    double rightValue = (rightTapView.frame.origin.x)/(self.frame.size.width - 40);

    NSNumber *percentageleftCovered = [NSNumber numberWithDouble:self.minimumValue + (self.maximumValue - self.minimumValue)*leftValue];
    NSNumber *percentageRightCovered = [NSNumber numberWithDouble:rightValue*self.maximumValue];

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


- (void)setSliderImg:(UIImage *)sliderImg
{
    leftSliderImg.image = sliderImg;
    rightSliderImg.image = sliderImg;
}

#pragma mark - PUBLIC METHODS

- (void)setSingleSliderPostion:(double)position
{
    double xPos = position * (self.bounds.size.width - 40)/self.maximumValue;
    NSLog(@"%f",xPos);
    
    tapView.frame = CGRectMake(xPos,tapView.frame.origin.y,tapView.frame.size.width,tapView.frame.size.height);
}

- (void)setleftSliderPosition:(double)leftPosition andRightPosition:(double)rightPosition
{

    double xPos = (leftPosition - self.minimumValue)/(self.frame.size.width - 40);
    leftTapView.frame = CGRectMake(xPos,leftTapView.frame.origin.y,leftTapView.frame.size.width,leftTapView.frame.size.height);
    
    xPos = (self.frame.size.width - 40) - ((self.maximumValue - rightPosition)/(self.frame.size.width - 40));
    rightTapView.frame = CGRectMake(xPos,rightTapView.frame.origin.y,rightTapView.frame.size.width,rightTapView.frame.size.height);
}

@end
