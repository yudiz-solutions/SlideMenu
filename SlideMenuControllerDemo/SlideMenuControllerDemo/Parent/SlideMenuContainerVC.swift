//
//  SlideMenuContainerVC.swift
//  ELeague
//
//  Created by Yudiz Solutions Pvt.Ltd. on 10/06/16.
//  Copyright © 2016 Yudiz Pvt.Ltd. All rights reserved.
//

import UIKit

enum MenuItem: String {
    case Home                           = "Home"
    case Profile                        = "Profile"
    case Notifications                  = "Notifications"
    case Setting                        = "Setting"
    case More                           = "More"
    case Logout                         = "Logout"
    
    
    static let allValues = [Home, Profile, Notifications, Setting, More, Logout]
    
}

//MARK: Point
/**
 *This class use for get center point of menu ,screen
 */
class Point {
    static var centerPoint = CGPoint()
}
//MARK: SlideAction
/**
 * Slide Menu Action Open & close
 */
public enum SlideAction {
    case open
    case close
}

//MARK: SlideAnimationStyle
/**
 *This class use Slide open animation style
 */
public enum SlideAnimationStyle {
    case style1
    case style2
}

public struct SlideMenuOptions {
    public static var animationStyle: SlideAnimationStyle = .style1
    
    public static var screenFrame     = UIScreen.main.bounds
    public static var panVelocity : CGFloat = 800
    public static var panAnimationDuration : TimeInterval = 0.35

    public static var pending = UIDevice.current.userInterfaceIdiom == .pad ? _screenSize.width/2.5 : 75 * _widthRatio
    public static var thresholdTrailSpace : CGFloat =  UIScreen.main.bounds.width + pending
    public static var thresholdLedSpace : CGFloat =  UIScreen.main.bounds.width - pending
    public static var panGesturesEnabled: Bool = true
    public static var tapGesturesEnabled: Bool = true
}


struct MenuSpecific {
    let items: [MenuItem] = MenuItem.allValues
    var selectedItem = MenuItem.Home
    let normalAlpha: CGFloat = 0.35
    let selectedAlpha: CGFloat = 1
    let normalFont : UIFont = FontBook.AvenirNext_Medium.of(16)
    let selectedFont : UIFont = FontBook.AvenirNext_Medium.of(16)
}

//MARK: - SliderContainer VC


class SlideMenuContainerVC: ParentVC {
    // MARK: - Outlets
    
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var mainContainer: UIView!
    
    @IBOutlet weak var mainContainerTrailSpace: NSLayoutConstraint!
    @IBOutlet weak var mainContainerLedSpace: NSLayoutConstraint!
    
    @IBOutlet weak var menuContainerTrailSpace: NSLayoutConstraint!
    @IBOutlet weak var menuContainerLedSpace: NSLayoutConstraint!
    
    // MARK: Variables
    var transparentView = UIControl()
    var tabbar : UITabBarController!
    var menu = MenuSpecific()
    var menuActionType: SlideAction = .close
    
    // MARK: - iOS Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareConstraintUpdate()
        prepareTableViewUI()
        prepareSlideMenuUI()
        prepareTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        prepareTabBar()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:- Private
extension  SlideMenuContainerVC{
    func prepareConstraintUpdate(){
        if SlideMenuOptions.animationStyle == .style1 {
            menuContainerTrailSpace.constant =  SlideMenuOptions.screenFrame.width
            menuContainerLedSpace.constant =  -SlideMenuOptions.thresholdLedSpace
            self.view.bringSubview(toFront: menuContainer)
            
        }else{
            menuContainerTrailSpace.constant = SlideMenuOptions.pending
            menuContainerLedSpace.constant = 0
            self.view.bringSubview(toFront: mainContainer)
            mainContainer.layer.shadowColor = UIColor.black.cgColor
            mainContainer.layer.shadowOpacity = 0.6
            mainContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
            
        }
    }
    func prepareTableViewUI() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            jprint("Version: \(version)")
        }
        
    }
    
    func prepareTabBar(){
        if tabbar == nil{
            for obj in self.childViewControllers{
                if (obj .isKind(of: UITabBarController.self)){
                    tabbar = obj as! UITabBarController
                }
            }
        }
    }
    
    func swapController(_ item : MenuItem){
        let nav : UINavigationController = self.tabbar?.viewControllers?.last as! UINavigationController
        if item == MenuItem.Setting{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
            nav.viewControllers = [vc]
            vc.view.layoutIfNeeded()
        }else if item == MenuItem.More{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MoreVC") as! MoreVC
            nav.viewControllers = [vc]
            vc.view.layoutIfNeeded()
        }
        tabbar?.selectedIndex = 4
        tabbar.tabBar.isHidden = true
        self.hideShowHomeTabbar()
        self.animatedDrawerEffect()
    }
    
}


//MARK:- UITableView DataSource & Delegate

