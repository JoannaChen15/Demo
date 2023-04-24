//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let albumImage = UIImageView()
    let lyrics = UILabel()
    let segment = UISegmentedControl()
    let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
    }
    
    func configUI() {
        configAlbumImage()
        configLyrics()
        configSegment()
        configPageControl()
    }
    
    func configAlbumImage() {
        albumImage.backgroundColor = .darkGray
        view.addSubview(albumImage)
        albumImage.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }
    }
    
    func configLyrics() {
        lyrics.text = """
        我把我的靈魂送給你
        或是一首歌
        帶你潛進深海裡
        我把我的秘密借給你
        一些孤獨的 自言自語
        """
        lyrics.numberOfLines = 0
        view.addSubview(lyrics)
        lyrics.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(albumImage.snp.bottom).offset(50)
        }
    }
    
    func configSegment() {
        segment.insertSegment(withTitle: "或是一首歌", at: 0, animated: true)
        segment.insertSegment(withTitle: "諷刺的情書", at: 1, animated: true)
        segment.insertSegment(withTitle: "無人知曉", at: 2, animated: true)
        segment.selectedSegmentIndex = 0
        view.addSubview(segment)
        segment.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(lyrics.snp.bottom).offset(50)
        }
    }
    
    func configPageControl() {
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(segment.snp.bottom).offset(50)
        }
    }
}
