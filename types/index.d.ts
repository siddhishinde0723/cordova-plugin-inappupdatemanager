// Type definitions for cordova-plugin-inappupdatemanager v1.0.0
// Project: https://www.npmjs.com/package/cordova-plugin-inappupdatemanager
// Definitions by: Philipp A. Mohrenweiser <https://github.com/phiamo>
// Definitions: https://github.com/DefinitelyTyped/DefinitelyTyped
//
// Licensed under the MIT license.

interface CordovaPlugins {
    /**
     * cordova_app_version_plugin interface
     */
    InAppUpdateManager: InAppUpdateManager.InAppUpdateManager;
}

/**
 * Keep the type global namespace clean by using a module
 */
declare module InAppUpdateManager {
    interface InAppUpdateManager {
        /**
         * App version from config.xml's version (e.g. <widget id="my.app.id" version="1.5.0">)
         * @example window.cordova.plugins.version.getAppVersion() // e.g: "1.5.0"
         */
        immediate(): boolean;
    }
}