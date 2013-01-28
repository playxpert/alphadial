//
//  ImagesManager.m
//  Alpha Dial
//
//  Created by Bryan Lemster on 12/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ImagesManager.h"


@implementation ImagesManager

- (id) init
{
	self = [super init];
	if (self != nil) {
		images = [[NSMutableArray alloc] init];
		highlightedImages = [[NSMutableArray alloc] init];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonA" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonB" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonC" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonD" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonE" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonF" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonG" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonH" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonI" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonJ" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonK" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonL" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonM" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonN" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonO" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonP" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonQ" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonR" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonS" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonT" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonU" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonV" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonW" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonX" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonY" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonZ" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonStar" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonSmile" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonApple" ofType:@"png" inDirectory:@"/"]] retain]];
		[images addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHeart" ofType:@"png" inDirectory:@"/"]] retain]];

	
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgA" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgB" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgC" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgD" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgE" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgF" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgG" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgH" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgI" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgJ" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgK" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgL" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgM" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgN" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgO" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgP" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgQ" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgR" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgS" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgT" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgU" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgV" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgW" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgX" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgY" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgZ" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgStar" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgSmile" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgApple" ofType:@"png" inDirectory:@"/"]] retain]];
		[highlightedImages addObject:[[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"buttonHgHeart" ofType:@"png" inDirectory:@"/"]] retain]];
	}
	return self;
}


- (UIImage *) imageForIndex:(int)index highlight:(BOOL)highlight {
	if (highlight) {
		return [highlightedImages objectAtIndex:index];
	} else {
		return [images objectAtIndex:index];
	}
}

- (void) dealloc
{
	[images release];
	[highlightedImages release];
	[super dealloc];
}


@end
