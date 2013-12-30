//
//  PlayHelper.m
//  happy
//
//  Created by 曾 哲 on 13-12-26.
//
//

#import "PlayHelper.h"
#import "VoiceConverter.h"

static PlayHelper *help;

@implementation PlayHelper


+(id)shareHelper{
    if (help==nil) {
        help=[[self alloc]init];
    }
    
    return help;
    
}


-(void)playWithFilePath:(NSString *)filePath callBackFun:(NSString *) callback{
    NSLog(@"---Play Record----");
    NSString *amrFilePath=filePath; //amr文件路径
    NSString *wavFilePath=[[filePath substringToIndex:[filePath rangeOfString:@"amr"].location] stringByAppendingString:@"wav"];
    NSFileManager *fMgr=[NSFileManager defaultManager];
    
    if (![fMgr fileExistsAtPath:wavFilePath]) { //不存在则转换并生成
        [VoiceConverter amrToWav:amrFilePath wavSavePath:wavFilePath]; //转换amr文件到wav文件
    }
    
    
    
    NSError *err;
    NSURL *fileUrl=[NSURL fileURLWithPath:wavFilePath];
    AVAudioPlayer *player =[[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&err];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    player.delegate=self;
    
    [player play];
    
}


-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"播放结束");
    
}

@end
