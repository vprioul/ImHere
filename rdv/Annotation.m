//
//  Annotation.m
//  rdv
//
//  Created by Vincent Prioul on 11/12/2013.
//  Copyright (c) 2013 Vincent Prioul. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

@synthesize title, coordinate;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d {
	title = ttl;
	coordinate = c2d;
	return self;
}



@end
