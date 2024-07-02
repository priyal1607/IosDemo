/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    A struct for accessing generic password keychain items.
*/

import Foundation

struct KeychainItem
{
    // MARK: Types
    
    enum KeychainError: Error
    {
        case noDeviceID
        case unexpectedDeviceIDData
        case unexpectedItemData
        case unhandledError(status: OSStatus)
    }
    
    // MARK: Properties
    
    let service: String
    
    let accessGroup: String?

    // MARK: Intialization
    
    init(service: String, accessGroup: String? = nil)
    {
        self.service = service
        self.accessGroup = accessGroup
    }
    
    // MARK: Keychain access
    
    func readDeviceID() throws -> String
    {
        /*
            Build a query to find the item that matches the service and
            access group.
        */
        var query = KeychainItem.keychainQuery(withService: service, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        
        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult)
        {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }
        
        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else { throw KeychainError.noDeviceID }
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        
        // Parse the password string from the query result.
        guard let existingItem = queryResult as? [String : AnyObject],
            let deviceIDData = existingItem[kSecValueData as String] as? Data,
            let deviceID = String(data: deviceIDData, encoding: String.Encoding.utf8)
            else
            {
                throw KeychainError.unexpectedDeviceIDData
            }
        
        return deviceID
    }
    
    func saveDeviceID(_ deviceID: String) throws -> String
    {
        // Encode the password into an Data object.
        let encodedDeviceID = deviceID.data(using: String.Encoding.utf8)!
        
        do
        {
            //try deleteItem()
            // Check for an existing item in the keychain.
            let deviceID = try readDeviceID()
            
            return deviceID
        }
        catch KeychainError.noDeviceID
        {
            /*
                No deviceID was found in the keychain. Create a dictionary to save
                as a new keychain item.
            */
            var newItem = KeychainItem.keychainQuery(withService: service, accessGroup: accessGroup)
            newItem[kSecValueData as String] = encodedDeviceID as AnyObject?
            
            // Add a the new item to the keychain.
            let status = SecItemAdd(newItem as CFDictionary, nil)
            
            // Throw an error if an unexpected status was returned.
            guard status == noErr else {
                throw KeychainError.unhandledError(status: status)
            }
            
            let deviceID = try readDeviceID()
            return deviceID
        }
    }
    
    func deleteItem() throws
    {
        // Delete the existing item from the keychain.
        let query = KeychainItem.keychainQuery(withService: service, accessGroup: accessGroup)
        let status = SecItemDelete(query as CFDictionary)
        
        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    // MARK: Convenience
    
    private static func keychainQuery(withService service: String, accessGroup: String? = nil) -> [String : AnyObject]
    {
        var query: [String : AnyObject] = [:]
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?

        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        
        return query
    }
}
