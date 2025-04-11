#import <UIKit/UIKit.h>
#import <objc/runtime.h>

__attribute__((constructor)) static void Inject() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        UITapGestureRecognizer *tripleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showIconNames)];
        tripleTap.numberOfTapsRequired = 2;
        tripleTap.numberOfTouchesRequired = 3;
        [[UIApplication sharedApplication].keyWindow addGestureRecognizer:tripleTap];
    });
}

void traverseViews(UIView *view, NSMutableString *output) {
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            [output appendFormat:@"🖼️ [UIImageView]\n"];
            if (((UIImageView *)subview).image) {
                [output appendFormat:@"- 图片名: %@\n", ((UIImageView *)subview).image.accessibilityIdentifier ?: @"未知"];
            }
        } else if ([subview isKindOfClass:[UILabel class]]) {
            [output appendFormat:@"📛 [UILabel]\n- 文本: \"%@\"\n", ((UILabel *)subview).text ?: @"空"];
        }
        traverseViews(subview, output
