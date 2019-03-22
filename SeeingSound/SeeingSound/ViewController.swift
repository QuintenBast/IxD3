//
//  ViewController.swift
//  ColorsSpotify v1
//  Get spotify song analyse and use the values in a image.
//
//  Created by Quinten Bast - PRQJECT on 17/03/2019.
//  Copyright © 2019 Quinten Bast - PRQJECT. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var nameSong = ""
    
    var valence = 0.000
    var danceability = 0.000
    var energy = 0.000


    
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
                            
                            
                            // Draw the "art"
                            DispatchQueue.main.async {
                                self.drawLines()
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
    
    func drawLines() {

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 324, height: 593))
        
        
        let img = renderer.image { ctx in

            ctx.cgContext.move(to: CGPoint(x: 0, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 0, y: 593))
            
            ctx.cgContext.setLineWidth(1000)
            
            // Give color to elements with valence variable
            if valence > 0.900 {
                ctx.cgContext.setStrokeColor(red: 1.0, green: 0.5, blue: 0.0, alpha: CGFloat(energy)) // Orange
            }
                
            else if (0.600...0.750).contains(valence) {
                ctx.cgContext.setStrokeColor(red: 1.0, green: 0.0, blue: 0.45, alpha: CGFloat(energy)) // Pink
            }
                
            else if (0.450...0.600).contains(valence) {
                ctx.cgContext.setStrokeColor(red: 0.0, green: 1.0, blue: 0.0, alpha: CGFloat(energy)) // Green
            }
            
            else if (0.300...0.450).contains(valence) {
                ctx.cgContext.setStrokeColor(red: 0.5, green: 0.0, blue: 8.0, alpha: CGFloat(energy)) // Purple
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
