import UIKit

extension UITableView {
    public func reloadDataWithoutAnimation() {
        UIView.performWithoutAnimation { self.reloadData() }
    }
    
    public func reloadSectionsWithoutAnimation(sections: IndexSet) {
        UIView.performWithoutAnimation { self.reloadSections(sections, with: .none) }
    }
    
    public func insertSectionsWithoutAnimation(sections: IndexSet) {
        UIView.performWithoutAnimation { self.insertSections(sections, with: .none) }
    }
    
    public func deleteSectionsWithoutAnimation(sections: IndexSet) {
        UIView.performWithoutAnimation { self.deleteSections(sections, with: .none) }
    }
    
    public func reloadRowsWithoutAnimation(at: [IndexPath]) {
        UIView.performWithoutAnimation { self.reloadRows(at: at, with: .none) }
    }
    
    public func insertRowsWithoutAnimation(at: [IndexPath]) {
        UIView.performWithoutAnimation { self.insertRows(at: at, with: .none) }
    }
    
    public func deleteRowsWithoutAnimation(at: [IndexPath]) {
        UIView.performWithoutAnimation { self.deleteRows(at: at, with: .none) }
    }
}
