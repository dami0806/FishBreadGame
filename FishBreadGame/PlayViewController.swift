//
//  PlayViewController.swift
//  FishBreadGame
//
//  Created by 박다미 on 2023/03/27.
//

import UIKit

class PlayViewController: UIViewController {
  //  @IBOutlet weak var scoreViewRound: UIView!
    
    
    
    @IBOutlet var toolButtons: [UIButton]!
    
    @IBOutlet var fishButtons: [UIButton]!
    @IBOutlet var giveButtons: [UIButton]!
    
    @IBOutlet weak var bagLabelView: UIView!
    @IBOutlet weak var bagLabel: UILabel!
    
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var orderView: [UIView]!
    @IBOutlet var orderLabel: [UILabel]!
    
    
    
    
    var mainTimer = Timer()
    var mainIsRun = false
    var mainTimeCount = 0
    
    var toolSelect = -1
    
    var fishLevel = Array(repeating: -1, count: 9)
    var fishIsBurn = Array(repeating: false, count: 9)
    var fishIsRun = Array(repeating: false, count: 9)
    var fishTimer = Array(repeating: Timer(), count: 9)
    var fishTimerInt = Array(repeating: 0, count: 9)
    
    var orderLevel = [-1, -1]
    var orderAmount = [-1, -1]
    var orderIsRun = [false, false]
    var orderTimer = [Timer(), Timer()]
    var orderTimeCount = [0, 0]
    
    var bagLabelInt = 0
    
    var life = 3
    var score = 0
    
    
    var leftImageView: UIImageView!
    var rightImageView: UIImageView!
    var centerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...1{
            
            orderView[i].isHidden = true
            
//            scoreViewRound.layer.cornerRadius = 8
            orderView[0].layer.cornerRadius = 5
            orderView[1].layer.cornerRadius = 5
            
            orderView[0].layer.borderWidth = 1
            orderView[0].layer.borderColor = UIColor.systemGray5.cgColor
            orderView[1].layer.borderWidth = 1
            orderView[1].layer.borderColor = UIColor.systemGray5.cgColor
            
            giveButtons[0].layer.cornerRadius = 5
            giveButtons[1].layer.cornerRadius = 5
        }
        

        let leftImageView = UIImageView(image: UIImage(named: "왼쪽start"))
        let rightImageView = UIImageView(image: UIImage(named: "오른쪽start"))

        let width: CGFloat = 200
        let height: CGFloat = 200
        let startX: CGFloat = (view.bounds.width - width) / 2.0
        let startY: CGFloat = (view.bounds.height - height) / 2.0

        // 처음 위치
        leftImageView.frame = CGRect(x: -width, y: startY, width: width, height: height)
        rightImageView.frame = CGRect(x: view.bounds.width, y: startY, width: width, height: height)

        view.addSubview(leftImageView)
        view.addSubview(rightImageView)

