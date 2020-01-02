@objc(ModusEchoSwift) class ModusEchoSwift : CDVPlugin {
  @objc(immediate:)
  func immediate(command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )
	

    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: msg
    )
    self.commandDelegate!.send(
      pluginResult,
      callbackId: command.callbackId
    )
  }
  func isUpdateAvailable() throws -> Bool {
    guard let info = Bundle.main.infoDictionary,
        let currentVersion = info["CFBundleShortVersionString"] as? String,
        let identifier = info["CFBundleIdentifier"] as? String,
        let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
            throw VersionError.invalidBundleInfo
    }
    let data = try Data(contentsOf: url)
    guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
        throw VersionError.invalidResponse
    }
    if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
        print("version in app store", version,currentVersion);
        
        return version != currentVersion
    }
    throw VersionError.invalidResponse
  }
  func popupUpdateDialogue(){
        var versionInfo = ""
        do {
            versionInfo = try self.globalObjectHome.getAppStoreVersion()
        }catch {
            print(error)
        }
 
        
        let alertMessage = "A new version of Mobikul Magento2 Application is available, Please update to version "+versionInfo;
        let alert = UIAlertController(title: "New Version Available", message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
  
        let okBtn = UIAlertAction(title: "Update", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            if let url = URL(string: "itms-apps://itunes.apple.com/us/app/myrecordings/id1398496124"),
                UIApplication.shared.canOpenURL(url){
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        })
        let noBtn = UIAlertAction(title:"Skip this Version" , style: .destructive, handler: {(_ action: UIAlertAction) -> Void in
        })
        alert.addAction(okBtn)
        alert.addAction(noBtn)
        self.present(alert, animated: true, completion: nil)
    }
}