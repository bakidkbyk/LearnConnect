//
//  ButtonFactory.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 23.11.2024.
//

//import UIKit
//
//public class ButtonFactory {
//    
//    public enum Style {
//        case small
//        case medium
//        case large
//        
//        var height: CGFloat {
//            switch self {
//            case .small:
//                return 40
//            case .medium:
//                return 50
//            case .large:
//                return 60
//            }
//        }
//        
//        var fontSize: UIFont.FontSize {
//            switch self {
//            case .small:  return .xSmall
//            case .medium: return . medium
//            case .large:  return .xLarge
//            }
//        }
//    }
//    
//    public static func createPrimaryButton(style: Style) -> UIButton {
//            let button: UIButton = {
//            let button = UIButton(type: .system)
//                button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//            button.setTitleColor(.white, for: .normal)
//            button.backgroundColor = .red
//            button.layer.cornerRadius = 4 // Köşe yarıçapını ayarla
//            button.translatesAutoresizingMaskIntoConstraints = false // AutoLayout kullanacaksa
//            return button
//        }()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.heightAnchor.constraint(equalToConstant: style.height).isActive = true
//        button.layer.masksToBounds = true
//        button.clipsToBounds = true
//        return button
//    }
//    
//    public static func createPrimaryBorderedButton(style: Style) -> UIButton {
//        
//        let button = UIButtonBuilder()
//            .titleFont(.font(.nunitoBold, size: style.fontSize))
//            .titleColor(.red)
//            .backgroundColor(.white)
//            .cornerRadius(4)
//            .borderWidth(2)
//            .borderColor(UIColor.appRed.cgColor)
//            .build()
//        
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.heightAnchor.constraint(equalToConstant: style.height).isActive = true
//        button.layer.masksToBounds = true
//        button.clipsToBounds = true
//        return button
//        
//    }
//}

