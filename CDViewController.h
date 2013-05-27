//
//  CDViewController.h
//  CoreDataSampleApp
//
//  Created by 川端和樹 on 2013/05/24.
//  Copyright (c) 2013年 LemonApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import "Entity.h"

#define ENTITY_NAME @"BoxViewData"
#define MODEL_NAME    @"ModelSampleA"
#define DB_NAME @"testAppDB.sqlite"
@interface CDViewController : UIViewController {
}

@property (weak, nonatomic) IBOutlet UITextView *dataViewer;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UITextField *label1tf;
- (IBAction)resetPushed:(id)sender;
- (IBAction)addToData:(id)sender;
- (IBAction)loadAllData:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *label2tf;
@property (weak, nonatomic) IBOutlet UITextField *label3tf;
@property (weak, nonatomic) IBOutlet UILabel *dataControllState;
//NSManagedContext(オブジェクトの格納する
@property (strong,nonatomic)NSManagedObjectContext *context;
@property (weak, nonatomic) IBOutlet UITextField *searchWindows;
- (IBAction)search:(id)sender;



//テキストフィールド選択状態だと、FirstResponderから話すためのタップジェスチャ
@property (nonatomic) UITapGestureRecognizer *tapresigner;
@end
