////
////  SeviceViewController.swift
////  FirebaseApp
////
////  Created by Ritesh Narayan Patil on 4/27/18.
////  Copyright © 2018 Robert Canton. All rights reserved.
////
//
//import UIKit
//
//
//class SeviceViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate, UISearchBarDelegate,UINavigationControllerDelegate {
//    @IBOutlet weak var searchbar: UISearchBar!
//    @IBOutlet weak var tableView: UITableView!
//
//
//
//    var customersSerached :[Customers]? = [Customers]()
//    var roomsSerached :[Rooms]? = [Rooms]()
//    var bookingsStoreSearched :[Bookings]? =  [Bookings]()
//
//    var noDataLabel :UILabel = UILabel()
//    var tableViewIdentifier :String = String()
//    var isSearching : Bool = false
//
//    var isCustomerListClicked :Bool = false
//    var isRoomListClicked :Bool = false
//    var isBookedListClicked :Bool = false
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        let backItem = UIBarButtonItem()
//        backItem.title = ""
//        navigationItem.backBarButtonItem = backItem
//
//        context = CoreDataHelpher.saveDatainContext()
//
//
//        customers = CoreDataHelpher.fetchRecordsFromCustomers(context: context)
//        rooms = CoreDataHelpher.fetchRecordsFromRoom(context: context)
//        bookingsStore = CoreDataHelpher.fetchRecordsFromBooking(context:context)
//        tableView.alpha = 1.0
//
//        // Do any additional setup after loading the view.
//    }
//    override func viewWillAppear(_ animated: Bool) {
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//
//
//        if isCustomerListClicked == true{
//            tableViewIdentifier = "customTableViewCell"
//            var nipName=UINib(nibName:"CustomTable", bundle:nil)
//            self.tableView.register(nipName, forCellReuseIdentifier:tableViewIdentifier)
//        }else if isRoomListClicked == true{
//
//            tableViewIdentifier = "roomTableViewCell"
//            var nipName=UINib(nibName:"RoomTableXib", bundle:nil)
//            self.tableView.register(nipName, forCellReuseIdentifier:"roomTableViewCell")
//
//
//        }else{
//            tableViewIdentifier = "bookingTableViewCell"
//            var nipName=UINib(nibName:"BookingTableXib", bundle:nil)
//            self.tableView.register(nipName, forCellReuseIdentifier:"bookingTableViewCell")
//        }
//        self.navigationItem.hidesBackButton = true
//        //
//        //        self.customerView.alpha = 0
//        //        self.roomView.alpha = 0
//        //        self.BookingView.alpha = 0
//
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        navigationItem.rightBarButtonItem = addButton
//
//
//        let newBackButton = UIBarButtonItem(image: UIImage(named: "back"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(self.backButtonClick(sender:)))
//        //UIBarButtonItem(title: "<", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MyWalkViewController.back(sender:)))
//        self.navigationItem.leftBarButtonItem = newBackButton
//
//        noDataLabel.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height)
//
//        noDataLabel.text = "No Records Found. To add Please Press + Button in the navigation bar"
//        noDataLabel.textColor = UIColor.black
//        noDataLabel.textAlignment = .center
//        noDataLabel.numberOfLines = 2
//        self.tableView.backgroundView = noDataLabel
//        self.tableView.separatorStyle = .none
//        noDataLabel.alpha = 0.0
//        tableView.reloadData()
//
//        animateTable()
//        self.searchbar.delegate = self
//        self.title = "List"
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func animateTable() {
//
//        tableView.alpha = 1
//        tableView.reloadData()
//
//        let cells = tableView.visibleCells
//
//        self.tableView.layoutIfNeeded()
//        var tableHeight: CGFloat = tableView.bounds.size.height
//
//
//
//
//
//        for i in cells {
//            let cell: UITableViewCell = i as UITableViewCell
//
//
//
//            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
//        }
//
//        var index = 0
//
//        for a in cells {
//            let cell: UITableViewCell = a as UITableViewCell
//
//
//            UIView.animate(withDuration: 1.8, delay:  0.050 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
//                cell.transform = CGAffineTransform(translationX: 0, y: 0);
//            }, completion: { (Bool) in
//
//            })
//
//
//
//            index += 1
//        }
//
//
//    }
//
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        if isCustomerListClicked == true && customers?.count != 0{
//            noDataLabel.alpha = 0.0
//            self.searchbar.alpha = 1.0
//            if isSearching == true{
//                return (customersSerached?.count)!
//            }else{
//                return (customers?.count)!
//                //return 5
//            }
//
//
//        }else if isRoomListClicked == true && rooms?.count != 0{
//            noDataLabel.alpha = 0.0
//            self.searchbar.alpha = 1.0
//            if isSearching == true{
//                return (roomsSerached?.count)!
//            }else{
//                return (rooms?.count)!;
//            }
//
//
//        }else  if isBookedListClicked  == true && bookingsStore?.count != 0{
//            noDataLabel.alpha = 0.0
//            self.searchbar.alpha = 1.0
//            if isSearching == true{
//                return (bookingsStoreSearched?.count)!
//            }else{
//                return (bookingsStore?.count)!
//            }
//
//        }else{
//            noDataLabel.alpha = 1.0
//            self.searchbar.alpha = 0.0
//
//            return 0
//        }
//
//        return 5;
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//        if isCustomerListClicked == true{
//            var cell:CustomTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier, for: indexPath) as! CustomTableViewCell
//
//            cell.selectionStyle = .none
//            print("Ritesh")
//
//
//
//            //  if isCustomerListClicked == true{
//            if customers?.count != 0{
//
//                if isSearching == true {
//                    cell.label1.text! = customersSerached![indexPath.row].name!
//
//                    cell.idLabel.text! = String(describing: customersSerached![indexPath.row].customerId!)
//                    cell.addressLabel.text! = customersSerached![indexPath.row].address!
//                    cell.phoenNumber.text! = String(describing: customersSerached![indexPath.row].phoneNumber!)
//
//
//                }else{
//                    cell.label1.text! = customers![indexPath.row].name!
//
//                    cell.idLabel.text! = String(describing: customers![indexPath.row].customerId!)
//                    cell.addressLabel.text! = customers![indexPath.row].address!
//                    cell.phoenNumber.text! = String(describing: customers![indexPath.row].phoneNumber!)
//                    //
//                    //                    cell.label1.text! = "Ritesh"
//                    //
//                    //                    cell.idLabel.text! = "idLabel"
//                    //                    cell.addressLabel.text! = "Sanika"
//                    //                    cell.phoenNumber.text! = "Ritesh Narayan Patil"
//
//                }
//            }
//
//            return cell
//        }else if isRoomListClicked == true{
//
//            var cell:RoomTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "roomTableViewCell", for: indexPath) as! RoomTableViewCell
//
//            cell.selectionStyle = .none
//            print("Ritesh")
//
//
//            if rooms?.count != 0{
//
//                if  isSearching == true{
//                    cell.lblroomNo.text! = roomsSerached![indexPath.row].roomNumber!
//
//                    cell.lblPrice.text! = String(describing: roomsSerached![indexPath.row].roomPrice!) + " $"
//
//                    cell.lblroomType.text! = String(describing: roomsSerached![indexPath.row].roomType!)
//
//                    var imageUIImage: UIImage = UIImage(data: roomsSerached![indexPath.row].roomImage!)!
//                    cell.roomTypeImage.image = imageUIImage
//                }else{
//                    cell.lblroomNo.text! = rooms![indexPath.row].roomNumber!
//
//                    cell.lblPrice.text! = String(describing: rooms![indexPath.row].roomPrice!) + " $"
//
//                    cell.lblroomType.text! = String(describing: rooms![indexPath.row].roomType!)
//                    if rooms![indexPath.row].roomImage != nil{
//                        var imageUIImage: UIImage = UIImage(data: rooms![indexPath.row].roomImage!)!
//
//                        cell.roomTypeImage.image = imageUIImage
//                    }else{
//
//                        cell.roomTypeImage.image = UIImage(named: "ImageOfperson")
//                    }
//                }
//            }
//
//            return cell
//        }else {
//
//
//
//            var cell:BookingTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: tableViewIdentifier,
//                                                                               for: indexPath) as! BookingTableViewCell
//
//            cell.selectionStyle = .none
//            print("Ritesh B")
//
//            print(bookingsStore?.count)
//            print(bookingsStoreSearched?.count)
//            if bookingsStore?.count != 0{
//                if isSearching == true{
//
//
//
//
//                    cell.customerId.text = bookingsStoreSearched![indexPath.row].customerId!
//                    cell.bookingName.text = bookingsStoreSearched![indexPath.row].bookingName!
//                    cell.bookingId.text = bookingsStoreSearched![indexPath.row].bookingId
//                    cell.bookingRoomNo.text = bookingsStoreSearched![indexPath.row].roomNumber
//                    cell.fromDate.text = String(describing: bookingsStoreSearched![indexPath.row].checkInDate!)
//                    cell.toDate.text = String(describing: bookingsStoreSearched![indexPath.row].checkOutDate!)
//
//                    //                    if roomsSerached
//                    //                    if rooms![indexPath.row].roomImage != nil{
//                    //                        var imageUIImage: UIImage = UIImage(data: roomsSerached![indexPath.row].roomImage!)!
//                    //
//                    //                        cell.bookingRoomImage.image = imageUIImage
//                    //                    }else{
//                    //
//                    //                        cell.bookingRoomImage.image = UIImage(named: "ImageOfperson")
//                    //                    }
//
//                }else{
//                    cell.customerId.text = bookingsStore![indexPath.row].customerId!
//                    cell.bookingName.text = bookingsStore![indexPath.row].bookingName!
//                    cell.bookingId.text = bookingsStore![indexPath.row].bookingId
//                    cell.bookingRoomNo.text = bookingsStore![indexPath.row].roomNumber
//                    cell.fromDate.text = String(describing: bookingsStore![indexPath.row].checkInDate!)
//                    cell.toDate.text = String(describing: bookingsStore![indexPath.row].checkOutDate!)
//
//                    //                    for room in rooms! {
//                    //                        if room.roomNumber == bookingsStore![indexPath.row].roomNumber{
//                    //
//                    //                            if rooms![indexPath.row].roomImage != nil{
//                    //                                var imageUIImage: UIImage = UIImage(data: rooms![indexPath.row].roomImage!)!
//                    //
//                    //                                cell.bookingRoomImage.image = UIImage(data: rooms![indexPath.row].roomImage!)!
//                    //                            }else{
//                    //
//                    //                                cell.bookingRoomImage.image = UIImage(named: "ImageOfperson")
//                    //                            }
//                    //
//                    //                        }
//                    //
//                    //                    }
//                    //
//
//
//
//
//                }
//            }
//
//            return cell
//        }
//
//    }
//
//    func navigateToDetailViewController(){
//
//
//        let forgotVC = UIStoryboard(name: "Main", bundle: nil)
//        if let forgotViewVC = forgotVC.instantiateViewController(withIdentifier: "BookingViewController") as? BookingViewController {
//
//            forgotViewVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//            if isCustomerListClicked == true{
//
//
//            }else if isRoomListClicked == true{
//
//
//            }else if isRoomListClicked == true{
//
//
//
//
//            }
//
//
//            self.navigationController?.pushViewController(forgotViewVC, animated: true)
//
//        }
//
//    }
//
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if tableView == self.tableView
//        {
//
//            let forgotVC = UIStoryboard(name: "Main", bundle: nil)
//            if let forgotViewVC = forgotVC.instantiateViewController(withIdentifier: "BookingViewController") as? BookingViewController {
//
//                forgotViewVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//                if isBookedListClicked == true{
//                    var curCell=tableView.cellForRow(at: indexPath) as! BookingTableViewCell
//                    forgotViewVC.titleBookingLabel.text = "Id"
//                    forgotViewVC.titleBookingLabel2.text = "Start Date"
//                    forgotViewVC.titleBookingLabel3.text = "End Date"
//                    forgotViewVC.titleBookinhLabel4.text = "Name"
//
//                    forgotViewVC.subTitleLabel.text = curCell.bookingId.text
//                    forgotViewVC.subTitleLabel1.text = curCell.fromDate.text
//                    forgotViewVC.subTitleLabel2.text = curCell.toDate.text
//                    forgotViewVC.subTitleLabel3.text = curCell.bookingName.text
//
//
//                }else if isCustomerListClicked == true{
//
//                    var curCell=tableView.cellForRow(at: indexPath) as! CustomTableViewCell
//                    forgotViewVC.titleBookingLabel.text = "Id"
//                    forgotViewVC.titleBookingLabel2.text = "Phone Number"
//
//                    forgotViewVC.titleBookingLabel3.text = "Name"
//
//                    forgotViewVC.subTitleLabel.text = curCell.idLabel.text
//                    forgotViewVC.subTitleLabel1.text = curCell.phoenNumber.text
//                    forgotViewVC.subTitleLabel2.text = curCell.label1.text
//                    forgotViewVC.subTitleLabel3.text = curCell.addressLabel.text
//
//
//                }else if isRoomListClicked == true{
//                    var curCell=tableView.cellForRow(at: indexPath) as! RoomTableViewCell
//                    forgotViewVC.titleBookingLabel.text = "Room No"
//                    forgotViewVC.titleBookingLabel2.text = "Price"
//
//                    forgotViewVC.titleBookingLabel3.text = "Type"
//
//                    forgotViewVC.subTitleLabel.text = curCell.lblroomNo.text
//                    forgotViewVC.subTitleLabel1.text = curCell.lblPrice.text
//                    forgotViewVC.subTitleLabel3.text = curCell.lblroomType.text
//                    forgotViewVC.imageView.image = curCell.roomTypeImage.image
//
//                }
//                self.navigationController?.pushViewController(forgotViewVC, animated: true)
//            }
//
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        var cellHeight:CGFloat = 75
//
//        //        if isBookedListClicked == true{
//        //            for expandedIndexPath in expandedIndexPathsArray{
//        //                if indexPath.compare((expandedIndexPath as! NSIndexPath) as IndexPath)==ComparisonResult.orderedSame {
//        //
//        //                    cellHeight=150
//        //                }
//        //            }
//        //        }
//        return cellHeight;
//
//    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//
//        if editingStyle == .delete {
//            print("Deleted")
//            if isBookedListClicked == true{
//
//                if isSearching == false{
//                    CoreDataHelpher.deleteObject(context: context, booking: bookingsStore![indexPath.row])
//                    bookingsStore?.remove(at: indexPath.row)
//                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
//                }else{
//                    searchbar.text = " "
//                    bookingsStore?.remove(at: indexPath.row)
//
//                    CoreDataHelpher.deleteObject(context: context, booking: bookingsStore![indexPath.row])
//                    bookingsStoreSearched?.remove(at: indexPath.row)
//                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
//                    // self.tableView.reloadData()
//                }
//
//
//            }
//        }
//    }
//
//
//    @objc
//    func insertNewObject(_ sender: Any) {
//        //if isCustomerListClicked == true{
//        //self.customerView.alpha = 1
//
//        // self.searchBar.alpha = 0
//        navigateToOtherViewController()
//        // self.addCustomer()
//
//
//        //    imageViewForRoom.image = UIImage(named: "ImageOfperson")
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        navigationItem.rightBarButtonItem = addButton
//
//        // }
//    }
//    @objc func backButtonClick(sender: UIBarButtonItem) {
//
//        //        if customerView.alpha == 1{
//        //            UIView.animate(withDuration: 0.5) {
//        //                self.customerView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height - 64)
//        //                self.customerView.alpha = 0
//        //                self.searchbar.alpha = 1
//        //                let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.insertNewObject(_:)))
//        //                self.navigationItem.rightBarButtonItem = addButton
//        //                self.showCustomerList()
//        //
//        //
//        //            }
//        //            self.tableView.reloadData()
//        //
//        //        }else if roomView.alpha == 1{
//        //            UIView.animate(withDuration: 0.5) {
//        //                self.roomView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height - 64)
//        //                self.roomView.alpha = 0
//        //                self.searchbar.alpha = 1
//        //                let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.insertNewObject(_:)))
//        //                self.navigationItem.rightBarButtonItem = addButton
//        //                self.showRoomList()
//        //
//        //                self.tableView.reloadData()
//        //            }
//        //
//        //        }else if BookingView.alpha == 1{
//        //
//        //            UIView.animate(withDuration: 0.5) {
//        //                self.BookingView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height - 64)
//        //                self.BookingView.alpha = 0
//        //                self.searchbar.alpha = 1
//        //                let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.insertNewObject(_:)))
//        //                self.navigationItem.rightBarButtonItem = addButton
//        //                self.showBookingList()
//        //
//        //                self.tableView.reloadData()
//        //            }
//        //
//        //        }else{
//
//        _ = navigationController?.popViewController(animated: true)
//
//        animateTable()
//        //}
//    }
//
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//
//        print(bookingsStore?.count)
//        if searchBar.text == nil || searchBar.text == "" {
//            isSearching = false
//            view.endEditing(true)
//            tableView.reloadData()
//        }else{
//
//            isSearching = true
//            if isCustomerListClicked == true{
//                customersSerached?.removeAll(keepingCapacity: false)
//                let searchPredicate = NSPredicate(format: "customerId CONTAINS[c] %@" , searchText)
//
//                let array = (customers as! NSArray).filtered(using: searchPredicate)
//                customersSerached = array as! Array<Customers>
//            }else if isRoomListClicked == true{
//                roomsSerached?.removeAll(keepingCapacity: false)
//                let searchPredicate = NSPredicate(format: "roomNumber CONTAINS[c] %@" , searchText)
//
//                let array = (rooms as! NSArray).filtered(using: searchPredicate)
//                roomsSerached = array as! Array<Rooms>
//
//            }else if isBookedListClicked == true{
//                bookingsStoreSearched?.removeAll(keepingCapacity: false)
//                let searchPredicate = NSPredicate(format: "bookingId CONTAINS[c] %@" , searchText)
//
//                let array = (bookingsStore as! NSArray).filtered(using: searchPredicate)
//                bookingsStoreSearched = array as! Array<Bookings>
//            }
//
//            self.tableView.reloadData()
//        }
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        isSearching = false
//    }
//
//    func navigateToOtherViewController(){
//
//
//
//        if isCustomerListClicked == true{
//
//            let forgotVC = UIStoryboard(name: "Main", bundle: nil)
//            if let forgotViewVC = forgotVC.instantiateViewController(withIdentifier: "CustomerViewController") as? CustomerViewController {
//
//                forgotViewVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//
//
//                self.navigationController?.pushViewController(forgotViewVC, animated: true)
//
//            }
//
//
//
//            //   addCustomer()
//
//        }else if isRoomListClicked == true{
//            // addRoom()
//
//            let forgotVC = UIStoryboard(name: "Main", bundle: nil)
//            if let forgotViewVC = forgotVC.instantiateViewController(withIdentifier: "RoomViewController") as? RoomViewController {
//
//                forgotViewVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//
//
//                self.navigationController?.pushViewController(forgotViewVC, animated: true)
//
//            }
//
//        }else if isBookedListClicked == true{
//            //searchTextFiedl.alpha = 0
//            let forgotVC = UIStoryboard(name: "Main", bundle: nil)
//            if let forgotViewVC = forgotVC.instantiateViewController(withIdentifier: "BookingListViewController") as? BookingListViewController {
//
//                forgotViewVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//
//
//                self.navigationController?.pushViewController(forgotViewVC, animated: true)
//
//            }
//
//            //addBookingList()
//        }
//
//        //    self.searchBar.alpha = 0
//
//        //self.present(self, animated: true, completion: nil)
//
//
//    }
//
//
//}
//
//
