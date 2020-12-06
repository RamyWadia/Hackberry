//
//  Constants.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-12-05.
//

import UIKit

enum MenuOptions {
    case mobile
    case analytics
    case workHere
    case aboutUs
    case contact
    case language(Language)
    
    var backgroundColor: UIColor {
        switch self {
        case .mobile: return .hackberryOrangePink
        case .analytics: return .hackberryPurble
        case .workHere: return .hackberryOrangePink
        case .aboutUs: return .hackberryPurble
        case .contact: return .hackberryOrangePink
        default: return .white
        }
    }
        
    var controller: UIViewController {
        switch self {
        case .mobile: return MobileController()
        case .analytics: return AnalysController()
        case .workHere: return WorkHereController()
        case .aboutUs: return AboutUsController()
        case .contact: return ContactUsController()
        default: return AboutUsController()
        }
    }
    
    var text: String {
        switch self {
        case .mobile: return "MOBIL"
        case .analytics: return "ANALYS"
        case .workHere: return "JOBBA HÄR"
        case .aboutUs: return "OM OSS"
        case .contact: return "KONTAKT"
        case .language(.swedish): return "SE"
        case .language(.english): return "EN"
        }
    }
    
    var image: UIImage {
        switch self {
        case .mobile: return UIImage(named: "mobile-icon")!
        case .analytics: return UIImage(named: "analytics")!
        case .workHere: return UIImage(named: "work-here")!
        case .aboutUs: return UIImage(named: "footer-small-logo")!
        case .contact: return UIImage(named: "button-thing-dark")!
        default: return UIImage(named: "mobile-icon")!
        }
    }
}

enum Language {
    case english
    case swedish
}
