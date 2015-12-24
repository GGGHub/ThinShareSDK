//
//  OKWShareActionSheet.m
//  OKWShareSDK
//
//  Created by Labanotation on 15/12/22.
//  Copyright © 2015年 okwei. All rights reserved.
//

#import "OKWShareActionSheet.h"
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kActionItemSize CGSizeMake(50, 80)

#pragma mark - Hidden OKWShareActionItem Interface
@interface OKWShareActionItem : UIView
+(instancetype)actionItem:(UIButton *)item title:(NSString *)title;
@end

#pragma mark - OKWShareActionSheet Entend
@interface OKWShareActionSheet ()
@property (nonatomic,copy) NSString *title;         // title
@property (nonatomic,strong) UIView *contentView;   //content view
@property (nonatomic,strong) UIButton *cancelButon; //cancel button
@property (nonatomic,strong) UILabel *titleLabel;   //title Label
@property (nonatomic,weak) UIView *parentView;  //self's parent view
@property (nonatomic,strong) NSMutableArray *buttonTitles;    // button title array
@property (nonatomic,strong) NSMutableArray *buttonBlocks;    // button block array
@property (nonatomic,strong) NSMutableArray *buttonImages;    // button image array
@property (nonatomic,strong) NSMutableArray *items;   // items array
@property (nonatomic,strong) UIFont *font;  // default font

@end

const CGFloat kContentDefaultHeight = 100.0f;
const CGFloat kContentDefaultWidth = 400.0f;
const CGFloat kActionSheetMargin = 20.0f;
const CGFloat kActionSheetRadius = 10.0f;

#pragma mark - OKWShareActionSheet Implementation
@implementation OKWShareActionSheet
-(instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        _title = title;
        [self initActionSheet];
        
        
    }
    return self;
}
-(void)initActionSheet
{
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)]];
    self.font = [UIFont systemFontOfSize:14.0f];
}

