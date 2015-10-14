//
//  TQRichTextEmojiRun.m
//  TQRichTextViewDemo
//
//  Created by fuqiang on 13-9-21.
//  Copyright (c) 2013年 fuqiang. All rights reserved.
//

#import "TQRichTextEmojiRun.h"

@implementation TQRichTextEmojiRun

- (id)init
{
    self = [super init];
    if (self) {
        self.type = richTextEmojiRunType;
        self.isResponseTouch = NO;
    }
    return self;
}

- (BOOL)drawRunWithRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSString *emojiString = [NSString stringWithFormat:@"%@.png",self.originalText];
   // NSLog(@"%@",emojiString);
    
    UIImage *image = [UIImage imageNamed:emojiString];
    if (image)
    {
        CGContextDrawImage(context, rect, image.CGImage);
    }
    return YES;
}

+ (NSArray *) emojiStringArray
{
    return [NSArray arrayWithObjects:@"[p0]",@"[p1]",@"[p2]",@"[p3]",@"[p4]",@"[p5]",@"[p6]",@"[p7]",@"[p8]",@"[p9]",@"[p10]",@"[p11]",@"[p12]",@"[p13]",@"[p14]",@"[p15]",@"[p16]",@"[p17]",@"[p18]",@"[p19]",@"[p20]",@"[p21]",@"[p22]",@"[p23]",@"[p24]",@"[p25]",@"[p26]",@"[p27]",@"[p28]",@"[p29]",@"[p30]",@"[p31]",@"[p32]",@"[p33]",@"[p34]",@"[p35]",@"[p36]",@"[p37]",@"[p38]",@"[p39]",@"[p40]",@"[p41]",@"[p42]",@"[p43]",@"[p44]",@"[p45]",@"[p46]",@"[p47]",@"[p48]",@"[p49]",@"[p50]",@"[p51]",@"[p52]",@"[p53]",@"[p54]",@"[p55]",@"[p56]",@"[p57]",@"[p58]",@"[p59]",@"[p60]",@"[p61]",@"[p62]",@"[p63]",@"[p64]",@"[p65]",@"[p66]",@"[p67]",@"[p68]",@"[p69]",@"[p70]",@"[p71]",@"[p72]",@"[p73]",@"[p74]",@"[p75]",@"[p76]",@"[p77]",@"[p78]",@"[p79]",@"[p80]",@"[p81]",@"[p82]",@"[p83]",@"[p84]",@"[p85]",@"[p86]",@"[p87]",@"[p88]",@"[p89]",@"[p90]",@"[p91]",@"[p92]",@"[p93]",@"[p94]",@"[p95]",@"[p96]",@"[p97]",@"[p98]",@"[p99]",@"[p100]",@"[p101]",@"[p102]",@"[p103]",@"[p104]",@"[p105]",@"[p106]",@"[p107]",@"[p108]",@"[p109]",@"[p1000]",@"[p1001]",@"[p1002]",nil];
}

+ (NSString *)analyzeText:(NSString *)string runsArray:(NSMutableArray **)runArray
{
    NSString *markL = @"[";
    NSString *markR = @"]";
    NSMutableArray *stack = [[NSMutableArray alloc] init];
    NSMutableString *newString = [[NSMutableString alloc] initWithCapacity:string.length];
    
    //偏移索引 由于会把长度大于1的字符串替换成一个空白字符。这里要记录每次的偏移了索引。以便简历下一次替换的正确索引
    int offsetIndex = 0;
    
    for (int i = 0; i < string.length; i++)
    {
        NSString *s = [string substringWithRange:NSMakeRange(i, 1)];
        
        if (([s isEqualToString:markL]) || ((stack.count > 0) && [stack[0] isEqualToString:markL]))
        {
            if (([s isEqualToString:markL]) && ((stack.count > 0) && [stack[0] isEqualToString:markL]))
            {
                for (NSString *c in stack)
                {
                    [newString appendString:c];
                }
                [stack removeAllObjects];
            }
            
            [stack addObject:s];
            
            if ([s isEqualToString:markR] || (i == string.length - 1))
            {
                NSMutableString *emojiStr = [[NSMutableString alloc] init];
                for (NSString *c in stack)
                {
                    [emojiStr appendString:c];
                }
                
                if ([[TQRichTextEmojiRun emojiStringArray] containsObject:emojiStr])
                {
                    TQRichTextEmojiRun *emoji = [[TQRichTextEmojiRun alloc] init];
                    emoji.range = NSMakeRange(i + 1 - emojiStr.length - offsetIndex, 1);
                    emoji.originalText = emojiStr;
                    [*runArray addObject:emoji];
                    [newString appendString:@" "];
                    
                    offsetIndex += emojiStr.length - 1;
                }
                else
                {
                    [newString appendString:emojiStr];
                }
                
                [stack removeAllObjects];
            }
        }
        else
        {
            [newString appendString:s];
        }
    }

    return newString;
}

@end
