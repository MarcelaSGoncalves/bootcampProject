//
//  NewTableViewCell.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 17/10/22.
//

import Foundation
import UIKit
import AndesUI

final class NewTableViewCell: UITableViewCell {
    // MARK: - Screen objects

    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 18
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.alpha = 0.7
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: AndesLabel = {
        let label = AndesLabel(forAutoLayout: ())
        label.setStyleAsBody(bodyConfig: (AndesLabelBodyConfig(bodySize: .bodyM, color: .systemBlue , bodyLinks: nil, bodyBolds: nil)))
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var priceLabel: AndesMoneyAmount = {
        let label = AndesMoneyAmount(type: .positive, size: .size18, currency: .BRL, decimalStyle: .normal, amount: nil)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var attributesLabel: AndesLabel = {
        let label = AndesLabel(forAutoLayout: ())
        label.setStyleAsBody(bodyConfig: (AndesLabelBodyConfig(bodySize: .bodyL, andesColor: .disabled, bodyLinks: nil, bodyBolds: nil)))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var addressLabel: AndesLabel = {
        let label = AndesLabel(forAutoLayout: ())
        label.setStyleAsBody(bodyConfig: (AndesLabelBodyConfig(bodySize: .bodyM, andesColor: .disabled , bodyLinks: nil, bodyBolds: nil)))
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    //MARK: - Properties
    var delegate: NewTableViewCellDelegateProtocol?
    private var indexOfThisCell = Int()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    func setCell(with product: Product, in index: Int, isFavorite: Bool, isHouse: Bool) {
        indexOfThisCell = index
        var image: UIImage?
        if isFavorite {
            image = UIImage(systemName: "heart.fill")
        } else {
            image = UIImage(systemName: "heart")
        }
        setAttributesLabel(product: product, isHouse: isHouse)
        setAddressLabel(product: product)
        favoriteButton.setImage(image, for: .normal)
        getImage(urlAddress: product.thumbnail)
        titleLabel.text = product.title
        priceLabel.amount = product.price
    }
    
    func setAddressLabel(product: Product){
        let address = "\(product.location.addressLine) \(product.location.neighborhood.name)"
        let cidade = product.location.city.name
        let estado = product.location.state.name
        let pais = product.location.country.name
        let addressArray = [address,cidade,estado,pais]
        addressLabel.text = addressArray.reduce("") { $0 + ($1.trimmingCharacters(in: .whitespaces).isEmpty ? "" : "\($1) - ")}
        addressLabel.text?.removeLast(2)
    }
    
    func setAttributesLabel(product: Product, isHouse: Bool) {
        var firtAttribute: String
        var secondAttribute: String
        if isHouse {
            firtAttribute = "COVERED_AREA"
            secondAttribute = "BEDROOMS"
        } else {
            firtAttribute = "VEHICLE_YEAR"
            secondAttribute = "KILOMETERS"
        }
        let firtAttributeData = product.attributes.filter { $0.id.contains(firtAttribute) }
        let secondAttributeData = product.attributes.filter { $0.id.contains(secondAttribute) }
        if firtAttributeData.isEmpty && secondAttributeData.isEmpty {
            attributesLabel.text = ""
        } else if firtAttributeData.isEmpty && secondAttributeData.count > 0 {
            attributesLabel.text = "\(secondAttributeData[0].valueName) \(isHouse ? secondAttributeData[0].name : "")"
        } else if firtAttributeData.count > 0 && secondAttributeData.isEmpty {
            attributesLabel.text = "\(firtAttributeData[0].valueName)"
        } else {
            attributesLabel.text = "\(firtAttributeData[0].valueName) - \(secondAttributeData[0].valueName) \(isHouse ? secondAttributeData[0].name : "")"
        }
    }
    
    func getImage(urlAddress: String) {
        if let imageData = CacheManager.retrieveData(urlAddress) {
            self.productImageView.image = UIImage(data: imageData)
            return
        }
        
        guard let url = URL(string: urlAddress) else {
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            if error == nil && data != nil {
                CacheManager.saveData(urlAddress, data!)
                DispatchQueue.main.async{
                    self.productImageView.image = UIImage(data: data!)
                }
            }
        }
        dataTask.resume()
    }
    
    @objc func favoriteButtonTapped() {
        delegate?.favoriteProduct(with: indexOfThisCell)
    }
}

// MARK: - View code protocol
extension NewTableViewCell: ViewCodeProtocol {
    func setupSubViews() {
        addSubview(productImageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(attributesLabel)
        addSubview(addressLabel)
        contentView.addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        productImageViewConstraints()
        favoriteButtonConstraints()
        titleLabelConstraints()
        priceLabelConstraints()
        attributesLabelContraints()
        addressLabelConstraints()
    }
    
    private func productImageViewConstraints(){
        productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14).isActive = true
        productImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        productImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
    }
    
    private func favoriteButtonConstraints(){
        favoriteButton.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 24).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -6).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 29).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 29).isActive = true
    }
    
    private func titleLabelConstraints(){
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 11).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    private func priceLabelConstraints(){
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16).isActive = true
    }
    
    private func attributesLabelContraints(){
        attributesLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        attributesLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16).isActive = true
    }
    private func addressLabelConstraints(){
        addressLabel.topAnchor.constraint(equalTo: attributesLabel.bottomAnchor, constant: 10).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        addressLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    func setupExtraConfiguration() { }
}
