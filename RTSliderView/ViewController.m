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

@property (weak, nonatomic) IBOutlet UILabel *singleSliderValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *dualSliderLeftValueLbl;
@property (weak, nonatomic) IBOutlet UILabel *dualSliderRightValueLbl;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        
    self.singleSlider.delegate = self;
    self.dualSlider.delegate = self;
    self.singleSlider.continuous = true;
    
    self.singleSlider.maximumValue = 50;
    self.dualSlider.maximumValue = 500;
    
    self.singleSlider.barColor = [UIColor grayColor];
    self.dualSlider.barColor = [[UIColor orangeColor] colorWithAlphaComponent:0.8];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.singleSlider setSingleSliderPostion:10.0];
        self.singleSliderValueLbl.text = [NSString stringWithFormat:@"%.2f", 10.0];

        [self.dualSlider setleftSliderPosition:50 andRightPosition:60];
        self.dualSliderLeftValueLbl.text = [NSString stringWithFormat:@"%.2f", 50.0];
        self.dualSliderRightValueLbl.text = [NSString stringWithFormat:@"%.2f", 60.0];

    });
    
}

-(void)sliderView:(RTSliderView *)slider valueChanged:(NSArray *)valuesAry {
    
    if (slider == self.singleSlider) {
        
        NSLog(@"single slider .. %@", valuesAry.firstObject);
        self.singleSliderValueLbl.text = [NSString stringWithFormat:@"%.2f", [valuesAry.firstObject floatValue]];
        
    }
    else {
        
        NSLog(@"Dual slider .. left : %@ and right : %@", valuesAry.firstObject, valuesAry.lastObject);
        self.dualSliderLeftValueLbl.text = [NSString stringWithFormat:@"%.2f", [valuesAry.firstObject floatValue]];
        self.dualSliderRightValueLbl.text = [NSString stringWithFormat:@"%.2f", [valuesAry.lastObject floatValue]];

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
