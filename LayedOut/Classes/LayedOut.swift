//
//  LayedOut.swift
//  Pods
//
//  Created by Oren F on 14/03/2017.
//
//

import UIKit

public extension NSLayoutAttribute {
    /// [.leading, .top, .trailing, .bottom]
    static var boxing: [NSLayoutAttribute] { return [.leading, .top, .trailing, .bottom] }
    var isPrivate: Bool { return self == .width || self == .height }
}

public enum UKFLayoutsDistribution {
    case horizontal, vertical
}

// MARK:- Functions
public extension UIView {
    
    // MARK:- To superview
    ///
    /// Matches contstraints between a view and it's superview's
    ///
    /// - Parameters:
    ///   - sprv: A view
    ///   - subv: A subview of the superview
    ///   - flags: An array of NSLayoutAttribute to set
    ///   - constant: The constant to set (value for constraint)
    /// - Returns: An array of NSLayoutConstraint
    @discardableResult
    class func applyConstraints(of sprv: UIView, on subv: UIView, with flags: [NSLayoutAttribute], constant: CGFloat = 0) -> [NSLayoutConstraint]  {
        return sprv.applyConstraints(to: subv, with: flags, constant: constant)
    }
    
    /// Matches a view's constraints to the provided subview
    ///
    /// - Parameters:
    ///   - subv: A subview of the caller
    ///   - flags: An array of NSLayoutAttribute to set
    ///   - constant: The constant to set (value for constraint)
    ///   - relation: NSLayoutRelation for each constraint
    /// - Returns: An array of NSLayoutConstraint
    @discardableResult
    func applyConstraints(to subv: UIView, with flags: [NSLayoutAttribute] = NSLayoutAttribute.boxing, constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> [NSLayoutConstraint] {
        assertThread()
        subv.translatesAutoresizingMaskIntoConstraints = false
        var cons: [NSLayoutConstraint] = []
        for attr in flags {
            let v = (attr == .bottom || attr == .trailing) ? -constant : constant
            let c = NSLayoutConstraint(item: subv, attribute: attr, relatedBy: relation, toItem: self, attribute: attr, multiplier: 1.0, constant: v)
            cons.append(c)
            self.addConstraint(c)
        }
        return cons
    }
    
    /// Match the caller's provided constraints to it's superview's
    ///
    /// - Parameters:
    ///   - flags: An array of NSLayoutAttribute to set
    ///   - constant: The constant to set (value for constraint)
    ///   - relation: NSLayoutRelation for each constraint
    /// - Returns: An array of NSLayoutConstraint
    @discardableResult
    func matchSuperview(_ flags: [NSLayoutAttribute] = NSLayoutAttribute.boxing, constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> [NSLayoutConstraint] {
        assertThread()
        return superview?.applyConstraints(to: self, with: flags, constant: constant, relation: relation) ?? []
    }
    
    /// Sets the trailing constraint to the caller's superview
    ///
    /// - Parameters:
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func setTrailing(_ constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = superview!.constraintWith(firstItem: superview, firstAttribute: .trailing, secondItem: self, secondAttribute: .trailing, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Sets the leading constraint to the caller's superview
    ///
    /// - Parameters:
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func setLeading(_ constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = constraintWith(firstItem: self, firstAttribute: .leading, secondItem: superview, secondAttribute: .leading, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Sets the bottom constraint to the caller's superview
    ///
    /// - Parameters:
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func setBottom(_ constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = superview!.constraintWith(firstItem: superview, firstAttribute: .bottom, secondItem: self, secondAttribute: .bottom, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Sets the top constraint to the caller's superview
    ///
    /// - Parameters:
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func setTop(_ constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = superview!.constraintWith(firstItem: self, firstAttribute: .top, secondItem: superview, secondAttribute: .top, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Sets the centerY constraint to the caller's superview
    ///
    /// - Parameters:
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func setCenterY(_ constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = superview!.constraintWith(firstItem: self, firstAttribute: .centerY, secondItem: superview, secondAttribute: .centerY, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Sets the centerX constraint to the caller's superview
    ///
    /// - Parameters:
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func setCenterX(_ constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = superview!.constraintWith(firstItem: self, firstAttribute: .centerX, secondItem: superview, secondAttribute: .centerX, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Sets the centerX and centerY constraints to the caller's superview
    ///
    /// - Parameters:
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func setCenter(_ constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> [NSLayoutConstraint] {
        var cons: [NSLayoutConstraint] = []
        cons.append(setCenterX(constant, relation: relation))
        cons.append(setCenterY(constant, relation: relation))
        return cons
    }
    
    // MARK:- To self
    
    /// Sets the height constraint of the caller
    ///
    /// - Parameters:
    ///   - constant: Constant value for the size
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func setHeight(_ constant: CGFloat, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        return addSizeConstraint(for: .height, with: constant, relation: relation)
    }
    
    /// Sets the width constraint of the caller
    ///
    /// - Parameters:
    ///   - constant: Constant value for the size
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func setWidth(_ constant: CGFloat, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        return addSizeConstraint(for: .width, with: constant, relation: relation)
    }
    
    // MARK:- To other view
    
    /// Set the sent view as the caller's trailing view
    ///
    /// - Parameters:
    ///   - otherView: The view to set as trailing
    ///   - spacing: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func setTrailingView(_ otherView: UIView, constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        assertSibling(with: otherView)
        let constraint = superview!.constraintWith(firstItem: otherView, firstAttribute: .leading, secondItem: self, secondAttribute: .trailing, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Set the sent view as the caller's leading view
    ///
    /// - Parameters:
    ///   - otherView: The view to set as trailing
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func setLeadingView(_ otherView: UIView, constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        return otherView.setTrailingView(self, constant: constant, relation: relation)
    }
    
    /// Set the sent view as the caller's top view
    ///
    /// - Parameters:
    ///   - otherView: The view to set as trailing
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func setTopView(_ otherView: UIView, constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        assertSibling(with: otherView)
        let constraint = superview!.constraintWith(firstItem: self, firstAttribute: .top, secondItem: otherView, secondAttribute: .bottom, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Set the sent view as the caller's bottom view
    ///
    /// - Parameters:
    ///   - otherView: The view to set as trailing
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func setBottomView(otherView: UIView, constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        return otherView.setTopView(self, constant: constant, relation: relation)
    }
    
    /// Matches the caller's centerY to a sibling view's centerY in the view hirarchy
    ///
    /// - Parameters:
    ///   - view: The view to match the constraint to
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func alignCenterY(with view: UIView, constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        assertSibling(with: view)
        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraint = superview!.constraintWith(firstItem: self, firstAttribute: .centerY, secondItem: view, secondAttribute: .centerY, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Matches the caller's centerX to a sibling view's centerX in the view hirarchy
    ///
    /// - Parameters:
    ///   - view: The view to match the constraint to
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func alignCenterX(with view: UIView, constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        assertSibling(with: view)
        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraint = superview!.constraintWith(firstItem: self, firstAttribute: .centerX, secondItem: view, secondAttribute: .centerX, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Matches the caller's top to a sibling view's top in the view hirarchy
    ///
    /// - Parameters:
    ///   - view: The view to match the constraint to
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func alignTop(with view: UIView, constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        assertSibling(with: view)
        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraint = superview!.constraintWith(firstItem: self, firstAttribute: .top, secondItem: view, secondAttribute: .top, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Matches the caller's leading to a sibling view's leading in the view hirarchy
    ///
    /// - Parameters:
    ///   - view: The view to match the constraint to
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func alignLeading(with view: UIView, constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        assertSibling(with: view)
        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraint = superview!.constraintWith(firstItem: self, firstAttribute: .leading, secondItem: view, secondAttribute: .leading, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Matches the caller's trailing to a sibling view's trailing in the view hirarchy
    ///
    /// - Parameters:
    ///   - view: The view to match the constraint to
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func alignTrailing(with view: UIView, constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        assertSibling(with: view)
        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraint = superview!.constraintWith(firstItem: self, firstAttribute: .trailing, secondItem: view, secondAttribute: .trailing, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Matches the caller's width to a sibling view's width in the view hirarchy
    ///
    /// - Parameters:
    ///   - view: The view to match the constraint to
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func matchWidth(with view: UIView, constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraint = superview!.constraintWith(firstItem: self, firstAttribute: .width, secondItem: view, secondAttribute: .width, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Matches the caller's height to a sibling view's height in the view hirarchy
    ///
    /// - Parameters:
    ///   - view: The view to match the constraint to
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    @discardableResult
    func matchHeight(with view: UIView, constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraint = superview!.constraintWith(firstItem: self, firstAttribute: .height, secondItem: view, secondAttribute: .height, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Matches the caller's bottom to a sibling view's bottom in the view hirarchy
    ///
    /// - Parameters:
    ///   - view: The view to match the constraint to
    ///   - constant: Constant value for the distance
    ///   - relation: NSLayoutRelation for the constraint
    /// - Returns: The created constraint
    @discardableResult
    func alignBottom(with view: UIView, constant: CGFloat = 0, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        assertSuperView()
        assertSibling(with: view)
        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraint = superview!.constraintWith(firstItem: self, firstAttribute: .bottom, secondItem: view, secondAttribute: .bottom, relation: relation, multiplier: 1.0, constant: constant)
        if !superview!.constraints.contains(constraint) {
            superview!.addConstraint(constraint)
        }
        return constraint
    }
    
    /// Aligns the subviews with same values (Same as UIStackView)
    ///
    /// - Parameters:
    ///   - distribution: horizontal or vertical
    ///   - verticalSpacing: Vertical distance between elements
    ///   - horizontalSpacing: Horizontal distance betwee elements
    ///   - includingEdges: A boolean value to determine whether the spacing should affect the first/last item space from parent
    func distributeSubviews(as distribution: UKFLayoutsDistribution, verticalSpacing: CGFloat = 0, horizontalSpacing: CGFloat = 0, includingEdges: Bool = true) {
        assertThread()
        guard subviews.count > 0 else { return }
        switch distribution {
        case .horizontal:
            horizontalDistribution(verticalSpacing: verticalSpacing, horizontalSpacing: horizontalSpacing, includingEdges: includingEdges)
        case .vertical:
            verticalDistribution(verticalSpacing: verticalSpacing, horizontalSpacing: horizontalSpacing, includingEdges: includingEdges)
        }
    }
}

// MARK:- Variables

public extension UIView {
    
    // MARK:- Layouts
    
    /// Return the top constraint for the caller, to any view, if exists
    var topConstraint: NSLayoutConstraint? {
        return find(attribute: .top)
    }
    
    /// Return the bottom constraint for the caller, to any view, if exists
    var bottomConstraint: NSLayoutConstraint? {
        return find(attribute: .bottom)
    }
    
    /// Return the leading constraint for the caller, to any view, if exists
    var leadingConstraint: NSLayoutConstraint? {
        return find(attribute: .leading)
    }
    
    /// Return the trailing constraint for the caller, to any view, if exists
    var trailingConstraint: NSLayoutConstraint? {
        return find(attribute: .trailing)
    }
    
    /// Return the width constraint for the caller, if exists
    var widthConstraint: NSLayoutConstraint? {
        return find(attribute: .width)
    }
    
    /// Return the height constraint for the caller, if exists
    var heightConstraint: NSLayoutConstraint? {
        return find(attribute: .height)
    }
    
    // MARK:- Frames
    
    var height: CGFloat {
        set {
            var rect = frame
            rect.size.height = newValue
            frame = rect
        }
        get {
            return frame.size.height
        }
        
    }
    
    var width: CGFloat {
        set {
            var rect = frame
            rect.size.width = newValue
            frame = rect
        }
        get {
            return frame.size.width
        }
    }
    
    var x: CGFloat {
        set {
            var rect = frame
            rect.origin.x = newValue
            frame = rect
        }
        get {
            return frame.origin.x
        }
    }
    
    var y: CGFloat {
        set {
            var rect = frame
            rect.origin.y = newValue
            frame = rect
        }
        get {
            return frame.origin.y
        }
    }
}

// MARK:- Private

fileprivate extension UIView {
    
    // MARK:- Layouts
    
    @discardableResult
    func addSizeConstraint(for attr: NSLayoutAttribute, with constant: CGFloat, relation: NSLayoutRelation = .equal) -> NSLayoutConstraint {
        assertThread()
        translatesAutoresizingMaskIntoConstraints = false
        assert(attr == .width || attr == .height, "addSizeConstraint:: only accepts width or height attributes")
        let constraint = constraintWith(firstItem: self, firstAttribute: attr, secondItem: nil, secondAttribute: .notAnAttribute, relation: relation, multiplier: 1.0, constant: constant)
        if !constraints.contains(constraint) {
            addConstraint(constraint)
        }
        return constraint
    }
    
    func horizontalDistribution(verticalSpacing: CGFloat, horizontalSpacing: CGFloat, includingEdges: Bool) {
        for (idx, view) in subviews.enumerated() {
            if idx == 0 {
                view.setTop(verticalSpacing)
                view.setBottom(verticalSpacing)
                view.setLeading(includingEdges ? horizontalSpacing : 0)
            } else {
                let prev = subviews[idx-1]
                view.setLeadingView(prev, constant: horizontalSpacing)
                let first = subviews.first!
                view.alignTop(with: first)
                view.alignBottom(with: first)
                view.matchWidth(with: first)
            }
            if idx == subviews.count - 1 {
                view.setTrailing(includingEdges ? horizontalSpacing : 0)
            }
        }
    }
    
    func verticalDistribution(verticalSpacing: CGFloat, horizontalSpacing: CGFloat, includingEdges: Bool) {
        for (idx, view) in subviews.enumerated() {
            if idx == 0 {
                view.setTrailing(horizontalSpacing)
                view.setLeading(horizontalSpacing)
                view.setTop(includingEdges ? verticalSpacing : 0)
            } else {
                let prev = subviews[idx-1]
                view.setTopView(prev, constant: verticalSpacing)
                let first = subviews.first!
                view.alignLeading(with: first)
                view.alignTrailing(with: first)
                view.matchHeight(with: first)
            }
            if idx == subviews.count - 1 {
                view.setBottom(includingEdges ? verticalSpacing : 0)
            }
        }
    }
    
    func constraintWith(firstItem: UIView?, firstAttribute: NSLayoutAttribute, secondItem: UIView?, secondAttribute: NSLayoutAttribute, relation: NSLayoutRelation, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        
        if let c = findConstaintWhere(firstItem: firstItem, firstAttribute: firstAttribute, secondItem: secondItem, secondAttribute: secondAttribute, relation: relation) {
            c.constant = constant
            return c
        }
        
        return NSLayoutConstraint(item: firstItem, attribute: firstAttribute, relatedBy: relation, toItem: secondItem, attribute: secondAttribute, multiplier: multiplier, constant: constant)
    }
    
    func findConstaintWhere(firstItem: UIView?, firstAttribute: NSLayoutAttribute, secondItem: UIView?, secondAttribute: NSLayoutAttribute, relation: NSLayoutRelation? = .equal) -> NSLayoutConstraint? {
        
        for c in constraints {
            if (c.firstItem as? UIView) == firstItem && c.firstAttribute == firstAttribute && (c.secondItem as? UIView) == secondItem && c.secondAttribute == secondAttribute {
                if let r = relation, c.relation == r || relation == nil {
                    return c
                }
            }
        }
        
        return nil
    }
    
    func findConstraint(for item: UIView?, attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        for c in constraints {
            if ((c.firstItem as? UIView) == item && c.firstAttribute == attribute) || ((c.secondItem as? UIView) == item && c.secondAttribute == attribute) {
                return c
            }
        }
        return nil
    }
    
    func find(attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        if attribute.isPrivate {
            return findConstraint(for: self, attribute: attribute)
        }
        return superview?.findConstraint(for: self, attribute: attribute)
    }
    
    // MARK:- Assertions
    
    var notSiblingAssertMessage: String { return "Views should be siblings of the save view" }
    
    func assertThread() {
        assert(Thread.isMainThread, "Trying to set constraint from a background thread")
    }
    
    func assertSuperView() {
        assert(superview != nil, "This view has no superview")
    }
    
    func assertSibling(with otherView: UIView) {
        assert(superview == otherView.superview, notSiblingAssertMessage)
    }
}
