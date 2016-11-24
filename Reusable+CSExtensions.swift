
//
//  Reusable+CSExtensions.swift
//  CodeShare
//
//  Created by 王广威 on 16/10/14.
//  Copyright © 2016年 forever. All rights reserved.
//

import UIKit

// 可从 xib 加载协议
// xib 名字即为类名，也是复用时的 id
protocol NibLoadable {
	
	static var cs_nibName: String { get }
}
// 给 UITableViewCell、UICollectionReusableView、UITableViewHeaderFooterView 添加从xib 加载的协议
extension UITableViewCell: NibLoadable {
	
	static var cs_nibName: String {
		return String(self)
	}
}
extension UICollectionReusableView: NibLoadable {
	
	static var cs_nibName: String {
		return String(self)
	}
}
extension UITableViewHeaderFooterView: NibLoadable {
	
	static var cs_nibName: String {
		return String(self)
	}
}


// 可复用的协议
// 类名即使用时的 id
protocol Reusable: class {
	
	static var cs_reuseIdentifier: String { get }
}
extension UITableViewCell: Reusable {
	
	static var cs_reuseIdentifier: String {
		return String(self)
	}
}
extension UITableViewHeaderFooterView: Reusable {
	
	static var cs_reuseIdentifier: String {
		return String(self)
	}
}
extension UICollectionReusableView: Reusable {
	
	static var cs_reuseIdentifier: String {
		return String(self)
	}
}


// 给 UITableView 添加注册和获取复用 cell 的方法
extension UITableView {
	// 用类名注册 cell
	// 这里的参数是一个泛型，我们给这个泛型添加了约束，必须继承自 UITableViewCell，必须遵循 Reusable 协议
	func registerClassOf<T: UITableViewCell where T: Reusable>(_: T.Type) {
		
		// 注册时，直接调用系统的注册 cell 方法，传入的 id 是遵循 Reusable 协议的类型的方法，即类名
		registerClass(T.self, forCellReuseIdentifier: T.cs_reuseIdentifier)
	}
	// 从 xib 注册 cell
	// 如果是用 xib 注册，那么这个类型必须继承自 UITableViewCell 还必须遵循 Reusable 和 NibLoadable 协议
	func registerNibOf<T: UITableViewCell where T: Reusable, T: NibLoadable>(_: T.Type) {
		
		let nib = UINib(nibName: T.cs_nibName, bundle: nil)
		registerNib(nib, forCellReuseIdentifier: T.cs_reuseIdentifier)
	}
	// 用类名注册 headerView 或 footerView
	func registerHeaderFooterClassOf<T: UITableViewHeaderFooterView where T: Reusable>(_: T.Type) {
		
		registerClass(T.self, forHeaderFooterViewReuseIdentifier: T.cs_reuseIdentifier)
	}
	// 用 xib 注册 headerView 或 footerView
	func registerHeaderFooterNibOf<T: UITableViewHeaderFooterView where T: Reusable, T: NibLoadable>(_: T.Type) {
		
		let nib = UINib(nibName: T.cs_nibName, bundle: nil)
		registerNib(nib, forHeaderFooterViewReuseIdentifier: T.cs_reuseIdentifier)
	}
	// 取出复用池中某个类的 cell
	func dequeueReusableCell<T: UITableViewCell where T: Reusable>() -> T {
		// 判断如果无法通过 id 取出 cell，则用这个 id 创建一个 style 为 Value1 的 cell
		guard let cell = dequeueReusableCellWithIdentifier(T.cs_reuseIdentifier) as? T else {
			return T.init(style: UITableViewCellStyle.Value1, reuseIdentifier: T.cs_reuseIdentifier)
		}
		
		return cell
	}
	// 取出复用池中某个 header 或 footer
	func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView where T: Reusable>() -> T {
		
		guard let view = dequeueReusableHeaderFooterViewWithIdentifier(T.cs_reuseIdentifier) as? T else {
			return T.init(reuseIdentifier: T.cs_reuseIdentifier)
		}
		
		return view
	}
}


extension UICollectionView {
	
	func registerClassOf<T: UICollectionViewCell where T: Reusable>(_: T.Type) {
		
		registerClass(T.self, forCellWithReuseIdentifier: T.cs_reuseIdentifier)
	}
	
	func registerNibOf<T: UICollectionViewCell where T: Reusable, T: NibLoadable>(_: T.Type) {
		
		let nib = UINib(nibName: T.cs_nibName, bundle: nil)
		registerNib(nib, forCellWithReuseIdentifier: T.cs_reuseIdentifier)
	}
	
	func registerHeaderNibOf<T: UICollectionReusableView where T: Reusable, T: NibLoadable>(_: T.Type) {
		
		let nib = UINib(nibName: T.cs_nibName, bundle: nil)
		registerNib(nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: T.cs_reuseIdentifier)
	}
	
	func registerFooterClassOf<T: UICollectionReusableView where T: Reusable>(_: T.Type) {
		
		registerClass(T.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: T.cs_reuseIdentifier)
	}
	
	func dequeueReusableCell<T: UICollectionViewCell where T: Reusable>(forIndexPath indexPath: NSIndexPath) -> T {
		
		guard let cell = dequeueReusableCellWithReuseIdentifier(T.cs_reuseIdentifier, forIndexPath: indexPath) as? T else {
			fatalError("没有注册 identifier: \(T.cs_reuseIdentifier) 的 UICollectionViewCell")
		}
		
		return cell
	}
	
	func dequeueReusableSupplementaryView<T: UICollectionReusableView where T: Reusable>(ofKind kind: String, forIndexPath indexPath: NSIndexPath) -> T {
		
		guard let view = dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: T.cs_reuseIdentifier, forIndexPath: indexPath) as? T else {
			fatalError("没有注册 identifier: \(T.cs_reuseIdentifier) 的 UICollectionReusableView")
		}
		
		return view
	}
}
