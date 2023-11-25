//
//  ContentView.swift
//  PDFTableCreator
//
//  Created by Krzysztof Czura on 25/11/2023.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    @State private var words: [Word] = [
        Word(id: "1", leftPart: "hello", rightPart: "siemano"),
        Word(id: "2", leftPart: "sun", rightPart: "słońce"),
        Word(id: "3", leftPart: "moon", rightPart: "księżyc"),
        Word(id: "4", leftPart: "table", rightPart: "tabelka"),
        Word(id: "5", leftPart: "this is a long text just to check whether a cell would place it", rightPart: "a tu krótki tekst"),
        Word(id: "6", leftPart: "flower", rightPart: "kwiatek"),
        Word(id: "7", leftPart: "speak of the devil", rightPart: "o wilku mowa"),
        Word(id: "8", leftPart: "there is no rose without a thorn", rightPart: "nie ma róży bez kolców"),
        Word(id: "9", leftPart: "unconsciousness", rightPart: "nieprzytomność"),
        Word(id: "10", leftPart: "practice makes perfect", rightPart: "trening czyni mistrza"),
        Word(id: "11", leftPart: "here a short text", rightPart: "a tutaj długi tekst, żeby zobaczyć, czy komórka go pomieści"),
        Word(id: "12", leftPart: "a friend in need is a friend indeed", rightPart: "prawdziwych przyjaciół poznaje się w biedzie"),
        Word(id: "13", leftPart: "time flies", rightPart: "czas leci"),
        Word(id: "14", leftPart: "blue sky", rightPart: "niebieskie niebo"),
        Word(id: "15", leftPart: "waterfall", rightPart: "wodospad"),
        Word(id: "16", leftPart: "fireplace", rightPart: "kominek"),
        Word(id: "17", leftPart: "mountain peak", rightPart: "szczyt góry"),
        Word(id: "18", leftPart: "ocean waves", rightPart: "fale oceaniczne"),
        Word(id: "19", leftPart: "whispering wind", rightPart: "szepta wiatru"),
        Word(id: "20", leftPart: "ancient ruins", rightPart: "starożytne ruiny"),
        Word(id: "21", leftPart: "wisdom tooth", rightPart: "ząb mądrości"),
        Word(id: "22", leftPart: "stormy weather", rightPart: "burzowa pogoda"),
        Word(id: "23", leftPart: "silent night", rightPart: "cicha noc"),
        Word(id: "24", leftPart: "garden blooming", rightPart: "kwitnący ogród"),
        Word(id: "25", leftPart: "dancing flames", rightPart: "taniec płomieni"),
        Word(id: "26", leftPart: "echoing laughter", rightPart: "rozbrzmiewający śmiech"),
        Word(id: "27", leftPart: "wispy clouds", rightPart: "chmurki"),
        Word(id: "28", leftPart: "melting snow", rightPart: "topniejący śnieg"),
        Word(id: "29", leftPart: "crackling fire", rightPart: "trzaskający ogień"),
        Word(id: "30", leftPart: "cherry blossom", rightPart: "kwitnąca wiśnia"),
        Word(id: "31", leftPart: "shooting star", rightPart: "spadająca gwiazda"),
        Word(id: "32", leftPart: "enchanted forest", rightPart: "zaczarowany las"),
        Word(id: "33", leftPart: "golden sunset", rightPart: "złoty zachód"),
        Word(id: "34", leftPart: "mystic river", rightPart: "mistyczna rzeka"),
        Word(id: "35", leftPart: "rustling leaves", rightPart: "szmer liści"),
        Word(id: "36", leftPart: "butterfly wings", rightPart: "skrzydła motyla"),
        Word(id: "37", leftPart: "ancient scroll", rightPart: "starożytny zwoj"),
        Word(id: "38", leftPart: "whistling breeze", rightPart: "świszcząca bryza"),
        Word(id: "39", leftPart: "sparkling dew", rightPart: "błyszcząca rosa"),
        Word(id: "40", leftPart: "thunderous applause", rightPart: "burzliwy aplauz"),
        Word(id: "41", leftPart: "moonlit meadow", rightPart: "oświetlona księżycem łąka"),
        Word(id: "42", leftPart: "glistening snowflakes", rightPart: "błyszczące płatki śniegu"),
        Word(id: "43", leftPart: "crimson sunset", rightPart: "karmazynowy zachód"),
        Word(id: "44", leftPart: "tranquil lake", rightPart: "spokojne jezioro"),
        Word(id: "45", leftPart: "murmuring brook", rightPart: "szemrzący strumień"),
        Word(id: "46", leftPart: "whimsical clouds", rightPart: "kapryśne chmury"),
        Word(id: "47", leftPart: "serene mountain", rightPart: "spokojna góra"),
        Word(id: "48", leftPart: "flickering candle", rightPart: "migocąca świeca"),
        Word(id: "49", leftPart: "hidden treasure", rightPart: "ukryty skarb"),
        Word(id: "50", leftPart: "gentle rain", rightPart: "łagodny deszcz"),
        Word(id: "51", leftPart: "whirling dervish", rightPart: "wirowy dervisz"),
        Word(id: "52", leftPart: "crystal clear", rightPart: "kryształowo czysty"),
        Word(id: "53", leftPart: "foggy morning", rightPart: "mglisty poranek"),
        Word(id: "54", leftPart: "frosty window", rightPart: "mroźne okno"),
        Word(id: "55", leftPart: "silent footsteps", rightPart: "ciche kroki"),
        Word(id: "56", leftPart: "whispering pines", rightPart: "szeleszczące sosny"),
        Word(id: "57", leftPart: "crescent moon", rightPart: "półksiężyc"),
        Word(id: "58", leftPart: "fading twilight", rightPart: "zanikający zmrok"),
        Word(id: "59", leftPart: "frozen lake", rightPart: "zamrożone jezioro"),
        Word(id: "60", leftPart: "gossamer wings", rightPart: "delikatne skrzydła")
    ]
    
    var body: some View {
        VStack {
            Image(systemName: "newspaper.circle")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Export to PDF") {
                sharePDF()
            }
        }
        .padding()
    }
    
    func sharePDF() {
        guard let pdfData = generatePDF() else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func generatePDF() -> Data? {
        let pdfData = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(pdfData, CGRect(x: 0, y: 0, width: 595.2, height: 842.4), nil) // A4 Paper size: 21 x 29.7 cm
        
        drawTable()
        
        UIGraphicsEndPDFContext()
        
        return pdfData as Data
    }
    
    func drawTable() {
        let pageWidth: CGFloat = 595.2
        let pageHeight: CGFloat = 842.4
        let margin: CGFloat = 2.0 * 28.35 // 2 cm in points (1 cm = 28.35 points)
        let tableWidth: CGFloat = pageWidth - margin * 2
        var yForHorizontalLines = margin
        var yForTextLines: CGFloat = 61
        var currentPage = 1
        
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), nil)
        
        let cellWidth: CGFloat = (tableWidth - margin * 2) / 2
        
        // Draw the first horizontal line
        let context = UIGraphicsGetCurrentContext()!
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(0.5)
        context.move(to: CGPoint(x: margin - 0.25, y: margin))
        context.addLine(to: CGPoint(x: margin + tableWidth + 0.25, y: margin))
        context.strokePath()
        
        // Drawing horizontal lines for texts
        for row in 0..<words.count {
            if yForHorizontalLines + 20 > pageHeight - margin {
                // Move to the next page
                UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), nil)
                currentPage += 1
                yForHorizontalLines = margin
                yForTextLines = 61
                // Draw the first horizontal line on the new page
                let context = UIGraphicsGetCurrentContext()!
                context.setStrokeColor(UIColor.black.cgColor)
                context.setLineWidth(0.5)
                context.move(to: CGPoint(x: margin - 0.25, y: margin))
                context.addLine(to: CGPoint(x: margin + tableWidth + 0.25, y: margin))
                context.strokePath()
            }
            
            if words[row].leftPart.width() > 230 || words[row].rightPart.width() > 230 {
                yForHorizontalLines += 30
            } else {
                yForHorizontalLines += 20
            }
            
            context.move(to: CGPoint(x: margin - 0.25, y: yForHorizontalLines))
            context.addLine(to: CGPoint(x: margin + tableWidth + 0.25, y: yForHorizontalLines))
            context.strokePath()
            
            // Drawing three vertical lines
            for col in 0...2 {
                let x = margin + CGFloat(col) * (cellWidth + margin)
                
                context.move(to: CGPoint(x: x, y: margin))
                context.addLine(to: CGPoint(x: x, y: yForHorizontalLines))
                context.strokePath()
            }
            
            // Placing text in cells
            let xLeft = margin + CGFloat(0) * (cellWidth + margin) + 5
            let xRight = margin + CGFloat(1) * (cellWidth + margin) + 5
            
            let leftTextRect = CGRect(x: xLeft, y: yForTextLines, width: 231, height: .infinity)
            let rightTextRect = CGRect(x: xRight, y: yForTextLines, width: 231, height: .infinity)
            
            words[row].leftPart.draw(in: leftTextRect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9), NSAttributedString.Key.foregroundColor: UIColor.black])
            words[row].rightPart.draw(in: rightTextRect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9), NSAttributedString.Key.foregroundColor: UIColor.black])
            
            if words[row].leftPart.width() > 230 || words[row].rightPart.width() > 230 {
                yForTextLines += 30
            } else {
                yForTextLines += 20
            }
        }
    }
}

struct Word: Identifiable {
    let id: String
    let leftPart: String
    let rightPart: String
}

extension String {
    func width() -> CGFloat {
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: .infinity)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9)]
        let boundingRect = self.boundingRect(with: size, options: options, attributes: attributes, context: nil)
        return ceil(boundingRect.width)
    }
}
