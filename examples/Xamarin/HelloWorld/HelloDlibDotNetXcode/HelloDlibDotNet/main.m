//
//  main.m
//  HelloDlibDotNet
//
//  Created by Takuya Takeuchi on 2020/08/02.
//  Copyright © 2020 com.takuyatakeuchi.dlibdotnet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
