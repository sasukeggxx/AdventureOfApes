//
//  RecordHelper.m
//  happy
//
//  Created by 曾 哲 on 13-12-25.
//
//

#import "RecordHelper.h"
#import "VoiceConverter.h"

static RecordHelper *help;

@implementation RecordHelper

@synthesize recorder;
@synthesize saveDirPath;
@synthesize wavFileName;
@synthesize amrFileName;


+(id)shareHelper{
    if (help==nil) {
        help=[[self alloc]init];
    }
    
    return help;

}

-(id)init{
    if (self=[super init]) {
        
    }
  return self;
}


-(void)startWithPath:(NSString *)docDir andFileName:(NSString *)fileName{
    
    self.amrFileName=fileName;
    self.saveDirPath=docDir;
    //录音设置
    NSMutableDictionary *recordSetting = [[[NSMutableDictionary alloc]init] autorelease];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:8000] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    //    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    NSString *subName=[fileName substringToIndex:[fileName rangeOfString:@"."].location];
    self.wavFileName=[subName stringByAppendingString:@".wav"];
    NSString *filePath = [NSString stringWithFormat:@"%@%@",docDir,wavFileName];
    
    NSError *err;
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    recorder = [[AVAudioRecorder alloc] initWithURL:fileUrl
                                           settings:recordSetting
                                              error:&err];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    
    if ([recorder prepareToRecord]) {
        NSLog(@"---Start Record---");
        [recorder record];
    }
}

-(void)stop{
    if ([recorder isRecording]) {
        NSLog(@"---Stop Record---");
        [recorder stop];
    }
   
    [VoiceConverter wavToAmr:[self.saveDirPath stringByAppendingString:wavFileName] amrSavePath:[self.saveDirPath stringByAppendingString:self.amrFileName]];
    [recorder deleteRecording];

}




-(void)dealloc{
    
    [super dealloc];
    [recorder release];
    recorder=nil;
    
    [saveDirPath release];
    saveDirPath=nil;
    
    [wavFileName release];
    wavFileName=nil;
    
    [wavFileName release];
    wavFileName=nil;
    
    
}


@end
