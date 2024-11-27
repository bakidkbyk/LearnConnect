//
//  CourseDetailViewController.swift
//  LearnConnect
//
//  Created by Melih Avcı on 27.11.2024.
//

import UIKit
import AVKit
import AVFoundation

final class CourseDetailViewController: BaseViewController<CourseDetailViewModel> {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play Video", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(CourseDetailViewController.self, action: #selector(playVideo), for: .touchUpInside)
        return button
    }()
    
    private let speedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["0.5x", "1x", "1.5x", "2x"])
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.addTarget(CourseDetailViewController.self, action: #selector(changeSpeed), for: .valueChanged)
        return segmentedControl
    }()
    
    private var player: AVPlayer?
    private var playerViewController: AVPlayerViewController?
    private var timeObserverToken: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContents()
        setLocalize()
        updateContents(image: viewModel.image, title: viewModel.title)
    }

    // MARK: - UI Layout
    private func addSubviews() {
        view.addSubview(imageView)
        imageView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        imageView.height(200)
        
        view.addSubview(playButton)
        playButton.centerInSuperview()
        playButton.width(200)
        playButton.height(50)
        
        view.addSubview(speedControl)
        speedControl.topToBottom(of: playButton, offset: 20)
        speedControl.centerXToSuperview()
    }

    // MARK: - Configure Contents And Localization
    private func configureContents() {
        view.backgroundColor = .systemBackground
    }

    private func setLocalize() {
        navigationItem.title = viewModel.title
    }

    private func updateContents(image: UIImage?, title: String?) {
        imageView.image = image
    }

    // MARK: - Actions
    @objc private func playVideo() {
        let videoName = viewModel.title.lowercased()
        
        guard let videoURL = Bundle.main.url(forResource: "\(videoName)", withExtension: "mp4") else {
            print("Video not found: \(videoName).mp4")
            return
        }

        let savedTime = UserDefaults.standard.double(forKey: "\(videoName)_savedTime")

        player = AVPlayer(url: videoURL)
        playerViewController = AVPlayerViewController()
        playerViewController?.player = player

        if savedTime > 0 {
            let startTime = CMTimeMakeWithSeconds(savedTime, preferredTimescale: 600)
            player?.seek(to: startTime)
        }

        present(playerViewController!, animated: true) {
            self.player?.play()
        }
        
        addObserverForVideoTime()
    }

    @objc private func changeSpeed() {
        guard let player = player else { return }
        
        let speed = getSpeedForSelectedSegment()
        
        player.rate = speed
    }

    private func getSpeedForSelectedSegment() -> Float {
        switch speedControl.selectedSegmentIndex {
        case 0: return 0.5
        case 1: return 1.0
        case 2: return 1.5
        case 3: return 2.0
        default: return 1.0
        }
    }

    private func addObserverForVideoTime() {
        guard let player = player else { return }
        
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 600), queue: .main) { [weak self] time in
            // Oynatma zamanını kaydediyoruz
            let currentTime = CMTimeGetSeconds(time)
            let videoName = self?.viewModel.title.lowercased() ?? ""
            UserDefaults.standard.set(currentTime, forKey: "\(videoName)_savedTime")
        }
    }
    
    deinit {
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
        }
    }
}


