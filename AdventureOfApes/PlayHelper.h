//
//  PlayHelper.h
//  happy
//
//  Created by 曾 哲 on 13-12-26.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface PlayHelper : NSObject<AVAudioPlayerDelegate>
{


}

+(id)shareHelper;

-(void)playWithFilePath:(NSString *)filePath callBackFun:(NSString *) callback;


@end
