UILabel. TTTAttributedLabel.
==

## TTTAttributedLabel

You can add custom actions to any of the available UILabel replacements that support links using a fake URL scheme that you'll intercept later:

```objc
TTTAttributedLabel *tttLabel = <# create the label here #>;
NSString *labelText = @"Lost? Learn more.";
tttLabel.text = labelText;
NSRange r = [labelText rangeOfString:@"Learn more"]; 
[tttLabel addLinkToURL:[NSURL URLWithString:@"action://show-help"] withRange:r];
Then, in your TTTAttributedLabelDelegate:

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    if ([[url scheme] hasPrefix:@"action"]) {
        if ([[url host] hasPrefix:@"show-help"]) {
            /* load help screen */
        } else if ([[url host] hasPrefix:@"show-settings"]) {
            /* load settings screen */
        }
    } else {
        /* deal with http links here */
    }
}
```

TTTAttributedLabel is a fork of OHAttributedLabel.

## IBDesignable TTTAttributedLabel (Чтобы использовать через IB)

TTTAttributedLabel includes IBInspectable and IB_DESIGNABLE annotations to enable configuring the label inside Interface Builder. However, if you see these warnings when building...
```
IB Designables: Failed to update auto layout status: Failed to load designables from path (null)
IB Designables: Failed to render instance of TTTAttributedLabel: Failed to load designables from path (null)
```
...then you are likely using TTTAttributedLabel as a static library, which does not support IB annotations. Some workarounds include:

```
Install TTTAttributedLabel as a dynamic framework using CocoaPods with `use_frameworks!` in your Podfile, or with Carthage
Install TTTAttributedLabel by dragging its source files to your project
```

## Nimbus Attributed Label

If you want a more complex approach, have a look to Nimbus Attributed Label. It support custom links out-of-the-box.

https://github.com/jverkoey/nimbus

http://docs.nimbuskit.info/group___nimbus_attributed_label.html



