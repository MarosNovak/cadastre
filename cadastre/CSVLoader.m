//
//  CSVParser.m
//  cadastre
//
//  Created by Maros Novák on 21/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "CSVLoader.h"
#import "Cadastre.h"

@implementation CSVLoader

+ (NSScanner *)scannerForFile:(NSString *)file
{
    NSError *error;
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:file];
    NSString *fileString = [NSString stringWithContentsOfFile:filePath
                                                     encoding:NSWindowsCP1250StringEncoding
                                                        error:&error];
    if (error) {
        NSLog(@"%@", [error description]);
        return nil;
    }
    if (!fileString) return nil;
    
    return [NSScanner scannerWithString:fileString];
}

+ (BOOL)loadCitizens
{
    NSLog(@"Loading citizens");
    
    NSScanner *scanner = [CSVLoader scannerForFile:kCitizensCSVFile];
    
    if (!scanner) return NO;
    
    NSString *line = [NSString new];
    
    while ([scanner scanUpToString:@"\n" intoString:&line]) {
        NSArray *components = [line componentsSeparatedByString:@","];
        
        [[Cadastre sharedCadastre] addCitizenWithBirthNumber:components[0]
                                                        name:components[1]
                                                     surname:components[2]];
    }
    
    return YES;
}

+ (BOOL)parseAreas
{
    return YES;
}

+ (BOOL)parseCertificates
{
    return YES;
}

+ (BOOL)parseProperties
{
    return YES;
}

+ (BOOL)parseOwnership
{
    return YES;
}

@end
