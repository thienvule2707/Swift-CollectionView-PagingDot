//
//  ExtendedpageControll.swift
//  Test_Paging_CollectionView
//
//  Created by Le Thien Vu (FHM.ADG) on 27/06/2023.
//

import UIKit

class ExtendedpageControl: UIView{
    var numberOfPage: Int
    var currentpage : Int = 0 {
        didSet {
            reloadView()
        }
    }
    
    var currentIndicatorColor: UIColor = .black
    var indicatorColor: UIColor = UIColor(white: 0.9, alpha: 1)
    var pageControllWidth: CGFloat = 0
    private var dotView = [UIView]()
    private var dotViewWidth: CGFloat = 0
    
    init(numberOfPages: Int, currentPage: Int) {
        self.numberOfPage = numberOfPages
        self.currentpage = currentPage
        super.init(frame: .zero)
        configView()
    }
    
    required init?(coder: NSCoder) {fatalError("not implemented")}
    
    private func configView(){
        backgroundColor = .clear
        self.pageControllWidth = 12 * 2 * CGFloat(self.numberOfPage)
        (0..<numberOfPage).forEach { _ in
            let view = UIView()
            addSubview(view)
            dotView.append(view)
        }
    }
    
    private func reloadView(){
        dotView.forEach {
            $0.backgroundColor = indicatorColor
            
        }
        dotView[currentpage].backgroundColor = currentIndicatorColor
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            for dot in self.dotView {
                dot.frame.origin.x   = dot.frame.origin.x - 12
                dot.frame.size.width = dot.frame.size.width + 12
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let spacing: CGFloat = 4
        for (i,view) in dotView.enumerated(){
            view.clipsToBounds = true
            view.layer.cornerRadius = bounds.height / 2
            let width: CGFloat = CGFloat(pageControllWidth / CGFloat(self.numberOfPage) - spacing) - 12
            
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self else { return }
                view.frame = CGRect(x: ((self.pageControllWidth / CGFloat(self.numberOfPage)) * CGFloat(i)) + spacing, y: 0, width: width , height: self.bounds.height)
            }
        }
        reloadView()
    }
}
