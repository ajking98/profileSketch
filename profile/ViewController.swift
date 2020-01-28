//
//  ViewController.swift
//  profile
//
//  Created by Ahmed Gedi on 1/24/20.
//  Copyright © 2020 Ahmed Gedi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Measurement Variables
    var bounds = UIScreen.main.bounds
    var width:CGFloat = 0.0
    var height:CGFloat = 0.0
    
    // Data Points
    var profileName = "Ahmed Gedi"
    var username = "@ahmedgedi"
    var numberOfGems = 0
    var isUser = true
    
    // Views
    var profileNav = UINavigationBar()
    var scrollView = UIScrollView()
    var imageView = UIImageView()
    var collectionView: UICollectionView!
    var secondCollectionView: UICollectionView!
    var nextBar = UIView()
    let stackView = UIStackView()
    let innerStackView = UIStackView()
    let secondInnerStackView = UIStackView()
    var usernameLabel = UILabel()
    var gemLabel = UILabel()
    let followButton = UIButton()
    let editProfileButton = UIButton()
    var gems = UIImage(named: "profileGems")
    var likes = UIImage(named: "like")
    var segmentedControl = UISegmentedControl()
    let horizontalBar = UIView()
    let segmentMiddlebar = UIView()
    
    // Collection View
    var cellIdentifier = "Cell"
    var data: [Int] = Array(1..<1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello")
        view.addSubview(scrollView)
        width = bounds.size.width
        height = bounds.size.height
        
        scrollView.frame = CGRect.zero
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0)
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0)
        scrollView.widthAnchor.constraint(equalToConstant: width).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: height).isActive = true
        scrollView.showsVerticalScrollIndicator = false
        // TODO: The height of the entire view needs to be here, included the size of the collectionview
        // Calculate it and it'll be okay
        scrollView.contentSize = CGSize(width: width, height: height*2)
        
        
        self.createProfilePage()
    }
    
    func createProfilePage() {
        self.createNavigationBar(isUser: isUser)
        self.createProfileImage()
        self.createNameLabel()
        self.createGemLabel(gems: numberOfGems)
        self.createStatusView(following: 12, followers: 101, likes: 10)
        self.addButton(isUser: isUser)
        self.createStatusBar()
        self.createSegmentControl()
        self.setUpCollectionView()
        self.createTabBar(isUser: isUser)
        self.createSegmentBars()
    }
    
    /*
     TODO: Put entire view onto a scroll view
     */
    func createNavigationBar(isUser: Bool) {
        profileNav.tintColor = UIColor.white
        let navItem = UINavigationItem(title: profileName)
        profileNav.pushItem(navItem, animated: false)
        
        if !isUser {
            // Creating Left Back Button, image imported from AdobeXD
            let back = UIButton(type: .custom)
            back.setImage(UIImage(named: "backButton"), for: .normal)
            back.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            back.addTarget(self, action: #selector(backToggle), for: .touchUpInside)
            let navItem2 = UIBarButtonItem(customView: back)
            navItem.setLeftBarButton(navItem2, animated: false)
        }
        
        // Creating Right Setting Button, image imported from AdobeXD
        let settings = UIButton(type: .custom)
        settings.setImage(UIImage(named: "settings"), for: .normal)
        settings.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        settings.addTarget(self, action: #selector(settingToggle), for: .touchUpInside)
        let navItem3 = UIBarButtonItem(customView: settings)
        navItem.setRightBarButton(navItem3, animated: false)
        
        scrollView.addSubview(profileNav)
        
        profileNav.frame = CGRect.zero
        profileNav.translatesAutoresizingMaskIntoConstraints = false
        profileNav.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        profileNav.heightAnchor.constraint(equalToConstant: height/10).isActive = true
        profileNav.widthAnchor.constraint(equalToConstant: width*1.02).isActive = true
        profileNav.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    }
    
    // TODO: Add settigns function
    @objc func settingToggle(sender: UIButton!) {
        print("Toggled Settings")
    }
    
    // TODO: Add back toggle function for other profiles
    @objc func backToggle(sender: UIButton) {
        print("Back")
    }
    
    func createProfileImage() {
        imageView.image = UIImage(named: "userImage")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        scrollView.addSubview(imageView)
        
        //temp
        imageView.frame = CGRect.zero
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: height*0.12).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: height*0.12).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: height/13).isActive = true
        imageView.layer.cornerRadius = height * 0.06
    }
    
    func createNameLabel() {
        usernameLabel.text = self.username
        //TODO: Add actual font
        usernameLabel.sizeToFit()
        usernameLabel.font = usernameLabel.font.withSize(width/35)
        usernameLabel.textAlignment = .center
        
        scrollView.addSubview(usernameLabel)
        
        usernameLabel.frame = CGRect.zero
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: usernameLabel.font.pointSize * 1.5).isActive = true
        usernameLabel.widthAnchor.constraint(equalToConstant: width*0.6).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        
    }
    
    func createGemLabel(gems: Int) {
        gemLabel.text = "\(gems) gems"
        gemLabel.sizeToFit()
        gemLabel.textAlignment = .center
        gemLabel.font = gemLabel.font.withSize(width/30)
        
        scrollView.addSubview(gemLabel)
        
        gemLabel.frame = CGRect.zero
        gemLabel.translatesAutoresizingMaskIntoConstraints = false
        gemLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        gemLabel.heightAnchor.constraint(equalToConstant: gemLabel.font.pointSize * 1.5).isActive = true
        gemLabel.widthAnchor.constraint(equalToConstant: width*0.6).isActive = true
        gemLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 2).isActive = true
    }
    
    func createStatusView(following: Int, followers: Int, likes: Int) {
        stackView.backgroundColor = .black
        stackView.axis = .vertical
        stackView.alignment = .fill // .leading .firstBaseline .center .trailing .lastBaseline
        stackView.distribution = .fillEqually // .fillEqually .fillProportionally .equalSpacing .equalCentering
        
        createInnerStackView(following: following, followers: followers, likes: likes)
        
        stackView.frame = CGRect(x: width/8 , y: (self.scrollView.center.y)/1.6, width: width*0.8, height: height/14)
        scrollView.addSubview(stackView)
        
        stackView.frame = CGRect.zero
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: height/14).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: width*0.8).isActive = true
        stackView.topAnchor.constraint(equalTo: gemLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func createInnerStackView(following: Int, followers: Int, likes: Int) {
        innerStackView.backgroundColor = .black
        innerStackView.axis = .horizontal
        innerStackView.alignment = .fill // .leading .firstBaseline .center .trailing .lastBaseline
        innerStackView.distribution = .fillEqually // .fillEqually .fillProportionally .equalSpacing .equalCentering
        
        secondInnerStackView.backgroundColor = .black
        secondInnerStackView.axis = .horizontal
        secondInnerStackView.alignment = .fill // .leading .firstBaseline .center .trailing .lastBaseline
        secondInnerStackView.distribution = .fillEqually // .fillEqually .fillProportionally .equalSpacing .equalCentering
        
        stackView.addArrangedSubview(innerStackView)
        stackView.addArrangedSubview(secondInnerStackView)
        
        createFollowingView(following: following)
        createFollowerView(followers: followers)
        createLikeView(likes: likes)
    }
    
    func createFollowingView(following: Int) {
        let view = UIView()
        let numberLabel = UILabel()
        let textLabel = UILabel()
        numberLabel.text = "\(following)"
        textLabel.text = "Following"
        textLabel.textColor = .systemGray2
        numberLabel.textAlignment = .center
        textLabel.textAlignment = .center
        view.addSubview(numberLabel)
        view.addSubview(textLabel)
        view.backgroundColor = .systemGray2
        innerStackView.addArrangedSubview(numberLabel)
        secondInnerStackView.addArrangedSubview(textLabel)
    }
    
    func createFollowerView(followers: Int) {
        let view = UIView()
        let numberLabel = UILabel()
        let textLabel = UILabel()
        numberLabel.text = "\(followers)"
        textLabel.text = "Followers"
        textLabel.textColor = .systemGray2
        numberLabel.textAlignment = .center
        textLabel.textAlignment = .center
        view.addSubview(numberLabel)
        view.addSubview(textLabel)
        view.backgroundColor = .systemGray2
        innerStackView.addArrangedSubview(numberLabel)
        secondInnerStackView.addArrangedSubview(textLabel)
    }
    
    func createLikeView(likes: Int) {
        let view = UIView()
        let numberLabel = UILabel()
        let textLabel = UILabel()
        numberLabel.text = "\(likes)"
        textLabel.text = "Likes"
        textLabel.textColor = .systemGray2
        numberLabel.textAlignment = .center
        textLabel.textAlignment = .center
        view.addSubview(numberLabel)
        view.addSubview(textLabel)
        view.backgroundColor = .systemGray2
        innerStackView.addArrangedSubview(numberLabel)
        secondInnerStackView.addArrangedSubview(textLabel)
    }
    
    func createStatusBar() {
        let bar = UIView(frame: CGRect(x: width/2.8, y: (self.scrollView.center.y)/1.62, width: 1, height: height/35))
        bar.backgroundColor = .systemGray5
        scrollView.addSubview(bar)
        
        let bar2 = UIView(frame: CGRect(x: width/1.55, y: (self.scrollView.center.y)/1.62, width: 1, height: height/35))
        bar2.backgroundColor = .systemGray5
        scrollView.addSubview(bar2)
    }
    
    func addButton(isUser: Bool) {
        if isUser {
            createEditProfileButton()
        } else {
            createFollowButton()
        }
    }
    func createEditProfileButton() {
        editProfileButton.backgroundColor = UIColor(red:0.93, green:0.11, blue:0.32, alpha:1.0)
        editProfileButton.setTitle("Edit Profile", for: .normal)
        editProfileButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.scrollView.addSubview(editProfileButton)
        
        editProfileButton.frame = CGRect.zero
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        editProfileButton.heightAnchor.constraint(equalToConstant: height/18).isActive = true
        editProfileButton.widthAnchor.constraint(equalToConstant: width*0.4).isActive = true
        editProfileButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30).isActive = true
    }
    
    // TODO: Add edit profile function for user's account
    @objc func buttonAction(sender: UIButton!) {
      print("Edit Profile")
    }
    
    // Only if other account
    func createFollowButton() {
        followButton.backgroundColor = UIColor(red:0.93, green:0.11, blue:0.32, alpha:1.0)
        followButton.setTitle("Follow", for: .normal)
        followButton.addTarget(self, action: #selector(followButtonAction), for: .touchUpInside)

        self.scrollView.addSubview(followButton)
        
        followButton.frame = CGRect.zero
        followButton.translatesAutoresizingMaskIntoConstraints = false
        followButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        followButton.heightAnchor.constraint(equalToConstant: height/18).isActive = true
        followButton.widthAnchor.constraint(equalToConstant: width*0.4).isActive = true
        followButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30).isActive = true
    }
    
    // TODO: Add follow profile function for other accounts
    @objc func followButtonAction(sender: UIButton!) {
      print("Followed")
    }
    
    func createSegmentControl() {
        let items = [gems, likes]
        segmentedControl = UISegmentedControl(items : items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(handleSegmentTap), for: .valueChanged)

        segmentedControl.backgroundColor = .white
        segmentedControl.tintColor = .black
        segmentedControl.removeBorders()
        self.scrollView.addSubview(segmentedControl)
        
        segmentedControl.frame = CGRect.zero
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: height/18).isActive = true
        segmentedControl.widthAnchor.constraint(equalToConstant: width).isActive = true
        if isUser {
            segmentedControl.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: height/25).isActive = true
        } else {
            segmentedControl.topAnchor.constraint(equalTo: followButton.bottomAnchor, constant: height/25).isActive = true
        }
        
    }
    
    @objc func handleSegmentTap(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Gems")
            secondCollectionView.alpha = 0.0
            collectionView.alpha = 1.0
        case 1:
            print("Likes")
            secondCollectionView.alpha = 1.0
            collectionView.alpha = 0.0
        default:
            break
        }
    }
    
    func createSegmentBars() {
        horizontalBar.backgroundColor = .systemGray5
        scrollView.addSubview(horizontalBar)
        
        horizontalBar.frame = CGRect.zero
        horizontalBar.translatesAutoresizingMaskIntoConstraints = false
        horizontalBar.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        horizontalBar.heightAnchor.constraint(equalToConstant: 1).isActive = true
        horizontalBar.widthAnchor.constraint(equalToConstant: width).isActive = true
        horizontalBar.topAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: 0).isActive = true
        
