//
//  TutorialTile.m
//  emilymalison
//
//  Created by Emily Malison on 7/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "TutorialTile.h"
#import "Dot.h"
#import "Tutorial.h"

@implementation TutorialTile{
    BOOL canTouch;
    CGFloat _tileColumnHeight;
    CGFloat _tileColumnWidth;
    CGFloat _dotMarginHorizontal;
    CGFloat _dotMarginVertical;
    //TutorialTile *tileLeft;
    //TutorialTile *tileRight;
    Dot *dot;
}


-(void)onEnter{
    [super onEnter];
    
    self.userInteractionEnabled=YES;
    canTouch=YES;
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    if (canTouch) {
        canTouch = NO;
        CCActionRotateBy *rotateTile= [CCActionRotateBy actionWithDuration:.4 angle:90];
        CCActionCallBlock *resetTouch = [CCActionCallBlock actionWithBlock:^{
            canTouch= YES;
        }];
        [self runAction:[CCActionSequence actionOne:rotateTile two:resetTouch]];
        
    }
}

-(void)setUpTutorialTile{
    _tileColumnHeight=self.contentSize.height/3;
    _tileColumnWidth=self.contentSize.width/3;
    
    _dotMarginHorizontal=_tileColumnWidth/3;
    _dotMarginVertical=_tileColumnHeight/3;
    
    float x=_dotMarginHorizontal;
    float y=_dotMarginVertical;
    
    if (self.number==1) {
        for (int i=0; i<3; i++) {
            x=_dotMarginHorizontal;
            for (int j=0; j<3; j++) {
                if (i==0 && j==0) {
                    dot=(Dot*)[CCBReader load:@"BlueDot"];
                }
                else if (i==0 && j==1){
                    dot=(Dot*)[CCBReader load:@"GreenDot"];
                }
                else if (i==0 && j==2){
                    dot=(Dot*)[CCBReader load:@"WhiteDot"];
                }
                else if (i==1 && j==0){
                    dot=(Dot*)[CCBReader load:@"WhiteDot"];
                }
                else if (i==1 && j==1){
                    dot=(Dot*)[CCBReader load:@"WhiteDot"];
                }
                else if (i==1 && j==2){
                    dot=(Dot*)[CCBReader load:@"GreenDot"];
                }
                else if (i==2 && j==0){
                    dot=(Dot*)[CCBReader load:@"BlueDot"];
                }
                else if (i==2 && j==1){
                    dot=(Dot*)[CCBReader load:@"BlueDot"];
                }
                else if (i==2 && j==2){
                    dot=(Dot*)[CCBReader load:@"BlueDot"];
                }
                [dot setScaleX:(((_tileColumnWidth)/dot.contentSize.width))/2];
                [dot setScaleY:(((_tileColumnHeight)/dot.contentSize.height))/2];
                [self addChild:dot];
                dot.contentSize = CGSizeMake(_tileColumnWidth, _tileColumnHeight);
                dot.position = ccp(x, y);
                
                
                x+=_tileColumnWidth;
            }
            y+=_tileColumnHeight;
        }
    }
    if (self.number==2) {
        for (int i=0; i<3; i++) {
            x=_dotMarginHorizontal;
            for (int j=0; j<3; j++) {
                if (i==0 && j==0) {
                    dot=(Dot*)[CCBReader load:@"BlueDot"];
                }
                else if (i==0 && j==1){
                    dot=(Dot*)[CCBReader load:@"WhiteDot"];
                }
                else if (i==0 && j==2){
                    dot=(Dot*)[CCBReader load:@"WhiteDot"];
                }
                else if (i==1 && j==0){
                    dot=(Dot*)[CCBReader load:@"BlueDot"];
                }
                else if (i==1 && j==1){
                    dot=(Dot*)[CCBReader load:@"BlueDot"];
                }
                else if (i==1 && j==2){
                    dot=(Dot*)[CCBReader load:@"GreenDot"];
                }
                else if (i==2 && j==0){
                    dot=(Dot*)[CCBReader load:@"GreenDot"];
                }
                else if (i==2 && j==1){
                    dot=(Dot*)[CCBReader load:@"WhiteDot"];
                }
                else if (i==2 && j==2){
                    dot=(Dot*)[CCBReader load:@"GreenDot"];
                }
                [dot setScaleX:(((_tileColumnWidth)/dot.contentSize.width))/2];
                [dot setScaleY:(((_tileColumnHeight)/dot.contentSize.height))/2];
                [self addChild:dot];
                dot.contentSize = CGSizeMake(_tileColumnWidth, _tileColumnHeight);
                dot.position = ccp(x, y);
                
                
                x+=_tileColumnWidth;
            }
            y+=_tileColumnHeight;
        }
    }
}




@end
