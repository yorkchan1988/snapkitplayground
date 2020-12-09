//
//  ViewController.swift
//  SnapKitPlayground
//
//  Created by YORK CHAN on 8/12/2020.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let VIEW_IMAGE_HEIGHT_REGULAR_RATIO = 0.4
    private let VIEW_IMAGE_WIDTH_COMPACT_RATIO = 0.5
    private let VIEW_IMAGE_PADDING : CGFloat = 30.0
    
    // Views
    lazy private var viewImage: UIView = UIView()
    lazy private var viewTemperature: UIView = UIView()
    lazy private var imgViewCloud: UIImageView = UIImageView()
    lazy private var viewTextContainer: UIView = UIView()
    lazy private var lblCityName: UILabel = UILabel()
    lazy private var lblTemperature: UILabel = UILabel()
    
    // Constraints
    private var compactContraints: [Constraint] = []
    private var regularContraints: [Constraint] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(viewImage)
        viewImage.backgroundColor = UIColor(red: 74/255, green: 171/255, blue: 247/255, alpha: 1)
        viewImage.snp.prepareConstraints { [weak self] (maker) in
            
            if let strongSelf = self {
                // generate regular constraints
                let regularConstraintHeightRatio = maker.height.equalToSuperview().multipliedBy(VIEW_IMAGE_HEIGHT_REGULAR_RATIO).constraint
                let regularConstraintLeftRightTopMargins = maker.left.right.top.equalToSuperview().constraint
            
                strongSelf.regularContraints.append(regularConstraintHeightRatio)
                strongSelf.regularContraints.append(regularConstraintLeftRightTopMargins)
            
                // generate compact constraints
                let compactConstraintWidthRatio = maker.width.equalToSuperview().multipliedBy(VIEW_IMAGE_WIDTH_COMPACT_RATIO).constraint
                let compactConstraintTopBottomLeftMargins = maker.top.bottom.left.equalToSuperview().constraint
            
                strongSelf.compactContraints.append(compactConstraintWidthRatio)
                strongSelf.compactContraints.append(compactConstraintTopBottomLeftMargins)
            }
        }
         
        self.view.addSubview(viewTemperature)
        viewTemperature.backgroundColor = UIColor(red: 55/255, green: 128/255, blue: 186/255, alpha: 1)
        viewTemperature.snp.prepareConstraints { [weak self] (maker) in
            
            if let strongSelf = self {
                // generate regular constraints
                let regularConstraintVerticalSpacing = maker.top.equalTo(strongSelf.viewImage.snp.bottom).constraint
                let regularConstraintLeftRightBottomMargins = maker.left.right.bottom.equalToSuperview().constraint
            
                strongSelf.regularContraints.append(regularConstraintVerticalSpacing)
                strongSelf.regularContraints.append(regularConstraintLeftRightBottomMargins)
            
                // generate compact constraints
                let compactConstraintHorizontalSpacing = maker.left.equalTo(strongSelf.viewImage.snp.right).constraint
                let compactConstraintTopBottomRightMargins = maker.top.bottom.right.equalToSuperview().constraint
            
                strongSelf.compactContraints.append(compactConstraintHorizontalSpacing)
                strongSelf.compactContraints.append(compactConstraintTopBottomRightMargins)
            }
        }
        
        self.view.addSubview(imgViewCloud)
        imgViewCloud.image = UIImage(named: "cloud_small")
        imgViewCloud.contentMode = .scaleAspectFit
        imgViewCloud.snp.makeConstraints { [weak self] (maker) in
            if let strongSelf = self {
                let edgeInset = UIEdgeInsets(top: VIEW_IMAGE_PADDING, left: VIEW_IMAGE_PADDING, bottom: VIEW_IMAGE_PADDING, right: VIEW_IMAGE_PADDING)
                maker.edges.equalTo(strongSelf.viewImage).inset(edgeInset)
            }
        }
        
        viewTextContainer.addSubview(lblCityName)
        viewTextContainer.addSubview(lblTemperature)
        viewTemperature.addSubview(viewTextContainer)
        lblCityName.text = "London"
        lblCityName.font = UIFont.systemFont(ofSize: 120.0, weight: .thin)
        lblTemperature.text = "15C"
        lblTemperature.font = UIFont.systemFont(ofSize: 200.0, weight: .thin)
        lblTemperature.textAlignment = .center
        
        viewTextContainer.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        lblCityName.snp.makeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
        }
        lblTemperature.snp.makeConstraints { [weak self] (maker) in
            if let strongSelf = self {
                maker.left.right.bottom.equalToSuperview()
                maker.top.equalTo(strongSelf.lblCityName.snp.bottom)
            }
        }
        
        if self.traitCollection.verticalSizeClass == .compact {
            _ = compactContraints.map { $0.activate() }
        }
        else {
            _ = regularContraints.map { $0.activate() }
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.verticalSizeClass == .compact {
            _ = regularContraints.map { $0.deactivate() }
            _ = compactContraints.map { $0.activate() }
        }
        else {
            _ = compactContraints.map { $0.deactivate() }
            _ = regularContraints.map { $0.activate() }
        }
    }
}

