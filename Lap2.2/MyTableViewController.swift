//
//  MyTableViewController.swift
//  Lap2.2
//
//  Created by MacOSSierra on 2/4/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData


class MyTableViewController: UITableViewController ,AddTextProtocol {
    
    func addMovie(obj: MovieOld) {
        arr.append(obj);
        self.tableView.reloadData();
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewDidLoad()
        
        
        
        //1 app delgate
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //2 manage object context
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        //3 create fetch request
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movies2")
        
        
        //    let prdictae = NSPredicate(format: "title == %@", "Movie1")
        
        //        fetchRequest.predicate = prdictae
        
        
        do{
            moviesArray2 = try manageContext.fetch(fetchRequest)
            print("data show")
            
            
        }catch let error{
            
            
            print(error)
            
        }
        self.tableView.reloadData();
    }

    var moviesArray2 = [NSManagedObject]()
    
    
    var arr : Array = Array<MovieOld>()
    override func viewDidLoad() {
       
        
        
        /*
        let mov1 = Movie()
        mov1.title = "End of the world"
        mov1.rating = 8.0
        mov1.releaseYear = 2012
        mov1.genre[0] = "ScienceFiction"
        mov1.image = "av1.png"
        
        let mov2 = Movie()
        mov2.title = "San Andreas"
        mov2.rating = 9.0
        mov2.releaseYear = 2015
        mov2.genre[0] = "ScienceFiction"
        mov2.image = "av1.png"
        
        let mov3 = Movie()
        mov3.title = "Fast and Furious7"
        mov3.rating = 8.6
        mov3.releaseYear = 2015
        mov3.genre[0] = "Action"
        mov3.image = "av1.png"
        
        
        arr.append(mov1)
        arr.append(mov2)
        arr.append(mov3)
        */

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moviesArray2.count
       // return arr.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        let  title:UILabel = cell.viewWithTag(1) as! UILabel
        let  releaseYear:UILabel! = cell.viewWithTag(2) as! UILabel
        let  genre:UILabel = cell.viewWithTag(3) as! UILabel
        let  rating:UILabel! = cell.viewWithTag(4) as! UILabel
        let  image:UIImageView = cell.viewWithTag(5) as! UIImageView
        
        //to api and add
        /*
        title.text = arr[indexPath.row].title
        releaseYear.text = "\(arr[indexPath.row].releaseYear)"
        rating.text = "\(arr[indexPath.row].rating)"
        genre.text = arr[indexPath.row].genre[0]
        //image.image = UIImage(named: arr[indexPath.row].image)
        
        image.sd_setImage(with: URL(string: arr[indexPath.row].image), placeholderImage: UIImage(named: "av1.png"))
 
        
        //title.text = moviesArray[indexPath.row].value(forKey: "title2") as! String
 */
        
        //to database
        
        
        title.text = moviesArray2[indexPath.row].value(forKey: "title2") as! String
        
        //cell.imageView?.image = moviesArray2[indexPath.row].value(forKey: "image2") as? UIImage
        // cell.detailTextLabel?.text = moviesArray[indexPath.row].value(forKey: "rating") as! Double
        
        let rt  = moviesArray2[indexPath.row].value(forKey: "rating2") as! Double
        let rt2  = String(rt)
        rating.text = rt2
        print(rt2)

        
        
        let ry  = (moviesArray2[indexPath.row].value(forKey: "releaseYear2") as! Int)
        let ry2 = String(ry)
        releaseYear.text = ry2
        print(ry2)
 
       
        
        genre.text = moviesArray2[indexPath.row].value(forKey: "gener2") as? String
        
        
        

        // Configure the cell...

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let  secondvc : SecondViewController = segue.destination as! SecondViewController
        secondvc.myProtocol = self
        
    }
    
    /*
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let nextviewcontroller : DetailsViewController = (self.storyboard?.instantiateViewController(withIdentifier:"secVc" ) as! DetailsViewController)
        nextviewcontroller.movie = arr[indexPath.row]
        self.navigationController?.show(nextviewcontroller, sender: nil)
        
        //self.navigationController?.pushViewController(nextviewcontroller, animated: true)
        // Configure the cell...
        
    }
 */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextviewcontroller : DetailsViewController = (self.storyboard?.instantiateViewController(withIdentifier:"secVc" ) as! DetailsViewController)
        nextviewcontroller.movie = arr[indexPath.row]
        self.navigationController?.show(nextviewcontroller, sender: nil)
       
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //1 app delgate
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            //2 manage object context
            
            let manageContext = appDelegate.persistentContainer.viewContext
            
            
            //3 delete from manage context
            
            manageContext.delete(moviesArray2[indexPath.row])
            
            
            do{
                
                try manageContext.save()
                
                
            }catch let error{
                
                print(error)
            }
            
            moviesArray2.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
