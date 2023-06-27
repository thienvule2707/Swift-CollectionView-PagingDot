//
//  ViewController.swift
//  Test_Paging_CollectionView
//
//  Created by Le Thien Vu (FHM.ADG) on 27/06/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControlContainer: UIView!
    
    lazy var pageControl: ExtendedpageControl = {
        let pageControl = ExtendedpageControl(numberOfPages: numberOfPages, currentPage: 0)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.indicatorColor = .systemGray
        pageControl.currentIndicatorColor = .red
        return pageControl
    }()
    
    private let numberOfPages = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        pageControlContainer.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: pageControlContainer.centerXAnchor, constant: -(pageControl.pageControllWidth / 2)),
            pageControl.heightAnchor.constraint(equalToConstant: 1.5)
        ])
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath)
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if pageControl.currentpage == indexPath.row {
                    guard let visible = self.collectionView.visibleCells.first else { return }
                    guard let index = self.collectionView.indexPath(for: visible)?.row else { return }
                    pageControl.currentpage = index
                }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

