//
//  BeerFilterView.swift
//  Beers
//
//  Created by Maria Wilfling on 13.03.24.
//

import SwiftUI

struct BeerFilterView: View {
    
    @Binding var filterSettings: BeerFilterSettings
    @Binding var isPresented: Bool
    @Binding var isActive: Bool
    
    @State var isShowingAlert: Bool = false
    
    var body: some View {
        
        VStack {
            
            headerView
            
            settingsView
            
            buttonView
            
            Spacer()
        }
        .padding()
        .bold()
        .background(Color.yellow)
        .foregroundColor(.white)
        .onAppear {
            UISegmentedControl.appearance().selectedSegmentTintColor = .white
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.orange], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        }
        .alert("This feature couldn't be tested, because Punk API was down. It was therefore deactivated temporarily.", isPresented: $isShowingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    var headerView: some View {
        
        VStack {
            HStack {
                Spacer()
                
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark.circle")
                }
                
            }
            Text("Filter")
                .font(.title)
            Text("Choose your preferences")
                .padding(.bottom)
        }
    }
    
    var settingsView: some View {
        
        VStack(alignment: .leading) {
            Text("Alcohol:")
                .font(.title3)
            Picker("%:", selection: $filterSettings.abvSetting) {
                ForEach(AbvSetting.allCases, id: \.self) {
                    Text($0.rawValue.uppercased())
                }
            }
            .pickerStyle(.segmented)
            
            Text("Bitterness:")
                .font(.title3)
            Picker("IBU:", selection: $filterSettings.ibuSetting) {
                ForEach(IbuSetting.allCases, id: \.self) {
                    Text($0.rawValue.uppercased())
                }
            }
            .pickerStyle(.segmented)
            
            Text("Color:")
                .font(.title3)
            Picker("EBC:", selection: $filterSettings.ebcSetting) {
                ForEach(EbcSetting.allCases, id: \.self) {
                    Text($0.rawValue.uppercased())
                }
            }
            .pickerStyle(.segmented)

        }
    }
    
    var buttonView: some View {
        VStack {
            Button("Confirm Settings".uppercased()) {
                //TODO: Temporarily deactivated
                //isPresented = false
                
                isShowingAlert = true
            }
            .buttonStyle(.borderedProminent)
            .tint(.white)
            .foregroundColor(.orange)
            .padding(.bottom)
            
            Button("Show All Beers".uppercased()) {
                isPresented = false
                isActive = false
                filterSettings = BeerFilterSettings(abvSetting: .light, ibuSetting: .mild, ebcSetting: .light)
            }
        }
        .padding(.top, 50)
    }
}

struct BeerFilterView_Previews: PreviewProvider {
    static var previews: some View {
        BeerFilterView(filterSettings: Binding.constant(BeerFilterSettings.mock()), isPresented: Binding.constant(true), isActive: Binding.constant(true))
    }
}
