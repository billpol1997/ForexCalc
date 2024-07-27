//
//  MainView.swift
//  ForexCalc
//
//  Created by Bill on 26/7/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @State var toggleDropDown: Bool = false
    
    
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
                HStack {
                    currency
                        .padding(.leading, 8)
                        .padding(.bottom, 12)
                    dropDown
                        .padding(.leading, 12)
                        .padding(.bottom, 12)
                    Spacer()
                }
                calculationView
                buttons
                    .padding(.bottom, 8)
            }
        }
    }
    
    var calculationView: some View {
        HStack {
            Spacer()
            Text(self.viewModel.result.toFormattedNumberToString() ?? "no")
                .foregroundColor(.white)
                .font(.system(size: 70))
                .fontWeight(.semibold)
                .padding(.horizontal,12)
                .lineLimit(2)
        }
    }
    
    var buttons: some View {
        VStack(spacing: 8) {
            ForEach(Array(self.viewModel.buttons.enumerated()), id: \.offset) { index, row in
                HStack(spacing: 8) {
                    ForEach(Array(row.enumerated()) , id: \.offset) { itemIndex, item in
                        Button {
                            self.viewModel.getButtonData(button: item)
                        } label: {
                            Text(item.description)
                                .frame(width: self.viewModel.getButtonWidth(button: item), height: (UIScreen.main.bounds.width - (5 * 12)) / 4)
                                .font(.system(size: 32))
                                .foregroundColor(self.viewModel.toggledFunction.isOn && item.description == self.viewModel.toggledFunction.type.rawValue ? .orange : self.viewModel.getButtonTextColor(button: item))
                                .background(self.viewModel.toggledFunction.isOn && item.description == self.viewModel.toggledFunction.type.rawValue ? .white : self.viewModel.getButtonBGColor(button: item))
                                .cornerRadius((UIScreen.main.bounds.width - (5 * 12)) / 4)
                        }
                    }
                }
                
            }
        }
    }
    
    var currency: some View {
        HStack {
            Button {
                withAnimation {
                    self.toggleDropDown.toggle()
                }
            } label: {
                Text(self.viewModel.baseCurrency.rawValue)
                    .foregroundColor(.white)
                    .font(.system(size: 13))
                    .fontWeight(.semibold)
                    .padding(16)
                    
            }
            .background(.orange)
        }
        .cornerRadius(12)
    }
    
    @ViewBuilder
    var dropDown: some View {
        if self.toggleDropDown {
            HStack(spacing: 8) {
                ForEach(self.viewModel.currencyList, id: \.self) { item in
                    Button {
                        withAnimation {
                            self.toggleDropDown = false
                            self.viewModel.convertCurrency(to: item)
                        }
                    } label: {
                        HStack {
                            Text(item.rawValue)
                                .foregroundColor(.orange)
                                .font(.system(size: 13))
                                .fontWeight(.semibold)
                                .padding(16)
                        }
                    }
                }
            }
            .background(.white)
            .cornerRadius(12)
        }
    }
}

