//
//  RTSliderView.h
//  RTSluderView
//
//  Created by Santhosh on 15/07/16.
//  Copyright © 2016 Santhosh. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,RTSliderType)
{
    RTSliderTypeSingleSlider = 1,
    RTSliderTypeDoubleSlider = 2,
};

@protocol RTSliderViewDelegate;

@interface RTSliderView : UIView

@property (nonatomic, readonly) RTSliderType sliderType;

/* Set this delegate to get the call backs when user update the slider position */
@property (nonatomic,weak) id<RTSliderViewDelegate> delegate;

/* barColor is the unselected poriton of the bar. 
   selectedPortionColor is for the selected Portion of the bar
   sliderImg is for the thumb images for the slider*/
@property (nonatomic,strong) IBInspectable UIColor *barColor; // Default value black color
@property (nonatomic,strong) IBInspectable UIColor *selectedPortionColor; // Default value blue color
@property (nonatomic,strong) IBInspectable UIImage *sliderImg; // Default value slider_thumb.png

/* Step size is used to get the values in those steps in the call back*/
@property (nonatomic) IBInspectable double stepSize; // Default value is 0.

/* minimum value and maximum value are assigned for getting the slider values in those range */
@property(nonatomic)IBInspectable float minimumValue; // Default value is 0
@property(nonatomic)IBInspectable float maximumValue; // Default value is 100

/* sliderValue is for single slider view. It will be updated when user move the thumb. The values will be in the range for minimum and maximum */
@property(nonatomic,readonly) double sliderValue;

/* leftSliderValue,rightSliderValue are for double slider view. It will be updated when user move the thumb. The values will be in the range for minimum and maximum */
@property(nonatomic,readonly) double leftSliderValue;
@property(nonatomic,readonly) double rightSliderValue;

- (instancetype)initWithFrame:(CGRect)frame ForSlider:(RTSliderType)noOfSlider;

/* Below both functions are used for setting the values for single and double slider respectively. */
- (void)setSingleSliderPostion:(double)value;
- (void)setLeftSliderPosition:(double)leftValue andRightPosition:(double)rightValue;

@end

/* If you implement RTSliderViewDelegate. You will be getting the call back when user changes the thumb position */
@protocol RTSliderViewDelegate <NSObject>

- (void)valueChangedForSliderView:(RTSliderView *)sliderVw;

@end
