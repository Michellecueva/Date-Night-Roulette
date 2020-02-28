//
//  MatchedCell.swift
//  Date-Night
//
//  Created by Krystal Campbell on 2/27/20.
//  Copyright © 2020 Date Night Roulette. All rights reserved.
//

import UIKit

class MatchedCell: UITableViewCell {

    static let identifier = "MatchedCell"
    
    var titleLabel: UILabel = {
          let label = UILabel()
          return label
      }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   func configureCell(with events: MatchedEventsHistory, row: Int) {
    titleLabel.text = events.title
    titleLabel.textColor = #colorLiteral(red: 0.9164920449, green: 0.7743749022, blue: 0.9852260947, alpha: 1)
    backgroundColor = .clear
      }
    
      private func addSubviews() {
             self.contentView.addSubview(titleLabel)
         }
    
    private func setConstraints() {
          setTitleLabelConstraints()
      }
    
    private func setTitleLabelConstraints() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
         
    NSLayoutConstraint.activate([
    titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
    titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
    titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
    titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6)
         ])
     }
     

}
