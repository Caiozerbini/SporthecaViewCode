//
//  IntroViewController.swift
//  viewCode
//
//  Created by Caio Carneiro on 28/10/22.
//

import UIKit
import SDWebImage

class IntroViewController: UIViewController {
    
    private lazy var userView: UIImageView = {
        let userImage = UIImageView()
        //userImage.frame = CGRect(x: 135, y: 80, width: 140, height: 140)
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.layer.cornerRadius = 70
        userImage.layer.masksToBounds = true
        userImage.backgroundColor = .yellow
        userImage.layer.borderColor = UIColor.white.cgColor
        userImage.layer.borderWidth = 2
        return userImage
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var posLabel: UILabel = {
        let label = UILabel()
        label.text = "Position"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Contry"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var percentageView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.7
        view.frame = CGRect(x: 158, y: 398, width: 100, height: 100)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 50
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "%"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cupsVictoriesLabel: UILabel = {
        let label = UILabel()
        label.text = "Copas do Mundo Vencidas"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var plaVictories: UILabel = {
        let label = UILabel()
        label.text = "plaV"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var posVictories: UILabel = {
        let label = UILabel()
        label.text = "posV"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var victoriesBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.frame = CGRect(x: 32, y: 594, width: 250, height: 50)
        progress.setProgress(0.4, animated: false)
        progress.trackTintColor = .clear
        progress.tintColor = .purple
        progress.alpha = 0.9
        progress.layer.cornerRadius = 10
        progress.clipsToBounds = true
        progress.layer.borderWidth = 0.2
        progress.layer.borderColor = UIColor.white.cgColor
        progress.transform = CGAffineTransform(scaleX: 1.2,y: 13)
        return progress
    }()
    
    private lazy var cupsDisputedLabel: UILabel = {
        let label = UILabel()
        label.text = "Copas do Mundo Disputadas"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var plaDisputed: UILabel = {
        let label = UILabel()
        label.text = "plaD"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var posDisputed: UILabel = {
        let label = UILabel()
        label.text = "posD"
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var disputedBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.frame = CGRect(x: 32, y: 685, width: 250, height: 50)
        progress.setProgress(0.4, animated: false)
        progress.trackTintColor = .clear
        progress.tintColor = .purple
        progress.alpha = 0.9
        progress.layer.cornerRadius = 10
        progress.clipsToBounds = true
        progress.layer.borderWidth = 0.2
        progress.layer.borderColor = UIColor.white.cgColor
        progress.transform = CGAffineTransform(scaleX: 1.2,y: 13)
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "BackgroundImage")!)
        
        Networking().getData {[weak self] player in
            DispatchQueue.main.async {
                self?.displayData(player: player)
            }
        } failure: { error in
            print(error.localizedDescription)
        }
        
        addSubview()
        constraintsUserView()
        constraintsNameLabel()
        constraintsPosLabel()
        constraintsCountryLabel()
        constraintsPercentageLabel()
        constraintsCupsVictoriesLabel()
        constraintsPlaVictories()
        constraintsPosVictories()
        constraintsCupsDisputedLabel()
        constraintsPlaDisputed()
        constraintsPosDisputed()
    }
    
    private func addSubview(){
        view.addSubview(userView)
        view.addSubview(nameLabel)
        view.addSubview(posLabel)
        view.addSubview(countryLabel)
        view.addSubview(percentageView)
        view.addSubview(percentageLabel)
        view.addSubview(cupsVictoriesLabel)
        view.addSubview(victoriesBar)
        view.addSubview(plaVictories)
        view.addSubview(posVictories)
        view.addSubview(cupsDisputedLabel)
        view.addSubview(disputedBar)
        view.addSubview(plaDisputed)
        view.addSubview(posDisputed)
    }
    
    func displayData(player: Player) {
        userView.sd_setImage(with: URL(string: player.imageURL), completed: nil)
        nameLabel.text = player.name
        posLabel.text = player.position
        countryLabel.text = player.country
        percentageLabel.text = String(format: "%.3f", player.percentage)
        plaVictories.text = String(format: "%.1f", player.worldCupVictories.pla)
        posVictories.text = String(format: "%dº", player.worldCupVictories.pos)
        plaDisputed.text = String(format: "%.1f", player.worldCupPlayed.pla)
        posDisputed.text = String(format: "%dº", player.worldCupPlayed.pos)
        
        let victoryProgress = Float(player.worldCupVictories.pla / player.worldCupVictories.max)
        let disputedProgress = Float(player.worldCupPlayed.pla / player.worldCupPlayed.max)
        victoriesBar.progress = victoryProgress
        disputedBar.progress = disputedProgress
    }
    
    func constraintsUserView(){
        let constraints = [
            userView.heightAnchor.constraint(equalToConstant: 150),
            userView.widthAnchor.constraint(equalToConstant: 150),
            userView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
        ]
        
        constraints.forEach { (item) in
            item.isActive = true
        }
    }
    
    
    
    func constraintsNameLabel(){
        let constraints = [
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 250)
        ]
        
        constraints.forEach { (item) in
            item.isActive = true
        }
    }
    
    func constraintsPosLabel(){
        let constraints = [
            posLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            posLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30)
        ]
        
        constraints.forEach { (item) in
            item.isActive = true
        }
    }
    
    func constraintsCountryLabel(){
        let constraints = [
            countryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countryLabel.centerYAnchor.constraint(equalTo: posLabel.bottomAnchor, constant: 30)
        ]
        
        constraints.forEach { (item) in
            item.isActive = true
        }
    }
    
    func constraintsPercentageLabel(){
        let constraints = [
            percentageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            percentageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        constraints.forEach { (item) in
            item.isActive = true
        }
    }
    
    func constraintsCupsVictoriesLabel(){
        let constraints = [
            cupsVictoriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cupsVictoriesLabel.centerYAnchor.constraint(equalTo: percentageLabel.bottomAnchor, constant: 105)
        ]
        
        constraints.forEach { (item) in
            item.isActive = true
        }
    }
    
    func constraintsPlaVictories(){
        let constraints = [
            plaVictories.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            plaVictories.centerYAnchor.constraint(equalTo: cupsVictoriesLabel.bottomAnchor, constant: 15)
        ]
        
        constraints.forEach { (item) in
            item.isActive = true
        }
    }
    
    func constraintsPosVictories(){
        let constraints = [
            posVictories.leadingAnchor.constraint(equalTo: victoriesBar.trailingAnchor, constant: 22),
            posVictories.centerYAnchor.constraint(equalTo: cupsVictoriesLabel.bottomAnchor, constant: 15)
        ]

        constraints.forEach { (item) in
            item.isActive = true
        }
    }
    
    func constraintsCupsDisputedLabel(){
        let constraints = [
            cupsDisputedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cupsDisputedLabel.centerYAnchor.constraint(equalTo: plaVictories.bottomAnchor, constant: 50)
        ]
        
        constraints.forEach { (item) in
            item.isActive = true
        }
    }
    
    func constraintsPlaDisputed(){
        let constraints = [
            plaDisputed.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            plaDisputed.centerYAnchor.constraint(equalTo: cupsDisputedLabel.bottomAnchor, constant: 17)
        ]
        
        constraints.forEach { (item) in
            item.isActive = true
        }
    }
    
    func constraintsPosDisputed(){
        let constraints = [
            posDisputed.leadingAnchor.constraint(equalTo: disputedBar.trailingAnchor, constant: 22),
            posDisputed.centerYAnchor.constraint(equalTo: cupsDisputedLabel.bottomAnchor, constant: 17)
        ]

        constraints.forEach { (item) in
            item.isActive = true
        }
    }
}

