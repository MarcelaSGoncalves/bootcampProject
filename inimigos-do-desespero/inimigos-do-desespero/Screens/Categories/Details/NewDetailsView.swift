//
//  NewDetailsView.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 17/10/22.
//

import UIKit
import AndesUI
import MessageUI

final class NewDetailsView: UIView {
    //MARK: - Screen Objects
    private lazy var feedbackView: AndesFeedbackScreenView = generateFeedbackView()
    
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.translatesAutoresizingMaskIntoConstraints = false
        myScrollView.addSubview(contentView)
        return myScrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(attributesProductLabel)
        contentView.addSubview(subTitleProductLabel)
        contentView.addSubview(carouselImage)
        contentView.addSubview(carouselImageLabel)
        contentView.addSubview(priceProductLabel)
        contentView.addSubview(coloredButtonStackView)
        contentView.addSubview(favoritesButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(mercadoPagoLabel)
        contentView.addSubview(localizationLabel)
        contentView.addSubview(askButtonsStackView)
        contentView.addSubview(askTextField)
        contentView.addSubview(errorLabel)
        return contentView
    }()
    private lazy var attributesProductLabel: AndesLabel = {
        let label = AndesLabel(forAutoLayout: ())
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = AndesLabelColor.disabled.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subTitleProductLabel: AndesLabel = {
        let label = AndesLabel(forAutoLayout: ())
        label.setStyleAsBody(bodyConfig: (AndesLabelBodyConfig(bodySize: .bodyL, color: .Andes.graySolid070 , bodyLinks: nil, bodyBolds: nil)))
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = AndesLabelColor.primary.color
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var carouselImage: AndesCarousel = {
        let carousel = AndesCarousel()
        carousel.margin = .compactMargin
        carousel.mode = .snapped
        carousel.usePaginator = false
        return carousel
    }()
    
    private lazy var carouselImageLabel: AndesBadgePill = {
        let pill = AndesBadgePill(hierarchy: .secondary, type: .neutral, border: .standard, size: .large, text: "0/0")
        return pill
    }()
    
    private lazy var priceProductLabel: AndesMoneyAmount = {
        let label = AndesMoneyAmount(type: .positive, size: .size32, currency: .BRL, decimalStyle: .normal, amount: nil)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var coloredButtonStackView: UIStackView = {
        let coloredButtonStackView = UIStackView(arrangedSubviews: [buyButton,whatsAppButton])
        coloredButtonStackView.axis = .horizontal
        coloredButtonStackView.distribution = .fillEqually
        coloredButtonStackView.spacing = 8
        coloredButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        return coloredButtonStackView
    }()
    
    private lazy var buyButton: AndesButton = {
        let button = AndesButton(text: "Comprar", hierarchy: .loud, size: .large)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var whatsAppButton: AndesButton = {
        let buttonIcon = AndesButtonIcon(icon: UIImage(named: "whatsapp")!, orientation: .left)
        let button = AndesButton(text: "WhatsApp", hierarchy: .loud, size: .large, icon: buttonIcon)
        button.addTarget(self, action: #selector(whatsAppButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var favoritesButton: AndesButton = {
        let buttonIcon = AndesButtonIcon(icon: UIImage(systemName: "heart")!, orientation: .left)
        let button = AndesButton(text: "Adicionar aos favoritos", hierarchy: .transparent, size: .large, icon: buttonIcon)
        button.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: AndesButton = {
        let buttonIcon = AndesButtonIcon(icon: UIImage(named: "share")!, orientation: .left)
        let button = AndesButton(text: "Compartilhar", hierarchy: .transparent, size: .large, icon: buttonIcon)
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var mercadoPagoLabel: AndesTagSimple = {
        let tag = AndesTagSimple(text: "Aceitamos Mercado Pago", size: .large, type: .highlight, isDismissible: false, leftContent: nil)
        return tag
    }()
    
    private lazy var localizationLabel: AndesLabel = {
        let label = AndesLabel(forAutoLayout: ())
        label.setStyleAsBody(bodyConfig: (AndesLabelBodyConfig(bodySize: .bodyS, color: .Andes.graySolid900 , bodyLinks: nil, bodyBolds: nil)))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var askVendorButton: AndesButton = {
        let button = AndesButton(text: "Perguntar", hierarchy: .loud, size: .large)
        button.addTarget(self, action: #selector(self.askButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var callButton: AndesButton = {
        let button = AndesButton(text: "Chamar", hierarchy: .quiet, size: .large)
        button.addTarget(self, action: #selector(self.callButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var askButtonsStackView: UIStackView = {
        let askButtonsStackView = UIStackView(arrangedSubviews: [askVendorButton,callButton])
        askButtonsStackView.axis = .vertical
        askButtonsStackView.distribution = .fillEqually
        askButtonsStackView.spacing = 9
        askButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        return askButtonsStackView
    }()
    
    private lazy var askTextField: AndesTextArea = {
        let label = AndesTextArea(state: .idle, label: "Pergunte ao vendedor", helper: nil, counter: 500, placeholder: "Digite sua pergunta", maxLines: 5, helperLinks: nil, helperBolds: nil)
        return label
    }()
    
    private lazy var errorLabel: AndesLabel = {
        let label = AndesLabel(forAutoLayout: ())
        label.setStyleAsBody(bodyConfig: (AndesLabelBodyConfig(bodySize: .bodyM, color: .Andes.graySolid900 , bodyLinks: nil, bodyBolds: nil)))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .Andes.red700
        return label
    }()
    
    // MARK: - ProgressBar
    private lazy var progressBar: AndesProgressIndicatorIndeterminate = {
        let progressIndicator = AndesProgressIndicatorIndeterminate(size: .large, tint: .Andes.blueML500, accessibilityLabel: "Carregando...")
        progressIndicator.isHidden = true
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        return progressIndicator
    }()
    
    //MARK: - Properties
    var delegate: NewDetailViewDelegateProtocol?
    var productDetail: ProductDetails?
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setup()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    func setData(with productDetails: ProductDetails?, isHouse: Bool, isFavorite: Bool) {
        guard let productDetails = productDetails else {
            print("Colocar uma tela de erro aqui. Tela do robo")
            return
        }
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoritesButton.icon = AndesButtonIcon(icon: UIImage(systemName: imageName)!, orientation: .left)
        self.productDetail = productDetails
        carouselImage.dataSource = self
        setAttributesLabel(product: productDetails, isHouse: isHouse)
        subTitleProductLabel.text = productDetails.body.title
        priceProductLabel.amount = productDetails.body.price
        scrollView.isHidden = false
    }
    
    func loadingStackView(isHidden: Bool) {
        scrollView.isHidden = !isHidden
        progressBar.isHidden = isHidden
        if isHidden {
            progressBar.stopAnimation()
        } else {
            progressBar.startAnimation()
        }
    }
    
    func setAttributesLabel(product: ProductDetails, isHouse: Bool) {
        var firtAttribute: String
        var secondAttribute: String
        if isHouse {
            firtAttribute = "COVERED_AREA"
            secondAttribute = "BEDROOMS"
        } else {
            firtAttribute = "VEHICLE_YEAR"
            secondAttribute = "KILOMETERS"
        }
        let firtAttributeData = product.body.attributes.filter { $0.id.contains(firtAttribute) }
        let secondAttributeData = product.body.attributes.filter { $0.id.contains(secondAttribute) }
        if firtAttributeData.isEmpty && secondAttributeData.isEmpty {
            attributesProductLabel.text = ""
        } else if firtAttributeData.isEmpty && secondAttributeData.count > 0 {
            attributesProductLabel.text = "\(secondAttributeData[0].valueName) \(isHouse ? secondAttributeData[0].name : "")"
        } else if firtAttributeData.count > 0 && secondAttributeData.isEmpty {
            attributesProductLabel.text = "\(firtAttributeData[0].valueName)"
        } else {
            attributesProductLabel.text = "\(firtAttributeData[0].valueName) - \(secondAttributeData[0].valueName) \(isHouse ? secondAttributeData[0].name : "")"
        }
    }
    
    @objc func askButtonTapped(){
        delegate?.sendQuestion(with: askTextField.text)
    }
    
    func setErrorLabel(with text: String){
        self.errorLabel.layer.opacity = 1
        errorLabel.text = text
        self.errorLabel.layer.opacity = 1
        UIView.animate(withDuration: 2, delay: 5) {
            self.errorLabel.layer.opacity = 0
        }
    }
    
    @objc func favoritesButtonTapped() {
        Message.show(with: "Funcionalidade não implementada", type: .neutral)
    }
    
    @objc func whatsAppButtonTapped() {
        let url  = URL(string: "whatsapp://send?text=Acabou o BootCamp galera!")
        
        if let url = url {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url as URL, options: [:]) { (success) in
                    if success {
                        Message.show(with: "WhatsApp accessed successfully", type: .success)
                    } else {
                        Message.show(with: "Error accessing WhatsApp", type: .error)
                    }
                }
            }
        }
    }
    
    @objc func buyButtonTapped() {
        Message.show(with: "Funcionalidade não implementada", type: .neutral)
    }
        
    @objc func callButtonTapped() {
        let phoneNumber = "12988082435"
        if let url = URL(string: "tel://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func shareButtonTapped() {
        if let productDetail = productDetail {
            guard let url = URL(string: productDetail.body.permalink ) else { return }
            UIApplication.shared.open(url)
        }
    }

    func setTextAskTextField(with text: String) {
        askTextField.text = text
    }
}

// MARK: - AndesCarouselDataSource
extension NewDetailsView: AndesCarouselDataSource{
    func andesCarousel(_ carouselView: AndesCarousel, cellForRowAt indexPath: IndexPath) -> UIView {
        guard let productDetail = productDetail else {
            return UIImageView()
        }
        carouselImageLabel.text = ("\(indexPath.row+1)/\(productDetail.body.pictures.count)")
        let imageView = UIImageView()
        imageView.image = getImage(urlAddress: productDetail.body.pictures[indexPath.row].secureURL)
        return imageView
    }
    
    func getDataSetSize(_ carouselView: AndesCarousel) -> Int {
        guard let productDetail = productDetail else {
            return 0
        }
        return productDetail.body.pictures.count
    }
    
    func getImage(urlAddress: String) -> UIImage {
        guard let url = URL(string: urlAddress) else {
            return UIImage()
        }
        if let imageData = try? Data(contentsOf: url) {
            return UIImage(data: imageData)!
        }
        return UIImage()
    }
}

extension NewDetailsView {
    private func generateFeedbackView() -> AndesFeedbackScreenView {
        let title = "Nenhum detalhe do produto escolhido foi encontrado"
        let description = "Volte e tente novamente"
        let imageName = "error404"
        let errorScreen: AndesFeedbackScreenErrorComponent = ErrorScreen(titleMessage: title, imageName: imageName, descriptionMessage: description)
        let view = AndesFeedbackScreenFactory.createAndesFeedbackScreenError(errorComponent: errorScreen, actions: nil)
        return view
    }
    
    func setIsHiddenFeedbackView(isHidden: Bool) {
        feedbackView.isHidden = false
        loadingStackView(isHidden: true)
    }
    
    private func setupViews() {
        feedbackView.isHidden = true
        addSubview(feedbackView)
        feedbackView.autoPinEdge(.top, to: .top, of: self, withOffset: 0)
        feedbackView.autoPinEdge(.leading, to: .leading, of: self)
        feedbackView.autoPinEdge(.trailing, to: .trailing, of: self)
        feedbackView.autoPinEdge(.bottom, to: .bottom, of: self)
    }
}

// MARK: - View code protocol
extension NewDetailsView: ViewCodeProtocol {
    func setupSubViews() {
        addSubview(scrollView)
        addSubview(progressBar)
    }
    
    func setupConstraints() {
        progressBarConstraint()
        setScrollViewConstraints()
        setContentViewConstraints()
        setTitleProductLabelConstraints()
        setSubTitleLabelConstraints()
        setProductImageConstraints()
        setCarouselLabelConstrains()
        setPriceProductLabelConstraints()
        setColoredButtonStackView()
        setfavoriteButtonConstrains()
        setshareButtonConstrains()
        setMercadoPagoLabelConstraints()
        setLocalizationLabelConstraints()
        setAskButtonsStackViewConstraints()
        setAskTextFieldConstraints()
        setErrorLabelConstraints()
    }
    
    //MARK: - CONSTRAINTS
    private func progressBarConstraint() {
        progressBar.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        progressBar.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    
    private func setScrollViewConstraints() {
        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setContentViewConstraints() {
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setTitleProductLabelConstraints() {
        attributesProductLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        attributesProductLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setSubTitleLabelConstraints(){
        subTitleProductLabel.topAnchor.constraint(equalTo: attributesProductLabel.bottomAnchor, constant: 20).isActive = true
        subTitleProductLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        subTitleProductLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setProductImageConstraints() {
        carouselImage.topAnchor.constraint(equalTo: subTitleProductLabel.bottomAnchor, constant: 20).isActive = true
        carouselImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        carouselImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        carouselImage.heightAnchor.constraint(equalToConstant: 275).isActive = true
    }
    
    private func setCarouselLabelConstrains() {
        carouselImageLabel.topAnchor.constraint(equalTo: carouselImage.topAnchor, constant: 20).isActive = true
        carouselImageLabel.leadingAnchor.constraint(equalTo: carouselImage.leadingAnchor, constant: 20).isActive = true
        
    }
    
    private func setPriceProductLabelConstraints() {
        priceProductLabel.topAnchor.constraint(equalTo: carouselImage.bottomAnchor, constant: 24).isActive = true
        priceProductLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setColoredButtonStackView(){
        coloredButtonStackView.topAnchor.constraint(equalTo: priceProductLabel.bottomAnchor, constant: 16).isActive = true
        coloredButtonStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9).isActive = true
        coloredButtonStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9).isActive = true
    }
    
    private func setfavoriteButtonConstrains() {
        favoritesButton.topAnchor.constraint(equalTo: coloredButtonStackView.bottomAnchor, constant: 32).isActive = true
        favoritesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    }
    
    private func setshareButtonConstrains() {
        shareButton.topAnchor.constraint(equalTo: coloredButtonStackView.bottomAnchor, constant: 32).isActive = true
        shareButton.leadingAnchor.constraint(equalTo: favoritesButton.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setMercadoPagoLabelConstraints(){
        mercadoPagoLabel.topAnchor.constraint(equalTo: favoritesButton.bottomAnchor, constant: 32).isActive = true
        mercadoPagoLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setLocalizationLabelConstraints(){
        localizationLabel.topAnchor.constraint(equalTo: mercadoPagoLabel.bottomAnchor, constant: 18).isActive = true
        localizationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setErrorLabelConstraints(){
        errorLabel.topAnchor.constraint(equalTo: askTextField.bottomAnchor, constant: -16).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -78).isActive = true
    }
    
    private func setAskTextFieldConstraints(){
        askTextField.topAnchor.constraint(equalTo: mercadoPagoLabel.bottomAnchor, constant: 32).isActive = true
        askTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        askTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setAskButtonsStackViewConstraints(){
        askButtonsStackView.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 24).isActive = true
        askButtonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        askButtonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        askButtonsStackView.heightAnchor.constraint(equalToConstant: 105).isActive = true
        askButtonsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setupExtraConfiguration() { }
}
