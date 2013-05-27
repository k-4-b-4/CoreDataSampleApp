//
//  CDViewController.m
//  CoreDataSampleApp
//
//  Created by 川端和樹 on 2013/05/24.
//  Copyright (c) 2013年 LemonApps. All rights reserved.
//

#import "CDViewController.h"

@interface CDViewController ()

@end

@implementation CDViewController
@synthesize resetButton;
@synthesize label1tf;
@synthesize label2tf;
@synthesize label3tf;
@synthesize dataViewer;
@synthesize context;
@synthesize tapresigner;
@synthesize searchWindows;
@synthesize dataControllState;
- (NSURL*)createModelURL {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [mainBundle pathForResource:MODEL_NAME ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:path];
    return modelURL;
}

- (NSURL*)createStoreURL {
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[directories lastObject] stringByAppendingPathComponent:DB_NAME];
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    return storeURL;
}

- (NSManagedObjectContext*)createManagedObjectContext {
    NSURL *modelURL = [self createModelURL];
    NSURL *storeURL = [self createStoreURL];
    NSError *error = nil;
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    NSManagedObjectContext *managedObjectContent = [[NSManagedObjectContext alloc] init];
    [managedObjectContent setPersistentStoreCoordinator:persistentStoreCoordinator];
    return managedObjectContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    tapresigner = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapresigner];
    
    context = [self createManagedObjectContext];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetPushed:(id)sender {
    NSLog(@"resetButton has Pushed");
    //データを全消去する処理
    NSLog(@"Data reset has Completed");
}

- (IBAction)addToData:(id)sender {
    dataControllState.text = @"DataSaving....";
    
    if(!context) {
        NSLog(@"context is nil");
    }
    Entity* newObject = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
    newObject.labelA = label1tf.text;
    newObject.labelB = label2tf.text;
    if(label3tf.text) {
        newObject.homeWork = label3tf.text;
        newObject.isExistAssign = [NSNumber numberWithBool:YES];
    } else {
        newObject.homeWork = @"";
        newObject.isExistAssign = [NSNumber numberWithBool:NO];
    }
    
    
    NSError *error = nil;
    if([context save:&error]) {
        dataControllState.text = @"Completed！！";
    } else {
        //セーブに失敗したときの処理
        dataControllState.text = @"Sorry,there was an Error";
    }
    
}

- (IBAction)loadAllData:(id)sender {
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_NAME inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //取ってくるエンティティの設定を行う
    [request setEntity:entity];
    
    NSError *error = nil;
    //データのフェッチを行う
    NSArray *fetchResults = [context executeFetchRequest:request error:&error];
    
    if([fetchResults count] > 0) {
        NSMutableString *str = [NSMutableString stringWithFormat:@"There is %d Datas \n",[fetchResults count]];
        int i = 0;
        for (Entity *ent in fetchResults) {
            [str appendFormat:@"Num:%d Room:%@ Name:%@ isAss:\n",i,ent.labelA,ent.labelB];
            i++;
        }
        
        dataViewer.text = str;
        
    } else {
        dataViewer.text = @"Data is None!";
    }
    
    
}

//FirstResponderから外させる処理
- (void)handleTap:(id)sender {
    if([label1tf isFirstResponder]) {
        [label1tf resignFirstResponder];
    }
    
    if([label2tf isFirstResponder]) {
        [label2tf resignFirstResponder];
    }

    if([label3tf isFirstResponder]) {
        [label3tf resignFirstResponder];
    }

    if([searchWindows isFirstResponder]) {
        [searchWindows resignFirstResponder];
    }
    
}

//指定された教室の授業を検索する。
- (IBAction)search:(id)sender {
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_NAME inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //取ってくるエンティティの設定を行う
    [request setEntity:entity];
    
    //検索条件の設定を行う。Add Predicate as filter;
    NSString *searchString = [searchWindows text];
    //比較対象を直接描くのがポイント
    NSPredicate *predicate =[NSPredicate predicateWithFormat:@"labelA == %@",searchString];
                              [request setPredicate:predicate];
    
    NSError *error = nil;
    
    //データのフェッチを行う Data Fetching.
    NSArray *fetchResults = [context executeFetchRequest:request error:&error];
    
    if([fetchResults count] > 0) {
        NSMutableString *str = [NSMutableString stringWithFormat:@"Found %d Datas \n",[fetchResults count]];
        int i = 0;
        for (Entity *ent in fetchResults) {
            [str appendFormat:@"Num:%d Room:%@ Name:%@ isAss:\n",i,ent.labelA,ent.labelB];
            i++;
        }
        
        dataViewer.text = str;
        
    } else {
        dataViewer.text = @"Data is None!";
    }
    

}
@end
