extern NSString* const kCAFilterDestOut;

@interface CCUIBaseSliderView : UIView
@property (nonatomic, retain) UILabel *percentLabel;
- (float)value;
@end

@interface CALayer (Private)
@property (nonatomic, retain) NSString *compositingFilter;
@property (nonatomic, assign) BOOL allowsGroupOpacity;
@property (nonatomic, assign) BOOL allowsGroupBlending;
@end


%hook CCUIBaseSliderView
%property (nonatomic, retain) UILabel *percentLabel;

- (id)initWithFrame:(CGRect)frame {
	CCUIBaseSliderView *orig = %orig;
	orig.percentLabel = [[UILabel alloc] init];
	orig.percentLabel.textColor = [UIColor whiteColor];
	orig.percentLabel.text = @"0%";
	orig.percentLabel.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.85);
	[orig addSubview:orig.percentLabel];
	orig.percentLabel.layer.allowsGroupBlending = NO;
	orig.percentLabel.layer.allowsGroupOpacity = YES;
	orig.percentLabel.layer.compositingFilter = kCAFilterDestOut;
	orig.percentLabel.font = [orig.percentLabel.font fontWithSize:10];
	return orig;
}

- (void)layoutSubviews {
	%orig;
	if ([self valueForKey:@"_glyphPackageView"]) {
		UIView *glyphView = (UIView *)[self valueForKey:@"_glyphPackageView"];
		glyphView.center = CGPointMake(self.bounds.size.width*0.5,self.bounds.size.height*0.5);
		if (self.percentLabel) {
			if ([self.percentLabel superview] != glyphView) {
				if ([self.percentLabel superview]) [self.percentLabel removeFromSuperview];
				[glyphView addSubview:self.percentLabel];
			}

			if ([self.percentLabel superview] == glyphView) {
				self.percentLabel.layer.allowsGroupBlending = NO;
				self.percentLabel.layer.allowsGroupOpacity = YES;
				self.percentLabel.layer.compositingFilter = kCAFilterDestOut;
				self.percentLabel.text = [[NSString stringWithFormat:@"%.f", [self value]*100] stringByAppendingString:@"%"];
				[self.percentLabel sizeToFit];
				self.percentLabel.center = [self convertPoint:CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.85) toView:glyphView];
			}
		}

		if ([self valueForKey:@"_compensatingGlyphPackageView"]) {
			UIView *compensatingGlyphView = [self valueForKey:@"_compensatingGlyphPackageView"];
			compensatingGlyphView.center = glyphView.center;

		}
	}
}
%end

