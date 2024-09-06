//
//  AppComponent+Root.swift
//  PillsUp
//
//  Created by Junyoung on 9/5/24.
//

import Foundation
import Features
import ModernRIBs

protocol AppDependencyRoot: Dependency { }

extension AppComponent: RootDependency { }
