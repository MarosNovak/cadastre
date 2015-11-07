//
//  CSVParser.m
//  cadastre
//
//  Created by Maros Novák on 21/10/15.
//  Copyright © 2015 Maros Novak. All rights reserved.
//

#import "CSVLoader.h"
#import "Cadastre.h"
#import "Property.h"
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

+ (BOOL)loadAreas
{
    NSScanner *scanner = [CSVLoader scannerForFile:kAreasCSVFile];
    
    if (!scanner) return NO;
    
    NSString *line = [NSString new];
    
    while ([scanner scanUpToString:@"\n" intoString:&line]) {
        NSArray *components = [line componentsSeparatedByString:@","];
        
        [[Cadastre sharedCadastre] addCadastreAreaWithNumber:[components[0] integerValue]
                                                        name:components[1]];
    }
    
    return YES;
}

+ (BOOL)loadLists
{
    NSScanner *scanner = [CSVLoader scannerForFile:kListsCSVFile];
    
    if (!scanner) return NO;
    
    NSString *line = [NSString new];
    
    while ([scanner scanUpToString:@"\n" intoString:&line]) {
        NSArray *components = [line componentsSeparatedByString:@","];
        
        CadastreArea *area = [[Cadastre sharedCadastre] areaByNumber:@([components[1] integerValue])];
        PropertyList *propertyList = [PropertyList propertyListWithNumber:@([components[0] integerValue])
                                                           inCadastreArea:area];
        
        if (area && propertyList && [area addPropertyList:propertyList]) {
            for (int i = 0; i < [components[2] integerValue]; i++) {
                [propertyList addOwnerWithEqualShare:[[Cadastre sharedCadastre] citizenByBirthNumber:components[i+3]]];
            }
            return YES;
        }
    }
    return NO;
}

+ (BOOL)loadProperties
{
    NSScanner *scanner = [CSVLoader scannerForFile:kPropertiesCSVFile];
    
    if (!scanner) return NO;
    
    NSString *line = [NSString new];
    
    while ([scanner scanUpToString:@"\n" intoString:&line]) {
        NSArray *components = [line componentsSeparatedByString:@","];
        
        CadastreArea *area = [[Cadastre sharedCadastre] areaByNumber:@([components[0] integerValue])];
        PropertyList *propertyList = [area propertyListByNumber:@([components[1] integerValue])];
        
        if (area && propertyList) {
            Property *property = [Property propertyWithNumber:@([components[2] integerValue]) inCadastreArea:area];
            [propertyList addProperty:property];
            [area addProperty:property];
            property.address = components[3];
            
            for (int i = 0; i < [components[4] integerValue]; i++) {
                [property.citizens addObject:[[Cadastre sharedCadastre] citizenByBirthNumber:components[i+5]]];
            }
            return YES;
        }
    }
    return NO;
}

@end
