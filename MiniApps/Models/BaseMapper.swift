import Foundation

class BaseModelMapper<S, L> {
    
    func toLocal(list: [S]?) -> [L] {
        guard let list = list else { return [] }
        return list.compactMap { $0 }
            .map { entity -> L in
            return toLocal(serverEntity: entity)
        }
    }

    func toLocal(serverEntity: S) -> L {
        preconditionFailure("This method must be overriden")
    }
    
    func toLocal(serverEntity: S?) -> L? {
        if let s = serverEntity {
            let l = self.toLocal(serverEntity: s)
            return l
        } else {
            return nil
        }
    }
}
