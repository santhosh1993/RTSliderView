
# RTSliderView
#### Manual
You can include the files to your project from the Resources folder of the library

### Importing

Using Objective-C:

```obj-c
#import "RTSliderView.h" 

```

Using Swift:

Do not need to import. 

#### Library Usage

You can create the sliderView using the given type of slider *RTSliderType*

#### RTSliderType

- **RTSliderTypeSingleSlider** for a single slider option
- **RTSliderTypeDoubleSlider** for a Range slider option which will give both selected left and right values

#### Initialisation

Using this library, you can create single slider or a Dual slider like range slider by using the appropriate enum of the **RTSliderType**

```obj-c
RTSliderView *slider = [[RTSliderView alloc] initWithFrame:CGRectMake(10,75,300,40) ForSlider: RTSliderTypeDoubleSlider];
```
#### UI adjustments

You can configure the User Interface, by the given properties

**barColor** // to set the progress bar <br/>
**selectedPortionColor** // to set the selection bar <br/>
**thumbImage** //to set the thumb icon for the slider


#### Dealing with values

You can set a minimum Value which is by default ‘0’ and a maximum value which is by default ‘100’. 

```obj-c
slider.minimumValue = 10;
slider.maximumValue = 50;
```

By using the above sample, user can select the values between 10 and 50.

#### Setting a stepper value

You can set a stepper size for the slider by which the output values will be in the ranges of this stepper.

```obj-c
slider.stepSize = 2
```

The above sample, will set the stepper size to 2 and while reading the values, it will sends in the range of 2’s

#### Reading slider values

You can read the slider values using:

**RTSliderTypeSingleSlider**  type, you can use the **slider.sliderValue**, to read the current user’s selection.

**RTSliderTypeDoubleSlider**  type, you can use the 
- **slider.leftSliderValue** to read the left thumb selection value and 
- **slider.rightSliderValue** to read the right thumb selection value.

#### Predefined value setup

Set the predefined values using the following instance methods.

```obj-c

- (void)setSingleSliderPostion:(double)value;//Single slider

- (void)setLeftSliderPosition:(double)leftValue andRightPosition:(double)rightValue; //Range Slider

```

#### Delegate Handler (RTSliderViewDelegate)

To notify the parent View, the slider has a delegate property which is optional, You can check the values whenever the thumb values were changed.

```obj-c

slider.delegate = <YOUR_LISTENER_CLASS>

```

And implement the following method in your listener class.

```obj-c

- (void)valueChangedForSliderView:(RTSliderView *)sliderView;

```

Here, sliderView will return the slider object which is being modified.
