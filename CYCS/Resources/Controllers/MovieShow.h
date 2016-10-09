//
//  MovieShow.h
//  CYCS
//
//  Created by Horus on 16/8/22.
//  Copyright © 2016年 Horus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MovieShow : UIViewController

@property(nonatomic,retain) NSArray *movieURL;

-(instancetype)initWthString:(NSArray *)string;

@end
