//
//  SharedData.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 22/06/24.
//

import Foundation
import UIKit

class SharedData: ObservableObject {
    @Published var orientation: UIDeviceOrientation = UIDeviceOrientation.portrait
}
