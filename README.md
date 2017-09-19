# CHTButtonPageView

A view to show a serial of buttons

![CHTButtonPageView](/CHTButtonPageView.gif)

## Usage

### init method

```
- (instancetype)initWithFrame:(CGRect)frame
              verCountPerPage:(NSInteger)verCountPerPage
              horCountPerPage:(NSInteger)horCountPerPage;
```

###  config icons & titles
```
- (void)configIcons:(NSArray <NSString *>*)icons
             titles: (NSArray <NSString *>*)titles;
```

### delegate

```
@protocol CHTButtonPageViewDelegate <NSObject>

@optional
- (void)buttonPageView:(CHTButtonPageView *)buttonPageView didSelectButtonWithIndex:(NSInteger)index;

@end
```

## LICENSE

MIT