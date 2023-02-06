import UIKit
import AVFoundation
import SpriteKit
import GameplayKit

var screenSize = UIScreen.main.bounds
var screenWidth: CGFloat?
var screenHeight: CGFloat?

class GameScene: SKScene {
    
    var ocean1: Ocean?
    var ocean2: Ocean?
    var plane: Plane?
    var island: Island?
    var clouds: [Cloud] = []
    
override func sceneDidLoad()
    {
        screenWidth = frame.width
        screenHeight = frame.height
        name = "FIRST GAME"
        
        //add ocean1 to the game scene
        ocean1 = Ocean()
        ocean1?.Reset()
        addChild(ocean1!)
        
        //add ocean2 to the game scene
        ocean2 = Ocean()
        ocean2?.position.y = -627
        addChild(ocean2!)
        
        //add plane to the Scene
        plane = Plane()
        addChild(plane!)
        
        //add island to the scene
        island = Island()
        addChild(island!)
        
        //add 3 clouds to the scene
        for _ in 0...2
        {
            let cloud: Cloud = Cloud()
            clouds.append(cloud)
            addChild(cloud)
        }
        
        // Engine Sound
        
        let engineSound = SKAudioNode(fileNamed: "engine.mp3")
        addChild(engineSound)
        engineSound.autoplayLooped = true
        
        //preload the sounds
        do
        {
            let sounds: [String] = ["thunder", "yay"]
            for sound in sounds
            {
                let path: String = Bundle.main.path(forResource: sound, ofType: "mp3") ?? ""
                let url: URL = URL(fileURLWithPath: path)
                let avPlane: AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                avPlane.prepareToPlay()
            }
        }
        catch
        {
            
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint)
    {
        plane?.TouchMove(newPos: CGPoint(x: pos.x, y: -640))
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        plane?.TouchMove(newPos: CGPoint(x: pos.x, y: -640))
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        plane?.TouchMove(newPos: CGPoint(x: pos.x, y: -640))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval)
    {
        ocean1?.Update()
        ocean2?.Update()
        plane?.Update()
        island?.Update()
        
        CollisionManager.SquaredRadiusCheck(scene: self, object1: plane!, object2: island!)
        
        //update each cloud in clouds
        for cloud in clouds
        {
            cloud.Update()
            CollisionManager.SquaredRadiusCheck(scene: self, object1: plane!, object2: cloud)
        }
    }
}
