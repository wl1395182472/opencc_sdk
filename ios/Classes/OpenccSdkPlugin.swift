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
        switch call.method {
        case "convertToTraditional":
            guard let bundle = self.bundle else {
                result(createFlutterError(code: "NO_BUNDLE", message: "The bundle for the plugin does not exist."))
                return
            }
            guard let args = call.arguments as? [String: Any],
                  let text = args["simplified_text"] as? String else {
                result(createFlutterError(code: "MISSING_PARAMETER", message: "Required parameters are missing."))
                return
            }
            convertToTraditional(text: text, bundle: bundle, result: result)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    // Lazy-loaded bundle for OpenCC resources
    lazy var bundle: Bundle? = {
        let openCCBundle = Bundle(for: ChineseConverter.self)
        guard let resourceUrl = openCCBundle.url(forResource: "OpenCCDictionary", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: resourceUrl)
    }()
    
    // Conversion function with error handling
    func convertToTraditional(text: String, bundle: Bundle, result: @escaping FlutterResult) {
        do {
            let converter = try ChineseConverter(bundle: bundle, option: [.traditionalize])
            let converted = converter.convert(text)
            result(converted)
        } catch {
            result(createFlutterError(code: "CONVERSION_ERROR", message: "Failed to convert text to traditional Chinese.", details: error.localizedDescription))
        }
    }
    
    // Helper function to create FlutterError
    private func createFlutterError(code: String, message: String, details: String? = nil) -> FlutterError {
        return FlutterError(code: code, message: message, details: details)
    }
}
