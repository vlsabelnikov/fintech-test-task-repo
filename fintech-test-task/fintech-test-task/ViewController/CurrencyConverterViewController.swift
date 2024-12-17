//
//  CurrencyConverterViewController.swift
//  fintech-test-task
//
//  Created by Vladyslav Sabelnikov on 16.12.2024.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

    private let converterView = CurrencyConverterView()
    private var model = CurrencyConverterModel(fromCurrency: "EUR", toCurrency: "USD", fromAmount: 1.0)
    private var timer: Timer?
    private let formatter = NumberFormatter()

    override func loadView() {
        view = converterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupListeners()
        setupDefaultValues()
        startBackgroundUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    private func setupActions() {
        converterView.fromTextField.addTarget(self, action: #selector(fromAmountChanged), for: .editingChanged)
    }
    
    private func setupListeners() {
        converterView.fromCurrencyPicker.delegate = self
        converterView.fromCurrencyPicker.dataSource = self
        converterView.toCurrencyPicker.delegate = self
        converterView.toCurrencyPicker.dataSource = self
        converterView.fromTextField.delegate = self
    }
    
    private func setupDefaultValues() {
        converterView.fromCurrencyPicker.selectRow(0, inComponent: 0, animated: false)
        converterView.toCurrencyPicker.selectRow(1, inComponent: 0, animated: false)
        converterView.fromCurrencyField.text = Currency.EUR.rawValue
        converterView.toCurrencyField.text = Currency.USD.rawValue
        converterView.fromTextField.text = "1"
        fromAmountChanged()
    }

    @objc private func fromAmountChanged() {
        guard let text = converterView.fromTextField.text, let amount = Double(text.replacingOccurrences(of: ",", with: ".")) else {
            converterView.toTextField.text = "0.00"
            model.fromAmount = 0
            return
        }

        model.fromAmount = amount
        fetchConvertedAmount()
    }

    private func fetchConvertedAmount() {
        //converterView.activityIndicator.startAnimating()
        model.convert { [weak self] result in
            DispatchQueue.main.async {
                //self?.converterView.activityIndicator.stopAnimating()
                switch result {
                case .success(let convertedAmount):
                    self?.converterView.toTextField.text = String(format: "%.2f", convertedAmount)
                case .failure(let error):
                    self?.showErrorAlert(error: error)
                }
            }
        }
    }

    private func showErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func startBackgroundUpdate() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
            self?.fetchConvertedAmount()
        }
    }

    deinit {
        timer?.invalidate()
    }
}

extension CurrencyConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - UIPickerView DataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Currency.allCurrencies.count
    }

    // MARK: - UIPickerView Delegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Currency.allCurrencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = Currency.allCurrencies[row]

        if pickerView == converterView.fromCurrencyPicker {
            model.fromCurrency = selectedCurrency
            converterView.fromCurrencyField.text = selectedCurrency
        } else if pickerView == converterView.toCurrencyPicker {
            model.toCurrency = selectedCurrency
            converterView.toCurrencyField.text = selectedCurrency
        }
        fetchConvertedAmount()
    }
}

extension CurrencyConverterViewController: UITextFieldDelegate {

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
