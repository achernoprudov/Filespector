//
//  InspectFileInteractor.swift
//  FileinspectorCore
//
//  Created by Andrey Chernoprudov on 17/06/2018.
//  Copyright © 2018 Little Stars. All rights reserved.
//

import Foundation

public struct InspectFileInteractor {
    
    public enum InspectError: LocalizedError {
        case unknown(String)
        
        public var errorDescription: String? {
            switch self {
            case .unknown(let message):
                return "Unknown error: \(message)"
            }
        }
    }
    
    public enum InspectionResult {
        case success([FileAttribute])
        case error(Error)
    }
    
    class Result {
        var attributes: [FileAttribute] = []
        
        func append(_ attribute: FileAttribute) {
            attributes.append(attribute)
        }
        
        func append(_ attributes: [FileAttribute]) {
            self.attributes += attributes
        }
    }
    
    public typealias Completition = (InspectionResult) -> Void
    
    // MARK: - Instance variables
    
    private let queue = DispatchQueue.global(qos: .background)
    
    // MARK: - Public
    
    public init() {
    }
    
    public func inspect(_ context: NSExtensionContext, completition: @escaping Completition) {
        queue.async {
            do {
                try self.extract(from: context, completition: completition)
            } catch {
                completition(.error(error))
            }
        }
    }
    
    // MARK: - Private
    
    private func extract(from context: NSExtensionContext, completition: @escaping Completition) throws {
        let result = Result()
        let items = context.inputItems
        //TODO inspect multiplie items
        guard !items.isEmpty else {
            throw InspectError.unknown("no input items")
        }
        guard let item = items.first, items.count == 1 else {
            throw InspectError.unknown("to many items")
        }
        guard let extensionItem = item as? NSExtensionItem else  {
            throw InspectError.unknown("NSExtensionItem expected")
        }
        let extensionAttributes = process(extensionItem)
        result.append(extensionAttributes)
        guard let itemProvider = extensionItem.attachments?.first as? NSItemProvider else {
            throw InspectError.unknown("NSItemProvider expected")
        }
        let providerAttributes = process(extensionItem)
        result.append(providerAttributes)
        guard let typeIdentifier = itemProvider.registeredTypeIdentifiers.first else {
            throw InspectError.unknown("No type identifier provided")
        }
        itemProvider.loadItem(forTypeIdentifier: typeIdentifier, options: nil) { (data, errorOrNil) in
            if let error = errorOrNil {
                completition(.error(error))
                return
            }
            guard let url = data as? URL else {
                let error = InspectError.unknown("No url provided")
                completition(.error(error))
                return
            }
            do {
                let urlAttributes = try self.process(url)
                result.append(urlAttributes)
                completition(.success(result.attributes))
            } catch {
                completition(.error(error))
            }
        }
    }
    
    private func process(_ extensionItem: NSExtensionItem) -> [FileAttribute] {
        var attributes: [FileAttribute] = []
        if let attributedTitle = extensionItem.attributedTitle {
            attributes.append(AttributedStringFileAttribute(
                title: "attributedTitle", value: attributedTitle))
        }
        if let contentText = extensionItem.attributedContentText {
            attributes.append(AttributedStringFileAttribute(
                title: "contentText", value: contentText))
        }
        return attributes
    }
    
    private func process(_ itemProvider: NSItemProvider) -> [FileAttribute] {
        var attributes: [FileAttribute] = []
        attributes.append(StringFileAttribute(
            title: "typeIdentifiers",
            value: itemProvider.registeredTypeIdentifiers.description))
        return attributes
    }
    
    private func process(_ url: URL) throws -> [FileAttribute] {
        var attributes: [FileAttribute] = []
        attributes.append(StringFileAttribute(
            title: "lastPathComponent (filename)",
            value: url.lastPathComponent))
        attributes.append(StringFileAttribute(
            title: "absoluteString (path)",
            value: url.absoluteString))
        
        let data = try Data(contentsOf: url)
        
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
        bcf.countStyle = .file
        let sizeString = bcf.string(fromByteCount: Int64(data.count))
        
        attributes.append(StringFileAttribute(
            title: "Size",
            value: sizeString))
        
        if let image = UIImage(data: data) {
            attributes.append(StringFileAttribute(
                title: "Image width",
                value: image.size.width.description))
            attributes.append(StringFileAttribute(
                title: "Image height",
                value: image.size.height.description))
        }
        
        return attributes
    }
}
