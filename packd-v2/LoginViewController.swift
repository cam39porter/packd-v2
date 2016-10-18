//
//  LoginViewController.swift
//  packd-v2
//
//  Created by Cameron Porter on 10/16/16.
//  Copyright © 2016 Cameron Porter. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    // START: View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubViews()
    }
    
    private func setupSubViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(coverView)
        view.addSubview(inputContainerView)
        
        inputContainerView.addSubview(packdLabel)
        inputContainerView.addSubview(emailTextField)
        emailTextField.delegate = self
        inputContainerView.addSubview(passwordTextField)
        passwordTextField.delegate = self
        view.addSubview(loginButton)
        
        _ = backgroundImageView.anchorAll(top: view.topAnchor,
                                      left: view.leftAnchor,
                                      bottom: view.bottomAnchor,
                                      right: view.rightAnchor,
                                      topConstant: 0,
                                      leftConstant: 0,
                                      bottomConstant: 0,
                                      rightConstant: 0,
                                      widthConstant: 0,
                                      heightConstant: 0)
        
        _ = coverView.anchorAll(top: view.topAnchor,
                                          left: view.leftAnchor,
                                          bottom: view.bottomAnchor,
                                          right: view.rightAnchor,
                                          topConstant: 0,
                                          leftConstant: 0,
                                          bottomConstant: 0,
                                          rightConstant: 0,
                                          widthConstant: 0,
                                          heightConstant: 0)
        
        packdLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        packdLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        packdLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        packdLabel.bottomAnchor.constraint(equalTo: inputContainerView.centerYAnchor, constant: 0).isActive = true
        
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        inputContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        inputContainerView.rightAnchor.constraint(equalTo:  view.rightAnchor, constant: 0).isActive = true
        inputContainerView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 2).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -Size.oneFinger).isActive = true
        
        emailTextField.centerXAnchor.constraint(equalTo: inputContainerView.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputContainerView.centerYAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width - Size.oneFinger * 3).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Size.minPadding).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: inputContainerView.centerXAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: Size.oneFinger).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width - Size.oneFinger * 3).isActive = true
        
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Size.oneFinger).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: Size.oneFinger * 2).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: Size.oneFinger * 2).isActive = true
    }
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "friends_bg"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let coverView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.8
        return view
    }()
    
    let inputContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let packdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textColor = Colors.contrast.withAlphaComponent(0.8)
        label.font = Fonts.boldFont(ofSize: 90)
        label.textAlignment = .center
        label.text = "PACKD"
        return label
    }()
    
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter email"
        textField.textColor = Colors.contrast
        textField.backgroundColor = Colors.background.withAlphaComponent(0.5)
        textField.layer.borderColor = Colors.highlight.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let passwordTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = Colors.contrast
        textField.backgroundColor = Colors.background.withAlphaComponent(0.5)
        textField.layer.borderColor = Colors.highlight.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.highlight
        button.setTitle("Login", for: .normal)
        button.setTitleColor(Colors.contrast, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Size.oneFinger
        return button
    }()
    // END: View
    
    // START: Text Field Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)

    }
    // END: Text Field Delegate
}

class LeftPaddedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
}
