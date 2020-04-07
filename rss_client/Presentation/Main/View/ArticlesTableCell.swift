//
//  ArticlesTableCell.swift
//  rss_client
//
//  Created by temir on 08.04.2020.
//  Copyright © 2020 temir. All rights reserved.
//

import UIKit

class ArticlesTableCell: UITableViewCell {

    @IBOutlet private weak var articleImage: UIImageView!
    @IBOutlet private weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setArticle(_ article: Article) {
        articleImage.downloadImage(with: article.imagePath)
        title.text = article.title
    }
}
