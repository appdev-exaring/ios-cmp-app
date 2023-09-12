//
//  Bundle+Framework.swift
//  ConsentViewController
//
//  Created by Vilas on 15/10/20.
//

import class Foundation.Bundle
#if os(tvOS)
import ConsentViewController_tvOSResources
#endif

extension Foundation.Bundle {
    /// Returns the resource bundle associated with the current Swift module.
    static var framework: Bundle = {
        #if SWIFT_PACKAGE

        #if os(tvOS)
        return Bundle(path: Bundle.main.bundlePath.appending( "/ConsentViewController-tvOSResources_ConsentViewControllerResources.bundle"))!
        #else
        return Bundle.module
        #endif

        #else
        return Bundle(for: SPConsentManager.self)
        #endif
    }()
}
