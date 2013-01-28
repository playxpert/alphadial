//
//  ImagesManager.h
//  Alpha Dial
//
//  Created by Bryan Lemster on 12/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImagesManager : NSObject {
	NSMutableArray *images;
	NSMutableArray *highlightedImages;
}

- (UIImage *) imageForIndex:(int)index highlight:(BOOL)highlight;

@end
