//
//  ViewController.m
//  RTSliderView
//
//  Created by Bharath Badam on 18/07/16.
//  Copyright © 2016 Riktam Technologies. All rights reserved.
//

#import "ViewController.h"
#import "RTSliderView.h"


@interface ViewController () <SliderViewDelegate>

@property (weak, nonatomic) IBOutlet RTSliderView *singleSlider;
@property (weak, nonatomic) IBOutlet RTSliderView *dualSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        
    self.singleSlider.delegate = self;
    self.dualSlider.delegate = self;
    
    self.singleSlider.maximumValue = 50;
    self.dualSlider.maximumValue = 200;
    
    self.singleSlider.barColor = [UIColor grayColor];
    self.dualSlider.barColor = [[UIColor orangeColor] colorWithAlphaComponent:0.8];
    
    [self.singleSlider setSingleSliderPostion:50.0];
    [self.dualSlider setleftSliderPosition:0 andRightPosition:200];
    
}

-(void)sliderView:(RTSliderView *)slider valueChanged:(NSArray *)valuesAry {
    
    if (slider == self.singleSlider) {
        NSLog(@"single slider .. %@", valuesAry.firstObject);
    }
    else {
        NSLog(@"Dual slider .. left : %@ and right : %@", valuesAry.firstObject, valuesAry.lastObject);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
