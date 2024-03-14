//
//  ContentView.swift
//  Beers
//
//  Created by Maria Wilfling on 11.03.24.
//

import SwiftUI

struct BeerListView: View {
    
    @StateObject var viewModel = BeerListViewModel()
    
    var body: some View {
        
        NavigationStack() {
            
            VStack {
                
                beerOfTheDayView
                                
                beerListView
            }
            .padding()
            .navigationTitle("Beers")
            .navigationDestination(for: Beer.self) { beer in
                BeerDetailView(beer: beer)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button(action: {
                        viewModel.showBeerFilter = true
                    }) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundStyle(Color.orange)
                    }
                }
            }
        }
        .popover(isPresented: $viewModel.showBeerFilter) {
            BeerFilterView(filterSettings: $viewModel.beerfilterSettings, isPresented: $viewModel.showBeerFilter, isActive: $viewModel.useSettings)
        }
    }
    
    
    //----------------------------------------------------------------
    // View Components
    //________________________________________________________________
    
    
    var beerOfTheDayView: some View {
        
        VStack {
            if let beer = viewModel.randomBeer, viewModel.showBeerOfTheDay {
                VStack {
                    
                    beerOfTheDayCloseButton
                    
                    Text("Beer of the Day")
                        .textCase(.uppercase)
                        .font(.title)
                        .bold()
                    
                    Text(beer.name)
                        .lineLimit(1)
                        .font(.title3)
                        .bold()
                    
                    NavigationLink(value: viewModel.randomBeer) {
                        ZStack {
                            Text("Learn More")
                                .padding(8)
                                .border(.white)
                        }
                    }
                }
                .padding()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.orange)
                )
            }
        }
        .task {
            await viewModel.loadRandomBeerIfNeeded()
        }
    }
    
    var beerOfTheDayCloseButton: some View {
        
        HStack {
            Spacer()
            Button(action: {
                viewModel.showBeerOfTheDay = false
            }) {
                Image(systemName: "xmark.circle")
                    .foregroundStyle(Color.white)
            }
        }
        
    }
    
    var beerListView: some View {
        
        List {
            ForEach(viewModel.beers, id: \.self) { beer in
                NavigationLink(value: beer) {
                    beerRowView(beer: beer)
                    
                }
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                .padding(.horizontal)
                .background(Color.yellow)
                .cornerRadius(5)
            }
            
            if viewModel.moreDataAvailable {
                lastRowView
                    .listRowSeparator(.hidden)
            }
        }
        .searchable(text: $viewModel.searchText , prompt: "search a beer's name")
        .refreshable {
            await viewModel.refreshBeers()
        }
        .listStyle(.plain)
        .task {
            await viewModel.loadBeersIfNeeded()
        }
    }
    
    func beerRowView(beer: Beer) -> some View {
        
        HStack {
            if let image = beer.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 50)
            } else {
                Image("beer-bottle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 50)
            }
            
            VStack(alignment: .leading) {
                Text(beer.name)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .lineLimit(1)
                Text(beer.tagline)
                    .font(.subheadline)
                    .foregroundColor(.orange)
                    .lineLimit(1)
            }
        }
        .padding()
        .background(Color.yellow)
        .cornerRadius(5)
    }
    
    var lastRowView: some View {
        HStack {
            Spacer()
            Text("loading beers...")
                .foregroundColor(.gray)
                .font(.callout)
            Spacer()
        }
        .frame(height: 50)
        .task {
            await viewModel.loadMoreBeers()
        }
    }
}

struct BeerListView_Previews: PreviewProvider {
    static var previews: some View {
        BeerListView(viewModel: BeerListViewModel())
    }
}
