@interface CALayer (Private)
	@property (nonatomic, assign) BOOL allowsGroupOpacity;
	@property (nonatomic, assign) BOOL allowsGroupBlending;
@end

@interface CCUIBaseSliderView : UIView
	- (float)value;
	@property (assign,getter=isGlyphVisible,nonatomic) BOOL glyphVisible;
@end

@interface CCUIContinuousSliderView : CCUIBaseSliderView
	@property (nonatomic, retain) UILabel *percentLabel;
@end

%hook CCUIContinuousSliderView
	%property (nonatomic, retain) UILabel *percentLabel;

	- (id)initWithFrame:(CGRect)arg1
	{
		CCUIContinuousSliderView *orig = %orig;
		orig.percentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		orig.percentLabel.text = @"0%";
		[orig addSubview:orig.percentLabel];
		orig.percentLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[orig.percentLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
		[orig.percentLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
		orig.percentLabel.font = [UIFont boldSystemFontOfSize:16];
		return orig;
	}

	- (void)setValue:(float)arg1
	{
		%orig;

		if (self.percentLabel)
		{
			float val = arg1*100;
			if (arg1 > 1)
				val = 100;
			else if (arg1 < 0)
				val = 0;

			if (self.frame.size.width > 15 && self.frame.size.height > 15) //To handle the minimized volume hud view
			{
				self.percentLabel.hidden = NO;
				self.percentLabel.textColor = val > 49 ? [UIColor blackColor] : [UIColor whiteColor];
				self.percentLabel.text = [[NSString stringWithFormat:@"%.f", val] stringByAppendingString:@"%"];				
			}
			else
				self.percentLabel.hidden = YES;
		}
	}
%end
