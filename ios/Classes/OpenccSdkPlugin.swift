import Flutter
import UIKit
import OpenCC

public class OpenccSdkPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "opencc_sdk", binaryMessenger: registrar.messenger())
        let instance = OpenccSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "convertToTraditional" {
            guard let bundle = self.bundle else {
                let flutterError = FlutterError(  code: "NO_BUNDLE", message: "The bundle for the plugin does not exist.", details: nil)
                result(flutterError)
                return
            }
            guard let args = call.arguments as? [String: Any],
                  let text = args["simplified_text"] as? String
            else {
                let flutterError = FlutterError(  code: "MISSING_PARAMETER", message: "Required parameters are missing",  details: nil)
                result(flutterError)
                return
            }
            convertToTraditional( text: text,bundle: bundle,  result: result)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    lazy var bundle: Bundle? = {
        let openCCBundle = Bundle(for: ChineseConverter.self)
        guard
            let resourceUrl = openCCBundle.url(    forResource: "OpenCCDictionary", withExtension: "bundle")
        else {
            return nil
        }
        return Bundle(url: resourceUrl)
    }()
    
    func convertToTraditional( text: String,  bundle: Bundle, result: @escaping FlutterResult) {
        do {
            let converter = try ChineseConverter(bundle: bundle,option: [.traditionalize])
            let converted = converter.convert(text)
            result(converted)
        } catch {
            let flutterError = FlutterError(   code: "convertToTraditional", message: error.localizedDescription, details: nil)
            result(flutterError)
        }
    }
}
