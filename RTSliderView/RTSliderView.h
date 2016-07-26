//
//  SliderView.h
//  Fetch
//
//  Created by Santhosh on 23/12/15.
//  Copyright © 2015 Santhosh. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,SliderType)
{
    SliderTypeSingleSlider = 1,
    SliderTypeDoubleSlider = 2,
};

@protocol SliderViewDelegate;

@interface RTSliderView : UIView

@property (nonatomic, readonly) SliderType sliderType;

@property (nonatomic,weak) id<SliderViewDelegate> delegate;

@property (nonatomic,weak) UIColor *barColor;
@property (nonatomic,weak) UIImage *sliderImg;

@property(nonatomic, getter=isContinuous) BOOL continuous;

@property(nonatomic) float minimumValue;
@property(nonatomic) float maximumValue;

- (instancetype)initWithFrame:(CGRect)frame ForSlider:(SliderType)noOfSlider;
- (void)setSingleSliderPostion:(double)value;
- (void)setleftSliderPosition:(double)leftValue andRightPosition:(double)rightValue;

@end

@protocol SliderViewDelegate <NSObject>

- (void)sliderView:(RTSliderView *)slider valueChanged:(NSArray *)valuesAry;

@end
