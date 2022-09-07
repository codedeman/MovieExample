//
//  MV3CollectionviewLayout.swift
//  MV3Framework
//
//  Created by Pham Kien on 23.11.21.
//

import UIKit

protocol MV3PrinterestLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath , cellWidth : CGFloat ) -> CGFloat
}

class MV3PrinterestLayout: UICollectionViewLayout {
    
    weak var delegate: MV3PrinterestLayoutDelegate?
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 7.5
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
      guard let collectionView = collectionView else {
        return 0
      }
      let insets = collectionView.contentInset
      return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
      return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
      guard let collectionView = collectionView else {
          return
      }
      let columnWidth = contentWidth / CGFloat(numberOfColumns)
      var xOffset: [CGFloat] = []
      for column in 0..<numberOfColumns {
          debugPrint("num column with \(CGFloat(column) * columnWidth)")
        xOffset.append(CGFloat(column) * columnWidth)
      }
      var column = 0
      var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
      for item in 0..<collectionView.numberOfItems(inSection: 0) {
        let indexPath = IndexPath(item: item, section: 0)
        let photoHeight = delegate?.collectionView( collectionView,
          heightForPhotoAtIndexPath: indexPath , cellWidth: columnWidth) ?? 180
        let height = cellPadding * 2 + photoHeight
        let frame = CGRect(x: xOffset[column],y: yOffset[column],width: columnWidth,height: height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = insetFrame
        cache.append(attributes)
        contentHeight = max(contentHeight, frame.maxY)
        yOffset[column] = yOffset[column] + height
        column = column < (numberOfColumns - 1) ? (column + 1) : 0
      }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
      
      // Loop through the cache and look for items in the rect
      for attributes in cache {
        if attributes.frame.intersects(rect) {
          visibleLayoutAttributes.append(attributes)
        }
      }
      return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
      return cache[indexPath.item]
    }
}

//
//extension MV3PrinterestLayoutDelegate where Self:MV3HomeVC {
//    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath , cellWidth : CGFloat ) -> CGFloat {
//        if indexPath.row > listMovie.count-1  {
//            return 0.0
//        } else {
//            if  let data = listMovie[indexPath.row].sizeImage {
//                let height = self.calculateImageHeight(sizeImage: data, scaledToWidth: cellWidth)
//                return  height
//            } else {
//                return 260
//            }
//        }
//    }
//}
