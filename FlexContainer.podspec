
Pod::Spec.new do |s|
  s.name             = 'FlexContainer'
  s.version          = '0.2.0'
  s.summary          = 'FlexContainer is an oversimplified StackView that hides tons of bugs and limitations.'

  s.description      = <<-DESC
Nothing interesting yet.
FlexContainer is oversimplified StackView that hides tons of limitations.
                       DESC

  s.homepage         = 'https://github.com/ReImpl/FlexContainer'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'genkernel' => 'kernel@reimplement.mobi' }
  s.source           = { :git => 'https://github.com/ReImpl/FlexContainer.git', :tag => s.version.to_s }

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
    styled.dependency 'Layoutless'

    styled.source_files = "FlexContainer/Classes/Styled/*.{swift}"
  end

  s.subspec 'Flow' do |flow|
    flow.source_files = "FlexContainer/Classes/Flow/*.{swift}"
  end

  s.subspec 'FlexContainer' do |flex|
    flex.dependency 'FlexContainer/UIKit'

    flex.source_files = "FlexContainer/Classes/FlexContainer/*.{swift}"
  end

  s.ios.deployment_target = '11.4'
  
  s.swift_version = '4.2'
  s.requires_arc = true
end
