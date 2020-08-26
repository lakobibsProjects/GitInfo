//
//  AppColor.swift
//  GitInfo
//
//  Created by user166683 on 8/26/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation
import UIKit

public enum AppColor{
    static public let white =  UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    static public let white00 =  UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
    static public let black =  UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
    
    public static let labelTextColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return white
                } else {
                    return black
                }
            }
        } else {
            return black
        }
    }()
    
    public static let labelBackgroundColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return black
                } else {
                    return white
                }
            }
        } else {
            return white
        }
    }()
    
    public static let textFieldTextColor: UIColor = {
           if #available(iOS 13, *) {
               return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                   if UITraitCollection.userInterfaceStyle == .dark {
                       return white
                   } else {
                       return black
                   }
               }
           } else {
               return black
           }
       }()
       
       public static let textFieldBackgroundColor: UIColor = {
           if #available(iOS 13, *) {
               return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                   if UITraitCollection.userInterfaceStyle == .dark {
                       return black
                   } else {
                       return white
                   }
               }
           } else {
               return white
           }
       }()
    
    public static let superviewBackgroundColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return black
                } else {
                    return white
                }
            }
        } else {
            return white
        }
    }()
    
    public static let bordersGeneralColor: UIColor = {
              if #available(iOS 13, *) {
                  return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                      if UITraitCollection.userInterfaceStyle == .dark {
                          return white
                      } else {
                          return black
                      }
                  }
              } else {
                  return black
              }
          }()
}
