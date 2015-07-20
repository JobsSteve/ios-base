48. Media. Images.
==

## SDWebImage

```objc
 if (user.avatarURL.length > 0) {
      [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:user.avatarURL]
                              placeholderImage:[UIImage imageWithUIColor:[UIColor DTAvatarPanelColor]]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                           
                                           //Cropper View
                                           self.cropperView.image = image;
                                           CGFloat side = self.view.bounds.size.width;
                                           CGSize size = CGSizeMake(side, side);
                                           UIImage *imageSized = [image scaleToSize:size];
                                           self.avatarImageView.image = imageSized;
                                       }];
    }
```

## 





