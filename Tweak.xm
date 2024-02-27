@interface CALayer (Private)
	@property (nonatomic, assign) BOOL allowsGroupOpacity;
	@property (nonatomic, assign) BOOL allowsGroupBlending;
@end

@interface CCUIBaseSliderView : UIView
	@property (nonatomic, retain) UILabel *percentLabel;
	- (float)value;
@end

%hook CCUIBaseSliderView
	%property (nonatomic, retain) UILabel *percentLabel;

	- (id)initWithFrame:(CGRect)arg1
	{
		CCUIBaseSliderView *orig = %orig;
		orig.percentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		orig.percentLabel.text = @"0%";
		[orig addSubview:orig.percentLabel];
		orig.percentLabel.translatesAutoresizingMaskIntoConstraints = NO;
		[orig.percentLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
		[orig.percentLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
		return orig;
	}

	- (void)layoutSubviews
	{
		%orig;

		if (self.percentLabel)
		{
			if (self.frame.size.width > 20)
			{
				self.percentLabel.font = [UIFont boldSystemFontOfSize:15];
				self.percentLabel.textColor = [self value] > 0.48 ? [UIColor blackColor] : [UIColor whiteColor];
				self.percentLabel.text = [[NSString stringWithFormat:@"%.f", [self value]*100] stringByAppendingString:@"%"];
				self.percentLabel.textAlignment = NSTextAlignmentCenter;
				[self.percentLabel sizeToFit];
				self.percentLabel.hidden = NO;
				[self bringSubviewToFront:self.percentLabel];
			}
			else
				self.percentLabel.hidden = YES;
		}
	}
%end
