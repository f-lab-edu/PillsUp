//
//  File.swift
//  
//
//  Created by Junyoung on 9/2/24.
//

import Foundation
import ModernRIBs
import Domain

protocol RootDependencyMain: Dependency { }

extension RootComponent: MainDependency { }

