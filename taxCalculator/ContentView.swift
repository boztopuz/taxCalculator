//
//  ContentView.swift
//  taxCalculator
//
//  Created by Burak Öztopuz on 4.06.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var araçBedeli = 0.0
    @State private var vergisizBedel = 0
    @State private var ötvBedeli = 0
    @State private var motorHacmi = "1600cc"
//    @State private var kdvBedeli = 0.0
    
    let ötvYüzdeListesi = [45.0,130.0,220.0]
    let araçMotorHacmi = ["1600cc'e kadar", "1601-2000cc arası", "2000cc ve üzeri"]
    
    var hamBedel: Double {
        var vergisiz = Double(vergisizBedel)
        let bedel = Double(araçBedeli)
        
        if motorHacmi == araçMotorHacmi[0]{
            let finalResult = (bedel * 100) / (100 + ötvYüzdeListesi[0])
            vergisiz = finalResult
            return vergisiz
        }else if motorHacmi == araçMotorHacmi[1]{
            let finalResult = (bedel * 100) / (100 + ötvYüzdeListesi[1])
            vergisiz = finalResult
            return vergisiz
        }
        
        let finalResult = (bedel * 100) / (100 + ötvYüzdeListesi[2])
        vergisiz = finalResult
        return vergisiz
    }
    
    var ötvTutatı : Double {
        let vergiMiktarı = araçBedeli - hamBedel
        return vergiMiktarı
    }
    
    var kdvBedeli: Double {
        let kdv = ötvTutatı + (araçBedeli * 18 / 100)
        return kdv
    }
    
    var kdvTutarı : Double {
        let vergiMiktarı = araçBedeli - kdvBedeli
        return vergiMiktarı
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Araç Bedeli", value: $araçBedeli, format: .currency(code: Locale.current.currencyCode ?? "TRY"))
                        .keyboardType(.decimalPad)
                    
                    Picker("Motor Hacmi", selection: $motorHacmi) {
                        ForEach(araçMotorHacmi, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                }header: {
                    Text("Araç bedeli")
                }
                
                Section{
                    Text(hamBedel, format: .currency(code: Locale.current.currencyCode ?? "TRY"))
                }header: {
                    Text("ÖTV hariç araç Fiyatı")
                }
                Section{
                    Text(ötvTutatı, format: .currency(code: Locale.current.currencyCode ?? "TRY"))
                }header: {
                    Text("Ötv tutarı")
                }
                Section{
                    Text(kdvBedeli, format: .currency(code: Locale.current.currencyCode ?? "TRY"))
                }header: {
                    Text("KDV Hariç Araç Fiyatı")
                }
                Section{
                    Text(kdvTutarı, format: .currency(code: Locale.current.currencyCode ?? "TRY"))
                }header: {
                    Text("KDV tutarı")
                }
            }
            .navigationTitle(Text("Vergi Hesapla"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
