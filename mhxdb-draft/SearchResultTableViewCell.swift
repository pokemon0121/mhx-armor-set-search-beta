//
//  SearchResult.swift
//  mhxdb-draft
//
//  Created by Gardevoir on 10/27/16.
//  Copyright © 2016 Yimu Gao. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var columnNameLabel: UILabel!
    
    @IBOutlet weak var columnValueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
