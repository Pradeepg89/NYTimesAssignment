//
//  NYTimesMostViewedFeedViewController.swift
//  NYTimesAssignment
//
//  Created by Pradeep Pandey on 01/09/18.
//  Copyright © 2018 Pradeep Pandey. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class Connectivity {
    class var isConnectedToInternet:Bool {
        return (NetworkReachabilityManager()?.isReachable)!
    }
}

class NYTimesMostViewedFeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var refreshControl: UIRefreshControl?
    @IBOutlet var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do Navigation setup after loading the view.
        self.navigationItem.title = NYTimesConfig.StringConstant.ArticleTableViewTitle
        self.navigationItem.backBarButtonItem?.title  = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.initializeBarButtons()
        
        self.feedTableView.rowHeight = NYTimesConfig.NumberConstant.ArticleTableRowHeight
        self.initilializeRefreshControl()
        
        // Load Article feeds from NYTimes Server
        loadMostViewFeedsFromServer()
        
    }
    
    func initializeBarButtons() {
        
        // Initialize BarButton Items
        let _btn = UIBarButtonItem(image: UIImage(named: "drawer_menu"), style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = _btn
        let customImg = UIImage(named: "menu")
        let _customButton = UIBarButtonItem(image: customImg, style: .plain, target: nil, action: nil)
        let customImg2 = UIImage(named: "search")
        let _customButton2 = UIBarButtonItem(image: customImg2, style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [_customButton, _customButton2]
    }

    
    func initilializeRefreshControl() {
        // Initialize refresh control
        if (self.refreshControl == nil) {
            self.refreshControl = UIRefreshControl()
            feedTableView.addSubview(self.refreshControl!)
            self.refreshControl?.backgroundColor = UIColor.lightGray
            self.refreshControl?.tintColor = UIColor.white
            // Configure Refresh Control
            self.refreshControl?.addTarget(self, action: #selector(refreshFeedArticleData(_:)), for: .valueChanged)
        }
    }
    
    // MARK:- NYTimes API Call
    func loadMostViewFeedsFromServer() {
        
        // Load Article feeds from NYTimes Server
        if Connectivity.isConnectedToInternet {
            print("internet is available.")
            self.refreshControl?.beginRefreshing()
            NYTimesAFNetworkingWrapper.getJSONFromAPI { (dict: Dictionary<String, AnyObject>) in
                if !NYTimesAppUtilities.objectIsValid(NYTimesMostViewedFeedDataManager.sharedInstance.mostViewedFeedsArray) {
                    NYTimesMostViewedFeedDataManager.sharedInstance.mostViewedFeedsArray = [Dictionary<String, Any>]()
                } else {
                    NYTimesMostViewedFeedDataManager.sharedInstance.mostViewedFeedsArray.removeAll()
                }
                
                if NYTimesAppUtilities.objectIsValid(dict["results"]) {
                    if let aKey = dict["results"] as? [Dictionary<String, Any>] {
                        NYTimesMostViewedFeedDataManager.sharedInstance.mostViewedFeedsArray.append(contentsOf: aKey)
                        self.reloadFeedTableView()
                    }
                }
            }
        }else{
            print("internet not connection.")
            self.refreshControl?.endRefreshing()
        }
    }
    
    
    // MARK:- Reload & Refresh TableView
    @objc private func refreshFeedArticleData(_ sender: Any) {
        // Fetch Article Data
        loadMostViewFeedsFromServer()
    }
    
    // MARK: reloadDataSoruce
    func reloadFeedTableView() {
        feedTableView.reloadData()
        // End the refreshing
        updateTimerDetails()
        self.refreshControl?.endRefreshing()
    }
    
    func updateTimerDetails() {
        if (self.refreshControl != nil) {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, h:mm a"
            let title = "Last update: \(formatter.string(from: Date()))"
            let attrsDictionary = [NSAttributedStringKey.foregroundColor : UIColor.white]
            let attributedTitle = NSAttributedString(string: title, attributes: attrsDictionary)
            refreshControl?.attributedTitle = attributedTitle
        }
    }

    // MARK:- UITableView DataSource and Delegate
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NYTimesMostViewedFeedDataManager.sharedInstance.mostViewedFeedsArray.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NYTimesMostViewedFeedTableViewCell"
        var feedCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? NYTimesMostViewedFeedTableViewCell
        let feedItem = NYTimesMostViewedFeedDataManager.sharedInstance.mostViewedFeedsArray[indexPath.row]
        // Instance().mostViewedFeedsArray[indexPath.row] as? [AnyHashable: Any]
        if feedCell == nil {
            let nib = Bundle.main.loadNibNamed("NYTimesMostViewedFeedTableViewCell", owner: self, options: nil)
            feedCell = nib?[0] as? NYTimesMostViewedFeedTableViewCell
            feedCell?.selectionStyle = .none
        }
        
        
        
        feedCell?.feedTitleLabel.text = feedItem["title"] as? String ?? ""
        feedCell?.feedTitleLabel.numberOfLines = 0
        feedCell?.feedDescriptionLabel.sizeToFit()
        feedCell?.feedDateLabel.text = feedItem["published_date"] as? String ?? ""
        
        if NYTimesAppUtilities.objectIsValid(feedItem) {
            feedCell?.feedDescriptionLabel.text = feedItem["byline"] as? String ?? ""
            if (feedCell?.feedDescriptionLabel.text?.count)! > 60 {
                feedCell?.feedDescriptionLabel.text = String((feedCell?.feedDescriptionLabel.text?.prefix(60))!) //"123"
            }
        }
        
        var mediaArray = feedItem["media"] as? [Any] ?? []
        var mediaInfoDictionary = mediaArray[0] as? [AnyHashable: Any]
        var mediaMetaDataArray = mediaInfoDictionary?["media-metadata"] as? [Any]
        if NYTimesAppUtilities.objectIsValid(mediaMetaDataArray) {
            var feedImageDictionary = mediaMetaDataArray?[1] as? [AnyHashable: Any]
            // First, cancel other tasks that could be downloading images.
            // Set up a NSURL for the image you want.
            let imageURL = URL(string: feedImageDictionary?["url"] as? String ?? "")
            // Check if the URL is valid
            if imageURL != nil {
                // The URL is valid so we'll use it to load the image asynchronously.
                feedCell?.feedIconImageView.af_setImage(withURL: (imageURL)!, placeholderImage: nil)
            } else {
                // The imageURL is invalid, just show the placeholder image.
                DispatchQueue.main.async(execute: {
                    feedCell?.feedIconImageView.image = nil
                })
            }
            feedCell?.feedIconImageView.clipsToBounds = true
        }
        
        return feedCell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feedItem = NYTimesMostViewedFeedDataManager.sharedInstance.mostViewedFeedsArray[indexPath.row]
        if NYTimesAppUtilities.objectIsValid(feedItem) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let feedDetailViewController = storyboard.instantiateViewController(withIdentifier: "NYTimesMostViewedFeedDetailViewController") as? NYTimesMostViewedFeedDetailViewController
            feedDetailViewController?.feedDictionary = feedItem
            if let aController = feedDetailViewController {
                navigationController?.pushViewController(aController, animated: true)
            }
        }

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
