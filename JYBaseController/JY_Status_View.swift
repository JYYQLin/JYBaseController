//
//  JY_Status_View.swift
//  JYBaseController
//
//  Created by Jing on 2024/8/9.
//

import UIKit

class JY_Status_View: UIView {
    
    var yq_retry_request_ClickBlock: (() -> Void)?
    
    private lazy var yq_status: JY_Enum_BaseController_Status = .yq_default

    private lazy var yq_icon_imageView: UIImageView = UIImageView()
    
    private lazy var yq_scale: CGFloat = 1.0

    private lazy var yq_status_label: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()

    private lazy var yq_retry_button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(yq_retry_request_click), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(yq_retry_button)
        addSubview(yq_icon_imageView)
        addSubview(yq_status_label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JY_Status_View {
    @objc private func yq_retry_request_click() {
        if yq_retry_request_ClickBlock != nil {
            yq_retry_request_ClickBlock!()
        }
    }
    
    func yq_set(status: JY_Enum_BaseController_Status) {
        yq_status = status
        
        isHidden = status == .yq_default || status == .yq_first_request || status == .yq_data_loaded
        
        layoutSubviews()
    }
}

extension JY_Status_View {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_icon_imageView.frame.origin = {
            yq_icon_imageView.image = UIImage(named: yq_status_imageName(status: yq_status))
            
            yq_icon_imageView.frame.size = CGSize(width: 140 * yq_scale, height: 140 * yq_scale)
            
            return CGPoint(x: (frame.width - yq_icon_imageView.frame.width) * 0.5, y: (frame.height * 0.5 - yq_icon_imageView.frame.height))
        }()
        
        yq_status_label.frame.origin = {
            yq_status_label.text = yq_controller_status_string(status: yq_status)
            yq_status_label.textColor = UIColor(named: "yq_base_status_label_textColor")
            yq_status_label.font = UIFont.systemFont(ofSize: 12 * yq_scale)
            
            yq_status_label.frame.size.width = yq_icon_imageView.frame.width + 50 * yq_scale
            yq_status_label.sizeToFit()
            
            return CGPoint(x: yq_icon_imageView.frame.midX - yq_status_label.frame.width * 0.5, y: yq_icon_imageView.frame.maxY + 8 * yq_scale)
        }()
        
        yq_retry_button.frame = {
           
            let x = yq_icon_imageView.frame.minX <= yq_status_label.frame.minX ? yq_icon_imageView.frame.minX : yq_status_label.frame.minX
            
            let width = (yq_icon_imageView.frame.width >= yq_status_label.frame.width ? yq_icon_imageView.frame.width : yq_status_label.frame.width)
            
            let height = yq_status_label.frame.maxY - yq_icon_imageView.frame.minY
            
            return CGRect(x: x, y: yq_icon_imageView.frame.minY, width: width, height: height)
        }()
    }
}

extension JY_Status_View {
    func yq_set(scale: CGFloat) {
        yq_scale = scale
        layoutSubviews()
    }
}

extension JY_Status_View {
    func yq_status_imageName(status: JY_Enum_BaseController_Status) -> String {
        if status == .yq_no_data {
            return "yq_icon_yq_no_data"
        }
        
        else if status == .yq_no_internet {
            return "yq_icon_yq_no_internet"
        }
        
        else if status == .yq_no_message {
            return "yq_icon_yq_no_comment"
        }
        
        else if status == .yq_no_comment {
            return "yq_icon_yq_no_comment"
        }
        
        else {
            return "yq_status_imageName"
        }
    }
    
    
    public func yq_controller_status_string(status: JY_Enum_BaseController_Status) -> String {
        
        if status == .yq_no_data {
            return "There is no data here!!"
        }
        
        else if status == .yq_no_internet {
            return "Internal server error ~ Please check your network connection and try again~"
        }
        
        else if status == .yq_data_loaded {
            return "Data loaded"
        }
        
        else if status == .yq_no_message {
            return "No message"
        }
        
        else if status == .yq_no_comment {
            return "be the first one to comment"
        }
        
        else if status == .yq_first_request {
            return "Requesting..."
        }
        
        else {
            return ""
        }
    }
}
