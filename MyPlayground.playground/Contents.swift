import UIKit

public struct SavePhotoPetEntity {
    
    public var id: String
    public var photo: String
    
    public init(id: String, photo: String) {
        self.id = id
        self.photo = photo
    }
}

public struct SavePhotoPetViewModel {
    
    let id: String
    let photo: String
    
    public init(id: String, photo: String) {
        self.id = id
        self.photo = photo
    }
    
    func toEntity() -> SavePhotoPetEntity {
        return SavePhotoPetEntity(id: id, photo: photo)
    }
    
}
\public typealias Object = RealmSwiftObject

public typealias ObjectBase = RLMObjectBase

var listaphotos = [SavePhotoPetViewModel]()

listaphotos.append(SavePhotoPetViewModel(id: "1324", photo: "teste1"))
listaphotos.append(SavePhotoPetViewModel(id: "1111", photo: "teste2"))

var teste = listaphotos.map({ $0.toEntity() })

print(teste)