-(UIButton *)cancelButon
{
    if (!_cancelButon) {
        _cancelButon = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelButon.backgroundColor = [UIColor whiteColor];
        _cancelButon.layer.cornerRadius = kActionSheetRadius;
        _cancelButon.clipsToBounds = YES;
        [_cancelButon setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButon.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_cancelButon addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGRect frame = CGRectZero;
        frame.size.width = isPad? kContentDefaultWidth:self.frame.size.width-20;
        frame.size.height = 40;
        _cancelButon.frame = frame;
        
    }
    return _cancelButon;
}
#pragma mark  Button click
-(void)buttonClick:(UIButton *)sender
{
    if (sender == self.cancelButon) {
    }
    else
    {
        NSInteger index = [self.items indexOfObject:sender];
        if (index != NSNotFound) {
            void(^handle)() = self.buttonBlocks[index];
            handle();
        }
    }
    
    [self dismissView];
}
-(UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = kActionSheetRadius;
        _contentView.clipsToBounds = YES;
        CGRect frame = CGRectZero;
        isPad ?({
            frame.size.width = kContentDefaultWidth;
        }):({
            frame.size.width = self.frame.size.width-kActionSheetMargin;
        });
        frame.size.height += ceil(self.buttonTitles.count/4.0)*kActionItemSize.height+10;
        frame.size.height += self.titleLabel.frame.size.height;
        _contentView.frame = frame;
        [_contentView addSubview:self.titleLabel];
    }
    return _contentView;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = self.title;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = self.font;
        CGRect frame = CGRectZero;
        frame.size = [_titleLabel sizeThatFits:CGSizeMake(isPad?kContentDefaultWidth:self.frame.size.width-kActionSheetMargin, LONG_MAX)];
        _titleLabel.frame = CGRectMake(0, 0,isPad?kContentDefaultWidth:self.frame.size.width-kActionSheetMargin, frame.size.height+10);
    }
    return _titleLabel;
}
#pragma mark Dismiss Tap
-(void)tapClick:(UITapGestureRecognizer *)tap
{
    CGPoint tapPoint = [tap locationInView:self];
    if (CGRectContainsPoint(self.contentView.frame, tapPoint)) {
        return;
    }
    [self dismissView];
}
-(void)show
{
    if (_contentView) {
        return;
    }
    [self addSubview:self.cancelButon];
    [self addSubview:self.contentView];
    [self setUpItems];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self presentView];
    
}
-(void)setUpItems
{
    self.items = [NSMutableArray array];
    CGFloat padding = (self.contentView.frame.size.width - 4*kActionItemSize.width)/5;
    NSInteger line;
    NSInteger count;
    for (int i = 0; i<self.buttonTitles.count; i++) {
        line = floor(i/4);
        count = i%4;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:self.buttonImages[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        OKWShareActionItem *item = [OKWShareActionItem actionItem:button title:self.buttonTitles[i]];
        [self.items addObject:button];
        [self.contentView addSubview:item];
        item.frame = CGRectMake(padding+(kActionItemSize.width+padding)*count, 10+(kActionItemSize.height)*line+_titleLabel.frame.size.height, kActionItemSize.width, kActionItemSize.height);
        
    }
    
}
-(void)presentView
{
    CGFloat offset = self.frame.size.height-self.contentView.frame.origin.y;
    CGRect contentViewFrame = self.contentView.frame;
    self.contentView.frame = CGRectOffset(self.contentView.frame, 0.0f, offset);
    CGRect cancelFrame = self.cancelButon.frame;
    self.cancelButon.frame = CGRectOffset(self.cancelButon.frame, 0.0f, offset);

    [UIView animateWithDuration:0.4f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:0.5f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.contentView.frame = contentViewFrame;
    } completion:nil];
    
    [UIView animateWithDuration:0.4f delay:0.1f usingSpringWithDamping:0.7f initialSpringVelocity:0.5f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.cancelButon.frame = cancelFrame;
    } completion:nil];
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.65f];
    }];
    
}
-(void)dismissView
{
    CGFloat offset = self.frame.size.height - self.contentView.frame.origin.y;
    [UIView animateWithDuration:0.4f delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:0.5f options:0 animations:^{
        self.contentView.frame = CGRectOffset(self.contentView.frame, 0.0f, offset);
        self.cancelButon.frame = CGRectOffset(self.cancelButon.frame, 0.0f, offset);
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)addButtonWithTitle:(NSString *)title image:(UIImage *)image handle:(void(^)(void))handle
{
    if (self.buttonTitles == nil) {
        self.buttonTitles = [NSMutableArray array];
    }
    if (self.buttonBlocks == nil) {
        self.buttonBlocks = [NSMutableArray array];
    }
    if (self.buttonImages == nil) {
        self.buttonImages = [NSMutableArray array];
    }
    [self.buttonTitles addObject:title];
    [self.buttonBlocks addObject:handle];
    [self.buttonImages addObject:image];
    
}
-(void)showInView:(UIView *)view
{
    _parentView = view;
    self.frame = view.bounds;
    [self.parentView addSubview:self];
    [self show];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.cancelButon.frame;
    frame.origin.x = (self.frame.size.width - frame.size.width) *0.5;
    frame.origin.y = (self.frame.size.height - kActionSheetMargin)-frame.size.height;
    self.cancelButon.frame = frame;
    frame = self.contentView.frame;
    frame.origin.x = (self.frame.size.width - frame.size.width)*0.5f;
    frame.origin.y = (self.cancelButon.frame.origin.y-kActionSheetMargin)-frame.size.height;
    self.contentView.frame = frame;
}
@end

#pragma mark - OKWShareActionItem Entend
@interface OKWShareActionItem ()
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,copy) NSString *title;

@property (nonatomic,strong) UIFont *titleFont;
@end

#pragma mark - OKWShareActionItem Implementation
@implementation OKWShareActionItem
+(instancetype)actionItem:(UIButton *)item title:(NSString *)title
{
    OKWShareActionItem *actionItem = [[OKWShareActionItem alloc] init];
    actionItem.button = item;
    actionItem.title = title;
    [actionItem addSubview:item];
    return actionItem;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initItem];
    }
    return self;
}
-(void)initItem
{
    _titleFont = [UIFont systemFontOfSize:11];
    [self addSubview:self.titleLabel];
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = _titleFont;
    }
    return _titleLabel;
}
-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _button.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-30);
    _titleLabel.frame = CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30);
}
@end
