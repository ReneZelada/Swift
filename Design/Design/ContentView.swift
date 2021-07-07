//
//  ContentView.swift
//  Design
//
//  Created by René Zelada on 6/15/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeclass
    var body: some View {
        if sizeclass == .compact{
            compactDesign()
        }else{
            regularDesign()
        }
    }
}

struct compactDesign: View {
    
    let numero = "12345678"
    let mensaje = "Hola mundo"
    
    
    func sendMessage(){
        let sms = "sms:\(numero)&body=\(mensaje)"
        guard let stringSMS = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)else {return}
        UIApplication.shared.open(URL.init(string: stringSMS)!, options: [:],completionHandler: nil)
    }
    func sendCall(){
        guard let number = URL(string: "tel://\(numero)")else {return}
        UIApplication.shared.open(number)
    }
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            HStack{
                Image(systemName: "person.crop.circle").font(.largeTitle).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                VStack(alignment: .leading, spacing: 10){
                    Text("Nombre").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white).bold()
                    Text("Telefono").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white).bold()
                    
                }
                VStack{
                    Button(action:{
                        sendCall()
                    }){
                    Image(systemName: "phone.fill").modifier(boton())
                    }
                Button(action:{
                    sendMessage()
                }){
                Image(systemName: "message.fill").modifier(boton())
                }
                    
                }
            }
        }
    }
    
}

struct boton : ViewModifier {
    func body(content : Content) -> some View {
            content
                .padding().background(Color.blue).clipShape(Circle()).foregroundColor(.white).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    }
}

struct regularDesign: View {
    var body: some View {
        ZStack{
            Color.blue.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            HStack{
                Image("Rando_App_Logo").resizable().frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                VStack(alignment: .leading, spacing: 10){
                    Text("Nombre").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white).bold()
                    Text("Telefono").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.white).bold()
                    
                }
            }
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
