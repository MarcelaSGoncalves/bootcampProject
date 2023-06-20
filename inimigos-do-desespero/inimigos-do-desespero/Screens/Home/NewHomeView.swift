//
//  HomeView.swift
//  inimigos-do-desespero
//
//  Created by Luciano Da Silva Berchon on 18/10/22.
//

import Foundation
import UIKit
import AndesUI

final class NewHomeView: UIView {
    // MARK: - Screen Object
    private lazy var scrollView: UIScrollView = {
        let myScrollView = UIScrollView()
        myScrollView.translatesAutoresizingMaskIntoConstraints = false
        myScrollView.addSubview(contentView)
        return myScrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.layer.insertSublayer(contentGradientLayer, at: 0)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(carousel)
        contentView.addSubview(sendFreeStackView)
        contentView.addSubview(buttonsStackView)
        contentView.addSubview(bannerViewCard)
        contentView.addSubview(recentlyViewCard)
        contentView.addSubview(promoOfDayCard)
        return contentView
    }()
    
    private lazy var userLocationLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .Andes.yellowML500
        label.text = " Enviar para José Maria - Rua Tietê, nº 234"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private lazy var userLocationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mapin")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var userLocationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userLocationImage, userLocationLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 7)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 0.0, alpha: 1.0)
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var carousel: AndesCarousel = {
        let carousel = AndesCarousel()
        carousel.margin = .defaultMargin
        carousel.mode = .snapped
        carousel.usePaginator = false
        carousel.dataSource = self
        return carousel
    }()
    
