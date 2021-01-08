//
//  GlobalExceptionHandler.swift
//  Brandi
//
//  Created by brandi on 2016. 7. 1..
//  Copyright © 2016년 Brandi. All rights reserved.
//

import Foundation

open class GlobalExceptionHandler {
    
    public init() {}
    
    // MARK: Uncaught Exception Handler
    public static func handleException(_ exception: NSException) {
        let stackArray = exception.callStackReturnAddresses
        Logger.errorLog("\(stackArray)")
    }
}
