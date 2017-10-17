//
//  GroupMainVC.swift
//  DTAdmin
//
//  Created by Admin on 18.10.17.
//  Copyright © 2017 if-ios-077. All rights reserved.
//

import UIKit

class GroupMainVC: UIViewController {

    @IBAction func loginTapped(_ sender: Any) {
        HTTPService.login()
    }
    @IBAction func getTapped(_ sender: Any) {
//        HTTPService.getAllData(entityName: "group"){ (result:[Group]) in
//            print(result)
//        }
        HTTPService.getCommonArrayForGroups(){(result:[Any]) in
            print("results")
            print(result)
            for i in result{
                print("res\(i)")
            }
            
        }
    }
    
    @IBAction func postTapped(_ sender: Any) {
        HTTPService.postData()
    }
    @IBAction func putTapped(_ sender: Any) {
    }
    @IBAction func deleteTapped(_ sender: Any) {
    }
    @IBAction func getOneTapped(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