//        let segmentMiddlebar = UIView(frame: CGRect(x: width/2, y: (self.view.center.y)*1.04, width: 1, height: height/35))
        segmentMiddlebar.backgroundColor = .systemGray5
        scrollView.addSubview(segmentMiddlebar)
        
        segmentMiddlebar.frame = CGRect.zero
        segmentMiddlebar.translatesAutoresizingMaskIntoConstraints = false
        segmentMiddlebar.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        segmentMiddlebar.heightAnchor.constraint(equalToConstant: height/35).isActive = true
        segmentMiddlebar.widthAnchor.constraint(equalToConstant: 1).isActive = true
        segmentMiddlebar.topAnchor.constraint(equalTo: horizontalBar.bottomAnchor, constant: height/75).isActive = true
    }
    
    func setUpCollectionView() {
        var frame = CGRect(x: 0, y: height/1.75, width: width, height: height*2)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.alwaysBounceVertical = false
        self.collectionView.backgroundColor = .white
        self.collectionView.isScrollEnabled = false;
        setUpSecondCollectionView()
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(collectionView)
        collectionView.frame = CGRect.zero
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: height*2).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: width).isActive = true
        collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 0).isActive = true
    }
    
    func setUpSecondCollectionView() {
        var frame = CGRect(x: 0, y: height/1.75, width: width, height: height*2)
        secondCollectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.secondCollectionView.dataSource = self
        self.secondCollectionView.delegate = self
        self.secondCollectionView.register(Cell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.secondCollectionView.showsHorizontalScrollIndicator = false
        self.secondCollectionView.alwaysBounceVertical = false
        self.secondCollectionView.showsVerticalScrollIndicator = false
        self.secondCollectionView.backgroundColor = .white
        self.secondCollectionView.isScrollEnabled = false;
        configureSecondCollectionView()
    }
        
    func configureSecondCollectionView() {
        secondCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(secondCollectionView)
        secondCollectionView.frame = CGRect.zero
        secondCollectionView.translatesAutoresizingMaskIntoConstraints = false
        secondCollectionView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        secondCollectionView.heightAnchor.constraint(equalToConstant: height*2).isActive = true
        secondCollectionView.widthAnchor.constraint(equalToConstant: width).isActive = true
        secondCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 0).isActive = true
    }
    
    // TODO: Fix when segemnt control is pressed and the bottom tab bar changes
    func createTabBar(isUser: Bool) {
        if isUser {
            // TODO: Replace with TabBar Controller
            nextBar.backgroundColor = UIColor(red:0.93, green:0.11, blue:0.32, alpha:1.0)
            nextBar.frame = CGRect(x: 0, y: height - 80 , width: self.scrollView.frame.width, height: 80)
            self.scrollView.addSubview(nextBar)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // For GemCollections
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Cell
            let data = self.data[indexPath.item]
            cell.nameLabel.text = "Gem Collection"
            return cell
        }
        // For LikeCollections
        else {
            let cell = secondCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Cell
            let data = self.data[indexPath.item]
            cell.nameLabel.text = "Like Collection"
            return cell
        }
        
    }
    
    // TODO: Add function when content in profile collections get clicked
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width)/3, height: (collectionView.bounds.width)/2)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

class Cell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
//    let picCollection: UIImageView = {
//        let image = UIImage(named: "example\(3)")
//        let imageView = UIImageView(image: image)
//        return imageView
//    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        backgroundColor = UIColor.systemGray6
        
//        addSubview(picCollection)
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": picCollection]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": picCollection]))
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(color: backgroundColor!), for: .normal, barMetrics: .default)
        setBackgroundImage(imageWithColor(color: tintColor!), for: .selected, barMetrics: .default)
        setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}
