//
//  CurrencyConverterView.swift
//  fintech-test-task
//
//  Created by Vladyslav Sabelnikov on 16.12.2024.
//

import UIKit

class CurrencyConverterView: UIView {
    
    let formatter = NumberFormatter()

    let fromTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Amount"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()

    let toTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Converted Amount"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.isUserInteractionEnabled = false
        return textField
    }()

    let fromCurrencyPicker: UIPickerView = UIPickerView()
    let toCurrencyPicker: UIPickerView = UIPickerView()

    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        fromTextField.delegate = self
        toTextField.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(fromTextField)
        addSubview(toTextField)
        addSubview(fromCurrencyPicker)
        addSubview(toCurrencyPicker)
        addSubview(activityIndicator)

        fromTextField.translatesAutoresizingMaskIntoConstraints = false
        toTextField.translatesAutoresizingMaskIntoConstraints = false
        fromCurrencyPicker.translatesAutoresizingMaskIntoConstraints = false
        toCurrencyPicker.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            fromTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            fromTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            fromTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            fromCurrencyPicker.topAnchor.constraint(equalTo: fromTextField.bottomAnchor, constant: 10),
            fromCurrencyPicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            fromCurrencyPicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            toTextField.topAnchor.constraint(equalTo: fromCurrencyPicker.bottomAnchor, constant: 20),
            toTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            toTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            toCurrencyPicker.topAnchor.constraint(equalTo: toTextField.bottomAnchor, constant: 10),
            toCurrencyPicker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            toCurrencyPicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: toCurrencyPicker.bottomAnchor, constant: 20)
        ])
    }
}

extension CurrencyConverterView: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let candidate = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        let separator = formatter.decimalSeparator!

        if candidate == "" { return true }

        let isWellFormatted = candidate.range(of: "^[0-9]{1,11}([\(separator)][0-9]{0,2})?$", options: .regularExpression) != nil

        if isWellFormatted,
            let _ = formatter.number(from: candidate)?.doubleValue {
                return true
        }

        return false
    }
}


