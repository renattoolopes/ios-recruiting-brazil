//
//  MovieCell.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 11/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit
import Stevia

class MovieCell: UICollectionViewCell {
    public static let identifier = "movieCellIdentifier"
    private var posterImage = UIImageView.init()
    private var title = UILabel.init()
    private var favoriteIcon = UIImageView.init()
    private let margin: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subViews()
        autolayout()
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func subViews() {
        sv(posterImage, title, favoriteIcon)
    }
    private func style() {
        backgroundColor = .blue
        let font = UIFont.systemFont(ofSize: 12)
        title.textColor = .white
        title.font = font
        title.numberOfLines = 2
        posterImage.image = UIImage.init(named: "placeholder-movies")
        favoriteIcon.image = UIImage.init(named: "favorites")
    }
    
    private func autolayout() {
        let heightCell = (UIScreen.main.bounds.height / 3)
        let favoriteSpace = (heightCell / 4)
        
        posterImage.leading(margin).trailing(margin).top(margin)
        posterImage.height(heightCell - favoriteSpace)
        
        favoriteIcon.trailing(margin)
        favoriteIcon.Top == posterImage.Bottom + margin
        favoriteIcon.height(24).width(24)
        title.bottom(margin).leading(margin).Trailing == (favoriteIcon.Leading + margin)
        title.Top == posterImage.Bottom
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        posterImage.image = nil
        favoriteIcon.image = nil
    }
    
    public func fill(withMovie movie: Movie) {
        title.text = movie.title
    }
}
