import UIKit

extension UIView {
  func autoRemoveConstraint(_ constraint: NSLayoutConstraint?) {
    if constraint != nil {
      self.removeConstraint(constraint!)
    }
  }
    func overlapHitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        // 1
        if !self.isUserInteractionEnabled || self.isHidden || self.alpha == 0 || self.backgroundColor == .clear {
            return nil
        }
        //2
        var hitView: UIView? = self
        if !self.point(inside: point, with: event) {
            if self.clipsToBounds {
                return nil
            } else {
                hitView = nil
            }
        }
        //3
        for subview in self.subviews.reversed() {
            let insideSubview = self.convert(point, to: subview)
            if let sview = subview.overlapHitTest(point: insideSubview, withEvent: event) {
                return sview
            }
        }
        return hitView
    }
}
