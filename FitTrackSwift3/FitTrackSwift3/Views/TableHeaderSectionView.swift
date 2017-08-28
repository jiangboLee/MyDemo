//
//  TableHeaderSectionView.swift
//  YALFitnessConcept
//
//  Created by Roman on 22.03.16.
//  Copyright © 2016 Yalantis. All rights reserved.
//

import UIKit

private let startIndicatorPosition: CGFloat = 0.0

class TableHeaderSectionView: UITableViewHeaderFooterView, CellInterface {

    @IBOutlet
    fileprivate weak var timelineButton: UIButton!
    
    @IBOutlet
    fileprivate weak var statisticsButton: UIButton!
    
    @IBOutlet
    fileprivate weak var segmentView: SegmentView!
    
    // MARK - Lifecycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        configureButtons()
    }
    
    // MARK - Provate methods
    fileprivate func configureButtons() {
        timelineButton.setTitleColor(UIColor.activeSegmentButtonFontBackgroundColor(), for: .selected)
        timelineButton.setTitleColor(UIColor.white, for: UIControlState())
        statisticsButton.setTitleColor(UIColor.activeSegmentButtonFontBackgroundColor(), for: .selected)
        statisticsButton.setTitleColor(UIColor.white, for: UIControlState())
        timelineButton.isSelected = true
        statisticsButton.isSelected = false
    }

    // MARK - Actions
    @IBAction func timelineButtonTapped(_ sender: AnyObject) {
        timelineButton.isSelected = true
        statisticsButton.isSelected = false
        segmentView.setIndicatorPosition(startIndicatorPosition)
    }

    @IBAction func statisticsButtonTapped(_ sender: AnyObject) {
        statisticsButton.isSelected = true
        timelineButton.isSelected = false
        segmentView.setIndicatorPosition(statisticsButton.bounds.width)
    }

}
