//
//  CurrencyConverterViewController.swift
//  fintech-test-task
//
//  Created by Vladyslav Sabelnikov on 16.12.2024.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

    private let converterView = CurrencyConverterView()
    private var model = CurrencyConverterModel(fromCurrency: "EUR", toCurrency: "USD", fromAmount: 0.0)
    private var timer: Timer?

    override func loadView() {
        view = converterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        startBackgroundUpdate()
    }

    private func setupActions() {
        converterView.fromTextField.addTarget(self, action: #selector(fromAmountChanged), for: .editingChanged)
    }

    @objc private func fromAmountChanged() {
        guard let text = converterView.fromTextField.text, let amount = Double(text.replacingOccurrences(of: ",", with: ".")) else {
            return
        }

        model.fromAmount = amount
        fetchConvertedAmount()
    }

    private func fetchConvertedAmount() {
        converterView.activityIndicator.startAnimating()
        model.convert { [weak self] result in
            DispatchQueue.main.async {
                self?.converterView.activityIndicator.stopAnimating()
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


