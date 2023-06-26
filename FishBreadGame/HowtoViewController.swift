//
//  HowtoViewController.swift
//  FishBreadGame
//
//  Created by 박다미 on 2023/03/27.
//

import UIKit
import Lottie
class HowtoViewController: UIViewController {

    @IBOutlet weak var howTo1: UIView!
    @IBOutlet weak var howTo2: UIView!
    @IBOutlet weak var howTo3: UIView!
    @IBOutlet weak var howTo4: UIView!
    
  
    
    private var currentStep: Int = 1
    override func viewWillAppear(_ animated: Bool) {
        // 배경 이미지 설정
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
       override func viewDidLoad() {
           super.viewDidLoad()
           howTo1.isHidden = false
           howTo2.isHidden = true
           howTo3.isHidden = true
           howTo4.isHidden = true
           addLottieAnimation(to: howTo1)
           addTapGesture(to: howTo1, step: 1)
           addTapGesture(to: howTo2, step: 2)
           addTapGesture(to: howTo3, step: 3)
       }
       
       private func addLottieAnimation(to view: UIView) {
           let animationView = LottieAnimationView(name: "arrow-right")
           animationView.frame = CGRect(x: view.bounds.width-70, y:view.bounds.height-80 , width: 60, height: 60)

           animationView.contentMode = .scaleAspectFit
           animationView.loopMode = .loop
           animationView.animationSpeed = 1.0
           animationView.play()
           
           view.addSubview(animationView)
       }
       
       private func addTapGesture(to view: UIView, step: Int) {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(animationTapped(_:)))
           view.isUserInteractionEnabled = true
           view.tag = step
           view.addGestureRecognizer(tapGesture)
       }
       
       @objc private func animationTapped(_ sender: UITapGestureRecognizer) {
           if let view = sender.view, view.tag == currentStep {
               showNextStep()
           }
       }
       
       private func showNextStep() {
           currentStep += 1
           
           switch currentStep {
           case 2:
               howTo1.isHidden = true
               howTo2.isHidden = false
               howTo3.isHidden = true
               howTo4.isHidden = true
               addLottieAnimation(to: howTo2)
           case 3:
               howTo1.isHidden = true
               howTo2.isHidden = true
               howTo3.isHidden = false
               howTo4.isHidden = true
               addLottieAnimation(to: howTo3)
           case 4:
               howTo1.isHidden = true
               howTo2.isHidden = true
               howTo3.isHidden = true
               howTo4.isHidden = false
               addLottieAnimation(to: howTo4)
               addTapGesture(to: howTo4, step: 4)
           default:
                       backToHome()
                   }
               }

               @objc private func backToHome() {
                   dismiss(animated: true, completion: nil)
               }
           }
       
   
