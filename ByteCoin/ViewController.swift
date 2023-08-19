//
//  ViewController.swift
//  ByteCoin
//
//  Created by Elshad Babaev on 19.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var coinManager = CoinManager()
    
    private lazy var bitcoinLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "27000"
        label.textColor = .systemPink
        label.font = .boldSystemFont(ofSize: 36)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "USD"
        label.backgroundColor = .tertiaryLabel
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var byteCoinLabel: UILabel = {
        let label = UILabel()
        label.text = "ByteCoin"
        label.textColor = UIColor(named: "Title Color")
        label.font = .boldSystemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var currencyPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var bitcoinImage: UIImageView = {
      let image = UIImageView()
      image.contentMode = .scaleAspectFit
      image.image = UIImage(named: "bitcoin")
      image.translatesAutoresizingMaskIntoConstraints = false
      return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(byteCoinLabel)
        view.addSubview(bitcoinLabel)
        view.addSubview(currencyLabel)
        view.addSubview(currencyPicker)
        view.addSubview(bitcoinImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            byteCoinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            byteCoinLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            
            currencyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currencyLabel.topAnchor.constraint(equalTo: byteCoinLabel.bottomAnchor, constant: 30),
            currencyLabel.widthAnchor.constraint(equalToConstant: 150),
            
            
            bitcoinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bitcoinLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 25),
            bitcoinLabel.widthAnchor.constraint(equalToConstant: 250),
            
            currencyPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currencyPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            bitcoinImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bitcoinImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bitcoinImage.widthAnchor.constraint(equalToConstant: 200),
            bitcoinImage.heightAnchor.constraint(equalToConstant: 200)
            
            
            
            
        ])
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    
    func didUpdatePrice(price: String, currency: String) {
        
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - UIPickerView DataSource & Delegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}


