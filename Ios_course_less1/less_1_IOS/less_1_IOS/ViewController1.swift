//
//  ViewController1.swift
//  less_1_IOS
//
//  Created by elf on 30.01.2021.
//

import UIKit

class ViewController1: UIViewController {
    
    let checkName = "elf"
    let checkPassword = "12345"

    @IBOutlet weak var textName: UITextField!

    @IBOutlet var loginView: UIView!
    
    @IBOutlet weak var resultText: UITextField!
    
    @IBOutlet weak var textPassword: UITextField!
    @IBAction func checkForm(_ sender: Any) {
        if self.textName.text == checkName, self.textPassword.text == checkPassword {
            self.resultText.text = "Вы вошли!"
            
            self.performSegue(withIdentifier: "buttonWork", sender: self)

        } else {
            self.resultText.text = "Неверное имя или пароль"
        }
    }
    
//    let gradient = GradientView()
//
//
    //add to your collectionView
//    collectionView?.addSubview(gradient)
//    collectionView?.sendSubview(toBack: gradient)
//    self.collectionView?.backgroundView = gradient
   
    private let color1 = UIColor.blue.cgColor
    private let color2 = UIColor.green.cgColor
    private let color3 = UIColor.blue.cgColor
        
    private var gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.gradient.frame = self.loginView.bounds
        self.gradient.colors = [self.color1, self.color2, self.color3]
        self.gradient.startPoint = CGPoint(x: 0.0, y: 0.1)
        self.gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        self.loginView.layer.insertSublayer(self.gradient, at: 0)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