        UIView.animate(withDuration: 1.0, animations: {
            // 가운데로 모이기
            leftImageView.frame = CGRect(x: startX - 100, y: startY - 50, width: width, height: height)
            rightImageView.frame = CGRect(x: startX + 100, y: startY - 50, width: width, height: height)

       

        }) { _ in
            UIView.animate(withDuration: 0.5, animations: {
       
                leftImageView.transform = CGAffineTransform(translationX: 0, y: 20)
                rightImageView.transform = CGAffineTransform(translationX: 0, y: 20)
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, animations: {
              
                    leftImageView.transform = CGAffineTransform(translationX: 0, y: -20)
                    rightImageView.transform = CGAffineTransform(translationX: 0, y: -20)
                }, completion: { _ in
                    UIView.animate(withDuration: 1.0, animations: {
                        
                        leftImageView.frame = CGRect(x: -width, y: startY, width: width, height: height)
                        rightImageView.frame = CGRect(x: self.view.bounds.width, y: startY, width: width, height: height)
                    }, completion: { _ in
                        
                        leftImageView.removeFromSuperview()
                        rightImageView.removeFromSuperview()
                    })
                })
            })
        }
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
              self.startMainTimer()
          }
    }
    
    
    func startMainTimer() {
        mainIsRun = true
        mainTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countMainTime), userInfo: nil, repeats: true)
    }
    
    @objc func countMainTime() {
        mainTimeCount += 1
        let isOrderEnabled = Bool.random()
        let orderIndex = Int.random(in: 0...1)
        if isOrderEnabled && orderLevel[orderIndex] == -1 {
            let orderAmount = Int.random(in: 1...6)
            self.orderAmount[orderIndex] = orderAmount
            DispatchQueue.main.async {
                self.orderView[orderIndex].isHidden = false
                self.orderLabel[orderIndex].text = String(orderAmount)
            }
            DispatchQueue.global().async {
                self.orderLevel[orderIndex] = 0
                self.orderIsRun[orderIndex] = true
                let runLoop = RunLoop.current
                self.orderTimer[orderIndex] = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countOrderTime), userInfo: ["index": orderIndex], repeats: true)
                
                while self.orderIsRun[orderIndex] {
                    runLoop.run(until: Date().addingTimeInterval(0.1))
                }
            }
        }
    }
    
    @objc func countOrderTime(_ sender: Timer) {
        guard let userInfo = sender.userInfo as? Dictionary<String, Int> else {
            return
        }
        guard let index = userInfo["index"] else {
            return
        }
        orderTimeCount[index] += 1
        if orderTimeCount[index] >= 20 {
            orderAmount[index] = -1
            orderLevel[index] = -1
            DispatchQueue.main.async {
                self.orderView[index].backgroundColor = .white
                self.orderView[index].isHidden = true
                
            }
            self.life -= 1
            setLife()
            orderTimeCount[index] = 0
            orderTimer[index].invalidate()
            orderIsRun[index] = false
        } else if orderTimeCount[index] >= 10 {
            orderLevel[index] = 1
            DispatchQueue.main.async {
                self.orderView[index].backgroundColor = .red
            }
        }
    }
    
    func setLife() {
        if life == 0 {
            finishGame()
        }
        var lifeLabel = ""
        for _ in 0..<life {
            lifeLabel += "❤️"
        }
        DispatchQueue.main.async {
            self.lifeLabel.text = lifeLabel
        }
    }
    
    func finishGame() {
        mainTimer.invalidate()
        mainIsRun = false
        mainTimeCount = 0
        for i in 0..<2 {
            orderTimer[i].invalidate()
            orderIsRun[i] = false
            orderLevel[i] = -1
            orderAmount[i] = -1
            orderTimeCount[i] = 0
            bagLabelInt = 0
            
            
        }
        for i in 0..<9 {
            fishTimer[i].invalidate()
            fishIsRun[i] = false
            fishIsBurn[i] = false
            fishTimerInt[i] = 0
            fishLevel[i] = -1
            
        }
        
        let alert = UIAlertController(title: "GameOver", message:
                                        "당신의 점수는 \(score)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "네", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "다시하기", style: .cancel, handler: allReset)
        alert.addAction(cancel)
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    func allReset(action: UIAlertAction) {
        life = 3
        setLife()
        
        //점수
        score = 0
        for i in 0...1{
            initOrders(i)
        }
        
        for i in 0...fishButtons.count-1{
            initFish(i)
        }
        for i in 0...1{
            initOrders(i)
        }
        scoreLabel.text = "\(score)"
        startMainTimer()
        initBag()

    }
    
    @IBAction func pressedToolButton(_ sender: UIButton) {
        let index = toolButtons.firstIndex(of: sender)!
        sender.isSelected.toggle()
        toolSelect = sender.isSelected ? index : -1
        toolButtonState()
    }
    
    func toolButtonState() {
        for (index, button) in toolButtons.enumerated() {
            if index == toolSelect {
                button.layer.borderWidth = 3
                button.layer.borderColor = UIColor.red.cgColor
            } else {
                button.isSelected = false
                button.layer.borderWidth = 0
            }
        }
    }
    
    
    
    @IBAction func fishButtonTapped(_ sender: UIButton) {
        let index = fishButtons.firstIndex(of: sender)!
        switch toolSelect {
        case 0: // 주전자
            if fishLevel[index] == -1 {
                sender.setImage(UIImage(named: "붕어빵1반죽"), for: .normal)
                fishLevel[index] = 0
                DispatchQueue.global().async {
                    self.fishIsRun[index] = true
                    let runLoop = RunLoop.current
                    self.fishTimer[index] = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.fishTimecount(_:)), userInfo: ["index": index], repeats: true)
                    
                    while self.fishIsRun[index] {
                        runLoop.run(until: Date().addingTimeInterval(0.1))
                    }
                }
            }
        case 1: // 팥
            if fishLevel[index] == 0 {
                sender.setImage(UIImage(named: "붕어빵2팥"), for: .normal)
                fishLevel[index] = 1
            }
        case 2: // 손
            if fishLevel[index] == 1 {
                // 팥 넣고 처음 뒤집은 상태
                if fishIsBurn[index] == false {
                    sender.setImage(UIImage(named: "붕어빵3-1"), for: .normal)
                    fishLevel[index] = 2}
                else if fishIsBurn[index] == true {
                    sender.setImage(UIImage(named: "붕어빵3-4"), for: .normal)
                    fishLevel[index] = 4
                    
                }
            } else if fishLevel[index] == 2 {
                if fishIsBurn[index] == false {
                    sender.setImage(UIImage(named: "붕어빵3-2"), for: .normal)
                    fishLevel[index] = 3
                }
                else if fishIsBurn[index] == true {
                    sender.setImage(UIImage(named: "붕어빵3-4"), for: .normal)
                    fishLevel[index] = 4
                    
                }
            }
            else if fishLevel[index] == 3 {
                if fishIsBurn[index] == false {
                    sender.setImage(UIImage(named: "붕어빵3-3"), for: .normal)
                    fishLevel[index] = 4
                }
                else if fishIsBurn[index] == true {
                    sender.setImage(UIImage(named: "붕어빵3-4"), for: .normal)
                    fishLevel[index] = 4
                    
                }
            }
            else if fishLevel[index] == 4{
                if fishIsBurn[index] == false {
                    bagLabelInt += 1
                    bagLabel.text = String(bagLabelInt)
                }
                initFish(index)
            }
            
            
        default:
            return
        }
    }
    
    @objc func fishTimecount(_ sender: Timer) {
        guard let userInfo = sender.userInfo as? Dictionary<String, Int> else {
            return
        }
        guard let index = userInfo["index"] else {
            return
        }
        fishTimerInt[index] += 1
        if fishTimerInt[index] <= 25 {
            fishIsBurn[index] = false
        } else {
            fishIsBurn[index] = true
            if fishLevel[index] == 3 {
                DispatchQueue.main.async {
                    self.fishButtons[index].setImage(UIImage(named: "붕어빵3-4"), for: .normal)
                }
            }
        }
    }
    
    func initFish(_ index: Int) {
        fishTimer[index].invalidate()
        fishIsRun[index] = false
        fishButtons[index].setImage(UIImage(named: "붕어빵틀"), for: .normal)
        fishLevel[index] = -1
        fishIsBurn[index] = false
        fishTimerInt[index] = 0
    }
    
    // MARK: - 봉투 관련
    
    @IBAction func resetBag(_ sender: UIButton) {
        bagLabelInt = 0
        bagLabel.text = String(bagLabelInt)
    }
    
    
    @IBAction func giveButtonTapped(_ sender: UIButton) {
        if toolSelect == 3 {
            let index = giveButtons.firstIndex(of: sender)!
            if bagLabelInt == orderAmount[index] {
                setAfterOrderSuccess(index)
            }
        }
    }
    
    func setAfterOrderSuccess(_ index: Int) {
        score += 10
        scoreLabel.text = String(score)
        initOrders(index)
        initBag()
    }
    
    func initOrders(_ index: Int) {
        orderView[index].backgroundColor = .white
        orderView[index].isHidden = true
        orderLevel[index] = -1
        orderAmount[index] = -1
        orderIsRun[index] = false
        orderTimeCount[index] = 0
        orderTimer[index].invalidate()
    }
    
    func initBag() {
        bagLabelInt = 0
        bagLabel.text = "0"
    }
    
}

