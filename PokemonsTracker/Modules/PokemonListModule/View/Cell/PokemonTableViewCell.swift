import UIKit

class PokemonTableViewCell: UITableViewCell {
    static let reuseId = "PokemonTableViewCell"
    
    // MARK: - Creating custom cell objects
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CellColor")
        return view
    }()
    
//    let isSelectedView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(named: "TextColor")
//        view.layer.cornerRadius = 10
//        return view
//    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        label.textColor = UIColor(named: "TextColor")
        label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        return label
    }()
    
    private let numLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0, weight: .bold)
        label.textColor = UIColor(named: "TextColor")
        label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        accessoryType = .disclosureIndicator
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 15
        cardView.clipsToBounds = true
        
        overlayFirstLayer()
        overlaySecondLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func overlayFirstLayer() {
        addSubview(cardView)
        //addSubview(isSelectedView)
        
        cardView.setPosition(top: topAnchor,
                             left: leftAnchor,
                             bottom: bottomAnchor,
                             right: rightAnchor,
                             paddingTop: 12,
                             paddingLeft: 12,
                             paddingBottom: 16,
                             paddingRight: 12,
                             height: 60)
        
        //isSelectedView.setPosition(top: cardView.topAnchor,
//                                   left: cardView.leftAnchor,
//                                   bottom: cardView.bottomAnchor,
//                                   right: nil,
//                                   paddingTop: 0,
//                                   paddingLeft: 0,
//                                   paddingBottom: 0,
//                                   paddingRight: 0,
//                                   width: 5,
//                                   height: 0)
    }

    private func overlaySecondLayer() {
        cardView.addSubview(numLabel)
        cardView.addSubview(nameLabel)
        
        numLabel.setPosition(top: cardView.topAnchor,
                               left: cardView.leftAnchor,
                               bottom: nil,
                               right: cardView.rightAnchor,
                               paddingTop: 10,
                               paddingLeft: 12,
                               paddingBottom: 0,
                               paddingRight: 20)
        
        nameLabel.setPosition(top: cardView.topAnchor,
                              left: numLabel.leftAnchor,
                              bottom: nil,
                              right: numLabel.rightAnchor,
                              paddingTop: 17,
                              paddingLeft: 50,
                              paddingBottom: 0,
                              paddingRight: 20)
    }
    
    func setLabelText(num: String, name: String) {
        numLabel.text = num
        nameLabel.text = name
    }
}
