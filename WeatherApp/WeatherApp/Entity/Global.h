//
//  Global.h
//  WeatherApp
//
//  Created by Samir Rathod on 15/11/17.
//  Copyright (c) 2017 Samir Rathod. All rights reserved.
//

//Device Compatibility
#define g_IS_IPHONE             ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
#define g_IS_IPOD               ( [[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"] )
#define g_IS_IPAD               ( [[[UIDevice currentDevice] model] isEqualToString:@"iPad"] || [[[UIDevice currentDevice] model] isEqualToString:@"iPad Simulator"])

//Display Size Compatibility
#define g_IS_IPHONE_4_SCREEN    [[UIScreen mainScreen] bounds].size.height >= 480.0f && [[UIScreen mainScreen] bounds].size.height < 568.0f
#define g_IS_IPHONE_5_SCREEN    [[UIScreen mainScreen] bounds].size.height >= 568.0f && [[UIScreen mainScreen] bounds].size.height < 667.0f
#define g_IS_IPHONE_6_SCREEN    [[UIScreen mainScreen] bounds].size.height >= 667.0f && [[UIScreen mainScreen] bounds].size.height < 736.0f
#define g_IS_IPHONE_6P_SCREEN    [[UIScreen mainScreen] bounds].size.height >= 736.0f && [[UIScreen mainScreen] bounds].size.height < 1024.0f

//IOS Version Compatibility
#define g_IS_IOS_9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define g_IS_IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define g_IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define g_IS_IOS_6 ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)

//appdelegate
#define appDelegate (AppDelegate *)[[UIApplication sharedApplication]delegate]

//screen width height
#define screenWidth appDelegate.window.bounds.size.width
#define screenHeight appDelegate.window.bounds.size.height

#define screenWidthself self.view.frame.size.width
#define screenHeightself self.view.frame.size.height

//color from RGB Color
#define UIColorFromRGB(rVal,gVal,bVal) [UIColor colorWithRed:((float)rVal)/255.0 green:((float)gVal)/255.0 blue:((float)bVal)/255.0 alpha:1.0]

#define kAppOrangeColor UIColorFromRGB(242, 103, 83)
//#define kAppOrangeColor UIColorFromRGB(235, 80, 66)



//App Name.
#define kAppName        @"Weather App"
#define kbaseURLPath @"https://query.yahooapis.com/v1/public/yql?q="
#define kstringPath1 = @"select * from geo.places where text="
#define kreturnFormat = @"json"

//https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.places%20where%20text=%22ahmedabad,%20Ind%22&format=json
