//
//  ViewController.swift
//  TheMUSICApp
//
//  Created by Divyam Solanki on 26/02/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet var table : UITableView!
    
    var songs = [Song]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSongs()
        table.delegate = self
        table.dataSource = self
    }
    
    //Function to configure songs
    
    func configureSongs() {
        songs.append(Song(name: "Sorry", albumName: "Purpose", artistName: "Justin Beiber", imageName: "Cover1", trackName: "song1"))
        
        songs.append(Song(name: "Intentions", albumName: "Changes", artistName: "Justin Beiber", imageName: "Cover2", trackName: "song2"))
        
        songs.append(Song(name: "Confident", albumName: "My Journals", artistName: "Justin Beiber", imageName: "Cover3", trackName: "song3"))
        
        songs.append(Song(name: "Holy", albumName: "Changes", artistName: "Justin Beiber", imageName: "Cover4", trackName: "song4"))
        
        songs.append(Song(name: "Lonely", albumName: "Single", artistName: "Justin Beiber", imageName: "Cover5", trackName: "song5"))
        
        songs.append(Song(name: "Boyfriend", albumName: "Believe", artistName: "Justin Beiber", imageName: "Cover6", trackName: "song6"))
        
        songs.append(Song(name: "Anyone", albumName: "Single", artistName: "Justin Beiber", imageName: "Cover7", trackName: "song7"))
        
        songs.append(Song(name: "Changes", albumName: "Changes", artistName: "Justin Beiber", imageName: "Cover8", trackName: "song8"))
        
        songs.append(Song(name: "10000 Hours", albumName: "Single", artistName: "Justin Beiber, Dan and Shay", imageName: "Cover9", trackName: "song9"))
        
        songs.append(Song(name: "Love Yourself", albumName: "Purpose", artistName: "Justin Beiber", imageName: "Cover10", trackName: "song10"))
        
        songs.append(Song(name: "Monster", albumName: "Single", artistName: "Justin Beiber, Shawn Mendes", imageName: "Cover11", trackName: "song11"))
      
    }
    
    //Table
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        //Configuring the cell properties
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 20)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 16)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //PRESENTING THE PLAYER
        
        let position = indexPath.row
        
        //SONGS
        
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? PlayerViewController else {
            return
        }
        vc.songs = songs
        vc.position = position
        
        present(vc, animated: true)
    }

    

}

struct Song {
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}

