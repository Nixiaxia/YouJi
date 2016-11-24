import UIKit

// 顶部图片的高度
private let topImageHeight: CGFloat = 200
// 顶部图片
private var topImag: UIImageView?

private var topView: UIView?

private var blurView: UIVisualEffectView?

// 自定义导航栏
private var customNavc: UIView?
// 自定义返回按钮
private var customBackBtn: UIButton?
// 当导航栏透明的时候 加载在view上的按钮
private var viewBackBtn: UIButton?
// 自定义导航栏标题
private var customTitleLabel: UILabel?
// // 当导航栏透明的时候 加载在view上的标题
private var viewTitleLabel: UILabel?

class MainTravelViewController_1: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        // 顶部图片
        let topImage = UIImageView(frame: CGRect(x: 0, y:-topImageHeight, width: view.bounds.width, height: topImageHeight))
        topImage.image = UIImage(named: "1457667496349p1adhrbufv5ru161o14cu12penn93u")
        topImage.contentMode = .ScaleAspectFill
        topImage.clipsToBounds = true
        topImag = topImage
        
//        let topView_1 = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: topImageHeight))
//        topView_1.backgroundColor = UIColor(red: 0/255.0, green: 130/255.0, blue: 210/255.0, alpha: 0)
////        topView_1.alpha = 0.0
//        topImage.addSubview(topView_1)
//        topView = topView_1
        
        //首先创建一个模糊效果
        let blurEffect = UIBlurEffect.init(style: .Light)
        //接着创建一个承载模糊效果的视图
        let blurView_1 = UIVisualEffectView.init(effect: blurEffect)
        //设置模糊视图的大小
        blurView_1.frame.size = CGSize(width: topImage.frame.size.width, height: topImage.frame.size.height)
        blurView_1.alpha = 0.0
        blurView = blurView_1
        topImage.addSubview(blurView!)
        
        
        // tableView
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        tableView.delegate = self
        tableView.dataSource = self;
        view.addSubview(tableView)
        tableView.contentInset = UIEdgeInsetsMake(topImageHeight, 0, 0, 0)
        tableView.addSubview(topImage)
        
        // 自定义导航栏
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 64))
        view.addSubview(backView)
        backView.backgroundColor = UIColor.whiteColor()
        backView.alpha = 0.0
        customNavc = backView
        
        // 自定义返回按钮
        let backBtn = UIButton(frame: CGRect(x: 0, y: 20, width: 40, height: 44))
        backBtn.setImage(UIImage(named: "nav_back_icon_ipad"), forState: .Normal)
        backView.addSubview(backBtn)
        customBackBtn = backBtn
        
        // 返回按钮
        let btn = UIButton(frame: CGRect(x: 0, y: 20, width: 40, height: 44))
        btn.setImage(UIImage(named: "nav_back_icon_ipad"), forState: .Normal)
        view.addSubview(btn)
        viewBackBtn = btn
        
        // 自定义标题
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        titleLabel.center = CGPoint(x: view.frame.width / 2, y: 20 + 22)
        titleLabel.text = "标题"
        titleLabel.textColor = UIColor.whiteColor()
        customTitleLabel = titleLabel
        customNavc?.addSubview(titleLabel)
        
        // 标题
        let viewTitleLabe = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        viewTitleLabe.center = CGPoint(x: view.frame.width / 2, y: 20 + 22)
        viewTitleLabe.text = "标题"
        viewTitleLabe.textColor = UIColor.blackColor()
        viewTitleLabel = viewTitleLabe
        view?.addSubview(titleLabel)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellID = "cellID"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellID)
        }
        cell!.textLabel!.text = "cell\(indexPath.row)"
        return cell!
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offY = scrollView.contentOffset.y
        // 根据偏移量改变alpha的值
        blurView?.alpha = (offY + 64) / (topImageHeight - 64) + 1
//        topView?.alpha = (offY + 64) / (topImageHeight - 64) + 1
//        customNavc?.alpha = (offY + 64) / (topImageHeight - 64) + 1
        // 设置图片的高度 和 Y 值
        if offY < -topImageHeight {
            topImag?.frame.origin.y = offY
            topImag?.frame.size.height = -offY
        }
        
        // 改变导航栏（自定义View）返回按钮的图片 和 标题颜色
        if offY >= -64 {
            customBackBtn?.setImage(UIImage(named: "nav_back_icon_ipad"), forState: .Normal)
            viewBackBtn?.hidden = true
            customTitleLabel?.textColor = UIColor.blackColor()
        } else {
            customBackBtn?.setImage(UIImage(named: "nav_back_icon_ipad"), forState: .Normal)
            viewBackBtn?.hidden = false
            customTitleLabel?.textColor = UIColor.whiteColor()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

