//
//  CourseDetailViewController.swift
//  LearnConnect
//
//  Created by Baki Dikbıyık on 27.11.2024.
//

import AVKit
import AVFoundation

final class CourseDetailViewController: BaseViewController<CourseDetailViewModel> {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play Video", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
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
        
        playButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
    }

    private func addSubviews() {
        view.addSubview(imageView)
        imageView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        imageView.height(200)
        
        view.addSubview(playButton)
        playButton.centerInSuperview()
        playButton.size(.init(width: 200, height: 50))
    }

    private func configureContents() {
        view.backgroundColor = .systemBackground
    }

    private func setLocalize() {
        navigationItem.title = viewModel.title
    }
    
    private func updateContents(image: UIImage?, title: String?) {
        imageView.image = image
    }

    // MARK: - Video Oynatma ve Hız Ayarı
    @objc private func playVideo() {
        let videoName = viewModel.title.lowercased()
        guard let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4") else {
            print("Video not found: \(videoName).mp4")
            return
        }
        
        player = AVPlayer(url: videoURL)
        playerViewController = AVPlayerViewController()
        playerViewController?.player = player

        let savedTime = UserDefaults.standard.double(forKey: "\(videoName)_savedTime")
        if savedTime > 0 {
            let startTime = CMTimeMakeWithSeconds(savedTime, preferredTimescale: 600)
            player?.seek(to: startTime)
        }
        
        present(playerViewController!, animated: true) {
            self.player?.play()
        }
        
        addObserverForVideoTime()
    }

    // MARK: - Video Hız Ayarını Yapma
    private func setPlayerSpeed(_ speed: Float) {
        guard let player = player else { return }
        player.rate = speed // AVPlayer üzerinden hız ayarı
    }
    
    @objc private func changeSpeed() {
        let speed: Float = 1.5  // Hız değeri 1.5x
        setPlayerSpeed(speed)
    }

    // MARK: - Video Zamanını Kaydetme
    private func addObserverForVideoTime() {
        guard let player = player else { return }
        
        // Her saniye video zamanını kaydetmek için observer ekliyoruz
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 600), queue: .main) { [weak self] time in
            let currentTime = CMTimeGetSeconds(time)
            let videoName = self?.viewModel.title.lowercased() ?? ""
            UserDefaults.standard.set(currentTime, forKey: "\(videoName)_savedTime")
        }
    }

    // MARK: - Cleanup
    deinit {
        if let token = timeObserverToken {
            player?.removeTimeObserver(token)
        }
    }
}









