//
//  CheckoutViewController.swift
//  Standard Integration (Swift)
//
//  Created by Ben Guo on 4/22/16.
//  Copyright © 2016 Stripe. All rights reserved.
//

import UIKit
import Stripe
import Firebase

class CheckoutViewController: UIViewController, STPPaymentContextDelegate {

    // 1) To get started with this demo, first head to https://dashboard.stripe.com/account/apikeys
    // and copy your "Test Publishable Key" (it looks like pk_test_abcdef) into the line below.
    let stripePublishableKey = "pk_test_vZfVdD7sa2pNVbE4H0RM0IyO"
    
    // 2) Next, optionally, to have this demo save your user's payment details, head to
    // https://github.com/stripe/example-ios-backend , click "Deploy to Heroku", and follow
    // the instructions (don't worry, it's free). Replace nil on the line below with your
    // Heroku URL (it looks like https://blazing-sunrise-1234.herokuapp.com ).
    let backendBaseURL: String? = "https://boiling-escarpment-31183.herokuapp.com"

    // 3) Optionally, to enable Apple Pay, follow the instructions at https://stripe.com/docs/mobile/apple-pay
    // to create an Apple Merchant ID. Replace nil on the line below with it (it looks like merchant.com.yourappname).
    let appleMerchantID: String? = nil
    
    // These values will be shown to the user when they purchase with Apple Pay.
    let companyName = "Cinematic Payment"
    let paymentCurrency = "usd"

    let paymentContext: STPPaymentContext

