//
//  ViewController.swift
//  ColorsSpotify v1
//  Get spotify song analyse and use the values in a image.
//
//  Created by Quinten Bast - PRQJECT on 17/03/2019.
//  Copyright © 2019 Quinten Bast - PRQJECT. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var UIImageViewTwo: UIImageView!
    
    var nameSong = ""
    
    var valence = 0.000
    var danceability = 0.000
    var energy = 0.000
    var tempo = 0.000
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
    }
    
    private func configureTextFields() {
        textField.delegate = self
    }
    
    
    func getJsonData() {
        // Get URL for JSON Data
       let url = NSURL(string: "http://desiqner.com/spotify/getdata.php?track_id=\(nameSong)")
        
        if url != nil {
            
            let task = URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) -> Void in
                //print(data as Any)
                
                if error == nil {
                    
                    let urlContent = NSString(data: data!, encoding: String.Encoding.ascii.rawValue) as NSString?
                    
                    let data = urlContent!.data(using: String.Encoding.utf8.rawValue)!
                    
                    
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Dictionary<String, Any>
                        {
                            print(jsonArray);
                            
                            // Get data from JSON File
                            self.valence = (jsonArray["valence"] as? NSNumber)?.doubleValue ?? 0
                            
                            self.danceability = (jsonArray["danceability"] as? NSNumber)?.doubleValue ?? 0

                            self.energy = (jsonArray["energy"] as? NSNumber)?.doubleValue ?? 0
                            
                            self.tempo = (jsonArray["tempo"] as? NSNumber)?.doubleValue ?? 0
                            
                            
                            // Draw the "art"
                            DispatchQueue.main.async {
                                self.drawLines()
                                self.drawLinesTwo()
                            }
                            
                        } else {
                            
                            print("Json not found")
                            
                        }
                        
                    } catch let error as NSError {
                        
                        print(error)
                    }
                }
            })
            task.resume()
        }
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        // If button is pressed, take the value in textField and read de function getJsonData.
        nameSong = textField.text!
        getJsonData()
        
    }
    
    func drawLinesTwo() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 324, height: 640))
        
        
        let imgTwo = renderer.image { ctxTwo in

            
            ctxTwo.cgContext.move(to: CGPoint(x: 85, y: 50))
            ctxTwo.cgContext.addLine(to: CGPoint(x: 85, y: tempo * 3.5))
        
            
            ctxTwo.cgContext.move(to: CGPoint(x: 185, y: 50))
            ctxTwo.cgContext.addLine(to: CGPoint(x: 185, y: tempo * 3.5))
            
            
            ctxTwo.cgContext.move(to: CGPoint(x: 285, y: 50))
            ctxTwo.cgContext.addLine(to: CGPoint(x: 285, y: tempo * 3.5))
            
            
            // Give line width based on danceability variable
            if (0.750...1.000).contains(danceability){
                ctxTwo.cgContext.setLineWidth(1)
            }
                
            else if (0.600...0.750).contains(danceability) {
                ctxTwo.cgContext.setLineWidth(10)
            }
                
            else if (0.450...0.600).contains(danceability) {
                ctxTwo.cgContext.setLineWidth(20)
            }
                
            else if (0.300...0.450).contains(danceability) {
                ctxTwo.cgContext.setLineWidth(30)
            }
                
            else if (0.150...0.300).contains(danceability) {
                ctxTwo.cgContext.setLineWidth(40)
            }
                
            else if danceability < 0.150 {
                ctxTwo.cgContext.setLineWidth(49)
            }
            
            
            
            
            // Give color to elements based on valence variable
            if (0.750...1.000).contains(valence) {
                ctxTwo.cgContext.setStrokeColor(red: 1.0, green: 1.0, blue: 0.00, alpha: CGFloat(energy)) // Yellow
            }
                
            else if (0.600...0.750).contains(valence) {
                ctxTwo.cgContext.setStrokeColor(red: 0.0, green: 0.2, blue: 1.0, alpha: CGFloat(energy)) // Blue
            }
                
            else if (0.450...0.600).contains(valence) {
                ctxTwo.cgContext.setStrokeColor(red: 0.0, green: 0.75, blue: 0.75, alpha: CGFloat(energy)) // Turquose
            }
                
            else if (0.300...0.450).contains(valence) {
                ctxTwo.cgContext.setStrokeColor(red: 0.8, green: 0.6, blue: 0.5, alpha: CGFloat(energy)) // Tan/Beige
            }
                
            else if (0.150...0.300).contains(valence) {
                ctxTwo.cgContext.setStrokeColor(red: 0.7, green: 0.5, blue: 0.3, alpha: CGFloat(energy)) // Brown
            }
                
            else if valence < 0.150 {
                ctxTwo.cgContext.setStrokeColor(red: 0.4, green: 0.4, blue: 0.4, alpha: CGFloat(energy)) // Gray
            }
            
            ctxTwo.cgContext.strokePath()
        }
        
        UIImageViewTwo.image = imgTwo
    }
    
    
    func drawLines() {

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 324, height: 640))
        

        let img = renderer.image { ctx in

            ctx.cgContext.move(to: CGPoint(x: 35, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 35, y: tempo * 3.5))

            
            ctx.cgContext.move(to: CGPoint(x: 135, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 135, y: tempo * 3.5))
            
           
            ctx.cgContext.move(to: CGPoint(x: 235, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 235, y: tempo * 3.5))
            
            
            // Give line width based on danceability variable
            if (0.750...1.000).contains(danceability){
                ctx.cgContext.setLineWidth(1)
            }
            
            else if (0.600...0.750).contains(danceability) {
                ctx.cgContext.setLineWidth(10)
            }
            
            else if (0.450...0.600).contains(danceability) {
                ctx.cgContext.setLineWidth(20)
            }
            
            else if (0.300...0.450).contains(danceability) {
                ctx.cgContext.setLineWidth(30)
            }
            
            else if (0.150...0.300).contains(danceability) {
                ctx.cgContext.setLineWidth(40)
            }
                
            
            else if danceability < 0.150 {
                ctx.cgContext.setLineWidth(49)
            }

            // Give color to elements based on valence variable
            if (0.750...1.000).contains(valence) {
                ctx.cgContext.setStrokeColor(red: 1.0, green: 0.5, blue: 0.0, alpha: CGFloat(energy)) // Orange
            }
                
            else if (0.600...0.750).contains(valence) {
                ctx.cgContext.setStrokeColor(red: 1.0, green: 0.0, blue: 0.45, alpha: CGFloat(energy)) // Pink
            }
                
            else if (0.450...0.600).contains(valence) {
                ctx.cgContext.setStrokeColor(red: 0.0, green: 1.0, blue: 0.0, alpha: CGFloat(energy)) // Green
            }
            
            else if (0.300...0.450).contains(valence) {
                ctx.cgContext.setStrokeColor(red: 0.5, green: 0.0, blue: 1.0, alpha: CGFloat(energy)) // Purple
            }
                
            else if (0.150...0.300).contains(valence) {
                ctx.cgContext.setStrokeColor(red: 1.0, green: 0.0, blue: 0.0, alpha: CGFloat(energy)) // Red
            }
            
            else if valence < 0.150 {
                ctx.cgContext.setStrokeColor(red: 0.5, green: 0.3, blue: 0.1, alpha: CGFloat(energy)) // Brown
            }
            
            ctx.cgContext.strokePath()
        }
        
        imageView.image = img
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
