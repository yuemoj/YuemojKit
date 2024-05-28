#
# Be sure to run `pod lib lint YuemojKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YuemojKit'
  s.version          = '0.0.6'
  s.summary          = 'A decoupling framework for UI layout, data sources, and event responses'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  YuemojKit
  1.处理控件与数据模型的耦合, 提供控件事件的回调处理; 
  2.支持Layout定制, 避免重复创建大量类似布局的cell;
  3.TableView和CollectionView的DataSource通用处理
  4.数据库SQL语句对象化构建
  5.生产者消费者工厂
  6.JSON排序构建
                       DESC

  s.homepage         = 'https://github.com/yuemoj/YuemojKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yuemoj' => 'yj_745@163.com' }
  s.source           = { :git => 'https://github.com/yuemoj/YuemojKit.git', :branch => 'master' } #:tag => s.version.to_s }

  s.platform    = :ios
  s.ios.deployment_target = '13.0'
  s.requires_arc = true
  
  # 这里设置空的resource只是为了在项目中可以获取到pod库的bundle路径
  #s.resource_bundles = {
  #  'YuemojKit' => ['YuemojKit/PrivacyInfo.xcprivacy'],
  #}
  s.prefix_header_contents = <<-EOS
  EOS
  
#  s.ios.pod_target_xcconfig = { :GCC_PRECOMPILE_PREFIX_HEADER => 'YES' }
      
#  s.public_header_files = 'YuemojKit/Yuemoj{Kit,Macros,Metamacros}.h', 'YuemojKit/Yuemoj.h'
#  s.project_header_files = 'YuemojKit/Yuemoj.h'
  s.source_files = 'YuemojKit/YuemojKit.h'
    
  s.subspec 'Core' do |ss|
    ss.public_header_files = 'YuemojKit/*.h'
    ss.source_files = 'YuemojKit/*.{h,m}'
  end
                
  s.subspec 'UIAbility' do |ss|
    ss.public_header_files = 'YuemojKit/UIKit/UIKit+Yuemoj.h', 'YuemojKit/UIKit/YuemojUIAbilities.h'
    ss.pod_target_xcconfig = { :OTHER_LDFLAGS => '-lObjC', :HEADER_SEARCH_PATHS => '$(inherited)' }
    
    ss.source_files = 'YuemojKit/UIKit'
        
    ss.dependency 'YuemojKit/Core'
  end
  
  s.subspec 'FoundationAbility' do |ss|
    ss.public_header_files = 'YuemojKit/Foundation/Foundation+Yuemoj.h', 'YuemojKit/Foundation/YuemojFoundationAbilities.h'
    ss.pod_target_xcconfig = { :OTHER_LDFLAGS => '-lObjC', :HEADER_SEARCH_PATHS => '$(inherited)' }
    
    ss.source_files = 'YuemojKit/Foundation'
        
    ss.dependency 'YuemojKit/Core'
    ss.dependency 'PinYin4Objc', '~> 1.1.1'
  end
    
  s.subspec 'Component' do |ss|
    ss.subspec 'Common' do |sss|
      sss.public_header_files = 'YuemojKit/Component/YJComponentDataSource.h'
      sss.source_files = 'YuemojKit/Component/*.{h,m}'
      
      sss.dependency 'YuemojKit/UIAbility'
    end
                  
    ss.subspec 'EventBuilder' do |sss|
      sss.public_header_files = 'YuemojKit/Component/EventBuilder/YJEventBuilderProtocol.h'
      sss.source_files = 'YuemojKit/Component/EventBuilder/*'
            
      sss.dependency 'YuemojKit/Component/Common'
    end
        
    ss.subspec 'Filler' do |sss|
      sss.public_header_files = 'YuemojKit/Component/Filler/YJDataFill{DataSource,erProtocol,Types}.h'
      sss.source_files = 'YuemojKit/Component/Filler/*'
                
      sss.dependency 'YuemojKit/Component/Common'
    end
          
    ss.subspec 'Layouter' do |sss|
      sss.public_header_files = 'YuemojKit/Component/Layouter/YJLayout{DataSource,erProtocol,Models}.h'
      sss.source_files = 'YuemojKit/Component/Layouter/*'
                        
      sss.dependency 'YuemojKit/Component/Common'
      sss.dependency 'Masonry', '~>1.1.0'
    end
  end
  
  s.subspec 'DataSource' do |ss|
    ss.public_header_files = 'YuemojKit/DataSource/*.h'
    
    ss.source_files = 'YuemojKit/DataSource/*'
  end

  s.subspec 'Tools' do |ss|
    ss.public_header_files = 'YuemojKit/Tools/*.h'

    ss.source_files = 'YuemojKit/Tools'
  end
end
