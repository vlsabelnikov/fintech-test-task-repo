//
//  CurrencyConverterView.swift
//  fintech-test-task
//
//  Created by Vladyslav Sabelnikov on 16.12.2024.
//

import UIKit

import UIKit

class CurrencyConverterView: UIView {
    
    // MARK: - UI Elements
    let backgroundContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        view.layer.cornerRadius = 20
        return view
    }()
    
    let fromTextField: UITextField = {
        let textField = UITextField()
        textField.text = "120.00"
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 48, weight: .bold)
        textField.textAlignment = .center
        textField.isUserInteractionEnabled = true
        textField.keyboardType = .decimalPad
        textField.inputAccessoryView = CurrencyConverterView.createPickerToolbar()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter Amount",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        return textField
    }()
    
    let fromCurrencyPicker: UIPickerView = {
            let picker = UIPickerView()
            picker.backgroundColor = .white
            picker.layer.masksToBounds = true
            return picker
    }()

    let fromCurrencyField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "USD"
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 42, weight: .bold)
        textField.isUserInteractionEnabled = true
        textField.inputView = UIPickerView()
        textField.inputAccessoryView = CurrencyConverterView.createPickerToolbar()
        textField.textColor = .white
        return textField
    }()
    
    let fromSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.5)
        return view
    }()
    
    let toTextField: UITextField = {
        let textField = UITextField()
        textField.text = "133.70"
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 48, weight: .bold)
        textField.textAlignment = .center
        textField.isUserInteractionEnabled = false
        textField.adjustsFontSizeToFitWidth = true
        textField.inputAccessoryView = CurrencyConverterView.createPickerToolbar()
        return textField
    }()
    
    let toCurrencyPicker: UIPickerView = {
            let picker = UIPickerView()
            picker.backgroundColor = .white
            picker.layer.masksToBounds = true
            return picker
    }()

    let toCurrencyField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "EUR"
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 42, weight: .bold)
        textField.isUserInteractionEnabled = true
        textField.inputView = UIPickerView()
        textField.inputAccessoryView = CurrencyConverterView.createPickerToolbar()
        textField.textColor = .white
        return textField
    }()
    
    let toSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.5)
        return view
    }()
    
    let swapButton: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "arrow.down")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.systemBackground
        setupSubviews()
        setupConstraints()
        configurePickers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(backgroundContainer)
        backgroundContainer.addSubview(fromTextField)
        backgroundContainer.addSubview(fromCurrencyField)
        backgroundContainer.addSubview(fromSeparator)
        backgroundContainer.addSubview(swapButton)
        backgroundContainer.addSubview(toTextField)
        backgroundContainer.addSubview(toCurrencyField)
        backgroundContainer.addSubview(toSeparator)
    }
    private func setupConstraints() {
            backgroundContainer.translatesAutoresizingMaskIntoConstraints = false
            fromTextField.translatesAutoresizingMaskIntoConstraints = false
            fromCurrencyField.translatesAutoresizingMaskIntoConstraints = false
            fromSeparator.translatesAutoresizingMaskIntoConstraints = false
            swapButton.translatesAutoresizingMaskIntoConstraints = false
            toTextField.translatesAutoresizingMaskIntoConstraints = false
            toCurrencyField.translatesAutoresizingMaskIntoConstraints = false
            toSeparator.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                // Background Container
                backgroundContainer.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                backgroundContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                backgroundContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                backgroundContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
                
                // From TextField
                fromTextField.topAnchor.constraint(equalTo: backgroundContainer.topAnchor, constant: 100),
                fromTextField.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: 20),
                fromTextField.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -20),
                fromTextField.heightAnchor.constraint(equalToConstant: 60),
                
                fromSeparator.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 5),
                fromSeparator.leadingAnchor.constraint(equalTo: fromTextField.leadingAnchor, constant: 40),
                fromSeparator.trailingAnchor.constraint(equalTo: fromTextField.trailingAnchor, constant: -40),
                fromSeparator.heightAnchor.constraint(equalToConstant: 1),
                
                fromCurrencyField.topAnchor.constraint(equalTo: fromSeparator.bottomAnchor, constant: 10),
                fromCurrencyField.leadingAnchor.constraint(equalTo: fromTextField.leadingAnchor),
                fromCurrencyField.trailingAnchor.constraint(equalTo: fromTextField.trailingAnchor),
                fromCurrencyField.heightAnchor.constraint(equalToConstant: 44),
                
                // Swap Button
                swapButton.centerXAnchor.constraint(equalTo: backgroundContainer.centerXAnchor),
                swapButton.topAnchor.constraint(equalTo: fromCurrencyField.bottomAnchor, constant: 20),
                swapButton.widthAnchor.constraint(equalToConstant: 112),
                swapButton.heightAnchor.constraint(equalToConstant: 56),
                
                // To TextField
                toTextField.topAnchor.constraint(equalTo: swapButton.bottomAnchor, constant: 20),
                toTextField.leadingAnchor.constraint(equalTo: fromTextField.leadingAnchor),
                toTextField.trailingAnchor.constraint(equalTo: fromTextField.trailingAnchor),
                toTextField.heightAnchor.constraint(equalToConstant: 60),
                
                toSeparator.topAnchor.constraint(equalTo: toTextField.bottomAnchor, constant: 5),
                toSeparator.leadingAnchor.constraint(equalTo: toTextField.leadingAnchor, constant: 40),
                toSeparator.trailingAnchor.constraint(equalTo: toTextField.trailingAnchor, constant: -40),
                toSeparator.heightAnchor.constraint(equalToConstant: 1),
                
                toCurrencyField.topAnchor.constraint(equalTo: toSeparator.bottomAnchor, constant: 10),
                toCurrencyField.leadingAnchor.constraint(equalTo: toTextField.leadingAnchor),
                toCurrencyField.trailingAnchor.constraint(equalTo: toTextField.trailingAnchor),
                toCurrencyField.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
    private func configurePickers() {
        fromCurrencyField.inputView = fromCurrencyPicker
        toCurrencyField.inputView = toCurrencyPicker
    }
    
    private static func createPickerToolbar() -> UIToolbar {
            let toolbar = UIToolbar()
        toolbar.backgroundColor = .white
            toolbar.sizeToFit()
            
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: #selector(donePressed))
            
            toolbar.setItems([doneButton], animated: false)
            return toolbar
        }

        @objc private func donePressed() {
            endEditing(true)
        }
}


