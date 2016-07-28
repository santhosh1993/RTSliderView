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
@property (nonatomic,weak) UIColor *selectedPortionColor;
@property (nonatomic,weak) IBInspectable UIImage *sliderImg;

@property(nonatomic, getter=isContinuous)IBInspectable BOOL continuous;


@property(nonatomic)IBInspectable float minimumValue;
@property(nonatomic)IBInspectable float maximumValue;

- (instancetype)initWithFrame:(CGRect)frame ForSlider:(SliderType)noOfSlider;
- (void)setSingleSliderPostion:(double)value;
- (void)setleftSliderPosition:(double)leftValue andRightPosition:(double)rightValue;

@end

@protocol SliderViewDelegate <NSObject>

- (void)sliderView:(RTSliderView *)slider valueChanged:(NSArray *)valuesAry;

@end
