//
//  JY_Base_Controller.swift
//  JYBaseController
//
//  Created by JYYQLin on 2024/8/9.
//

import UIKit
import JYScreen

open class JY_Base_Controller: UIViewController {

    //  状态栏颜色
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }

    //  控制器状态
    public lazy var yq_controller_status: JY_Enum_BaseController_Status = .yq_default {
        didSet {
            yq_controller_status_change()
        }
    }

    public lazy var yq_scale: CGFloat = 1.0
    public lazy var yq_is_push: Bool = true
    public lazy var yq_is_tabBar_child: Bool = false
    
    public lazy var yq_content_view: UIView = UIView()
    
    public lazy var yq_background_content_view: UIView = UIView()
    public lazy var yq_background_header_imageView: UIImageView = UIImageView()
    
    //  用于解决,左滑返回于scrollView等控件左右滑动冲突,牺牲左侧宽度10的所有事件
    private(set) lazy var yq_left_tap_view: UIView = UIView()
    
    private(set) lazy var yq_request_loading_view: JY_Base_Loading_View = JY_Base_Loading_View()
    
    private(set) lazy var yq_status_view: JY_Status_View = {
        let view = JY_Status_View()
        
        view.yq_retry_request_ClickBlock = { [weak self] in
            self?.yq_retry_request_click()
        }
        
        return view
    }()
    
    deinit {
        print(String(format: "%@", self) + "被销毁了")
    }
}

extension JY_Base_Controller {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        yq_setInterface()
        yq_setNavigationBar()
        
        yq_controller_status = .yq_default
        
        print("viewDidLoad" + String(format: "%@", self))
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        yq_setSubviewsFrame()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("viewWillDisappear" + String(format: "%@", self))
    }
}

extension JY_Base_Controller {
    
    @objc dynamic open func yq_retry_request_click() {
        yq_controller_status = .yq_first_request
    }
}

extension JY_Base_Controller {
    @objc dynamic open func yq_setInterface() {
        
        view.addSubview(yq_background_content_view)
        view.addSubview(yq_status_view)
        
        view.addSubview(yq_request_loading_view)
        view.addSubview(yq_content_view)
        view.addSubview(yq_left_tap_view)
        
        yq_background_content_view.addSubview(yq_background_header_imageView)
    }
    
    @objc dynamic open func yq_setNavigationBar() { }
    
    @objc dynamic open func yq_setSubviewsFrame() {
        
        let scale = view.frame.yq_scale_to_width(originalWidth: 375)
        yq_scale = scale
        
        yq_background_content_view.frame = view.bounds
        yq_content_view.frame = view.bounds
        
        yq_request_loading_view.frame = view.bounds
        yq_request_loading_view.yq_set(scale: scale)
        
        yq_status_view.frame = view.bounds
        yq_status_view.yq_set(scale: scale)
        
        yq_background_content_view.backgroundColor = JY_Base_Controller.yq_background_color()
        
        yq_left_tap_view.frame = CGRect(x: 0, y: 0, width: 15 * scale, height: view.frame.height)
        
        yq_background_header_imageView.frame.origin = {
            yq_background_header_imageView.frame.size = CGSize(width: yq_background_content_view.frame.width, height: yq_background_content_view.frame.height)
            yq_background_header_imageView.image = UIImage(named: "yq_bg_controller")
            return .zero
        }()
    }
    
    public func yq_hidden_background_header_imageView() {
        yq_background_header_imageView.isHidden = true
    }
}

extension JY_Base_Controller {
    private func yq_show_request_loading() {
        yq_content_view.isHidden = true
        yq_request_loading_view.yq_show_loading()
    }
    
    private func yq_show_contentView() {
        yq_request_loading_view.yq_hidden_loading()
        yq_content_view.isHidden = false
    }
}

extension JY_Base_Controller {
    private func yq_controller_status_change() {
        yq_status_view.yq_set(status: yq_controller_status)
        
        if yq_controller_status == JY_Enum_BaseController_Status.yq_first_request {
            yq_show_request_loading()
            
        }else if yq_controller_status == .yq_data_loaded || yq_controller_status == .yq_default {
            yq_show_contentView()
            
        }else if yq_controller_status == .yq_no_data || yq_controller_status == .yq_no_internet || yq_controller_status == .yq_no_message {
            
            yq_request_loading_view.yq_hidden_loading()
            yq_content_view.isHidden = true
        }
    }
}

public extension JY_Base_Controller {
    static func yq_ID() -> String {
        return "\(self)"
    }
    
    static func yq_background_color() -> UIColor? {
        return UIColor(named: "yq_baseController_bgColor")
    }
}
