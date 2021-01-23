//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <sys/sys_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) sys_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SysPlugin");
  sys_plugin_register_with_registrar(sys_registrar);
}
