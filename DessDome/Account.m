//
//  Account.m
//  DessDome
//
//  Created by Jack on 15/6/30.
//  Copyright (c) 2015年 zhr. All rights reserved.
//
#define kUsername @"LoginUsername"
#define kPassword @"LoginPassword"
#define kUserId @"userId"
#define kFullName @"fullName"
#define kBindPhone @"BindPhone"
#define kSiteName @"siteName"
#define kSiteId @"siteId"
#define kRole @"role"
#define kisExpUser @"isExpUser"
#define kSex @"sex"
#define kTitle @"title"
#define kPhotoPath @"photoPath"
#define kOrder @"order"
#define kMessage @"message"
#define kToken @"token"
#define kChannel @"channel"
#define kIsAdmin @"isAdmin"
#define kNoReadCount @"noReadCount"

#import "Account.h"

@implementation Account
- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.userId = [NSString stringWithFormat:@"%@",dict[@"userId"]];
        self.fullName = dict[@"fullName"];
        self.siteName= dict[@"cmpName"];
        self.siteId = [NSString stringWithFormat:@"%@",dict[@"cmpId"]];
        self.role = dict[@"role"];
        self.token = dict[@"token"];
        self.isExpUser = [dict[@"isExpUser"] boolValue];
        self.bindPhone = @"未绑定手机号码";                // --默认未绑定手机号码，当后期绑定时修改
        self.isAdmin = [dict[@"isAdmin"] intValue];
        self.noReadCount = [dict[@"noReadCount"] intValue];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.username = [decoder decodeObjectForKey:kUsername];
        self.password = [decoder decodeObjectForKey:kPassword];
        self.userId = [decoder decodeObjectForKey:kUserId];
        self.fullName = [decoder decodeObjectForKey:kFullName];
        self.bindPhone = [decoder decodeObjectForKey:kBindPhone];
        self.siteName = [decoder decodeObjectForKey:kSiteName];
        self.siteId = [decoder decodeObjectForKey:kSiteId];
        self.role = [decoder decodeObjectForKey:kRole];
        self.token = [decoder decodeObjectForKey:kToken];
        self.isExpUser = [[decoder decodeObjectForKey:kisExpUser] boolValue];
        self.sex = [decoder decodeObjectForKey:kSex];
        self.title = [decoder decodeObjectForKey:kTitle];
        self.photoPath = [decoder decodeObjectForKey:kPhotoPath];
        self.order = [[decoder decodeObjectForKey:kOrder] intValue];
        self.message = [[decoder decodeObjectForKey:kMessage] intValue];
        self.channel = [decoder decodeObjectForKey:kChannel];
        self.isAdmin = [[decoder decodeObjectForKey:kIsAdmin] intValue];
        self.noReadCount = [[decoder decodeObjectForKey:kNoReadCount] intValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.username forKey:kUsername];
    [encoder encodeObject:self.password forKey:kPassword];
    [encoder encodeObject:self.userId forKey:kUserId];
    [encoder encodeObject:self.fullName forKey:kFullName];
    [encoder encodeObject:self.bindPhone forKey:kBindPhone];
    [encoder encodeObject:self.siteName forKey:kSiteName];
    [encoder encodeObject:self.siteId forKey:kSiteId];
    [encoder encodeObject:self.role forKey:kRole];
    [encoder encodeObject:self.token forKey:kToken];
    [encoder encodeObject:[NSNumber numberWithBool:self.isExpUser] forKey:kisExpUser];
    [encoder encodeObject:self.sex forKey:kSex];
    [encoder encodeObject:self.title forKey:kTitle];
    [encoder encodeObject:self.photoPath forKey:kPhotoPath];
    [encoder encodeObject:[NSNumber numberWithInt:self.order] forKey:kOrder];
    [encoder encodeObject:[NSNumber numberWithInt:self.message] forKey:kMessage];
    [encoder encodeObject:self.channel forKey:kChannel];
    [encoder encodeObject:[NSNumber numberWithInt:self.isAdmin] forKey:kIsAdmin];
    [encoder encodeObject:[NSNumber numberWithInt:self.noReadCount] forKey:kNoReadCount];
}

@end
