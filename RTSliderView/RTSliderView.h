//
//  SliderView.h
//  Fetch
//
//  Created by Santhosh on 23/12/15.
//  Copyright © 2015 Santhosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SliderViewDelegate;

@interface RTSliderView : UIView

typedef NS_ENUM(NSInteger,SliderType)
{
    SliderTypeSingleSlider = 1,
    SliderTypeDoubleSlider = 2,
};

@property (nonatomic,weak) id<SliderViewDelegate> delegate;
@property (nonatomic,weak) UIColor *barColor;
@property (nonatomic,weak) IBInspectable UIImage *sliderImg;

@property (nonatomic, readonly) SliderType sliderType;

@property(nonatomic, getter=isContinuous) BOOL continuous;

@property(nonatomic) float minimumValue;
@property(nonatomic) float maximumValue;

- (instancetype)initWithFrame:(CGRect)frame ForSlider:(SliderType)noOfSlider;
- (void)setSingleSliderPostion:(double)position;
- (void)setleftSliderPosition:(double)leftPosition andRightPosition:(double)rightPosition;

@end

@protocol SliderViewDelegate <NSObject>

- (void)sliderView:(RTSliderView *)slider valueChanged:(NSArray *)valuesAry;

@end
