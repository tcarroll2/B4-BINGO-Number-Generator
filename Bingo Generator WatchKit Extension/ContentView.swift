//
//  ContentView.swift
//  Bingo Generator WatchKit Extension
//  Creative Commons Attribution 4.0 International Public License
//  Creative Commons may be contacted at creativecommons.org.
//
//  Copyright (c) 2021 Thomas Cavalli
//  Thomas Cavalli may be contacted at thomascavalli.com
//
//  List of What Changed (by Who and When):
//  Created by Thomas Cavalli on 12/2/21.
//

import SwiftUI
private var numbers: [Int] = []
struct ContentView: View {
    @State var number: Int = 4 // "before and after"
    @State var newGame: Bool = false
    @State var debounce: Bool = false
    var body: some View {
        VStack(spacing: 2.0) {
            Spacer()
            Button(numbers.isEmpty ? "Confirm New Game" : newGame ? "Confirm New Game" : "Next Number") {
                if numbers.isEmpty { newGame = true }
                if newGame {
                    numbers = Array(stride(from: 1, to: 76, by: 1)).shuffled()
                    number = numbers.popLast()!
                    newGame = false
                }else{ // next number
                    if !numbers.isEmpty {
                        number = numbers.popLast() ?? 1
                    }
                    debounce = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.debounce = false
                    }
                }
            }
            .foregroundColor(debounce ? Color.red : Color.white  )
            .disabled(debounce)
            HStack(spacing: 12.0) {
                Text(bingo())
                .font(.system(size: 55.0))
                Text("\(number)")
                .font(.system(size: 55.0))
            }
            .onTapGesture {
                if !newGame {
                    if !numbers.isEmpty {
                        number = numbers.popLast() ?? 1
                    }
                    debounce = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.debounce = false
                    }
                }
            }
            .disabled(debounce)
            Spacer()
            if !numbers.isEmpty {
                Button(newGame ? "Cancel" : "New Game") {
                    newGame.toggle()
                }
                //.foregroundColor(newGame ? Color.red : Color.white)
            }
        }
    }
        
    func bingo() -> String {
        if number < 16 { return "B" }
        if number < 31 { return "I" }
        if number < 46 { return "N" }
        if number < 61 { return "G" }
        return "O"
    }
}
/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
