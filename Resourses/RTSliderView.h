//
//  SliderView.h
//  Fetch
//
//  Created by Santhosh on 23/12/15.
//  Copyright © 2015 Santhosh. All rights reserved.
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

@property (nonatomic,weak) id<RTSliderViewDelegate> delegate;

@property (nonatomic,weak) UIColor *barColor;
@property (nonatomic,weak) UIColor *selectedPortionColor;
@property (nonatomic,weak) IBInspectable UIImage *sliderImg;

@property (nonatomic) double stepSize;

@property(nonatomic)IBInspectable float minimumValue;
@property(nonatomic)IBInspectable float maximumValue;

@property(nonatomic,readonly) double sliderValue;
@property(nonatomic,readonly) double leftSliderValue;
@property(nonatomic,readonly) double rightSliderValue;

- (instancetype)initWithFrame:(CGRect)frame ForSlider:(RTSliderType)noOfSlider;
- (void)setSingleSliderPostion:(double)value;
- (void)setLeftSliderPosition:(double)leftValue andRightPosition:(double)rightValue;

@end

@protocol RTSliderViewDelegate <NSObject>

- (void)valueChangedForSliderView:(RTSliderView *)sliderVw;

@end
