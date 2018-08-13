
Pod::Spec.new do |s|
  s.name             = 'FlexContainer'
  s.version          = '0.1.5'
  s.summary          = 'FlexContainer is oversimplified StackView that hides tons of limitations.'

  s.description      = <<-DESC
WIP.
FlexContainer is oversimplified StackView that hides tons of limitations.
                       DESC

  s.homepage         = 'https://github.com/ReImpl/FlexContainer'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'genkernel' => 'kernel@reimplement.mobi' }
  s.source           = { :git => 'https://github.com/ReImpl/FlexContainer.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  # s.source_files = 'FlexContainer/Classes/**/*'

  s.subspec 'Foundation' do |f|
    f.frameworks = 'Foundation'

    f.source_files = "FlexContainer/Classes/Foundation/*.{swift}"
  end

  s.subspec 'UIKit' do |ui|
    ui.frameworks = 'UIKit'
    ui.dependency 'FlexContainer/Foundation'

    ui.source_files = "FlexContainer/Classes/UIKit/*.{swift}"
  end

  s.subspec 'Styled' do |styled|
    styled.dependency 'FlexContainer/UIKit'

    styled.source_files = "FlexContainer/Classes/Styled/*.{swift}"
  end

  s.subspec 'Flow' do |flow|
    flow.source_files = "FlexContainer/Classes/Flow/*.{swift}"
  end

  s.subspec 'FlexContainer' do |flex|
    flex.dependency 'FlexContainer/UIKit'

    flex.source_files = "FlexContainer/Classes/FlexContainer/*.{swift}"
  end
  
  s.swift_version = '4.1'
  s.requires_arc = true
end
