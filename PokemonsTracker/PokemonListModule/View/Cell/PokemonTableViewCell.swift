import UIKit

class PokemonTableViewCell: UITableViewCell {
    static let reuseId = "PokemonTableViewCell"
    
    // MARK: - Creating custom cell objects
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CellColor")
        return view
    }()
    
    let isSelectedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "MainColor")
        
        // MARK: - temporary
        view.isHidden = true
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        label.textColor = UIColor(named: "TextColor")
        label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .vertical)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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

    func overlayFirstLayer() {
        addSubview(cardView)
        addSubview(isSelectedView)
        
        cardView.setPosition(top: topAnchor,
                             left: leftAnchor,
                             bottom: bottomAnchor,
                             right: rightAnchor,
                             paddingTop: 12,
                             paddingLeft: 12,
                             paddingBottom: 16,
                             paddingRight: 12,
                             height: 50)
        
        isSelectedView.setPosition(top: cardView.topAnchor,
                                   left: cardView.leftAnchor,
                                   bottom: cardView.bottomAnchor,
                                   right: nil,
                                   paddingTop: 0,
                                   paddingLeft: 0,
                                   paddingBottom: 0,
                                   paddingRight: 0,
                                   width: 5,
                                   height: 0)
    }

    func overlaySecondLayer() {
        cardView.addSubview(titleLabel)
        
        titleLabel.setPosition(top: cardView.topAnchor,
                               left: cardView.leftAnchor,
                               bottom: nil,
                               right: cardView.rightAnchor,
                               paddingTop: 16,
                               paddingLeft: 12,
                               paddingBottom: 0,
                               paddingRight: 20)
    }
}
