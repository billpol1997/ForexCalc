//
//  MainView.swift
//  ForexCalc
//
//  Created by Bill on 26/7/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = DIContainer.shared.getContainerSwinject().resolve(MainViewModel.self)!
    }
    
    var body: some View {
        content
    }
    
    var content: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 8) {
                Spacer()
                calculationView
                buttons
                    .padding(.bottom, 8)
            }
        }
    }
    
    var calculationView: some View {
        HStack {
            Spacer()
            Text("0")
                .foregroundColor(.white)
                .font(.system(size: 70))
                .fontWeight(.semibold)
                .padding(.horizontal,12)
        }
    }
    
    var buttons: some View {
        VStack(spacing: 8) {
            ForEach(Array(self.viewModel.buttons.enumerated()), id: \.offset) { index, row in
                HStack(spacing: 8) {
                    ForEach(Array(row.enumerated()) , id: \.offset) { itemIndex, item in
                        Button {
                            //TODO: add action 
                        } label: {
                            Text(item.description)
                                .frame(width: self.viewModel.getButtonWidth(button: item), height: (UIScreen.main.bounds.width - (5 * 12)) / 4)
                                .font(.system(size: 32))
                                .foregroundColor(self.viewModel.getButtonTextColor(button: item))
                                .background(self.viewModel.getButtonBGColor(button: item))
                                .cornerRadius((UIScreen.main.bounds.width - (5 * 12)) / 4)
                        }
                    }
                }
                
            }
        }
    }
}