extension  SlideMenuContainerVC {
    
    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menu.items.count
    }
    
    func tableView(_ tableView: UITableView,heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat{
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell   = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MenuItemCell
        cell.prepareToFillData(menu, index: indexPath.row)
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath)
    {
        var indexPaths : [IndexPath] = []
        
        if menu.items[indexPath.row] == .Logout{
            jprint("Logout")
        }else if menu.selectedItem != menu.items[indexPath.row]{
            let index = menu.items.index(where: { (item) -> Bool in
                return item == menu.selectedItem
            })
            
            if let row = index {
                indexPaths.append(IndexPath(row: row, section: indexPath.section))
            }
            
            menu.selectedItem =  menu.items[indexPath.row]
            indexPaths.append(indexPath)
            if indexPath.row >= 4{
                swapController(menu.selectedItem)
            }else{
                tabbar.selectedIndex = indexPath.row
                self.hideShowHomeTabbar()
                self.animatedDrawerEffect()
            }
        }else{
            tabbar.selectedIndex = indexPath.row >= 4 ?  4 : indexPath.row
            self.hideShowHomeTabbar()
            self.animatedDrawerEffect()
        }
        
        if !indexPaths.isEmpty{
            tableView.beginUpdates()
            tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)
            tableView.endUpdates()
        }
    }
}
//MARK: - UIGesture
extension SlideMenuContainerVC {
    func animatedDrawerEffect() {
        if let container = self.findContainerController(){
            if menuActionType == .close
            {
                container.panMenuOpen()
            }else
            {
                container.panMenuClose()
            }
        }
    }
    
