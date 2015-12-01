20. NSAutoLayout. PureLayout.
==

## Setup Autolayouts

NSLayoutConstraint-ы позволяют верстать для любых экранов устройств.

```objc
@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *roundMapHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *roundMapWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *roundMapTopConstraint;

@end

- (void)setupAutoLayouts {
    
    if (IS_IPHONE_6 && IS_IPHONE_6_PLUS) {
        //RoundMap
        self.roundMapHeightConstraint.constant = 220;
        self.roundMapWidthConstraint.constant = 220;
        self.roundMapTopConstraint.constant = 157;
    }
    else if (IS_IPHONE_5 && IS_IPHONE_5_OR_HIGHER) {
        //RoundMap
        self.roundMapHeightConstraint.constant = 220;
        self.roundMapWidthConstraint.constant = 220;
        self.roundMapTopConstraint.constant = 127;
    }
    else {
        //RoundMap
        self.roundMapHeightConstraint.constant = 180;
        self.roundMapWidthConstraint.constant = 180;
        self.roundMapTopConstraint.constant = 87;
    }
}
```

## 


