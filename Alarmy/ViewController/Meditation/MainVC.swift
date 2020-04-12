import UIKit

struct MainItem {
    var name:String
    var desc:String
    var image:String
    var audio:String
}

class MainVC: UITableViewController{
    let mainItems = [
        MainItem(name: "Blue-Lagoon", desc: "For positive reflection", image: "Blue-Lagoon.jpg", audio: "Blue-Lagoon"),
        MainItem(name: "Country-Meadow", desc: "For rest and tranquility", image: "Country-Meadow.jpg", audio: "Country-Meadow"),
        MainItem(name: "Deep-Ocean", desc: "For total relaxation", image: "Deep-Ocean.jpg", audio: "Deep-Ocean"),
        MainItem(name: "Desert-Oasis", desc: "For deep recharge", image: "Desert-Oasis.jpg", audio: "Desert-Oasis"),
        MainItem(name: "Falling-Asleep", desc: "For natural sleep", image: "Falling-Asleep.jpg", audio: "Falling-Asleep"),
        MainItem(name: "Fantasy-Island", desc: "For calmness of thought", image: "Fantasy-Island.jpg", audio: "Fantasy-Island"),
        MainItem(name: "Island-Paradise", desc: "For rapid relaxation", image: "Island-Paradise.jpg", audio: "Island-Paradise"),
        MainItem(name: "Mountain-Refuge", desc: "For self-motivation", image: "Mountain-Refuge.jpg", audio: "Mountain-Refuge"),
        MainItem(name: "Pain-Management", desc: "For pain relief", image: "Pain-Management.jpg", audio: "Pain-Management"),
        MainItem(name: "Tropical-Sands", desc: "For stress management", image: "Tropical-Sands", audio: "Tropical-Sands"),
    ]
    var selectedData: MainItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 140
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.systemIndigo
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainItems.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
        tableView.deselectRow(at: indexPath, animated: false)
        selectedData = mainItems[indexPath.row] as MainItem
        performSegue(withIdentifier: "toDetailVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailVC{
            detailVC.dataMainVC = selectedData
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! DesignTableViewCell
        let mainItem = mainItems[indexPath.row]
        cell.mainItem = mainItem
        cell.backgroundColor = UIColor.clear
        return cell
    }
}
