//
//  CustomSwitch.swift
//  customSwitch
//
//  Created by Rustem Manafov on 13.01.23.
//

import UIKit

@IBDesignable
class CustomSwitch: UIView {
    
    private let yellowColor = UIColor(red: 0.99, green: 0.65, blue: 0.35, alpha: 1.00)
    private let purpleColor = UIColor(red: 0.34, green: 0.20, blue: 0.33, alpha: 1.00)
    
    private var bgView: UIView!
    private var stackView: UIStackView!
    private var circleCenterX: NSLayoutConstraint!
    private var onLabel: UILabel!
    private var offLabel: UILabel!
    private var circleView: UIView!
    
    @IBInspectable
    public var isOn: Bool = false
    
    override func draw(_ rect: CGRect) {
        clipsToBounds = false
        
        createBG()
        
        createStackView()
        
        createLabels()
        
        createCircle()
        
        createButton()
        
        super.draw(rect)
    }
    
    func createBG() {
        bgView = UIView()
        
        if isOn {
            bgView.backgroundColor = yellowColor.withAlphaComponent(0.1)
        } else {
            bgView.backgroundColor = purpleColor.withAlphaComponent(0.1)
        }
        
        bgView.clipsToBounds = true
        bgView.layer.cornerRadius = 15
        
        self.addSubview(bgView)
        
        bgView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: bgView!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: bgView!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: bgView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 54).isActive = true
        NSLayoutConstraint(item: bgView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30).isActive = true
    }
    
    func createStackView() {
        stackView = UIStackView()
        stackView.spacing = 6
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.backgroundColor = .clear
        
        bgView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: stackView!, attribute: .centerX, relatedBy: .equal, toItem: bgView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: stackView!, attribute: .centerY, relatedBy: .equal, toItem: bgView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: stackView!, attribute: .width, relatedBy: .equal, toItem: bgView, attribute: .width, multiplier: 1, constant: -16).isActive = true
        NSLayoutConstraint(item: stackView!, attribute: .height, relatedBy: .lessThanOrEqual, toItem: bgView, attribute: .height, multiplier: 1, constant: 0).isActive = true
    }
    
    func createLabels() {
        onLabel = UILabel()
        onLabel.text = "On"
        
        if isOn {
            onLabel.textColor = yellowColor
        } else {
            onLabel.textColor = purpleColor
        }
        
        onLabel.font = .systemFont(ofSize: 10)
        
        stackView.addArrangedSubview(onLabel)
        
        offLabel = UILabel()
        offLabel.text = "Off"
        
        if isOn {
            onLabel.textColor = yellowColor
        } else {
            onLabel.textColor = purpleColor
        }
        
        offLabel.font = .systemFont(ofSize: 10)
        
        stackView.addArrangedSubview(offLabel)
    }
    
    func createCircle() {
        circleView = UIView()
        
        if isOn {
            circleView.backgroundColor = yellowColor
        } else {
            circleView.backgroundColor = purpleColor
        }
        
        circleView.layer.cornerRadius = 11
        
        if isOn {
            circleView.layer.shadowColor = yellowColor.cgColor
        } else {
            circleView.layer.shadowColor = purpleColor.cgColor
        }
        
        circleView.layer.shadowRadius = 6
        circleView.layer.shadowOpacity = 0.5
        
        if isOn {
            circleView.layer.shadowOffset = CGSize(width: 2, height: 3)
        } else {
            circleView.layer.shadowOffset = CGSize(width: -2, height: 3)
        }
        
        bgView.addSubview(circleView)
        
        circleView.translatesAutoresizingMaskIntoConstraints = false
        
        if isOn {
            circleCenterX = NSLayoutConstraint(item: circleView!, attribute: .centerX, relatedBy: .equal, toItem: bgView, attribute: .centerX, multiplier: 1, constant: 11)
        } else {
            circleCenterX = NSLayoutConstraint(item: circleView!, attribute: .centerX, relatedBy: .equal, toItem: bgView, attribute: .centerX, multiplier: 1, constant: -11)
        }
        circleCenterX.isActive = true
        
        NSLayoutConstraint(item: circleView!, attribute: .centerY, relatedBy: .equal, toItem: bgView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: circleView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 22).isActive = true
        NSLayoutConstraint(item: circleView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 22).isActive = true
    }
    
    func createButton() {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        bgView.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: bgView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: bgView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: bgView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: bgView, attribute: .height, multiplier: 1, constant: 0).isActive = true
    }
    
    @objc func buttonPressed(_ sender: Any) {
        if isOn {
            self.circleCenterX.constant = -11
            
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.layoutIfNeeded()
                self.bgView.backgroundColor = self.purpleColor.withAlphaComponent(0.1)
                self.circleView.backgroundColor = self.purpleColor
                self.onLabel.textColor = self.purpleColor
                self.offLabel.textColor = self.purpleColor
                self.circleView.layer.shadowColor = self.purpleColor.cgColor
                self.circleView.layer.shadowOffset = CGSize(width: -2, height: 3)
            } completion: { _ in
                self.isOn = false
            }
        } else {
            self.circleCenterX.constant = 11
            
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.layoutIfNeeded()
                self.bgView.backgroundColor = self.yellowColor.withAlphaComponent(0.1)
                self.circleView.backgroundColor = self.yellowColor
                self.onLabel.textColor = self.yellowColor
                self.offLabel.textColor = self.yellowColor
                self.circleView.layer.shadowColor = self.yellowColor.cgColor
                self.circleView.layer.shadowOffset = CGSize(width: 2, height: 3)
            } completion: { _ in
                self.isOn = true
            }
        }
    }
    
    
    
}

