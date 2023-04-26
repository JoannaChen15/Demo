//
//  ViewController.swift
//  Demo
//
//  Created by 譚培成 on 2023/4/18.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let musicVideoImage = UIImageView()
    let pageControl = UIPageControl()
    let segment = UISegmentedControl()
    let name = UILabel()
    let lyrics = UITextView()
    let musicVideos = ["或是一首歌", "無人知曉", "皆可"]
    let names = ["或是一首歌", "無人知曉", "皆可"]
    let songLyrics = [
    """
    我把我的靈魂送給你
    或是一首歌
    帶你潛進深海裡
    
    我把我的秘密借給你
    一些孤獨的 自言自語
    
    我把我的靈魂送給你
    或是一首歌
    帶你潛進深海裡
    
    我把我的秘密借給你
    一些孤獨的 自言自語
    
    春天的憂愁 是拚命揮灑毫無保留
    世界的盡頭 是悲傷和快樂相同
    
    我無處可躲
    藏在影子背後任憑時光溜走
    沒有人對我說 除了溫柔的晚風
    
    春天的憂愁 是拚命揮灑毫無保留
    世界的盡頭 是悲傷和快樂相同
    
    我無處可躲
    藏在影子背後任憑時光溜走
    沒有人對我說 除了溫柔的晚風
    
    我把我的靈魂送給你
    或是一首歌
    帶你潛進深海裡
    
    我把我的秘密借給你
    一些孤獨的 自言自語
    """,
    """
    我像是 小數點 第幾位
    存在但 能自動 被省略
    
    也習慣不避嫌 跟你看作一對
    
    你也算 夠謹慎 的同類
    踏著卻 不逾越 那條線
    
    發生一切 或不發生一切
    又有什麼 差別
    
    看不見 聽不到 愛不了
    卻注定要糾結
    
    我想我 是壞人
    故意不聽懂你的拒絕
    
    難以昭告世界 愛上你多優越
    無人知曉 可不可憐
    
    不靠近 不走遠 不定義
    像玩笑的曖昧
    
    你說你 是壞人
    想安定也沒缺過消遣
    
    無權為你崩潰 卻帶一點慚愧
    我不夠好 害你虧欠
    
    還能夠 再糾纏 幾個月
    像爛戲 碰上了 好演員
    
    你想矯情一點 我就加倍收斂
    
    陪到你 有下個 新對象
    記得要 找台階 讓我下
    
    兄弟姐妹 你就賜個稱謂
    反正我沒 負累
    
    看不見 聽不到 愛不了
    卻注定要糾結
    
    我想我 是壞人
    故意不聽懂你的拒絕
    
    難以昭告世界 愛上你多優越
    無人知曉 可不可憐
    
    不靠近 不走遠 不定義
    像玩笑的曖昧
    
    你說你 是壞人 想安定
    也沒缺過消遣
    
    無權為你崩潰 卻帶一點慚愧
    我不夠好 害你虧欠
    
    好狡猾 好僥倖 好浪費
    誰道歉 都虛偽
    
    我們都 是壞人 沒籌碼
    卻想賭贏一切
    
    貪圖痛徹心扉 找不到施力點
    你既是誰 又不是誰
    
    進不進 退不退 又怎樣
    愛不愛 等不等 都不說
    
    無人知曉 多美
    """,
    """
    可以只睡覺嗎
    不做成 什麼夢
    
    可以只呼吸嗎
    不吞吐 茫茫人生
    
    不勇敢 不慌張 不懷疑 不信仰
    不用有什麼
    
    不聰明 不笨拙 不怕錯 也不害怕
    不錯
    
    我可不可以 飄蕩成雨
    可不可以 碎裂成瓦礫
    可不可以 開成一朵 粉的雲
    
    誰懂我
    可不可以 心向光明
    可不可以 身陷在泥濘
    可不可以 僅僅擁抱我自己
    
    不勇敢 不慌張 不懷疑 不信仰
    不用有什麼
    
    好在 不聰明 不笨拙 不怕錯
    也不害怕 不錯
    
    我可不可以 飄蕩成雨
    可不可以 碎裂成瓦礫
    可不可以 開成一朵 粉的雲
    
    誰懂我
    可不可以 心向光明
    可不可以 身陷在泥濘
    可不可以 緊緊擁抱 我自己
    
    隨便我
    變成一粒塵 還是一顆星
    變成了海洋 還是空氣
    
    變成了自己 放過了自己
    都可以
    
    隨便我
    想要去哪裡 偏去了哪裡
    路過誰懷裡 誰的心裡
    
    看透了風景 淪為了風景
    都可以
    
    容我 哄哄 自己
    """
    ]
    let lastButton = UIButton()
    let nextButton = UIButton()
    let swipeGestureLeft = UISwipeGestureRecognizer()
    let swipeGestureRight = UISwipeGestureRecognizer()
    var index = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        lastButton.addTarget(self, action: #selector(lastButtonPressed), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        pageControl.addTarget(self, action: #selector(selectPage), for: .valueChanged)
        segment.addTarget(self, action: #selector(selectSegment), for: .valueChanged)
        swipeGestureLeft.addTarget(self, action: #selector(handleSwipeGesture))
        swipeGestureRight.addTarget(self, action: #selector(handleSwipeGesture))
    }
    
    func updateUI() {
        musicVideoImage.image = UIImage(named: musicVideos[index])
        name.text = names[index]
        lyrics.text = songLyrics[index]
        pageControl.currentPage = index
        segment.selectedSegmentIndex = index
    }
    
    @objc func selectPage(_ sender: UIPageControl) {
        index = pageControl.currentPage
        updateUI()
    }
    
    @objc func selectSegment(_ sender: UISegmentedControl) {
        index = segment.selectedSegmentIndex
        updateUI()
    }
    
    @objc func lastButtonPressed(_ sender: UIButton) {
        index = (index - 1 + musicVideos.count) % musicVideos.count
        updateUI()
    }
    
    @objc func nextButtonPressed(_ sender: UIButton) {
        index = (index + 1) % musicVideos.count
        updateUI()
    }
    
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            index = (index - 1 + musicVideos.count) % musicVideos.count
            updateUI()
        } else if gesture.direction == .left {
            index = (index + 1) % musicVideos.count
            updateUI()
        }
    }
    
    
    func configUI() {
        configMusicVideoImage()
        configPageControl()
        configSegment()
        configName()
        configLyrics()
        configLastButton()
        configNextButton()
        configSwipeGesture()
    }
    
    func configMusicVideoImage() {
        musicVideoImage.backgroundColor = .darkGray
        musicVideoImage.image = UIImage(named: musicVideos[index])
        view.addSubview(musicVideoImage)
        musicVideoImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(musicVideoImage.snp.width).multipliedBy(0.5625)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(60)
        }
    }
    
    func configLastButton() {
        lastButton.setImage(UIImage(systemName: "arrowtriangle.left.fill"), for: .normal)
        lastButton.tintColor = .systemPink
        view.addSubview(lastButton)
        lastButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerY.equalTo(name.snp.centerY)
            make.leading.equalToSuperview().inset(50)
        }
    }
    
    func configNextButton() {
        nextButton.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        nextButton.tintColor = .systemPink
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerY.equalTo(name.snp.centerY)
            make.trailing.equalToSuperview().inset(50)
        }
    }
    
    func configPageControl() {
        pageControl.numberOfPages = 3
        pageControl.currentPage = index
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(musicVideoImage.snp.bottom).offset(10)
            
        }
    }
    
    func configSegment() {
        segment.insertSegment(withTitle: "或是一首歌", at: 0, animated: true)
        segment.insertSegment(withTitle: "無人知曉", at: 1, animated: true)
        segment.insertSegment(withTitle: "皆可", at: 2, animated: true)
        segment.selectedSegmentIndex = index
        segment.backgroundColor = .systemPink
        view.addSubview(segment)
        segment.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pageControl.snp.bottom).offset(30)
        }
    }
    
    func configName() {
        name.text = names[index]
        name.font = .systemFont(ofSize: 28)
        name.textColor = .systemBackground
        view.addSubview(name)
        name.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(segment.snp.bottom).offset(40)
        }
    }
    
    func configLyrics() {
        lyrics.text = songLyrics[index]
        lyrics.textAlignment = NSTextAlignment.center
        lyrics.font = .systemFont(ofSize: 20)
        lyrics.backgroundColor = .clear
        lyrics.textColor = .systemBackground
        lyrics.isEditable = false
        view.addSubview(lyrics)
        lyrics.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(name.snp.bottom).offset(30)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalToSuperview().inset(60)
        }
    }
    
    func configSwipeGesture() {
        view.addGestureRecognizer(swipeGestureLeft)
        swipeGestureLeft.direction = .left
        view.addGestureRecognizer(swipeGestureRight)
        swipeGestureRight.direction = .right
    }
}
