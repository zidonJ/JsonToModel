//
//  GenerateFileHelper.h
//  JsonTransitionToModel
//
//  Created by zidonj on 2018/10/29.
//  Copyright © 2018 langlib. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define k_HEADINFO(h) ((h) == 'h' ? @("//\n//  %@.h\n//  %@\n//  Created by %@ on %@.\n//  Copyright © %@年 %@. All rights reserved.\n//\n\n#import <Foundation/Foundation.h>\n\n#if __has_include(<YYModel/YYModel.h>)\n#import <YYModel/YYModel.h>\n#else\n#import\"YYModel.h\" \n#endif\n\n") :@("//\n//  %@.m\n//  %@\n//  Created by %@ on %@.\n//  Copyright © %@年 %@. All rights reserved.\n//\n\n#import \"%@.h\"\n"))

//#define k_HEADINFO(h) ((h) == 'h' ? @("//\n//  %@.h\n//  %@\n//  Created by %@ on %@.\n//  Copyright © %@年 %@. All rights reserved.\n//\n\n#import <Foundation/Foundation.h>\n#import \"YYModel.h\" \n") :@("//\n//  %@.m\n//  %@\n//  Created by %@ on %@.\n//  Copyright © %@年 %@. All rights reserved.\n//\n\n#import \"%@.h\"\n"))
#define k_DEFAULT_CLASS_NAME @("Model")
#define k_AT_CLASS @("@class %@;\n")
#define k_CLASS       @("\n@interface %@ : NSObject\n%@\n@end\n\n")
#define k_PROPERTY(s)    ((s) == 'c' ? @("\n/** <#%@#>*/\n@property (nonatomic, copy) %@ *%@;\n") : @("\n/** <#%@#>*/\n@property (nonatomic, strong) %@ *%@;\n"))


#define METHODIMP(keyValue) [NSString stringWithFormat:DMethod,keyValue]
///MJExtension使用
#define ModelMethod @"\
+ (NSDictionary *)mj_replacedKeyFromPropertyName {\n\n\
return @{@\"Id\":@\"id\",@\"Description\":@\"description\"};\n\
}\n\n\
+ (NSDictionary *)mj_objectClassInArray {\n\
return @{%@};\n\
}\n\n"

#define k_CLASS_M     @("\n\n@implementation %@\n\n%@\n@end\n")

#define MethodDef  @"\n\n+ (instancetype)modelWithJson:(id)json;\n"

#define DMethod @"+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {\n\
\n\
    return @{@\"Id\":@\"id\",@\"Description\":@\"description\"};\n\
}\n\n\
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {\n\
    return @{%@};\n\
}\n\n"

#define JsonToModelMethod @"+ (instancetype)modelWithJson:(id)json {\n\n\
    id model = nil;\n\
    if ([json isKindOfClass:[NSString class]] || [json isKindOfClass:[NSDictionary class]]){\n\
        model = [self yy_modelWithJSON:json];\n\
    }else if([json isKindOfClass:[NSArray class]]){\n\
        model = [NSArray yy_modelArrayWithClass:self json:json].mutableCopy;\n\
    }\n\
    return model;\n\
}\n\n"

@class MakeModelHelper;

@interface GenerateFileHelper : NSObject

//类名称
@property (nonatomic, copy) NSString *className;
//项目名称
@property (nonatomic, copy) NSString *projectName;
//开发者姓名
@property (nonatomic, copy) NSString *developerName;
//格式化json串后的数据
@property (nonatomic, copy ,readonly) NSString *formatJson;

/**
 解析 并生成OC类文件

 @param json 参数 json字符串
 @return 生成文件是否成功
 */
- (BOOL)createModelWithJson:(NSString *)json;

/// 验证json
- (BOOL)verifyJson:(NSString *)json;

/// 格式化字符串
- (nullable NSString *)formattingJson:(NSString *)json;

@end


/// 避免递归调用引起生成类的顺序错乱 引入中间类
@interface MakeModelHelper : NSObject

- (instancetype)initWithClassName:(NSString *)className;

@property (nonatomic,copy) NSString *className;

///头文件内容
@property (nonatomic, strong) NSMutableString *headerString;
///源文件内容
@property (nonatomic, strong) NSMutableString *sourceString;

@end

NS_ASSUME_NONNULL_END
