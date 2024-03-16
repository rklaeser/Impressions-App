//
//  ListViewController.swift
//  Hw8
//
//  Created by Reed Klaeser on 3/4/24.
//

import UIKit


class VC_Campaign: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Assuming your tableView is named "tableView"
        tableView.reloadData() // Reload the table view data
    }
    override func numberOfSections(in tableView: UITableView)
    -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return M_Impressions.count
    }
    
    // Render table view cells
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        let impression = M_Impressions[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: impression.type.rawValue,
            for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = impression.name
        cell.detailTextLabel?.text = impression.subtitle
        
        let textColor: UIColor = impression.complete ? .gray : .black
           cell.textLabel?.textColor = textColor.withAlphaComponent(1.0) // Adjust the alpha value as needed
           cell.detailTextLabel?.textColor = textColor.withAlphaComponent(0.8) // Adjust the alpha value as neede
        
        let checkmarkImage = UIImage(systemName: impression.complete ? "checkmark.square.fill" : "square")

        cell.accessoryView = UIImageView(image: checkmarkImage)

        
        return cell
    }
    
    // Handle cell selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let impression = M_Impressions[indexPath.row]
        
        // Accessing the "Detail View Controller" using its identifier
        if let VC_CampaignDetail = storyboard?.instantiateViewController(withIdentifier: "VC_CampaignDetail") as? VC_CampaignDetail {
            VC_CampaignDetail.impression = impression
            
            // Set up the popover presentation controller
            VC_CampaignDetail.modalPresentationStyle = .fullScreen
            VC_CampaignDetail.popoverPresentationController?.permittedArrowDirections = .any
            VC_CampaignDetail.popoverPresentationController?.delegate = self
            
            if let selectedCell = tableView.cellForRow(at: indexPath) {
                VC_CampaignDetail.popoverPresentationController?.sourceView = selectedCell
                VC_CampaignDetail.popoverPresentationController?.sourceRect = selectedCell.bounds
            } else {
                // Handle the case where the cell is nil
                print("Error: Selected cell is nil")
                return
            }
            
            present(VC_CampaignDetail, animated: true, completion: nil)
        } else {
            // Handle the case where the view controller couldn't be instantiated
            print("Error: Unable to instantiate Detail View Controller")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView,
          accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let impression = M_Impressions[indexPath.row]
        let title = impression.name
        let message = impression.script
        let alertController = UIAlertController(title: title,
            message: message, preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Okay",
            style: .default, handler: nil)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    
}
