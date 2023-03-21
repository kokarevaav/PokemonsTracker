import UIKit

class ImagesCollectionView: UICollectionView {
    private var images = [Data]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = UIColor(named: "MainColor")
        
        delegate = self
        dataSource = self
        register(ImagesCollectionViewCell.self, forCellWithReuseIdentifier: ImagesCollectionViewCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImages(images: [Data]) {
        self.images = images
    }
    
    func setNoImageState() {
        guard let data = UIImage(named: "NoImage")?.pngData() else { return  }
        self.images.append(data)

    }
}

extension ImagesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: ImagesCollectionViewCell.reuseId, for: indexPath) as! ImagesCollectionViewCell
        cell.pokemonImageView.convertDataToImage(data: images[indexPath.row])
        return cell
    }
    
}

extension ImagesCollectionView: UICollectionViewDelegate {
    
}

extension ImagesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 310, height: 280)
    }
}