    private lazy var sendFreeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sendFreeImageView, sendFreeLabel, sendFree2Label])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.layer.cornerRadius = 6
        stackView.backgroundColor = .white
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 7
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var sendFreeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sendFree")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var sendFreeLabel: UILabel = {
        let label = UILabel()
        label.text = "Envio Gratis"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(red: 0.0, green: 0.65, blue: 0.31, alpha: 1.0)
        return label
    }()
    
    private lazy var sendFree2Label: UILabel = {
        let label = UILabel()
        label.text = "em milhões de produtos a partir de R$ 120 "
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var carButton: UIButton = {
        let button = createButton(withImageName: "car")
        button.addTarget(self, action: #selector(carButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cycleButton: UIButton = {
        let button = createButton(withImageName: "cycle")
        button.addTarget(self, action: #selector(cycleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var busButton: UIButton = {
        let button = createButton(withImageName: "truck")
        button.addTarget(self, action: #selector(busButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var propertyButton: UIButton = {
        let button = createButton(withImageName: "property")
        button.addTarget(self, action: #selector(propertyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = createButton(withImageName: "plus")
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var carLabel: UILabel = {
        return createLabel(with: "Carros")
    }()
    
    private lazy var cycleLabel: UILabel = {
        return createLabel(with: "Motos")
    }()
    
    private lazy var truckLabel: UILabel = {
        return createLabel(with: "Caminhões")
    }()
    
    private lazy var propertyLabel: UILabel = {
        return createLabel(with: "Imóveis")
    }()
    
    private lazy var plusLabel: UILabel = {
        return createLabel(with: "Ver mais")
    }()
    
    private lazy var carStackView: UIStackView = {
        return createVerticalStackView(with: carButton, label: carLabel)
    }()
    
    private lazy var cycleStackView: UIStackView = {
        return createVerticalStackView(with: cycleButton, label: cycleLabel)
    }()
    
    private lazy var truckStackView: UIStackView = {
        return createVerticalStackView(with: busButton, label: truckLabel)
    }()
    
    private lazy var propertyStackView: UIStackView = {
        return createVerticalStackView(with: propertyButton, label: propertyLabel)
    }()
    
    private lazy var plusStackView: UIStackView = {
        return createVerticalStackView(with: plusButton, label: plusLabel)
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let subViews = [carStackView, cycleStackView, truckStackView, propertyStackView, plusStackView]
        let stackView = UIStackView(arrangedSubviews: [carStackView, cycleStackView, truckStackView, propertyStackView, plusStackView])
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var bannerViewCard: UIView = {
        let view = AndesCard(cardView: bannerCardView(imageView: bannerImageView))
        view.setLinkAction("Ver mais") { card in
            Message.show(with: "Funcionalidade não implementada", type: .neutral)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bannerImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "banner")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var bannerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "  S U M M E R  V I B E S"
        label.numberOfLines = 0
        label.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary, font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: 16), lineSpacing: 1))
        return label
    }()
    
    private lazy var bannerSubTitle: UILabel = {
        let label = UILabel()
        label.text = "  O VERÃO VEM AÍ"
        label.numberOfLines = 0
        label.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary, font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 20), lineSpacing: 1))
        return label
    }()
    
    private lazy var recentlyViewCard: UIView = {
        let view = AndesCard(cardView: cardView(imageView: recentlyViewImageView), title: "Visto Recentemente", padding: .small, hierarchy: .primary, style: .elevated, type: .none)
        view.setLinkAction("Ver histórico de navegação") { card in
            Message.show(with: "Funcionalidade não implementada", type: .neutral)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var recentlyViewImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "tenis")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var recentlyViewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tênis esportivo Adidas feminino"
        label.numberOfLines = 0
        label.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary, font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: 14), lineSpacing: 1))
        return label
    }()
    
    private lazy var recentlyViewPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "R$ 259,00"
        label.numberOfLines = 1
        label.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary, font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 20), lineSpacing: 1))
        return label
    }()
    
    private lazy var recentlyViewSendFreeLabel: UILabel = {
        let label = UILabel()
        label.text = "Frete Grátis"
        label.numberOfLines = 1
        label.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.feedbackColorPositive, font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 12),lineSpacing: 1))
        return label
    }()
    
    private lazy var promoOfDayCard: UIView = {
        let view = AndesCard(cardView: secondCardView(imageView: promoOfDayImageView), title: "Oferta do dia", padding: .small, hierarchy: .primary, style: .elevated, type: .none)
        view.setLinkAction("Ver todas as ofertas do dia") { card in
            Message.show(with: "Funcionalidade não implementada", type: .neutral)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var promoOfDayImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "iphone")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var promoOfDayTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Iphone 13 256gb preto"
        label.numberOfLines = 0
        label.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary, font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: 14), lineSpacing: 1))
        return label
    }()
    
    private lazy var promoOfDayPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "R$ 6.599,98"
        label.numberOfLines = 1
        label.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary, font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 20),lineSpacing: 1))
        return label
    }()
    
    private lazy var promoOfDayParcelLabel: UILabel = {
        let label = UILabel()
        label.text = "12x R$549,00"
        label.numberOfLines = 1
        label.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.feedbackColorPositive, font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: 12), lineSpacing: 1))
        return label
    }()
    
    private lazy var promoOfDaySendFreeLabel: UILabel = {
        let label = UILabel()
        label.text = "Frete Grátis"
        label.numberOfLines = 1
        label.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.feedbackColorPositive, font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 14),lineSpacing: 1))
        return label
    }()
    
    //MARK: - Properties
    var delegate: NewHomeViewDelegateProtocol?
    private let images: [UIImage] = {
        let image1 = UIImage(named: "1") ?? UIImage()
        let image2 = UIImage(named: "2") ?? UIImage()
        let image3 = UIImage(named: "3") ?? UIImage()
        let image4 = UIImage(named: "4") ?? UIImage()
        let images: [UIImage] = [image1, image2, image3, image4]
        return images
    }()
    
    private lazy var contentGradientLayer: CAGradientLayer = {
        let colorTop = CGColor(red: 0.997, green: 0.859, blue: 0.080, alpha: 1)
        let colorBottom = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.15, 0.26]
        return gradientLayer
    }()
    
    private lazy var viewGradientLayer: CAGradientLayer = {
        let colorTop =  CGColor(red: 0.997, green: 0.859, blue: 0.080, alpha: 1)
        let colorBottom = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.49, 0.5]
        return gradientLayer
    }()
    
    //MARK: - Inicialização
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentGradientLayer.frame = contentView.bounds
        viewGradientLayer.frame = bounds
    }
    
    // MARK: - Methods
    @objc private func carButtonTapped() {
        delegate?.go(to: .car)
    }
    
    @objc private func cycleButtonTapped() {
        delegate?.go(to: .cycle)
    }
    
    @objc private func busButtonTapped() {
        delegate?.go(to: .truck)
    }
    
    @objc private func propertyButtonTapped() {
        delegate?.go(to: .property)
    }
    
    @objc private func plusButtonTapped() {
        Message.show(with: "Funcionalidade não implementada", type: .neutral)
    }
    
    private func createButton(withImageName imageName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.tintColor = .gray
        button.layer.cornerRadius = 28
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createVerticalStackView(with button: UIButton, label: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [button, label])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func bannerCardView(imageView: UIImageView) -> UIView {
        let view = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackViewVertical = UIStackView(arrangedSubviews: [bannerTitleLabel, bannerSubTitle])
        stackViewVertical.axis = .vertical
        stackViewVertical.distribution = .fillEqually
        stackViewVertical.spacing = 10
        
        let stackViewHorizontal = UIStackView(arrangedSubviews: [stackViewVertical, bannerImageView])
        stackViewHorizontal.axis = .horizontal
        stackViewHorizontal.distribution = .fillEqually
        stackViewHorizontal.alignment = .top
        stackViewHorizontal.spacing = 20
        
        view.addSubview(stackViewHorizontal)
        stackViewHorizontal.pinTo(view: view)
        
        return view
    }
    
    private func cardView(imageView: UIImageView) -> UIView {
        let view = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        let verticalStackView = UIStackView(arrangedSubviews: [recentlyViewTitleLabel, recentlyViewPriceLabel, recentlyViewSendFreeLabel])
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 2
        
        let stackView = UIStackView(arrangedSubviews: [recentlyViewImageView, verticalStackView])
        stackView.axis = .horizontal
        stackView.spacing = 30
        
        view.addSubview(stackView)
        stackView.pinTo(view: view)
        
        return view
    }
    
    private func secondCardView(imageView: UIImageView) -> UIView {
        let view = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 180),
        ])
        
        let stackView = UIStackView(arrangedSubviews: [promoOfDayTitleLabel, promoOfDayPriceLabel, promoOfDayParcelLabel, promoOfDaySendFreeLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 6
        
        let stackView2 = UIStackView(arrangedSubviews: [promoOfDayImageView, stackView])
        stackView2.axis = .vertical
        stackView2.distribution = .fill
        stackView2.spacing = 10
        
        view.addSubview(stackView2)
        stackView2.pinTo(view: view)
        
        return view
    }
}

