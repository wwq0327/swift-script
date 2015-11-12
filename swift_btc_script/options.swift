#!/usr/bin/swift -F Carthage/Build/Mac

import OptionKit

let sayOpt = Option(trigger: .Mixed("s", "say"))
let helpOpt = Option(trigger: .Mixed("h", "help"))
let parser = OptionParser(definitions: [sayOpt, helpOpt])
let actualArguments = Array(Process.arguments[1..<Process.arguments.count])

func printHelp(parser: OptionParser) {
    print(parser.helpStringForCommandName("options.swift"))
}

do {
    let (options, rest) = try parser.parse(actualArguments)
    if options[helpOpt] != nil {
        printHelp(parser)
    } else {
        if options[sayOpt] != nil {
            let toSay = rest.joinWithSeparator(" ")
            print(toSay)
        } else {
            printHelp(parser)
        }
    }
} catch let OptionKitError.InvalidOption(description: description) {
    print(description)
}
