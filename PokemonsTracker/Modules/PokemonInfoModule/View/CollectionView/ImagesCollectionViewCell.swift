import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    static let reuseId = "ImagesCollectionViewCell"
    
    let pokemonImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let imageBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor(named: "CellColor")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        overlayFirstLayer()
        overlaySecondLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func overlayFirstLayer() {
        addSubview(imageBackgroundView)
        
        imageBackgroundView.setPosition(top: topAnchor,
                                 left: leftAnchor,
                                 bottom: bottomAnchor,
                                 right: rightAnchor)
    }
    
    func overlaySecondLayer() {
        imageBackgroundView.addSubview(pokemonImageView)
        
        pokemonImageView.setPosition(top: imageBackgroundView.topAnchor,
                                 left: imageBackgroundView.leftAnchor,
                                 bottom: imageBackgroundView.bottomAnchor,
                                 right: imageBackgroundView.rightAnchor,
                                 paddingTop: 50,
                                 paddingLeft: 50,
                                 paddingBottom: 50,
                                 paddingRight: 50)
    }
}