    func menuContainerClose(_ animatedView: UIView) {
        if let container = self.findContainerController(){
            menuActionType = .close
            if SlideMenuOptions.animationStyle == .style1{
                container.menuContainerTrailSpace.constant = SlideMenuOptions.screenFrame.width
                container.menuContainerLedSpace.constant   = -SlideMenuOptions.thresholdLedSpace
            }else{
                container.mainContainerTrailSpace.constant = 0
                container.mainContainerLedSpace.constant = 0
            }
            
            UIView.animate(withDuration: SlideMenuOptions.panAnimationDuration, animations: { () -> Void in
                container.tableView.isUserInteractionEnabled = false
                self.transparentView.isEnabled = false
                self.transparentView.alpha = 0
                container.view.layoutIfNeeded()
                
            }, completion: { (finished) -> Void in
                self.transparentView.isHidden = true
                self.transparentView.isEnabled = true
                container.tableView.isUserInteractionEnabled = true
            })
            
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOfGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    //MARK: - Swipe Getsure code
    
    func swipePanAction(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        if !SlideMenuOptions.panGesturesEnabled{
            return
        }
        
        if let navCon: UINavigationController = self.tabbar!.selectedViewController as? UINavigationController{
            if navCon.viewControllers.count != 1 {
                return
            }
        }
        let centerPoint = Point.centerPoint
        
        
        switch gestureRecognizer.state {
        case .began:
            Point.centerPoint = self.mainContainer.center
            break
            
        case .changed:
            let translation: CGPoint = gestureRecognizer.translation(in: self.view)
            moveContainerOnGesture(x: centerPoint.x, translation: translation)
            break
            
        case .ended,.failed,.cancelled:
            let translation: CGPoint = gestureRecognizer.translation(in: self.view)
            let vel: CGPoint = gestureRecognizer.velocity(in: self.view)
            let halfWidth = SlideMenuOptions.screenFrame.width / 2
            self.view.endEditing(true)
            //  recognizer has received touches recognized as the end of the gesture base on menu close/open
            if vel.x > SlideMenuOptions.panVelocity{
                self.panMenuOpen()
            }else if vel.x < -SlideMenuOptions.panVelocity{
                self.panMenuClose()
            }else if  translation.x > halfWidth{
                self.panMenuOpen()
            }else{
                self.panMenuClose()
            }
            
            break
        default:
            break
        }
    }
    //  MenuContainer/MainContainer Constraint update base on moment action
    
    func moveContainerOnGesture(x:CGFloat,translation: CGPoint){
        let ctPoint = (x + translation.x)
        
        let halfWidth = SlideMenuOptions.screenFrame.width / 2
        if ctPoint >= halfWidth {
            if ctPoint - halfWidth > SlideMenuOptions.thresholdLedSpace {
                //Menu Screen rech maximum to open
                if SlideMenuOptions.animationStyle == .style1{
                    if menuContainerLedSpace.constant != 0
                    {
                        self.menuContainerTrailSpace.constant = SlideMenuOptions.pending
                        self.menuContainerLedSpace.constant = 0
                        transparentViewAnimation(x: translation.x)
                        self.view.layoutIfNeeded()
                    }
                }else{
                    if mainContainerLedSpace.constant != SlideMenuOptions.thresholdLedSpace
                    {
                        mainContainerTrailSpace.constant = -SlideMenuOptions.thresholdLedSpace;
                        mainContainerLedSpace.constant = SlideMenuOptions.thresholdLedSpace;
                        menuSlideAnimation(x: translation.x)
                        transparentViewAnimation(x: translation.x)
                        self.view.layoutIfNeeded()
                    }
                }
                
            }else {
                if SlideMenuOptions.animationStyle == .style1{
                    self.menuContainerLedSpace.constant =   (ctPoint - halfWidth) - SlideMenuOptions.screenFrame.width + SlideMenuOptions.pending
                    self.menuContainerTrailSpace.constant =  SlideMenuOptions.screenFrame.width - (ctPoint - halfWidth)
                    transparentViewAnimation(x: translation.x)
                    
                }else{
                    self.mainContainerTrailSpace.constant = -translation.x
                    self.mainContainerLedSpace.constant = translation.x
                    menuSlideAnimation(x: translation.x)
                    transparentViewAnimation(x: translation.x)
                }
                self.view.layoutIfNeeded()
                
            }
            
        }
    }
    
    //  recognizer has received touches recognized as the end of the gesture base on menu close method
    func panMenuClose() {
        menuActionType = .close
        if SlideMenuOptions.animationStyle == .style1{
            menuContainerTrailSpace.constant = SlideMenuOptions.screenFrame.width
            menuContainerLedSpace.constant   = -SlideMenuOptions.thresholdLedSpace
        }else{
            mainContainerTrailSpace.constant = 0
            mainContainerLedSpace.constant = 0
            menuSlideAnimation(x: SlideMenuOptions.pending,isAnimate: false)
        }
        
        UIView.animate(withDuration: SlideMenuOptions.panAnimationDuration, animations: { () -> Void in
            self.transparentView.isEnabled = false
            self.tableView.isUserInteractionEnabled = false
            
            self.transparentView.alpha = 0
            self.view.layoutIfNeeded()
            
        }, completion: { (finished) -> Void in
            self.transparentView.isHidden = true
            self.transparentView.isEnabled = true
            self.tableView.isUserInteractionEnabled = true
        })
    }
    //  recognizer has received touches recognized as the end of the gesture base on menu open method
    
    func panMenuOpen() {
        menuActionType = .open
        
        if SlideMenuOptions.animationStyle == .style1{
            menuContainerTrailSpace.constant = SlideMenuOptions.pending
            menuContainerLedSpace.constant = 0
            
        }else{
            mainContainerTrailSpace.constant = -SlideMenuOptions.thresholdLedSpace
            mainContainerLedSpace.constant = SlideMenuOptions.thresholdLedSpace
            menuSlideAnimation(x: SlideMenuOptions.screenFrame.width,isAnimate: false)
        }
        self.transparentView.isHidden = false
        
        UIView.animate(withDuration: SlideMenuOptions.panAnimationDuration, animations: { () -> Void in
            self.transparentView.isEnabled = false
            self.tableView.isUserInteractionEnabled = false
            
            self.transparentView.alpha = 1
            self.view.layoutIfNeeded()
            
        }, completion: { (finished) -> Void in
            self.tableView.isUserInteractionEnabled = true
            
            self.transparentView.isEnabled = true
        })
    }
    
    //MARK: -  animation method
    //  Menu slide animation with user touch moment code
    
    func menuSlideAnimation(x: CGFloat,isAnimate:Bool = true){
        let progress: CGFloat = (x)/SlideMenuOptions.thresholdLedSpace
        let slideMovement : CGFloat = 100
        var location :CGFloat = (slideMovement * -1) + (slideMovement * progress)
        location = location > 0 ? 0 : location
        self.menuContainerLedSpace.constant = location
        self.menuContainerTrailSpace.constant =  abs(location) + SlideMenuOptions.pending
        if isAnimate{
            UIView.animate(withDuration: 0.1) {
                self.view.layoutIfNeeded()
            }
        }
        
        
    }
    
    //  Transparent view alpha animation with user touch moment code
    func transparentViewAnimation(x: CGFloat){
        let progress: CGFloat = (x)/SlideMenuOptions.thresholdLedSpace
        self.transparentView.isHidden = false
        
        UIView.animate(withDuration: 0.1) {
            self.transparentView.alpha = progress
        }
    }

}

//MARK: - Slider Menu UI
extension SlideMenuContainerVC {
    
    func prepareSlideMenuUI() {
        // Pan Gesture Recognizer code
        let corner :UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(SlideMenuContainerVC.swipePanAction(gestureRecognizer:)))
        corner.edges = UIRectEdge.left
        mainContainer.addGestureRecognizer(corner)
        
        //transparentView Code
        addTransparentControlUI()
    }
    func addTransparentControlUI() {
        transparentView =  UIControl()
        transparentView.alpha = 0
        transparentView.isHidden = true
        transparentView.addTarget(self, action: #selector(ParentVC.shutterAction(_:)), for: UIControlEvents.touchUpInside)
        
        
        if SlideMenuOptions.animationStyle == .style1{
            transparentView.frame =  CGRect(x: 0, y: 0, width: SlideMenuOptions.screenFrame.width, height: SlideMenuOptions.screenFrame.height)
            transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            self.view.addSubview(self.transparentView)
            self.view.bringSubview(toFront: menuContainer)
        }else{
            transparentView.frame =  CGRect(x: SlideMenuOptions.thresholdLedSpace, y: 0, width: SlideMenuOptions.pending, height: SlideMenuOptions.screenFrame.height)
            transparentView.backgroundColor =   UIColor.clear
            
            self.view.addSubview(self.transparentView)
        }
    }
}

