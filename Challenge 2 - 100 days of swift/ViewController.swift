//
//  ViewController.swift
//  Challenge 2 - 100 days of swift
//
//  Created by Enzo Rossetto on 10/07/24.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping list"
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        let clear = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearList))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        navigationController?.isToolbarHidden = false
        toolbarItems = [clear, spacer, add]
    }
    
    @objc func addItem() {
        let ac = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addItemAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            guard let item = ac?.textFields?.first?.text else { return }
            self?.shoppingList.append(item)
            
            guard let itemsCount = self?.shoppingList.count else { return }
            
            let indexPath = IndexPath(row: itemsCount - 1, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(addItemAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
    }
    
    @objc func clearList() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func shareList() {
        let listItemsString = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [listItemsString], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        shoppingList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

