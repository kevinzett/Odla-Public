//
//  ToolsViewController.swift
//  Odla KBZ
//
//  Created by Kevin Zetterlind on 2022-09-11.
//

import UIKit
import MessageUI

class ToolsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var header = StretchyHeaderProfileAndTools()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewAndDesignDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }

    func tableViewAndDesignDetails() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .darkGray
        let nibButtons = UINib(nibName: "ProfileButtonsCell", bundle: nil)
        tableView.register(nibButtons, forCellReuseIdentifier: "ProfileButtonsCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        header = StretchyHeaderProfileAndTools(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width / 2.2))
        
        tableView.separatorStyle = .none
        tableView.tableHeaderView = header
    }
    
}

extension ToolsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileButtonsCell", for: indexPath) as! ProfileButtonsCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.actionBlockNotiser = {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "notiservc") as? NotiserViewController else {return}
            vc.title = "Påminnelser"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.actionBlockKontakt = {
            self.sendEmail()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? StretchyHeaderProfileAndTools else {return}
        header.scrollViewDidScroll(scrollView: scrollView)
        
    }
    
}

extension ToolsViewController: MFMailComposeViewControllerDelegate {

    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.mailComposeDelegate = self
            vc.setToRecipients(["Odlakbz@outlook.com"])
            self.present(vc, animated: true)
        } else {
            self.cantSendMail()
        }
    }

    func cantSendMail() {
        let alertController = UIAlertController(title: "Restriced",
                                      message: "Mail access from inside apps is restricted on your phone, please contact us at: Odlakbz@outlook.com",
                                      preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(alertController, animated: true)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}


