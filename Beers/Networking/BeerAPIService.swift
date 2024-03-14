//
//  BeerAPIService.swift
//  Beers
//
//  Created by Maria Wilfling on 11.03.24.
//

import Foundation
import SwiftUI

enum APIError: Error {
    case invalidUrl, requestError, decodingError, statusNotOk
}

struct BeerAPIService {
    
    /// Punk API base url
    let baseUrl: String = "https://api.punkapi.com/v2"
    
    /// Fetches beers
    /// - Parameters:
    ///   - searchText: The search string for searching beers by name
    ///   - page: The next page of beers to be loaded
    ///   - filterSettings: The filter settings for filtering beers
    func getBeers(searchText: String?, page: Int, filterSettings: BeerFilterSettings?) async throws -> [Beer] {
        
        var urlString = "\(baseUrl)/beers"
        
        if let searchText {
            urlString = "\(urlString)?beer_name=\(searchText)"
        } else {
            urlString = "\(urlString)?page=\(page)"
        }
        
        // TODO: Couldn't test the request with filter settings because Punk API was down
        // TODO: Create a priority for parameters searchText, page and filter settings
        
//        if let filterSettings {
//            let settings = BeerFilterRequestSettings(filterSetting: filterSettings)
//            urlString = "\(urlString)?abv_gt=\(settings.abvMin)&abv_lt=\(settings.abvMax)&ibu_gt=\(settings.ibuMin)&ibu_lt=\(settings.ibuMax)&ebc_gt=\(settings.ibuMin)&ebc_lt=\(settings.ibuMax)"
//        }
//        print(urlString)
        
        let beerData = try await requestBeers(urlString: urlString)
        let beers = await beersWithImage(from: beerData)
        
        return beers
    }
    
    /// Fetches a random beer
    func getRandomBeer() async throws -> Beer {
        
        let urlString = "\(baseUrl)/beers/random"
        
        let beerData = try await requestBeers(urlString: urlString)
        
        let randomBeers = await beersWithImage(from: beerData)
            
        guard let randomBeer = randomBeers.first else {
            throw APIError.decodingError
        }
        
        return randomBeer
    }
    
    /// Fetches beers from API
    /// - Parameters:
    ///   - urlString: The url string for the request
    private func requestBeers(urlString:String) async throws -> [BeerData] {
        
        guard let url = URL(string: urlString) else{
            throw APIError.invalidUrl
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else{
            throw APIError.requestError
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw APIError.statusNotOk
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let beerData = try? decoder.decode([BeerData].self, from: data) else {
            throw APIError.decodingError
        }
        
        return beerData
    }
    
    /// Fetches images for an array of beer request data
    /// - Parameters:
    ///   - beerDataResult: The result of beer data from the request
    private func beersWithImage(from beerDataResult: [BeerData]) async -> [Beer] {
        
        var beers = [Beer]()
        
        for beerData in beerDataResult {
            
            var beer = Beer(beerData: beerData)
            
            if let urlString = beerData.imageUrl, let url = URL(string: urlString) {
                if let data = try? await downloadImageData(from: url) {
                    beer.image = UIImage(data: data)
                }
            }
            
            beers.append(beer)
        }
        
        return beers
    }
    
    /// Loads image data from a URL
    ///   - url: The URL of the image
    private func downloadImageData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
