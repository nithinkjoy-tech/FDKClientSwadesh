//
//  ActionPageContentAppModel.swift
//  FDKClientSwadesh
//
//  Created by Nithin on 24/10/25.
//



import Foundation
public extension ApplicationClient.Content {
    /*
        Model: ActionPage
        Used By: Content
    */
    class ActionPage: Codable {
        
        public var params: [String: [String]]?
        
        public var query: [String: Any]?
        
        public var url: String?
        
        public var type: PageType
        

        public enum CodingKeys: String, CodingKey {
            
            case params = "params"
            
            case query = "query"
            
            case url = "url"
            
            case type = "type"
            
        }

        public init(params: [String: [String]]? = nil, query: [String: [String]]? = nil, type: PageType, url: String? = nil) {
            
            self.params = params
            
            self.query = query
            
            self.url = url
            
            self.type = type
            
        }

        required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            do {
                params = try container.decode([String: [String]].self, forKey: .params)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                
            }
            
            // FIXED: Decode query to handle both String and [String] values
            do {
                // First try as [String: [String]]
                if let arrayQuery = try? container.decode([String: [String]].self, forKey: .query) {
                    query = arrayQuery
                }
                // Then try as [String: String] and convert to Any
                else if let stringQuery = try? container.decode([String: String].self, forKey: .query) {
                    query = stringQuery
                }
                else {
                    query = nil
                }
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("Query decode error: \(error)")
            }
            
            do {
                url = try container.decode(String.self, forKey: .url)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                
            }
            
            type = try container.decode(PageType.self, forKey: .type)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            
            try? container.encodeIfPresent(params, forKey: .params)
            
            
            
            try? container.encodeIfPresent(query, forKey: .query)
            
            
            
            try? container.encodeIfPresent(url, forKey: .url)
            
            
            
            try? container.encodeIfPresent(type, forKey: .type)
            
            
        }
        
    }
}
