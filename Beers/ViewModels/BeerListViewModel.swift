//
//  BeerListViewModel.swift
//  Beers
//
//  Created by Maria Wilfling on 11.03.24.
//

import Foundation

@MainActor
class BeerListViewModel: ObservableObject {
    
    // data
    @Published var beers: [Beer] = []
    @Published var randomBeer: Beer?
    
    // paging attributes
    @Published var page = 1
    @Published var moreDataAvailable = true // TODO: is never set to false
    
    // toggling visibility
    @Published var showBeerOfTheDay = true
    @Published var showBeerFilter = false
    
    // filter preferences for the beers
    @Published var beerfilterSettings = BeerFilterSettings(abvSetting: .light, ibuSetting: .mild, ebcSetting: .light) {
        didSet {
            Task {
                await getBeers()
            }
        }
    }
    
    /// toggle if filter settings should be used or not
    @Published var useSettings = false {
        didSet {
            Task {
                await refreshBeers()
            }
        }
    }
    
    /// search text for filtering the beer's name
    /// when the search text was changed, new beers are requested
    @Published var searchText = "" {
        didSet {
            if searchText.count >= 3 || searchText.isEmpty {
                Task {
                    await getBeers()
                }
            }
        }
    }
    
    /// Refreshes the list items by replacing the current items with new beer request
    func refreshBeers() async {
        page = 1
        beers = []
        await getBeers()
    }
    
    /// Fetches beer items if they weren't already loaded
    /// to avoid unneccessary requests
    func loadBeersIfNeeded() async {
        if beers.isEmpty {
            await getBeers()
        }
    }
    
    /// Fetches the next page/bulk of beer items
    func loadMoreBeers() async {
        page += 1
        await getBeers()
    }
    
    /// Fetches a random beer if it wasn't already loaded
    /// to avoid unnecessary requests
    func loadRandomBeerIfNeeded() async {
        if randomBeer == nil {
            await getRandomBeer()
        }
    }
    
    /// fetch beers and add sorted results to the beers array
    private func getBeers() async {
        
        guard let data = try? await BeerAPIService().getBeers(searchText: searchText.isEmpty ? nil : searchText, page: page, filterSettings: useSettings ? beerfilterSettings : nil) else {
            self.beers = []
            return
        }
        
        beers.append(contentsOf: data)
        beers = beers.sorted{$0.id < $1.id}
    }
    
    /// fetch random beer and assign value
    private func getRandomBeer() async {
        if let data = try? await BeerAPIService().getRandomBeer() {
            self.randomBeer = data
        }
    }
}