    let theme: STPTheme
    let paymentRow: CheckoutRowView
    let shippingRow: CheckoutRowView
    let totalRow: CheckoutRowView
    let buyButton: BuyButton
    let rowHeight: CGFloat = 44
    let ticketInfo = UILabel()
    let seatInfo = UILabel()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let numberFormatter: NumberFormatter
    let shippingString: String
    var paymentInProgress: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                if self.paymentInProgress {
                    self.activityIndicator.startAnimating()
                    self.activityIndicator.alpha = 1
                    self.buyButton.alpha = 0
                }
                else {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                    self.buyButton.alpha = 1
                }
                }, completion: nil)
        }
    }
    
    var ref: DatabaseReference!
    var selectedMovie = Movie()
    var selectedCinema = Cinema()
    var selectedDate = String()
    var selectedTime = String()

    init(ticketInfo: String, seatInfo: String, price: Int, settings: Settings, movie: Movie, cinema: Cinema, date: String, time: String) {

        let stripePublishableKey = self.stripePublishableKey
        let backendBaseURL = self.backendBaseURL

        assert(stripePublishableKey.hasPrefix("pk_"), "You must set your Stripe publishable key at the top of CheckoutViewController.swift to run this app.")
        assert(backendBaseURL != nil, "You must set your backend base url at the top of CheckoutViewController.swift to run this app.")

        self.ticketInfo.text = ticketInfo
        self.seatInfo.text = seatInfo
        self.theme = settings.theme
        self.selectedMovie = movie
        self.selectedCinema = cinema
        self.selectedDate = date
        self.selectedTime = time
        MyAPIClient.sharedClient.baseURLString = self.backendBaseURL

        // This code is included here for the sake of readability, but in your application you should set up your configuration and theme earlier, preferably in your App Delegate.
        let config = STPPaymentConfiguration.shared()
        config.publishableKey = self.stripePublishableKey
        config.appleMerchantIdentifier = self.appleMerchantID
        config.companyName = self.companyName
        config.requiredBillingAddressFields = settings.requiredBillingAddressFields
        config.requiredShippingAddressFields = settings.requiredShippingAddressFields
        config.shippingType = settings.shippingType
        config.additionalPaymentMethods = settings.additionalPaymentMethods

        // Create card sources instead of card tokens
        //config.createCardSources = true;

        let customerContext = STPCustomerContext(keyProvider: MyAPIClient.sharedClient)
        let paymentContext = STPPaymentContext(customerContext: customerContext,
                                               configuration: config,
                                               theme: settings.theme)
        let userInformation = STPUserInformation()
        paymentContext.prefilledInformation = userInformation
        paymentContext.paymentAmount = price
        paymentContext.paymentCurrency = self.paymentCurrency

        let paymentSelectionFooter = PaymentContextFooterView(text: "You can add custom footer views to the payment selection screen.")
        paymentSelectionFooter.theme = settings.theme
        paymentContext.paymentMethodsViewControllerFooterView = paymentSelectionFooter

        let addCardFooter = PaymentContextFooterView(text: "You can add custom footer views to the add card screen.")
        addCardFooter.theme = settings.theme
        paymentContext.addCardViewControllerFooterView = addCardFooter

        self.paymentContext = paymentContext

        self.paymentRow = CheckoutRowView(title: "Payment", detail: "Select Payment",
                                          theme: settings.theme)
        var shippingString = "Contact"
        if config.requiredShippingAddressFields?.contains(.postalAddress) ?? false {
            shippingString = config.shippingType == .shipping ? "Shipping" : "Delivery"
        }
        self.shippingString = shippingString
        self.shippingRow = CheckoutRowView(title: self.shippingString,
                                           detail: "Enter \(self.shippingString) Info",
                                           theme: settings.theme)
        self.totalRow = CheckoutRowView(title: "Total", detail: "", tappable: false,
                                        theme: settings.theme)
        self.buyButton = BuyButton(enabled: true, theme: settings.theme)
        var localeComponents: [String: String] = [
            NSLocale.Key.currencyCode.rawValue: self.paymentCurrency,
        ]
        localeComponents[NSLocale.Key.languageCode.rawValue] = NSLocale.preferredLanguages.first
        let localeID = NSLocale.localeIdentifier(fromComponents: localeComponents)
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: localeID)
        numberFormatter.numberStyle = .currency
        numberFormatter.usesGroupingSeparator = true
        self.numberFormatter = numberFormatter
        super.init(nibName: nil, bundle: nil)
        self.paymentContext.delegate = self
        paymentContext.hostViewController = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.view.backgroundColor = self.theme.primaryBackgroundColor
        var red: CGFloat = 0
        self.theme.primaryBackgroundColor.getRed(&red, green: nil, blue: nil, alpha: nil)
        self.activityIndicator.activityIndicatorViewStyle = red < 0.5 ? .white : .gray
        self.navigationItem.title = "Cinematic Payment"

        self.ticketInfo.font = UIFont.systemFont(ofSize: 18)
        self.seatInfo.font = UIFont.italicSystemFont(ofSize: 16)
        self.seatInfo.textColor = .gray
        self.view.addSubview(self.totalRow)
        self.view.addSubview(self.paymentRow)
        self.view.addSubview(self.shippingRow)
        self.view.addSubview(self.ticketInfo)
        self.view.addSubview(self.seatInfo)
        self.view.addSubview(self.buyButton)
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.alpha = 0
        self.buyButton.addTarget(self, action: #selector(didTapBuy), for: .touchUpInside)
        self.totalRow.detail = self.numberFormatter.string(from: NSNumber(value: Float(self.paymentContext.paymentAmount)/100))!
        self.paymentRow.onTap = { [weak self] in
            self?.paymentContext.pushPaymentMethodsViewController()
        }
        self.shippingRow.onTap = { [weak self]  in
            self?.paymentContext.pushShippingViewController()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var insets = UIEdgeInsets.zero
        if #available(iOS 11.0, *) {
            insets = view.safeAreaInsets
        }
        let width = self.view.bounds.width - (insets.left + insets.right)
        self.ticketInfo.sizeToFit()
        self.ticketInfo.center = CGPoint(x: width/2.0, y: self.ticketInfo.bounds.height/2.0 + rowHeight + 80)
        self.seatInfo.sizeToFit()
        self.seatInfo.center = CGPoint(x: width/2.0, y: ticketInfo.frame.maxY + 15)
        self.paymentRow.frame = CGRect(x: insets.left, y: self.seatInfo.frame.maxY + rowHeight, width: width, height: rowHeight)
        self.shippingRow.frame = CGRect(x: insets.left, y: self.paymentRow.frame.maxY, width: width, height: rowHeight)
        self.totalRow.frame = CGRect(x: insets.left, y: self.shippingRow.frame.maxY, width: width, height: rowHeight)
        self.buyButton.frame = CGRect(x: insets.left, y: 0, width: 88, height: 44)
        self.buyButton.center = CGPoint(x: width/2.0, y: self.totalRow.frame.maxY + rowHeight*1.5)
        self.activityIndicator.center = self.buyButton.center
    }

    @objc func didTapBuy() {
        self.paymentInProgress = true
        self.paymentContext.requestPayment()
    }

    // MARK: STPPaymentContextDelegate
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
        MyAPIClient.sharedClient.completeCharge(paymentResult,
                                                amount: self.paymentContext.paymentAmount,
                                                shippingAddress: self.paymentContext.shippingAddress,
                                                shippingMethod: self.paymentContext.selectedShippingMethod,
                                                completion: completion)
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        self.paymentInProgress = false
        let title: String
        let message: String
        switch status {
        case .error:
            title = "Error"
            message = error?.localizedDescription ?? ""
        case .success:
            title = "Success"
            message = "You bought tickets!"
            putReceiptData(email: (paymentContext.shippingAddress?.email)!,
                           amount: paymentContext.paymentAmount,
                           ticketInfo: ticketInfo.text!,
                           seatInfo: seatInfo.text!,
                           movieTime: "\(selectedDate) (\(selectedTime))",
                           movieKey: selectedMovie.key!,
                           cinemaKey: selectedCinema.key!)
            
        case .userCancellation:
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        self.paymentRow.loading = paymentContext.loading
        if let paymentMethod = paymentContext.selectedPaymentMethod {
            self.paymentRow.detail = paymentMethod.label
        }
        else {
            self.paymentRow.detail = "Select Payment"
        }
        if let shippingMethod = paymentContext.selectedShippingMethod {
            self.shippingRow.detail = shippingMethod.label
        }
        else {
            self.shippingRow.detail = "Enter \(self.shippingString) Info"
        }
        self.totalRow.detail = self.numberFormatter.string(from: NSNumber(value: Float(self.paymentContext.paymentAmount)/100))!
    }

    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            // Need to assign to _ because optional binding loses @discardableResult value
            // https://bugs.swift.org/browse/SR-1681
            _ = self.navigationController?.popViewController(animated: true)
        })
        let retry = UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.paymentContext.retryLoading()
        })
        alertController.addAction(cancel)
        alertController.addAction(retry)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func putReceiptData(email: String, amount: Int, ticketInfo: String, seatInfo: String, movieTime: String, movieKey: String, cinemaKey: String) {
        ref = Database.database().reference()
        let key = ref.childByAutoId().key
        let receiptCode = randomString(length: 6)
        let purchasedDate = Date().todayDateInString()
        
        let path = "receipts/\(key)"
        let post = ["email": email,
                    "amount": amount,
                    "purchasedDate": purchasedDate,
                    "receiptCode": receiptCode,
                    "ticketInfo": ticketInfo,
                    "seatInfo": seatInfo,
                    "movieTime": movieTime,
                    "movieID": movieKey,
                    "cinemaID": cinemaKey] as [String : Any]
        
        let updateData = [path:post]
        self.ref.updateChildValues(updateData)
    }
    
    func randomString(length: Int) -> String {
        
        let letters :  NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}
