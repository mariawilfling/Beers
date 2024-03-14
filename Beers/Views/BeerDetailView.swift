//
//  BeerDetailView.swift
//  Beers
//
//  Created by Maria Wilfling on 11.03.24.
//

import SwiftUI

struct BeerDetailView: View {
    
    @State var beer: Beer?
    
    var body: some View {
        
        ScrollView {
            
            if let beer {
                
                VStack {
                    titleView(name: beer.name, tagline: beer.tagline)
                    
                    beerSheetView(abv: beer.abv, ibu: beer.ibu, ebc: beer.ebc, image: beer.image)
                        .padding(.vertical, 20)
                    
                    detailInfoView(description: beer.description)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
            } else {
                Text("Sorry, something went wrong!")
                    .bold()
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
    }
}

//----------------------------------------------------------------
// View Components
//________________________________________________________________

func titleView(name: String, tagline: String) -> some View {
    
    VStack(alignment: .leading) {
        Text(name)
            .font(.title)
            .bold()
            .foregroundColor(.white)
        Text(tagline)
            .font(.headline)
            .foregroundColor(.orange)
    }
}

func beerSheetView(abv: Double, ibu:Double?, ebc: Double?, image: UIImage?) -> some View {
    
    ZStack {
        Color.white
            .frame(height: 250)
        
        HStack {
            VStack(alignment: .leading) {
                
                brewSheetRow(title: "%", value: abv)
                if let ibu {
                    brewSheetRow(title: "IBU", value: ibu)
                }
                if let ebc {
                    brewSheetRow(title: "EBC", value: ebc)
                }
            }
            
            Spacer()
            
            VStack {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image("beer-bottle")
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(maxWidth: 150, maxHeight: 200)
            
        }
        .padding(.horizontal, 20)
        
    }
    .cornerRadius(20)
}

func detailInfoView(description: String) -> some View {
    
    Text(description)
        .bold()
        .foregroundColor(.white)
}

func brewSheetRow(title: String, value: Double) -> some View {
    
    HStack {
        ZStack {
            Circle()
                .fill(.orange)
                .frame(width: 60)
            
            Text(title)
                .bold()
                .foregroundStyle(.white)
                .padding()
        }
        
        Text(String(format: "%0.1f", value))
            .bold()
            .foregroundColor(.orange)
    }
}

struct BeerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BeerDetailView(beer: Beer.mock())
    }
}
