//
//  Grid.m
//  emilymalison
//
//  Created by Emily Malison on 7/8/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Grid.h"
#import "MainScene.h"
#import "Gameplay.h"
#import "Tile.h"
#import "Dot.h"

static const int GRID_SIZE=3;

@implementation Grid{
    CGFloat _columnWidth;
    CGFloat _columnHeight;
    CGFloat _tileMarginVertical;
    CGFloat _tileMarginHorizontal;
    CCSprite *tileSprite;
    NSMutableArray *_gridArray;
    Tile *tileRotated;
    int score;
    
}

- (void)onEnter
{
    [super onEnter];
    
    [self setUpGrid];
}

#pragma mark - Filling Grid with Tiles

-(void)setUpGrid{
    
    _gridArray=[NSMutableArray array];
    
    _columnWidth=(self.contentSize.width/GRID_SIZE);
    _columnHeight=(self.contentSize.height/GRID_SIZE);
    
    _tileMarginVertical=(_columnWidth/2);
    _tileMarginHorizontal=(_columnHeight/2);
    
    float x=_tileMarginHorizontal;
    float y=_tileMarginVertical;
    
    for (int i=0; i<GRID_SIZE; i++) {
        
        x=_tileMarginHorizontal;
        _gridArray[i]=[NSMutableArray array];
        
        
        for (int j=0; j<GRID_SIZE; j++) {
            Tile *tile= (Tile*)[CCBReader load:@"Tile"];
            
            [tile setScaleX:((_columnWidth)/tile.contentSize.width)];
            [tile setScaleY:((_columnHeight)/tile.contentSize.height)];
            
            [self addChild:tile];
            //tile.contentSize = CGSizeMake(_columnWidth, _columnHeight);
			tile.position = ccp(x, y);
            _gridArray[i][j]=tile;
            tile.tileX=i;
            tile.tileY=j;
            
			x+= _columnWidth;
		}
		y += _columnHeight;
    }
    
}

#pragma mark - Checking for Matches

-(void)checkTile:(Tile *)rotatedTile{
    int match;
    BOOL firstDot;
    for (int j=0; j<3; j++) {
        match=1;
        firstDot=true;
        for (int i=-1; i<2; i++) {
            if (rotatedTile.tileY+i>=0 && rotatedTile.tileY+i<=2) {
                Tile* currentTile=_gridArray[rotatedTile.tileX][rotatedTile.tileY+i];
                for (int k=0; k<3; k++) {
                    if (!firstDot){
                        if (k!=0) {
                            if (currentTile.dotColorArray[j][k]==currentTile.dotColorArray[j][k-1]) {
                                match++;
                                if (match>=4) {
                                    currentTile.remove=true;
                                    Tile* tileBefore=_gridArray[currentTile.tileX][currentTile.tileY-1];
                                    tileBefore.remove=true;
                                    if (match==4) {
                                        score+=4;
                                    }
                                    else if (match>4){
                                        score+=1;
                                    }
                                }
                            }
                            else{
                                
                                match=1;
                            }
                        }
                        else if (k==0){
                            Tile* tileBefore=_gridArray[currentTile.tileX][currentTile.tileY-1];
                            if (currentTile.dotColorArray[j][k]==tileBefore.dotColorArray[j][2]) {
                                match++;
                                if (match>=4) {
                                    currentTile.remove=true;
                                    tileBefore.remove=true;
                                    if (match==4) {
                                        score+=4;
                                    }
                                    else if (match>4){
                                        score+=1;
                                    }
                                }
                            }
                            else{
                                match=1;
                            }
                        }
                    }
                    else{
                        firstDot=false;
                    }
                }
            }
        }
    }
    
    for (int j=0; j<3; j++) {
        match=1;
        firstDot=true;
        for (int i=-1; i<2; i++) {
            if (rotatedTile.tileX+i>=0 && rotatedTile.tileX+i<=2) {
                Tile* currentTile=_gridArray[rotatedTile.tileX+i][rotatedTile.tileY];
                for (int k=0; k<3; k++) {
                    if (!firstDot) {
                        if (k!=0) {
                            if (currentTile.dotColorArray[k][j]==currentTile.dotColorArray[k-1][j]) {
                                match++;
                                if (match>=4) {
                                    currentTile.remove=true;
                                    Tile* tileBefore=_gridArray[currentTile.tileX-1][currentTile.tileY];
                                    tileBefore.remove=true;
                                    if (match==4) {
                                        score+=4;
                                    }
                                    else if (match>4){
                                        score+=1;
                                    }
                                }
                            }
                            else{
                                match=1;
                            }
                        }
                        else if (k==0){
                            Tile* tileBefore=_gridArray[currentTile.tileX-1][currentTile.tileY];
                            if (currentTile.dotColorArray[k][j]==tileBefore.dotColorArray[2][j]) {
                                match++;
                                if (match>=4) {
                                    currentTile.remove=true;
                                    tileBefore.remove=true;
                                    if (match==4) {
                                        score+=4;
                                    }
                                    else if (match>4){
                                        score+=1;
                                    }
                                }
                            }
                            else{
                                match=1;
                            }
                        }
                    }
                    else{
                        firstDot=false;
                    }
                }
            }
        }
    }
    _totalScore=score;
    CCTimer* myTimer=[NSTimer scheduledTimerWithTimeInterval:.7 target:self selector:@selector(removeTiles) userInfo:nil repeats:NO];
}

-(void)removeTiles{
    for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
            Tile* tile=_gridArray[i][j];
            if (tile.remove==true) {
                tile.remove=false;
                [self removeChild:tile];
                
                Tile* newTile= (Tile*)[CCBReader load:@"Tile"];
                 
                [newTile setScaleX:((_columnWidth)/tile.contentSize.width)];
                [newTile setScaleY:((_columnHeight)/tile.contentSize.height)];
                
                newTile.position = tile.position;
                _gridArray[i][j]=newTile;
                newTile.tileX=tile.tileX;
                newTile.tileY=tile.tileY;
                newTile.remove=false;
                
                [self addChild: newTile];
            }
        }
    }
}

@end

