# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

def ui_libs 
  pod 'FloatingPanel'
end

def firebase_firestore_swift
  pod 'FirebaseFirestoreSwift'
end

def firebase_storage
   pod 'Firebase/Storage'
end

def firebase_pods
  pod 'Firebase/Analytics'
#   pod 'Firebase/Database'
   pod 'Firebase/Firestore'
   
#   pod 'Firebase/Storage'
#   pod 'Firebase/Crashlytics'
#   pod 'Firebase/RemoteConfig'
end

def realmio_pods
  pod 'RealmSwift'
end

def google_signin_pod
  pod 'GoogleSignIn'
end

def firebase_auth
  pod 'Firebase/Auth'
end

target 'Main' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inherit! :search_paths
  # Pods for Main
  
 end

target 'Infra' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
      
  # Pods for Infra
  firebase_pods
  google_signin_pod
  firebase_auth
  firebase_firestore_swift
  realmio_pods
  firebase_storage
  
  target 'InfraTests' do
    # Pods for testing
  end

end

target 'iOSUI' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOSUI
  google_signin_pod
  firebase_auth
  firebase_pods
  ui_libs
  
  target 'iOSUITests' do
    # Pods for testing
  end

end

target 'Domain' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Domain
  firebase_pods
  firebase_firestore_swift  
end



#  target 'MainTests' do
#
#    # Pods for testing
#  end
#
#  target 'Data' do
#    # Comment the next line if you don't want to use dynamic frameworks
#    use_frameworks!
#
#    # Pods for Data
#
#    target 'DataTests' do
#
#      # Pods for testing
#    end
#
#  end
#
#  target 'Infra' do
#    # Comment the next line if you don't want to use dynamic frameworks
#    use_frameworks!
#
#    # Pods for Infra
#    firebase_pods
#
#    target 'InfraTests' do
#      # Pods for testing
#    end
#
#  end
#
#
#  target 'Presentation' do
#    # Comment the next line if you don't want to use dynamic frameworks
#    use_frameworks!
#
#    # Pods for Presentation
#
#    target 'PresentationTests' do
#      # Pods for testing
#    end
#
#  end
#
#  target 'Validation' do
#    # Comment the next line if you don't want to use dynamic frameworks
#    use_frameworks!
#
#    # Pods for Validation
#
#    target 'ValidationTests' do
#      # Pods for testing
#    end
#
#  end


#post_install do |installer_representation|
#    installer_representation.pods_project.targets.each do |target|
#        target.build_configurations.each do |config|
#            config.build_settings['ALWAYS_EMBED_Swift_STANDARD_LIBRARIES'] = #'$(inherited)'
#        end
#    end
#end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
    end
end