// MARK: - View code protocol
extension NewHomeView: ViewCodeProtocol {
    func setupSubViews() {
        layer.insertSublayer(viewGradientLayer, at: 0)
        addSubview(scrollView)
        addSubview(userLocationStackView)
    }
    
    func setupConstraints() {
        setScrollViewConstraints()
        setContentViewConstraints()
        setUserLocationStackConstraints()
        setCarouselConstraints()
        setSendFreeStackViewConstraints()
        setButtonsStackViewConstraints()
        setCarButtonConstraints()
        setCycleButtonConstraints()
        setBusButtonConstraints()
        setPropertyButtonConstraints()
        setPlusButtonConstraints()
        setBannerViewCardConstraints()
        setRecentlyViewConstraints()
        setPromoOfDayCardConstraints()
    }
    
    //MARK: - Constraints
    private func setButtonsStackViewConstraints() {
        buttonsStackView.topAnchor.constraint(equalTo: sendFreeStackView.bottomAnchor, constant: 16).isActive = true
        buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setScrollViewConstraints() {
        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: userLocationLabel.topAnchor, constant: 36).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setContentViewConstraints() {
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setUserLocationStackConstraints() {
        userLocationStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        userLocationStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        userLocationStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        userLocationStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setCarouselConstraints() {
        carousel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22).isActive = true
        carousel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        carousel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        carousel.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
    }
    private func setSendFreeStackViewConstraints() {
        sendFreeStackView.topAnchor.constraint(equalTo: carousel.bottomAnchor, constant: 5).isActive = true
        sendFreeStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        sendFreeStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setCarButtonConstraints() {
        carButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        carButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    private func setCycleButtonConstraints() {
        cycleButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        cycleButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    private func setBusButtonConstraints() {
        busButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        busButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    private func setPropertyButtonConstraints() {
        propertyButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        propertyButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    private func setPlusButtonConstraints() {
        plusButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    private func setBannerViewCardConstraints() {
        bannerViewCard.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: 20).isActive = true
        bannerViewCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        bannerViewCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        bannerViewCard.heightAnchor.constraint(equalTo: bannerViewCard.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setRecentlyViewConstraints() {
        recentlyViewCard.topAnchor.constraint(equalTo: bannerViewCard.bottomAnchor, constant: 20).isActive = true
        recentlyViewCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        recentlyViewCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setPromoOfDayCardConstraints() {
        promoOfDayCard.topAnchor.constraint(equalTo: recentlyViewCard.bottomAnchor, constant: 20).isActive = true
        promoOfDayCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        promoOfDayCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        promoOfDayCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    func setupExtraConfiguration() {
    }
}

extension NewHomeView: AndesCarouselDataSource{
    func andesCarousel(_ carouselView: AndesCarousel, cellForRowAt indexPath: IndexPath) -> UIView {
        let imageView = UIImageView()
        imageView.image = images[indexPath.row]
        return imageView
    }
    func getDataSetSize(_ carouselView: AndesCarousel) -> Int {
        return images.count
    }
}
