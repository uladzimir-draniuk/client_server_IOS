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
//    var outText = ""
    @IBOutlet weak var textName: UITextField!
    
    
    @IBOutlet weak var resultText: UITextField!
    
    @IBOutlet weak var textPassword: UITextField!
    @IBAction func checkForm(_ sender: Any) {
        if self.textName.text == checkName, self.textPassword.text == checkPassword {
            self.resultText.text = "Вы вошли!"

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
