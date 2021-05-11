//
//  ContentView.swift
//  HolaSwift
//
//  Created by René Zelada on 4/30/21.
//

import SwiftUI

struct ContentView: View {
    
    let x = "Mi boton"
    @State private var show = false
    var body: some View {
        Button(action: {show = true}) {
            Text(x)
        }.alert(isPresented: $show, content: {
            Alert(title: Text("titulo"), message: Text("mensaje aqui"), dismissButton: .default(Text("Aceptar")))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
