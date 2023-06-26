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
    private var animationView: LottieAnimationView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureInitialStep()
        addTapGesture(to: howTo1, step: 1)
        addTapGesture(to: howTo2, step: 2)
        addTapGesture(to: howTo3, step: 3)
    }
    
    private func configureInitialStep() {
        howTo1.isHidden = false
        howTo2.isHidden = true
        howTo3.isHidden = true
        howTo4.isHidden = true
        
        addLottieAnimation(to: howTo1)
    }
    
    private func addLottieAnimation(to view: UIView) {
        animationView?.removeFromSuperview()
        
        let newAnimationView = LottieAnimationView(name: "arrow-right")
        newAnimationView.frame = CGRect(x: view.bounds.width-70, y: view.bounds.height-80, width: 60, height: 60)
        newAnimationView.contentMode = .scaleAspectFit
        newAnimationView.loopMode = .loop
        newAnimationView.animationSpeed = 1.0
        newAnimationView.play()
        
        view.addSubview(newAnimationView)
        animationView = newAnimationView
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
            toggleViewVisibility(howTo1: true, howTo2: false, howTo3: true, howTo4: true)
            addLottieAnimation(to: howTo2)
        case 3:
            toggleViewVisibility(howTo1: true, howTo2: true, howTo3: false, howTo4: true)
            addLottieAnimation(to: howTo3)
        case 4:
            toggleViewVisibility(howTo1: true, howTo2: true, howTo3: true, howTo4: false)
            addLottieAnimation(to: howTo4)
            addTapGesture(to: howTo4, step: 4)
        default:
            backToHome()
        }
    }
    
    private func toggleViewVisibility(howTo1: Bool, howTo2: Bool, howTo3: Bool, howTo4: Bool) {
        self.howTo1.isHidden = howTo1
        self.howTo2.isHidden = howTo2
        self.howTo3.isHidden = howTo3
        self.howTo4.isHidden = howTo4
    }
    
    @objc private func backToHome() {
        dismiss(animated: true, completion: nil)
    }
}
