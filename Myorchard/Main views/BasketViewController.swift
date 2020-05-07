//
//  BasketViewController.swift
//  Myorchard
//
//  Created by PewPew on 4/2/2563 BE.
//  Copyright © 2563 PewPew. All rights reserved.
//

import UIKit
import JGProgressHUD
import Stripe

class BasketViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var basketTotalPriceLabel: UILabel!
    @IBOutlet weak var totalItemsLabel: UILabel!
    @IBOutlet weak var checkOutButtonOutlet: UIButton!
    @IBOutlet weak var footerView: UIView!
    
    
    //MARK: - Vars
    var basket: Basket?
    var allItems: [Item] = []
    var purchasedItemIds : [String] = []
    
    let hud = JGProgressHUD(style: .dark)
    var totalPrice = 0
    
    
    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = footerView
        
        
    }

    
     override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           
           //TODO: Check if user is logged in
        if MUser.currentUser() != nil {
            loadBasketFromFirestore()
        } else {
            self.updateTotalLabels(true)
            
        }
           

       }
    
    //MARK: - IBActions
    
    @IBAction func checkoutButtonPressed(_ sender: Any) {

        if MUser.currentUser()!.onBoard {
            
            showPaymentOptions()
        } else {
            self.showNotification(text: "Please complete you profile!", isError: true)
        }
    }

    
   //MARK: - Download basket
    private func loadBasketFromFirestore() {
        
        downloadBasketFromFirestore(MUser.currentId()) { (basket) in
            
            self.basket = basket
            self.getBasketItems()
        }
    }
    
    private func getBasketItems() {
        
        if basket != nil {
            
            downloadItems(basket!.itemIds) { (allItems) in
                
                self.allItems = allItems
                self.updateTotalLabels(false)
                self.tableView.reloadData()
            }
        }
        
    }
    
    //MARK: - Helper functions
    
//    func tempFunction() {
//        for item in allItems {
//            print("we have ", item.id)
//            purchasedItemIds.append(item.id)
//        }
//    }
    
    private func updateTotalLabels(_ isEmpty: Bool) {
        
        if isEmpty {
            totalItemsLabel.text = "0"
            basketTotalPriceLabel.text = returnBasketTotalPrice()
        } else {
            totalItemsLabel.text = "\(allItems.count)"
            basketTotalPriceLabel.text = returnBasketTotalPrice()
 
        }
        
        //TODO: Update the button status
        checkoutButtonStatusUpdate()
        
    }
    
    private func returnBasketTotalPrice() -> String {
        
        var totalPrice = 0.0
        
        for item in allItems {
            totalPrice += item.price
        }
        return "Total price: " + convertToCurrency(totalPrice)
    }
    
    
    private func emptyTheBasket() {
        
        purchasedItemIds.removeAll()
        allItems.removeAll()
        tableView.reloadData()
        
        basket!.itemIds = []
        
        updateBasketInFirestore(basket!, withValues: [kITEMIDS : basket!.itemIds]) { (error) in
            
            if error != nil {
                print("Error updating basket ", error!.localizedDescription)
            }
            
            self.getBasketItems()
        }
        
    }
    
    private func addItemsToPurchaseHistory(_ itemIds: [String]) {
        
        if MUser.currentUser() != nil {
            
            print("item ids , ", itemIds)
            let newItemIds = MUser.currentUser()!.purchasedItemIds + itemIds
            
            updateCurrentUserInFirestore(withValues: [kPURCHASEDITEMIDS : newItemIds]) { (error) in
                
                if error != nil {
                    print("Error adding purchased items ", error!.localizedDescription)
                }
            }
        }
        
        
    }
    
    //MARK: - Navigation
    
    private func showItemView(withItem: Item) {
        
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "itemView") as! ItemViewController
               
               itemVC.item = withItem
               
               self.navigationController?.pushViewController(itemVC, animated: true)
    }
    
    //MARK: - Control checkoutButton
    
    private func checkoutButtonStatusUpdate() {
        
        checkOutButtonOutlet.isEnabled = allItems.count > 0
        if checkOutButtonOutlet.isEnabled {
            checkOutButtonOutlet.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            
        } else {
            disableCheckoutButton()
        }
        
    }

    private func disableCheckoutButton() {
        checkOutButtonOutlet.isEnabled = false
        checkOutButtonOutlet.backgroundColor = #colorLiteral(red: 0.52180475, green: 0.5626481175, blue: 0.619096756, alpha: 1)

    }
    private func removeItemFromBasket(itemId: String) {
        
        for i in 0..<basket!.itemIds.count {
            
            if itemId == basket!.itemIds[i] {
                basket!.itemIds.remove(at: i)
                
                return
            }
        }
    }
    
    //MARK: - Paypal
    
   private func finishPayment(tolen: STPToken) {
        
        self.totalPrice = 0
        
        for item in allItems {
            purchasedItemIds.append(item.id)
            self.totalPrice += Int(item.price)
        }
        
        self.totalPrice = self.totalPrice * 100
        
        StripeClient.sharedClient.createAndConfirmPayment(tolen, amount: totalPrice) { (error) in
            
            if error == nil {
                self.emptyTheBasket()
                self.addItemsToPurchaseHistory(self.purchasedItemIds)
                //show notification
                self.showNotification(text: "Payment Successful", isError: false)
            } else {
                self.showNotification(text: error!.localizedDescription, isError: true)
                print("error ", error!.localizedDescription)
            }
        }
    }
    private func showNotification(text: String, isError: Bool) {
           
           if isError {
               self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
           } else {
               self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
           }
           
           self.hud.textLabel.text = text
           self.hud.show(in: self.view)
           
    }
    
    private func showPaymentOptions() {
               let alertController = UIAlertController(title: "Payment Options", message: "Choose prefered payment option", preferredStyle: .actionSheet)
                      
                      let cardAction = UIAlertAction(title: "Pay with Card", style: .default) { (action) in
                          
                        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "cardInfoVC") as! CardInfoViewController
                        
                        vc.delegate = self
                        
                        self.present(vc,animated: true, completion: nil)
                      }
                      
                      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(cardAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true,completion: nil)
           }
           
}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
        
        cell.generateCell(allItems[indexPath.row])
        
        return cell
        
    }
    
    //MARK: - UITableview Delagate
     
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let itemToDelete = allItems[indexPath.row]
            
            allItems.remove(at: indexPath.row)
            tableView.reloadData()
            
            removeItemFromBasket(itemId: itemToDelete.id)
            updateBasketInFirestore(basket!, withValues: [kITEMIDS : basket!.itemIds]) { (error) in
                
                if error != nil {
                    print("error updating the basket", error!.localizedDescription)
                }
                self.getBasketItems()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        showItemView(withItem: allItems[indexPath.row])
    }
    
    
    }

extension BasketViewController : CardInfoViewControllerDelegate {
    func didClickDone(_ token: STPToken) {
        finishPayment(tolen: token)
    }
    
    func didClickCancel() {
        showNotification(text: "Payment Canceled", isError: true)
    }
    
    
}




