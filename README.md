云课堂昵称: 巨型猪头

# BSCircleBanner

A circle scroll view for iOS.

[中文介绍](README.md)

## Installation

Available in [CocoaPods](http://cocoapods.org/?q=BSCircleBanner)

```
pod 'BSCircleBanner'
```

or 

1. Copy `BSCircleBanner` folder to project;
2. Install `Masonry` via CocoaPods or other way.

## Preview

#### The Album Type(Automatic Scrolling)

![Demo Gif](Preview/natural_scrolling_in_album_type.gif)

#### The Album Type(Touch Scrolling)

![Demo Gif](Preview/touch_scrolling_in_album_type.gif)

#### The Normal Type(Automatic Scrolling)

![Demo Gif](Preview/natural_scrolling_in_normal_type.gif)

#### The Normal Type(Touch Scrolling)

![Demo Gif](Preview/touch_scrolling_in_normal_type.gif)

#### Use Custom Layout

![Demo Gif](Preview/touch_scrolling_with_custom_layout.gif)

## Quickly Start


1. `#import "BSCircleBanner.h"`
2. Create a instance of `BSCircleBanner`;
3. Configure that instance, set the banner size and so on;
4. Add it to a superview;
5. Setup and implement its data source and delegate.

## Advanced Usage

Now, this repo just provide two layout for banners -- album type and normal type, the preview is in the above. Change the type property of banner view instance can change the display type which it use.

You can set the `customLayout` property to use the custom layouts.
