//
//  CocosDebugLayer.m
//  TryggaHander
//
//  Created by Erik Olsson on 8/24/11.
//  Copyright 2011 Traduko. All rights reserved.
//

#import "CocosDebugLayer.h"


@implementation CocosDebugLayer
@synthesize fixedY=_fixedY;

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        logMessages = [[NSMutableArray alloc] init];
        CCLayerColor *background = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 150)];
        [self addChild:background];
        self.position = CGPointMake(0, _fixedY);
        self.isTouchEnabled = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logMessage:) name:@"LogMessage" object:nil];
    }
    
    return self;
}

-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:INT_MIN swallowsTouches:YES];
}

-(void)onExit{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
}

-(void)updateLog{
    float posy = 10.0;
    for (int i = [logMessages count]-1; i>=0; i--) {
        CCLabelTTF *logMsg = [logMessages objectAtIndex:i];
        logMsg.position = CGPointMake(10.0, posy);
        posy += 20.0;
    }
}

-(void)logMessage:(NSNotification*)notification{
    NSString *message = [notification object];
    CCLabelTTF *logMsg = [CCLabelTTF labelWithString:message fontName:@"Helvetica" fontSize:12];
    [logMsg setAnchorPoint:CGPointZero];
    [self addChild:logMsg];
    [logMessages addObject:logMsg];
    [logMsg release];
    [self updateLog];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint position = [self convertTouchToNodeSpace:touch];

    if(position.y > 0){
        return YES;   
    }
    return NO;
}
-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint position = [self convertTouchToNodeSpace:touch];
    CGPoint worldPos = [self convertToWorldSpace:position];
    CGPoint newPos = CGPointMake(0, worldPos.y-20);
    if(newPos.y > _fixedY) newPos.y = _fixedY;
    if(newPos.y < 0) newPos.y = 0;
    
    self.position = newPos;
}




@end
