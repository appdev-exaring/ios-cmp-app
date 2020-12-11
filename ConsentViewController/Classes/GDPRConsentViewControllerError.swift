//
//  ConsentError.swift
//  GDPRConsentViewController
//
//  Created by Andre Herculano on 12.03.19.
//

import Foundation

@objcMembers public class GDPRConsentViewControllerError: NSError, LocalizedError {
    public var spCode: String { "generic_sdk_error" }
    public var spDescription: String { "Something went wrong in the SDK" }

    init() {
        super.init(domain: "GDPRConsentViewController", code: 0, userInfo: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objcMembers public class APIParsingError: GDPRConsentViewControllerError {
    private let parsingError: Error?
    private let endpoint: String

    init(_ endpoint: String, _ error: Error?) {
        self.endpoint = endpoint
        self.parsingError = error
        super.init()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override public var description: String { return "Error parsing response from \(endpoint): \(parsingError.debugDescription)" }
    public var errorDescription: String? { return description }
    public var failureReason: String? { return description }
}

@objcMembers public class UnableToLoadJSReceiver: GDPRConsentViewControllerError {
    public var failureReason: String? { return "Unable to load the JSReceiver.js resource." }
    override public var description: String { return "\(failureReason!)" }
}

@objcMembers public class MessageEventParsingError: GDPRConsentViewControllerError {
    let message: String

    init(message: String) {
        self.message = message
        super.init()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public var failureReason: String? { return "Could not parse message coming from the WebView \(message)" }
    override public var description: String { return "\(failureReason!)" }
}

@objcMembers public class WebViewError: GDPRConsentViewControllerError {
    let errorCode: Int?
    let title, stackTrace: String?

    init(code: Int? = nil, title: String? = nil, stackTrace: String? = nil) {
        self.errorCode = code
        self.title = title
        self.stackTrace = stackTrace
        super.init()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public var failureReason: String? { return "Something went wrong in the webview (code: \(errorCode ?? 0), title: \(title ?? ""), stackTrace: \(stackTrace ?? ""))" }
    override public var description: String { return "\(failureReason!)" }
}

@objcMembers public class InvalidArgumentError: GDPRConsentViewControllerError {
    let message: String

    init(message: String) {
        self.message = message
        super.init()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public var failureReason: String? { return message }
    override public var description: String { return message }
}

@objcMembers public class PostingConsentWithoutConsentUUID: GDPRConsentViewControllerError {
    public var failureReason: String? { return "Tried to post consent but the stored consentUUID is empty or nil. Make sure to call .loadMessage or .loadPrivacyManager first." }
    override public var description: String { return "\(failureReason!)" }
}

@objcMembers public class InvalidURLError: GDPRConsentViewControllerError {
    override public var spDescription: String { description }
    override public var spCode: String { "invalid_url" }

    let urlString: String

    init(urlString: String) {
        self.urlString = urlString
        super.init()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public var failureReason: String? { description }
    override public var description: String { "Could not parse URL: \(urlString)" }
}

/// Network Errors
@objcMembers public class NoInternetConnection: GDPRConsentViewControllerError {
    override public var spDescription: String { "User has no Internet connection." }
    override public var spCode: String { "no_internet_connection" }

    public var failureReason: String? { description }
    override public var description: String { "The device is not connected to the internet." }
}

@objcMembers public class ConnectionTimeOutError: GDPRConsentViewControllerError {
    override public var spDescription: String { description }
    override public var spCode: String { "connection_timeout" }

    let url: URL?
    let timeout: TimeInterval?

    init(url: URL?, timeout: TimeInterval?) {
        self.url = url
        self.timeout = timeout
        super.init()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public var failureReason: String? { return description }
    override public var description: String { return "Timed out when loading \(String(describing: url?.absoluteString)) after \(String(describing: timeout)) seconds" }
}

@objcMembers public class GenericNetworkError: GDPRConsentViewControllerError {
    override public var spDescription: String { description }
    override public var spCode: String { "generic_network_request_\(response?.statusCode ?? 999)" }

    let request: URLRequest
    let response: HTTPURLResponse?

    init(request: URLRequest, response: HTTPURLResponse?) {
        self.request = request
        self.response = response
        super.init()
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    public var failureReason: String? { return description }
    override public var description: String { return
        "The server responsed with \(response?.statusCode ?? 999) when performing \(request.httpMethod ?? "<no verb>") \(response?.url?.absoluteString ?? "<no url>")"
    }
}

@objcMembers public class InternalServerError: GenericNetworkError {
    override public var spCode: String { "internal_server_error_\(response?.statusCode ?? 500)" }
}

@objcMembers public class ResourceNotFoundError: GenericNetworkError {
    override public var spCode: String { "resource_not_found_\(response?.statusCode ?? 400)" }
}
