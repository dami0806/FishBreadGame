//
//  ViewController.swift
//  FishBreadGame
//
//  Created by 박다미 on 2023/03/27.
//

import UIKit

class ViewController: UIViewController {
  

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
           backgroundImage.image = UIImage(named: "home배경")
           backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
           self.view.insertSubview(backgroundImage, at: 0)
        
    }


    @IBAction func gameButtonTapped(_ sender: UIButton) {
      
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "PlayViewController") as? PlayViewController else { return }
              self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    @IBAction func howToButtonTapped(_ sender: UIButton) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HowtoViewController") as? HowtoViewController else { return }
       // nextVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
               present(nextVC, animated: true, completion: nil)
               
               
        
    }
}

