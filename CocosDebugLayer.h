//
//  CocosDebugLayer.h
//  TryggaHander
//
//  Created by Erik Olsson on 8/24/11.
//  Copyright 2011 Traduko. All rights reserved.
//

#import "cocos2d.h"

@interface CocosDebugLayer : CCLayer<CCTargetedTouchDelegate>{
    NSMutableArray *logMessages;
}
-(void)logMessage:(NSString*)message;
@end
