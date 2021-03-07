//
//  SecondViewController.swift
//  Lap2.2
//
//  Created by MacOSSierra on 2/5/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtGener: UITextField!
    @IBOutlet weak var txtRate: UITextField!
    
    var myProtocol : AddTextProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addBtn(_ sender: Any) {
        let obj = MovieOld()
        obj.title=txtTitle.text!
        obj.rating=Double(txtRate.text!)!
        obj.releaseYear=Int(txtYear.text!)!
        obj.genre=[txtGener.text!]
       
        
        myProtocol?.addMovie(obj: obj)
        
        self.navigationController?.popViewController(animated: true);
        
        
    }
 
    
    
    @IBAction func getDataFromAPI(_ sender: Any) {
        
     
        let dataMovie : Array<MovieOld>
        
        let url = URL(string: "https://api.androidhive.info/json/movies.json")
        let request = URLRequest(url: url!)
        let session = URLSession(configuration:URLSessionConfiguration.default)
        
        var task = session.dataTask(with: request){
            (data,request,error) in
            do{
                 let jsonArray = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<Dictionary<String,Any>>
                
                for index in 0...jsonArray.count-1
                {
                     let obj = MovieOld()
                    var dict = jsonArray[index]
                    
                    DispatchQueue.main.async {
                        obj.title = dict["title"] as! String
                        obj.rating = dict["rating"] as! Double
                        obj.releaseYear = dict["releaseYear"] as! Int
                        obj.genre = dict["genre"] as! [String]
                        obj.image = dict["image"] as! String
                        
                        self.myProtocol?.addMovie(obj: obj)
                        
                    }
                }
                
               
                
               
  
            }catch let error{
                print(error)
            }
            
            
        }
        task.resume()
 
          //self.myProtocol?.addMovie(obj: obj)
           self.navigationController?.popViewController(animated: true);
 
    }
 
    
    
     var moviesArray = [NSManagedObject]()
    var tbv = MyTableViewController()
    
    @IBAction func addToDB(_ sender: Any) {
        
        
        
        //1 app delgate
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //2 manage object context
        
        let manageContext = appDelegate.persistentContainer.viewContext
        
        //3 create entity object
        
        let entity = NSEntityDescription.entity(forEntityName: "Movies2", in: manageContext)
        let entityTwo = NSEntityDescription.entity(forEntityName: "Gener2", in: manageContext)
        
        // 4 create manage object for movie entity
        
        let movie = NSManagedObject(entity: entity!, insertInto: manageContext)
        let gener = NSManagedObject(entity: entityTwo!, insertInto: manageContext)
        //5 set values for the manage object
        /*
        movie.setValue("Movie Number2", forKey: "title2")
        movie.setValue("av1.png", forKey: "image2")
        movie.setValue(2.3, forKey: "rating2")
        movie.setValue(2010, forKey: "releaseYear2")
        //gener.setValue("comedy", forKey: "type")
       // movie.setValue(NSSet(object: gener) , forKey: "gener")
        //movie.setValue(Gener.self, forKey: "gener")
         */
        
        let NewTitle = txtTitle.text
        let NewTitle2 = String(NewTitle!)
        
        
        let NewRate = txtRate.text
        let NewRate2 = Double(NewRate!)
        
        
        let NewYear = txtYear.text
        let NewYear2 = Int(NewYear!)
        
        let NewGener = txtGener.text
        let NewGener2 = String(NewGener!)
        
        
        
        movie.setValue(NewTitle2, forKey: "title2")
        movie.setValue("av1.png", forKey: "image2")
        movie.setValue(NewRate2, forKey: "rating2")
        movie.setValue(NewYear2, forKey: "releaseYear2")
        movie.setValue(NewGener2, forKey: "gener2")
        //gener.setValue(NewGener2, forKey: "name2")
       // movie.setValue(NSSet(object: gener) , forKey: "genre")
        
        
        
        
        do{
            
            try manageContext.save()
            //try movie.managedObjectContext?.save()
            moviesArray.append(movie)
            print("data added")
            print(moviesArray[0])
            
            
        }catch let error{
            
            print(error)
            
        }
        
        
        
        tbv.tableView.reloadData()
        self.navigationController?.popViewController(animated: true);
        
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
