//
//  KPParentViewController.swift
//  VoteMe
//
//  Created by Yudiz Solutions Pvt.Ltd. on 30/03/16.
//  Copyright © 2016 Yudiz Solutions Pvt.Ltd. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class ParentVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var tableView :UITableView!
    @IBOutlet var collectionView: UICollectionView!

    @IBOutlet var viewHeader : UIView?
    @IBOutlet var viewBottom : UIView?
    
    @IBOutlet var horizontalConstraints: [NSLayoutConstraint]?
    @IBOutlet var verticalConstraints: [NSLayoutConstraint]?
    
    // MARK: Variables
    
    // MARK: - iOS Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        constraintUpdate()
        setDefaultUI()
        jprint("Allocated: \(self.classForCoder)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden : Bool{
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
   
    override var shouldAutorotate : Bool {
        return false
    }
    
    deinit {
        jprint("Deallocated: \(self.classForCoder)")
       _defaultCenter.removeObserver(self)
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
//MARK: - UI Releated Method
extension ParentVC {
    // This will update constaints and shrunk it as device screen goes lower.
    func constraintUpdate() {
        if let hConts = horizontalConstraints {
            for const in hConts {
                let v1 = const.constant
                let v2 = v1 * _widthRatio
                const.constant = v2
            }
        }
        if let vConst = verticalConstraints {
            for const in vConst {
                let v1 = const.constant
                let v2 = v1 * _heighRatio
                const.constant = v2
            }
        }
    }
    
    // Set tableView
    func setDefaultUI() {
        tableView?.scrollsToTop = true;
    }
   
    func hideShowHomeTabbar(){
        if let tabBarController = self.tabBarController,  tabBarController is SlideMenuTabbarVC{
            tabBarController.tabBar.isHidden = true
        }
    }
   

    func setHeaderShadow(){
        self.viewHeader?.layer.shadowColor = UIColor.black.cgColor
        self.viewHeader?.layer.shadowOpacity = 0.4
        self.viewHeader?.layer.shadowOffset = CGSize(width: 0, height: 2)
        //self.lblTitle?.font = UIFont.muAvenirMedium(18.0)
    }
    
    func setButtomShadow(){
        self.viewBottom?.layer.shadowColor = UIColor.black.cgColor
        self.viewBottom?.layer.shadowOpacity = 0.4
        self.viewBottom?.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
   
    
    // MARK: - TableView
    func tableViewCell(_ indexPath: IndexPath) -> UITableViewCell?  {
        let cell = tableView.cellForRow(at: indexPath)
        return cell
    }

    
    func scrollToTop(_ animate: Bool = false){
        if tableView?.numberOfRows(inSection: 0) > 0{
            tableView?.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: animate)
        }else{
            tableView?.contentOffset = CGPoint.zero
        }
    }
    
    func scrollToTopCollection(_ animate: Bool = false){
        if collectionView?.numberOfItems(inSection: 0) > 0{
            collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: animate)
        }else{
            collectionView?.contentOffset = CGPoint.zero
        }
    }
    
    func scrollToBottom(_ animate: Bool = false){
        if tableView?.numberOfRows(inSection: 0) > 0{
            tableView?.scrollToRow(at: IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0), at: .top, animated: animate)
        }
    }
    
    func closeAnimated(_ animated:Bool,img:UIImageView){
        if animated {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction, .curveLinear] , animations: { () -> Void in
                img.transform = CGAffineTransform.identity
                }, completion: { (Bool) -> Void in
            })
        }else{
            img.layer.removeAllAnimations()
            img.transform = CGAffineTransform.identity
        }
    }
    
    func openAnimated(_ animated:Bool,img:UIImageView){
        if animated {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction, .curveLinear] , animations: { () -> Void in
                img.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
                }, completion: { (Bool) -> Void in
            })
        }else{
            img.layer.removeAllAnimations()
            
            img.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        }
    }
    
}

// MARK: - Keyboard Functions
extension ParentVC {
    func setKeyboardNotifications() {
        _defaultCenter.addObserver(self, selector: #selector(ParentVC.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        _defaultCenter.addObserver(self, selector: #selector(ParentVC.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if let kbSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
//MARK: - UITextField Delegate
extension ParentVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if string == " " && range.location == 0{
            return false
        }
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - UITextView Delegate
extension ParentVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        if text == " " && range.location == 0{
            return false
        }
        return true
    }
    
}
// MARK: - TableViewDataSource & Delegate
extension ParentVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
}
// MARK: - Actions
extension ParentVC{
    // Navigate to Previous View Controller with navigation popview method
    @IBAction func parentBackAction(_ sender:UIButton!){
      let _ = self.navigationController?.popViewController(animated: true)
    }
    
    // Navigate to Previous View Controller with dismiss view method
    @IBAction func parentDismissAction(_ sender:UIButton!){
        self.dismiss(animated: true, completion: nil)
    }
    
    // Navigate to Root view controller
    @IBAction func parentBackToRootViewController(_ sender: UIButton!){
       let _ = self.navigationController?.popToRootViewController(animated: true)
    }
}


//MARK: - Custom SlideMenu
extension ParentVC {
    
    @IBAction func shutterAction(_ sender: AnyObject)
    {
        self.view.endEditing(true)
        
        if let containerController = self.findContainerController(){
            containerController.animatedDrawerEffect()
        }
    }
    
    func findContainerController() -> SlideMenuContainerVC? {
        
        let navCon = _appDelegator.window!.rootViewController as! UINavigationController
        for vc in navCon.viewControllers {
            if let con = vc as? SlideMenuContainerVC{
                return con
            }
        }
        return nil
    }
    
    func updateUserProfile(){
      if let containerController = self.findContainerController(){
            containerController.tableView.reloadData()
        }
    }
    
}
