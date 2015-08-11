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

If you want a more complex approach, have a look to Nimbus Attributed Label. It support custom links out-of-the-box.







