//
//  JY_Base_Loading_View.swift
//  JYBaseController
//
//  Created by JYYQLin on 2024/8/9.
//

import UIKit

public class JY_Base_Loading_View: UIView {

    private lazy var yq_scale: CGFloat = 1.0
    
    private lazy var yq_loading_view: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(yq_loading_view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = UIColor(named: "yq_loadingView_bgColor")
        
        yq_loading_view.frame.size = CGSize(width: 87 * yq_scale, height: 87 * yq_scale)
        
        yq_loading_view.frame.origin = CGPoint(x: (frame.width - yq_loading_view.frame.width) * 0.5, y: (frame.height - yq_loading_view.frame.height) * 0.5)
        
        yq_loading_view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        yq_loading_view.transform = CGAffineTransform(scaleX: 1.5 * yq_scale, y: 1.5 * yq_scale)
        
        yq_loading_view.color = UIColor(named: "yq_loadingView_color")
    }
    
    public func yq_set(scale: CGFloat) {
        yq_scale = scale
        layoutSubviews()
    }
    
    public func yq_show_loading() {
        yq_loading_view.startAnimating()
        isHidden = false
    }
    
    public func yq_hidden_loading() {
        isHidden = true
        yq_loading_view.stopAnimating()
    }
}
