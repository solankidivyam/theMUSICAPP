//
//  PlayerViewController.swift
//  TheMUSICApp
//
//  Created by Divyam Solanki on 26/02/21.
//
import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []
    
    @IBOutlet var holder : UIView!
    
    var player: AVAudioPlayer?
    let playPauseButton = UIButton()
    
    //Elements for our player basically
    
    private let albumImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let songNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 64)
        label.numberOfLines = 0 //Allow to line wrap (in one line only)
        return label
    }()
    
    private let artistNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 34)
        label.numberOfLines = 0 //Allow to line wrap (in one line only)
        return label
    }()
    
    private let albumNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0 //Allow to line wrap (in one line only)
        return label
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0 {
            configure()
        }
    }
    
    func configure() {
        //Setting up player here
        let song = songs[position]
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        do {
             try AVAudioSession.sharedInstance().setMode(.default)
             try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
        
            guard let urlString = urlString else {
                
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else {
                return
            }
            player.volume = 0.5
            
            player.play()
            
            
            
        }
        catch {
            print("ERROR has occured")
        }
        
        //USER interface
        
        //ALBUM COVER
        albumImageView.frame = CGRect(x: 10, y: 10, width: holder.frame.size.width - 20, height: holder.frame.size.width - 20)
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        
        //LABELS : SONG : ALBUM : ARTIST
        // Y is changed according to the previous attribute
        songNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height + 30 , width: holder.frame.size.width - 20, height: 70)
        albumNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height + 90, width: holder.frame.size.width - 20, height: 70)
        artistNameLabel.frame = CGRect(x: 10, y: albumImageView.frame.size.height + 140, width: holder.frame.size.width - 20, height: 70)
        
        
        songNameLabel.text = song.name
        albumNameLabel.text = song.albumName
        artistNameLabel.text = song.artistName
        
        holder.addSubview(songNameLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)
        
        //CONTROLS
        
      
        let nextButton = UIButton()
        let backButton = UIButton()
        
        //FRAMES
        let yPosition = artistNameLabel.frame.origin.y + 70 + 20
        let size: CGFloat = 50
        
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0, y: yPosition, width: size, height: size)
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 20, y: yPosition, width: size, height: size)
        backButton.frame = CGRect(x: 20, y: yPosition, width: size, height: size)
//
        
        //ACTIONS
        
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        
        //IMAGES :: STYLING
        
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        
        playPauseButton.tintColor = .black
        nextButton.tintColor = .black
        backButton.tintColor = .black
        
        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
        
        //SLIDER
        
        let slider = UISlider(frame: CGRect(x: 20, y: holder.frame.size.height - 20, width: holder.frame.size.width - 40, height: 50))
        
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)
        
        
    }
    
    @objc func didTapBackButton(){
        if position > 0 {
            position = position - 1
            player?.stop()
            //Previous song playing
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
        
    }
    
    @objc func didTapNextButton(){
        
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            //Previous song playing
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapPlayPauseButton(){
        if player?.isPlaying == true{
            //PAUSE THE PLAYER HERE
            player?.pause()
            
            //SHOWING THE Play button
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
            //Expanding the image
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 30, y: 30, width: self.holder.frame.size.width - 60, height: self.holder.frame.size.width - 60)
            })
            
        }
        
        else {
            player?.play()
            
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            //Shrinking
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 10, y: 10, width: self.holder.frame.size.width - 20, height: self.holder.frame.size.width - 20)
            })
            
        }
    }
    
    @objc func didSlideSlider(_ slider: UISlider){
        let value = slider.value
        player?.volume = value
        //ADJUSTING THE PLAYER VOLUME HERE
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
}
