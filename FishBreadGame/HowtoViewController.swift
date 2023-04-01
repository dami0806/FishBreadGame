//
//  HowtoViewController.swift
//  FishBreadGame
//
//  Created by 박다미 on 2023/03/27.
//

import UIKit

class HowtoViewController: UIViewController {

    
    @IBOutlet weak var Howto1: UIImageView!
    @IBOutlet weak var next1: UIImageView!
    @IBOutlet weak var Howto2: UIImageView!
    @IBOutlet weak var next2: UIImageView!
    @IBOutlet weak var Howto3: UIImageView!
    @IBOutlet weak var next3: UIImageView!
    @IBOutlet weak var Howto4: UIImageView!
   
    @IBOutlet weak var next4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        Howto1.isHidden = false
        Howto2.isHidden = true
        Howto3.isHidden = true
        Howto4.isHidden = true
        next1.isHidden = true
        next2.isHidden = true
        next3.isHidden = true
        next4.isHidden = true
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                  self.Howto1.isHidden = false
                  self.next1.isHidden = false
              }
        
        
        let next1TapGesture = UITapGestureRecognizer(target: self, action: #selector(showHowto2))
        
        next1.isUserInteractionEnabled = true
        next1.addGestureRecognizer(next1TapGesture)
        
        let next2TapGesture = UITapGestureRecognizer(target: self, action: #selector(showHowto3))
        next2.isUserInteractionEnabled = true
        next2.addGestureRecognizer(next2TapGesture)
        
        let next3TapGesture = UITapGestureRecognizer(target: self, action: #selector(showHowto4))
        next3.isUserInteractionEnabled = true
        next3.addGestureRecognizer(next3TapGesture)
        
        let next4TapGesture = UITapGestureRecognizer(target: self, action: #selector(backToHome))
        next4.isUserInteractionEnabled = true
        next4.addGestureRecognizer(next4TapGesture)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveNextUpAndDown()
        
    }
    func moveNextUpAndDown() {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
            self.next1.transform = CGAffineTransform(translationX: 0, y: -10)
            self.next2.transform = CGAffineTransform(translationX: 0, y: -10)
            self.next3.transform = CGAffineTransform(translationX: 0, y: -10)
            self.next4.transform = CGAffineTransform(translationX: 0, y: -10)
        })
    }
//    func moveNextUpAndDown() {
//        UIView.animate(withDuration: 1.0, animations: {
//            self.next1.transform = CGAffineTransform(translationX: 0, y: -10)
//            self.next2.transform = CGAffineTransform(translationX: 0, y: -10)
//            self.next3.transform = CGAffineTransform(translationX: 0, y: -20)
//            self.next4.transform = CGAffineTransform(translationX: 0, y: -20)
//        }, completion: { _ in
//            UIView.animate(withDuration: 1.0, animations: {
//                self.next1.transform = CGAffineTransform(translationX: 0, y: 10)
//                self.next2.transform = CGAffineTransform(translationX: 0, y: 10)
//                self.next3.transform = CGAffineTransform(translationX: 0, y: 10)
//                self.next4.transform = CGAffineTransform(translationX: 0, y: 10)
//            }, completion: { _ in
//                self.moveNextUpAndDown()
//            })
//        })
//    }
    @objc func showHowto2(_ sender:UITapGestureRecognizer){
        Howto1.isHidden = true
        next1.isHidden = true
        Howto2.isHidden = false
        next2.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              self.next2.isHidden = false
          }
    }
    @objc func showHowto3(_ sender:UITapGestureRecognizer){
        Howto2.isHidden = true
        next2.isHidden = true
        Howto3.isHidden = false
        next3.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              self.next3.isHidden = false
          }
    }
    @objc func showHowto4(_ sender:UITapGestureRecognizer){
        Howto3.isHidden = true
        next3.isHidden = true
        Howto4.isHidden = false
        next4.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              self.next4.isHidden = false
          }
       
    }
    @objc func backToHome(_ sender:UITapGestureRecognizer){
     dismiss(animated: true)
       
    }
    
}
