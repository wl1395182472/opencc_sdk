#include "include/opencc_sdk/opencc_sdk_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "opencc_sdk_plugin.h"

void OpenccSdkPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  opencc_sdk::OpenccSdkPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
