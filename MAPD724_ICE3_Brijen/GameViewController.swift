//
//  GameViewController.swift
//  MAPD724_ICE3_Brijen
//
//  Created by Brijen Shah on 2023-02-05.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController
{

    @IBOutlet weak var LivesLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //print(self.view.frame.size.width)
        //print(self.view.frame.size.height)
    
        if let scene = GKScene(fileNamed: "GameScene") {
            
           
            if let sceneNode = scene.rootNode as! GameScene?
            {
        
                sceneNode.scaleMode = .aspectFill
                
                if let view = self.view as! SKView?
                {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true
                    
                }
                
                
            }
        }
        
        //initialize the Lives and Score
        CollisionManager.gameViewController = self
        ScoreManager.Score = 0
        ScoreManager.Lives = 5
        updateLivesLabel()
        updateScoreLabel()
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
       
            return .portrait
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    func updateScoreLabel()
    {
        ScoreLabel?.text = "Score: \(ScoreManager.Score)"
    }
    
    func updateLivesLabel()
    {
        LivesLabel?.text = "Lives: \(ScoreManager.Lives)"
    }
}
