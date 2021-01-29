//
//  DetailAddressBottomSheet.swift
//  iOSUI
//
//  Created by Israel Ermel on 28/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit

protocol DetailAddressBottomSheetDelegate {
    func saveAddress()
}

class DetailAddressBottomSheetView: UIView {
    
    //MARK: - delegate
    var delegate: DetailAddressBottomSheetDelegate?
 
    //MARK: - Properties
    private let btnAction: VinButton = {
        let bt = VinButton(type: .system)
        bt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        bt.title = "Adicionar Endereço"
        bt.setHeight(height: 44)
        return bt
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        createDetail()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
        self.addSubview(btnAction)
        btnAction.anchor(top: self.safeTopAnchor, left: self.safeLeftAnchor, right: self.safeRightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
    
    //MARK: - Config Views
    func createDetail() {
    
    }
}
