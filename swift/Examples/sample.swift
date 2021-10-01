enum FeatureFlagKey: String, CaseIterable {
    case loyalty = "pos.hello"
    
}

@objc(FeatureFlagKey)
@objcMembers
class ObjcFeatureFlagKey: NSObject {
    static var useNewAdminSettingsSearchOrder: String {
        return FeatureFlagKey.loyalty.rawValue
    }
}


func testNewConfig() {
    let refreshConfigResult = (refreshSuccess: true, showCallbackAlert: showCallbackAlert, wepayEnabled: wepayEnabled)
}
