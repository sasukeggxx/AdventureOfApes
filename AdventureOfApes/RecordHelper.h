//
//  RecordHelper.h
//  happy
//
//  Created by 曾 哲 on 13-12-25.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface RecordHelper : NSObject<AVAudioRecorderDelegate>{
    AVAudioRecorder *recorder;
    NSString *saveDirPath;
    NSString *wavFileName;
    NSString *amrFileName;
}

@property( nonatomic ,retain) AVAudioRecorder *recorder;
@property( nonatomic ,retain) NSString *saveDirPath;
@property( nonatomic ,retain) NSString *wavFileName;
@property( nonatomic ,retain) NSString *amrFileName;

+(id)shareHelper;


-(id)init;

-(void)startWithPath:(NSString *)docDir andFileName:(NSString *)fileName;

-(void)stop;




@end
