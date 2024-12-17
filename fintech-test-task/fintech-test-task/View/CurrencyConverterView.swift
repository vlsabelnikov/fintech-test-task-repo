//
//  CurrencyConverterView.swift
//  fintech-test-task
//
//  Created by Vladyslav Sabelnikov on 16.12.2024.
//

import UIKit

class CurrencyConverterView: UIView {
    
    // MARK: - UI Elements
    let backgroundContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBlue
        view.layer.cornerRadius = 20
        return view
    }()
    
    let fromContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.25)
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 5
        return view
    }()
    
    let toContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.25)
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 5
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Currency Converter"
        label.textColor = .white
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 0.3
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.masksToBounds = false
        return label
    }()
    
    let fromTextField: UITextField = {
        let textField = StaticTextField()
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
        let textField = StaticTextField()
        textField.placeholder = "USD"
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 42, weight: .bold)
        textField.isUserInteractionEnabled = true
        textField.keyboardType = .decimalPad
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
        let textField = StaticTextField()
        textField.placeholder = "EUR"
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 42, weight: .bold)
        textField.isUserInteractionEnabled = true
        textField.keyboardType = .decimalPad
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
        backgroundContainer.addSubview(titleLabel)
        backgroundContainer.addSubview(fromContainer)
        backgroundContainer.addSubview(toContainer)
        fromContainer.addSubview(fromTextField)
        fromContainer.addSubview(fromCurrencyField)
        fromContainer.addSubview(fromSeparator)
        toContainer.addSubview(toTextField)
        toContainer.addSubview(toCurrencyField)
        toContainer.addSubview(toSeparator)
        backgroundContainer.addSubview(swapButton)
    }
    private func setupConstraints() {
        backgroundContainer.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        fromContainer.translatesAutoresizingMaskIntoConstraints = false
        toContainer.translatesAutoresizingMaskIntoConstraints = false
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
            
            //Title Label
            titleLabel.topAnchor.constraint(equalTo: backgroundContainer.topAnchor, constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            // From Container
            fromContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            fromContainer.leadingAnchor.constraint(equalTo: backgroundContainer.leadingAnchor, constant: 20),
            fromContainer.trailingAnchor.constraint(equalTo: backgroundContainer.trailingAnchor, constant: -20),
            
            
            fromTextField.topAnchor.constraint(equalTo: fromContainer.topAnchor, constant: 30),
            fromTextField.leadingAnchor.constraint(equalTo: fromContainer.leadingAnchor, constant: 20),
            fromTextField.trailingAnchor.constraint(equalTo: fromContainer.trailingAnchor, constant: -20),
            fromTextField.heightAnchor.constraint(equalToConstant: 60),
            
            fromSeparator.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 5),
            fromSeparator.leadingAnchor.constraint(equalTo: fromContainer.leadingAnchor, constant: 40),
            fromSeparator.trailingAnchor.constraint(equalTo: fromContainer.trailingAnchor, constant: -40),
            fromSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            fromCurrencyField.topAnchor.constraint(equalTo: fromSeparator.bottomAnchor, constant: 15),
            fromCurrencyField.leadingAnchor.constraint(equalTo: fromContainer.leadingAnchor),
            fromCurrencyField.trailingAnchor.constraint(equalTo: fromContainer.trailingAnchor),
            fromCurrencyField.bottomAnchor.constraint(equalTo: fromContainer.bottomAnchor, constant: -30),
            fromCurrencyField.heightAnchor.constraint(equalToConstant: 44),
            
            // To Container
            toContainer.topAnchor.constraint(equalTo: fromContainer.bottomAnchor, constant: 20),
            toContainer.leadingAnchor.constraint(equalTo: fromContainer.leadingAnchor),
            toContainer.trailingAnchor.constraint(equalTo: fromContainer.trailingAnchor),
            
            toTextField.topAnchor.constraint(equalTo: toContainer.topAnchor, constant: 30),
            toTextField.leadingAnchor.constraint(equalTo: toContainer.leadingAnchor),
            toTextField.trailingAnchor.constraint(equalTo: toContainer.trailingAnchor),
            toTextField.heightAnchor.constraint(equalToConstant: 60),
            
            toSeparator.topAnchor.constraint(equalTo: toTextField.bottomAnchor, constant: 5),
            toSeparator.leadingAnchor.constraint(equalTo: toContainer.leadingAnchor, constant: 40),
            toSeparator.trailingAnchor.constraint(equalTo: toContainer.trailingAnchor, constant: -40),
            toSeparator.heightAnchor.constraint(equalToConstant: 1),
            
            toCurrencyField.topAnchor.constraint(equalTo: toSeparator.bottomAnchor, constant: 15),
            toCurrencyField.leadingAnchor.constraint(equalTo: toContainer.leadingAnchor),
            toCurrencyField.trailingAnchor.constraint(equalTo: toContainer.trailingAnchor),
            toCurrencyField.bottomAnchor.constraint(equalTo: toContainer.bottomAnchor, constant: -30),
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


