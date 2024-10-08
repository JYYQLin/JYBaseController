//
//  JY_Enum_BaseController_Status.swift
//  JYBaseController
//
//  Created by JYYQLin on 2024/8/9.
//

import UIKit

public enum JY_Enum_BaseController_Status: String {
    //  默认状态下 显示contentView
    case yq_default = "yq_default"
    //  显示 request_loadingView
    case yq_first_request = "yq_first_request"
    //  显示
    case yq_data_loaded = "yq_data_loaded"
    
    case yq_no_internet = "yq_no_internet"
    case yq_no_message = "yq_no_message"
    case yq_no_data = "yq_no_data"
    case yq_no_comment = "yq_no_comment"
    
    case yq_other = "yq_other"
}
