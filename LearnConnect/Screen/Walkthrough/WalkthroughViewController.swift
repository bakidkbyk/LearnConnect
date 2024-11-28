//
//  WalkthroughViewController.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 25.11.2024.
//

import UIKit

final class WalkthroughViewController: BaseViewController<WalkthroughViewModel> {
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal  
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .appWhite
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        return pageControl
    }()
    
    private let nextActionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("İleri", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .appRed
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        setLocalize()
        addSubViews()
        self.overrideUserInterfaceStyle = .unspecified
    }
}

// MARK: - UILayout
extension WalkthroughViewController {

    private func addSubViews() {
        addCollectionView()
        addPageControl()
        addActionButton()
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
    }
    
    private func addPageControl() {
        view.addSubview(pageControl)
        pageControl.topToBottom(of: collectionView)
        pageControl.centerXToSuperview()
    }
    
    private func addActionButton() {
        view.addSubview(nextActionButton)
        nextActionButton.topToBottom(of: pageControl).constant = 20
        nextActionButton.leadingToSuperview().constant = 15
        nextActionButton.trailingToSuperview().constant = -15
        nextActionButton.bottomToSuperview(usingSafeArea: true)
    }
}

// MARK: - Configure Contents and Localize
extension WalkthroughViewController {
    
    private func configureContents() {
        view.backgroundColor = .appWhite
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WalkthroughCell.self, forCellWithReuseIdentifier: "WalkthroughCell")
        nextActionButton.height(60)
        pageControl.addTarget(self, action: #selector(pageControlChanged), for: .touchUpInside)
        nextActionButton.addTarget(self, action: #selector(nextActionButtonTapped), for: .touchUpInside)
    }
    
    private func setLocalize() {
        nextActionButton.setTitle(WalkthroughTexts.nextActionButtonNext, for: .normal)
    }
}

// MARK: - UICollectionView Delegate
extension WalkthroughViewController: UICollectionViewDelegate {}

// MARK: - CollectionView Data Source
extension WalkthroughViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsAt()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WalkthroughCell = collectionView.dequeueReusableCell(for: indexPath)
        let cellItem = viewModel.cellItemAt(indexPath: indexPath)
        cell.set(viewModel: cellItem)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WalkthroughViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}

// MARK: - UIScroll View Delegate
extension WalkthroughViewController {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if pageControl.currentPage == viewModel.numberOfItemsAt() - 1 {
            nextActionButton.setTitle(WalkthroughTexts.nextActionButtonStart, for: .normal)
        } else {
            nextActionButton.setTitle(WalkthroughTexts.nextActionButtonNext, for: .normal)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let xPoint = targetContentOffset.pointee.x
        let pageIndex = Int(xPoint / view.frame.width)
        pageControl.currentPage = pageIndex
    }
}

// MARK: - Actions
extension WalkthroughViewController {
    
    @objc
    func dissmissButtonTapped() {
        viewModel.didFinishWalkthrough()
    }
    
    @objc
    func nextActionButtonTapped() {
        if pageControl.currentPage == viewModel.numberOfItemsAt() - 1 {
            viewModel.didFinishWalkthrough()
        }
        
        pageControl.currentPage += 1
        
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc
    func pageControlChanged(_ sender: UIPageControl) {
        collectionView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(sender.currentPage), y: 0), animated: true)
    }
}
