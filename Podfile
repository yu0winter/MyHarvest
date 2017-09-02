platform :ios, "8.0"
# 要pod的工程不显示任何警告
# ignore all warnings from all pods
# inhibit_all_warnings!


def shared_pods
    pod 'Alamofire', '~> 4.4.0' # AFNetworking Swift 版本
    pod 'SnapKit' # Masonry Swift 版本
    pod 'SDWebImage'    # 图片缓存
    pod 'FMDB'          # 数据库
    pod 'FMDBMigrationManager' #数据库迁移管理器
    pod 'Bugly' #腾讯Bugly崩溃收集
    pod 'SwiftyJSON'    #GitHub 上最为开发者认可的 JSON 解析类
end

target 'MyHarvest' do
    # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
    use_frameworks! # 表明，应用了OC库
    shared_pods
    
end