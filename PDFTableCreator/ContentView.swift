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
        Word(id: "12", leftPart: "a friend in need is a friend indeed", rightPart: "prawdziwych przyjaciół poznaje się w biedzie")
    ]
    
    var body: some View {
        VStack {
            Image(systemName: "newspaper.circle")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Export to PDF") {
                exportToPDF()
            }
        }
        .padding()
    }
    
    func exportToPDF() {
        let pdfData = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(pdfData, CGRect(x: 0, y: 0, width: 595.2, height: 842.4), nil) // A4 Paper size: 21 x 29.7 cm
        
        drawTable()
        
        UIGraphicsEndPDFContext()
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pdfURL = documentsDirectory.appendingPathComponent("ExportedPDF.pdf")
            pdfData.write(to: pdfURL, atomically: true)
            print("PDF saved to: \(pdfURL)")
        }
    }
    
    func drawTable() {
        let pageWidth: CGFloat = 595.2
        let pageHeight: CGFloat = 842.4
        let margin: CGFloat = 2.0 * 28.35 // 2 cm in points (1 cm = 28.35 points)
        let tableWidth: CGFloat = pageWidth - margin * 2
        var yForHorizontalLines = margin
        var yForTextLines: CGFloat = 61
        
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), nil)
        
        let context = UIGraphicsGetCurrentContext()!
        let cellWidth: CGFloat = (tableWidth - margin * 2) / 2
        
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(0.5)
        
        // draw the first horizontal line
        context.move(to: CGPoint(x: margin - 0.25, y: margin))
        context.addLine(to: CGPoint(x: margin + tableWidth + 0.25, y: margin))
        context.strokePath()
        
        
        // Drawing horizontal lines for texts
        for row in 0...words.count - 1 {
            
            if words[row].leftPart.width() > 225 || words[row].rightPart.width() > 225 {
                yForHorizontalLines += 40
            } else {
                yForHorizontalLines += 20
            }
            
            context.move(to: CGPoint(x: margin - 0.25, y: yForHorizontalLines))
            context.addLine(to: CGPoint(x: margin + tableWidth + 0.25, y: yForHorizontalLines))
            context.strokePath()
        }
        
        // Drawing three vertical lines
        for col in 0...2 {
            let x = margin + CGFloat(col) * (cellWidth + margin)
            
            context.move(to: CGPoint(x: x, y: margin))
            context.addLine(to: CGPoint(x: x, y: yForHorizontalLines))
            context.strokePath()
        }
        
        
        // Placing text in cells
        for (index, item) in words.enumerated() {
            let xLeft = margin + CGFloat(0) * (cellWidth + margin) + 5
            let xRight = margin + CGFloat(1) * (cellWidth + margin) + 5
            
            let leftTextRect = CGRect(x: xLeft, y: yForTextLines, width: cellWidth - margin + 100, height: .infinity)
            let rightTextRect = CGRect(x: xRight, y: yForTextLines, width: cellWidth - margin + 100, height: .infinity)
            
            item.leftPart.draw(in: leftTextRect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9), NSAttributedString.Key.foregroundColor: UIColor.black])
            item.rightPart.draw(in: rightTextRect, withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9), NSAttributedString.Key.foregroundColor: UIColor.black])
            
            if words[index].leftPart.width() > 225 || words[index].rightPart.width() > 225 {
                yForTextLines += 40
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
