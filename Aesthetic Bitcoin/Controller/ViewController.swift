//
//  ViewController.swift
//  Aesthetic Bitcoin
//
//  Created by Nitish Dash on 09/02/18.
//  Copyright © 2018 Nitish Dash. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension UIView {
    func addDashedBorder() {
        let color = UIColor.darkGray.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width-15, height: frameSize.height-15)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = kCALineJoinBevel
        shapeLayer.lineDashPattern = [8,4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 1).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var currencyTitle: UILabel!
    @IBOutlet weak var currencySymbol: UILabel!
    @IBOutlet weak var btcTicker: UILabel!
    @IBOutlet weak var btcHigh: UILabel!
    @IBOutlet weak var btcLow: UILabel!
    @IBOutlet weak var flagIcon: UILabel!
    @IBOutlet weak var currencySegmentedControl: UISegmentedControl!
    
    let API_ENDPOINT = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    var currencyModel = CurrencyModel()
    public var numberOfActiveView = UInt(1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in view.subviews {
            if (view.restorationIdentifier == "bottomCard") {
                print("view found");
                view.addDashedBorder()
            }
        }
        
        getBitcoinData(url: API_ENDPOINT, currency: currencySegmentedControl.selectedSegmentIndex)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    func getBitcoinData(url: String, currency: Int) {
        //currency converter
        currencyModel.currencyTag = currency
        currencyModel.currencyFinal = currencyModel.currencySwitcher(tag: currencyModel.currencyTag)[0]
        
        let finalUrl = API_ENDPOINT + currencyModel.currencyFinal
        
        Alamofire.request(finalUrl, method: .get).responseJSON {
            response in //a closure - a function within another function
            if response.result.isSuccess {
                
                print("Successfully connected to server")
                
                let bitcoinJSON : JSON = JSON(response.result.value!)
                
                print(bitcoinJSON)
                self.updateUIComponents(jsonData: bitcoinJSON)
                
            }
            else {
                print("Error fetching data: \(response.result.error)")
//                self.cityLabel.text = "Error"
            }
            
        }
        
    }
    
    func updateUIComponents(jsonData: JSON) {
        
        let bidPrice : Double = jsonData["bid"].doubleValue
        //formatting the price value and confining it to 2 decimal places
        let priceText = String(format: "%.2f", bidPrice) // "3.14"
        
        //change bitcoin price in ticker label
        btcTicker.fadeTransition(0.5)
        btcTicker.text = priceText
        
        //change highest and lowest textlabels
        let highestPrice = jsonData["high"].doubleValue
        let lowestPrice = jsonData["low"].doubleValue
        btcHigh.text = "\(highestPrice) 🔺"
        btcLow.text = "\(lowestPrice) 🔻"
        
        
        //set currency symbol
        let currencySym = currencyModel.currencySwitcher(tag: currencyModel.currencyTag)[1]
        currencySymbol.text = currencySym
        
        //set currency title in second card
        currencyTitle.text = currencyModel.currencySwitcher(tag: currencyModel.currencyTag)[2]
        
        flagIcon.text = currencyModel.flagSwitcher(tag: currencyModel.currencyTag)
        
    }
    
    
    @IBAction func priceChanged(_ sender: Any) {
        
        getBitcoinData(url: API_ENDPOINT, currency: currencySegmentedControl.selectedSegmentIndex)
        
    }
    
    
    
    
    @IBOutlet weak var refreshButton: UIButton!
    
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        
        getBitcoinData(url: API_ENDPOINT, currency: currencySegmentedControl.selectedSegmentIndex)
        
    }
    
}

// Usage: insert view.fadeTransition right before changing content
extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionMoveIn
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionMoveIn)
    }
}
