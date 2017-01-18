//
//  JCDishDetailController.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/12/6.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class JCDishDetailController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 背景
    private lazy var background: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "homeEdit_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 白色背景
    private lazy var whitebackground: UIImageView = {
        let background = UIImageView();
        background.image = UIImage.imageWithName(name: "homeEdit_white_background");
        background.isUserInteractionEnabled = true;
        return background;
    }();
    
    // 标题
    private lazy var titleView: UILabel = {
        let label = UILabel();
        label.text = "修改菜品信息";
        label.font = Font(size: 48/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .center;
        return label;
    }();
    
    // 菜图片
    private lazy var dishImageBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "homeEdit_image"), for: .normal);
        button.addTarget(self, action: #selector(dishImageBtnClick), for: .touchUpInside);
        return button;
    }();
    
    
    // 请上传图片
    private lazy var hintImage: JCHintLabel = {
        let hintImage = JCHintLabel();
        hintImage.text = "请上传图片";
        hintImage.isHidden = true;
        return hintImage;
    }();
    
    
    // 菜品名称
    private lazy var dishNameLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.text = "菜品名称";
        label.textAlignment = .left;
        return label;
    }();
    
    // 菜品名称输入框
    private lazy var dishNameTextField: UITextField = {
        let textField = UITextField();
        textField.borderStyle = .none;
        textField.clearButtonMode = .whileEditing;
        textField.font = Font(size: 32/2);
        textField.textAlignment = .center;
        return textField;
    }();
    
    // 请输入菜名
    private lazy var hintDishName: JCHintLabel = {
        let hintDishName = JCHintLabel();
        hintDishName.text = "请输入菜名";
        hintDishName.isHidden = true;
        return hintDishName;
    }();
    
    // 价格
    private lazy var dishPriceLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.text = "价格";
        label.textAlignment = .left;
        return label;
    }();
    
    // 价格输入框
    private lazy var dishPriceTextField: UITextField = {
        let textField = UITextField();
        textField.borderStyle = .none;
        textField.clearButtonMode = .whileEditing;
        textField.font = Font(size: 32/2);
        textField.textAlignment = .center;
        textField.keyboardType = .namePhonePad;
        return textField;
    }();
    
    // 提示价格
    private lazy var hintPrice: JCHintLabel = {
        let hintPrice = JCHintLabel();
        hintPrice.text = "请输入价格";
        hintPrice.isHidden = true;
        return hintPrice;
    }();
    
    // 复选框
    private lazy var checkBoxBtn: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "checkbox_normal"), for: .normal);
        button.setImage(UIImage.imageWithName(name: "checkbox_selected"), for: .selected);
        button.addTarget(self, action: #selector(checkBoxBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    private lazy var recommendLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.text = "推荐";
        return label;
    }();
    
    // 标签
    private lazy var markLabel: UILabel = {
        let label = UILabel();
        label.text = "推荐（可不选）";
        label.textColor = RGBWithHexColor(hexColor: 0x808080);
        label.textAlignment = .left;
        label.font = Font(size: 28/2);
        return label;
    }();
    
   
    // 菜品介绍
    private lazy var dishDesLabel: UILabel = {
        let label = UILabel();
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.text = "介绍";
        label.textAlignment = .left;
        return label;
    }();
    
    // 输入框背景
    private lazy var textViewBackground: UIImageView = {
        let background = UIImageView();
        background.isUserInteractionEnabled = true;
        background.image = UIImage.imageWithName(name: "homeEdit_desTextView_border");
        return background;
    }();
    
    // 菜品介绍输入框
    private lazy var dishDesTextView: UITextView = {
        let textView = UITextView();
        textView.font = Font(size: 28/2);
        textView.textAlignment = .left;
        textView.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return textView;
    }();
    
    // 取消按钮
    private lazy var cancellBtn: UIButton = {
        let button = UIButton(type: .system);
        button.setTitle("取消", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.titleLabel?.font = Font(size: 36/2);
        button.addTarget(self, action: #selector(cancellBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 确定按钮
    private lazy var submitBtn: UIButton = {
        let button = UIButton(type: .system);
        button.setTitle("确定", for: .normal);
        button.setTitleColor(RGBWithHexColor(hexColor: 0x1a1a1a), for: .normal);
        button.titleLabel?.font = Font(size: 36/2);
        button.addTarget(self, action: #selector(submitBtnClick(button:)), for: .touchUpInside);
        return button;
    }();
    
    // 菜品名分割线
    private lazy var dishNameTextFieldBottomLine: UIImageView = {
        let line = UIImageView();
        line.image = UIImage.imageWithName(name: "homeEdit_cut_line");
        return line;
    }();
    
    // 价格分割线
    private lazy var dishPriceTextFieldBottomLine: UIImageView = {
        let line = UIImageView();
        line.image = UIImage.imageWithName(name: "homeEdit_cut_line");
        return line;
    }();
    
    
    // 菜品Model
    lazy var model: JCDishModel = JCDishModel();
    // 菜品分类Model
    var middleModel: JCMiddleModel?;
    
    // 取消回调
    var cancelCallBack: (() -> ())?;
    
    // 确定回调
    var submitCallBack: ((_ model: JCDishModel) -> ())?;
    
    deinit {
        print("JCDishDetailController 被释放了");
        // 移除通知
        NotificationCenter.default.removeObserver(self);
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // 添加背景
        view.addSubview(background);
        
        // 添加whitebackground
        background.addSubview(whitebackground);
        
        // 添加标题
        whitebackground.addSubview(titleView);
        
        // 添加图片
        whitebackground.addSubview(dishImageBtn);
        
        // 添加提示图片
        whitebackground.addSubview(hintImage);
        
        // 添加dishNameLabel
        whitebackground.addSubview(dishNameLabel);
        
        // 添加dishNameTextField
        whitebackground.addSubview(dishNameTextField);
        
        // 添加提示菜名
        whitebackground.addSubview(hintDishName);
        
        // 添加菜品名分割线
        whitebackground.addSubview(dishNameTextFieldBottomLine);
        
        // 添加dishPriceLabel
        whitebackground.addSubview(dishPriceLabel);
        
        // 添加dishPriceTextField
        whitebackground.addSubview(dishPriceTextField);
        
        // 添加提示价格
        whitebackground.addSubview(hintPrice);
        
        // 添加价格分割线
        whitebackground.addSubview(dishPriceTextFieldBottomLine);
        
        // 推荐
        whitebackground.addSubview(recommendLabel);
        
        // 复选框
        whitebackground.addSubview(checkBoxBtn);
        
        // 添加标签label
        whitebackground.addSubview(markLabel);
        
        // 添加dishDesLabel
        whitebackground.addSubview(dishDesLabel);
        
        // 添加dishDesTextView
        whitebackground.addSubview(textViewBackground);
        textViewBackground.addSubview(dishDesTextView);
        
        // 添加cancellBtn
        whitebackground.addSubview(cancellBtn);
        
        // 添加submitBtn
        whitebackground.addSubview(submitBtn);
        
        
        // 添加通知，监听键盘的弹出
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil);
       
    }
    
    // 监听复选框按钮的点击
    func checkBoxBtnClick(button: UIButton) -> () {
        
        checkBoxBtn.isSelected = !button.isSelected;
    }
    
    
    // MARK: - 点击屏幕其他地方，回收键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true);
    }
    
    // MARK: - 键盘弹出
    @objc private func keyboardWillShow(notification: Notification) -> Void {
        
        guard let userInfo = notification.userInfo else {
            return;
        }
        
        // 键盘弹出需要的时间
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue;
        
        // 动画
        UIView.animate(withDuration: duration) {
            
            // 取出键盘高度
            let keyboardF = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue;
            let keyboardH = keyboardF.size.height;
            self.view.transform = CGAffineTransform(translationX: 0, y: -keyboardH/2);
        }
    }
    
    // MARK: - 键盘影藏
    @objc private func keyboardWillHide(notification: Notification) -> Void {
        
        guard let userInfo = notification.userInfo else {
            return;
        }
        
        // 键盘弹出需要的时间
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue;
        // 动画
        UIView.animate(withDuration: duration) {
            
            self.view.transform = CGAffineTransform.identity;
        }
    }
    
    
    // 显示菜品信息
    func showDishInfo(model: JCDishModel) -> Void {
        // 菜品图片
        if let Thumbnail = model.Thumbnail {
            dishImageBtn.zx_setImage(urlString: Thumbnail, for: .normal, placeholderImageName: "homeEdit_image");
        }
        
        // 菜品名称
        if let DishName = model.DishName {
            dishNameTextField.text = DishName;
        }
        
        // 菜品价格
        if let Price = model.Price {
            dishPriceTextField.text = String(format: "￥%.2f", Price);
        }
        
        // 菜品标签
        if let Recommanded = model.Recommanded {
            checkBoxBtn.isSelected = Recommanded;
        }
        
        // 菜品描述
        if let Detail = model.Detail {
            dishDesTextView.text = Detail;
        }
    }
    
    // 点击图片打开相册
    @objc private func dishImageBtnClick() -> Void {
        
        // 设置方向
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return;
        }
        // 设置为横屏
        appDelegate.oriation = .all;
        // 创建照片选择器
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self;
        imagePicker.sourceType = .photoLibrary;
        imagePicker.allowsEditing = true;
        present(imagePicker, animated: true, completion: nil);
    }
    
    
    // 取消
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return;
        }
        appDelegate.oriation = .landscape;
        picker.dismiss(animated: false, completion: nil);
    }
    
    // 选中照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return;
        }
        appDelegate.oriation = .landscape;
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return;
        }
        
        // 缩略图
        // 压缩图片
        let smallImage = compressImage(sourceImage: image, targetSize: CGSize(width: realValue(value: 476/2), height: realValue(value: 476/2)));
        dishImageBtn.setImage(smallImage, for: .normal);
        
        // 保存压缩后的图片
        let imageData = UIImageJPEGRepresentation(smallImage, 0.4);
        model.imageData = imageData;
        
        // 大图
        let largeImage = compressImage(sourceImage: image, targetSize: CGSize(width: realValue(value: 1390/2), height: realValue(value: 1043/2)));
        // 压缩
        let largeImageData = UIImageJPEGRepresentation(largeImage, 0.4);
        model.largeImageData = largeImageData;
        
        dismiss(animated: true, completion: nil);
    }
    
    
    // MARK: - 监听取消点击
    @objc private func cancellBtnClick(button: UIButton) -> Void {
        
        if let cancelCallBack = cancelCallBack {
            cancelCallBack();
        }
    }
   
    
    // 监听确定点击
    @objc private func submitBtnClick(button: UIButton) -> Void {
        
        // 图片不能为空
        let image = dishImageBtn.image(for: .normal);
        if image == UIImage.imageWithName(name: "homeEdit_image") {
            hintImage.isHidden = false;
            delayCallBack(1, callBack: {
                
                self.hintImage.isHidden = true;
            })
            return;
        }
        
        // 缩略图不能为空
        if let Thumbnail = model.Thumbnail {
            let url = URL(string: Thumbnail)!;
            model.imageData = try! Data.init(contentsOf: url);
        }
        
        
        // 大图不能为空
        if let PictureUrlLarge = model.PictureUrlLarge {
            let url = URL(string: PictureUrlLarge)!;
            model.largeImageData = try! Data.init(contentsOf: url);
        }
        
        // 菜品名称
        if let DishName = dishNameTextField.text, DishName.characters.count != 0 {
            print("-----------\(DishName)");
            model.DishName = DishName;
        } else {
            hintDishName.isHidden = false;
            delayCallBack(1, callBack: {
                
                self.hintDishName.isHidden = true;
            })
            return;
        }
        
        // 菜品价格
        if let priceText = dishPriceTextField.text, priceText.characters.count != 0 {
            model.Price = (priceText as NSString).doubleValue;
            print("---------价格\(model.Price)");
            
            if model.Price! == 0 {
                
                hintPrice.isHidden = false;
                delayCallBack(1, callBack: {
                    
                    self.hintPrice.isHidden = true;
                })
                return;
            }
        } else {
            
            hintPrice.isHidden = false;
            delayCallBack(1, callBack: { 
                
                self.hintPrice.isHidden = true;
            })
            return;
        }
        
        // 菜品标签
        model.Recommanded = checkBoxBtn.isSelected;
        
        // 菜品描述
        if let Detail = dishDesTextView.text {
            model.Detail = Detail;
        }
        
        // 目录
        if let directory = middleModel?.MenuName {
            model.directory = directory;
        }
        
        if let submitCallBack = submitCallBack {
            
            submitCallBack(model);
        }
    }
 
    
    // 设置子控件的frame
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        
        let width = view.bounds.size.width;
        let height = view.bounds.size.height;
        
        // 设置背景的frame
        background.frame = view.bounds;
        
        // 设置白色背景的frame
        let whitebackgroundCenterX = width/2;
        let whitebackgroundCenterY = height/2;
        let whitebackgroundW = realValue(value: 800/2);
        let whitebackgroundH = realValue(value: 1022/2);
        whitebackground.center = CGPoint(x: whitebackgroundCenterX, y: whitebackgroundCenterY);
        whitebackground.bounds = CGRect(x: 0, y: 0, width: whitebackgroundW, height: whitebackgroundH);
        
        // titleView
        let titleViewX = realValue(value: 0);
        let titleViewY = realValue(value: 40/2);
        let titleViewW = whitebackgroundW;
        let titleViewH = realValue(value: 48/2);
        titleView.frame = CGRect(x: titleViewX, y: titleViewY, width: titleViewW, height: titleViewH);
        
        //  设置dishImage 的frame
        let dishImageBtnW = realValue(value: 296/2);
        let dishImageBtnH = realValue(value: 296/2);
        let dishImageBtnX = (whitebackgroundW - dishImageBtnW)/2;
        let dishImageBtnY = titleView.frame.maxY + realValue(value: 60/2);
        dishImageBtn.frame = CGRect(x: dishImageBtnX, y: dishImageBtnY, width: dishImageBtnW, height: dishImageBtnH);
        
        // 设置提示上传图片的frame
        let hintImageW = realValue(value: 164/2);
        let hintImageH = realValue(value: 30/2);
        let hintImageX = (whitebackgroundW - hintImageW)/2;
        let hintImageY = dishImageBtn.frame.maxY + realValue(value: 15/2);
        hintImage.frame = CGRect(x: hintImageX, y: hintImageY, width: hintImageW, height: hintImageH);
        
        // 设置菜品名称的frame
        let dishNameLabelX = realValue(value: 60/2);
        let dishNameLabelY = hintImage.frame.maxY + realValue(value: 15/2);
        let dishNameLabelW = calculateWidth(title: dishNameLabel.text ?? "", fontSize: 32/2);
        let dishNameLabelH = realValue(value: 32/2);
        dishNameLabel.frame = CGRect(x: dishNameLabelX, y: dishNameLabelY, width: dishNameLabelW, height: dishNameLabelH);
        
        // 设置菜品名称的输入框的frame
        let dishNameTextFieldX = dishNameLabel.frame.maxX + realValue(value: 20/2);
        let dishNameTextFieldY = dishNameLabel.frame.minY - realValue(value: 10/2);
        let dishNameTextFieldW = realValue(value: 354/2);
        let dishNameTextFieldH = dishNameLabelH + realValue(value: 10/2);
        dishNameTextField.frame = CGRect(x: dishNameTextFieldX, y: dishNameTextFieldY, width: dishNameTextFieldW, height: dishNameTextFieldH);
        
        // 菜品名分割线
        let dishNameTextFieldBottomLineX = dishNameTextFieldX;
        let dishNameTextFieldBottomLineY = dishNameTextField.frame.maxY + realValue(value: 1/2);
        let dishNameTextFieldBottomLineW = dishNameTextFieldW;
        let dishNameTextFieldBottomLineH = realValue(value: 1/2);
        dishNameTextFieldBottomLine.frame = CGRect(x: dishNameTextFieldBottomLineX, y: dishNameTextFieldBottomLineY, width: dishNameTextFieldBottomLineW, height: dishNameTextFieldBottomLineH);
        
        
        // 设置提示输入菜名的frame
        let hintDishNameW = hintImageW;
        let hintDishNameH = hintImageH;
        let hintDishNameX = hintImageX;
        let hintDishNameY = dishNameTextFieldBottomLine.frame.maxY + realValue(value: 15/2);
        hintDishName.frame = CGRect(x: hintDishNameX, y: hintDishNameY, width: hintDishNameW, height: hintDishNameH);
        
        
        // 设置价格的frame
        let dishPriceLabelX = dishNameLabelX;
        let dishPriceLabelY = dishNameLabel.frame.maxY + realValue(value: 60/2);
        let dishPriceLabelW = dishNameLabelW;
        let dishPriceLabelH = dishNameLabelH;
        dishPriceLabel.frame = CGRect(x: dishPriceLabelX, y: dishPriceLabelY, width: dishPriceLabelW, height: dishPriceLabelH);
        
        // 设置价格输入框的frame
        let dishPriceTextFieldX = dishNameTextFieldX;
        let dishPriceTextFieldY = dishPriceLabel.frame.minY - realValue(value: 10/2);
        let dishPriceTextFieldW = dishNameTextFieldW;
        let dishPriceTextFieldH = dishNameTextFieldH;
        dishPriceTextField.frame =  CGRect(x: dishPriceTextFieldX, y: dishPriceTextFieldY, width: dishPriceTextFieldW, height: dishPriceTextFieldH);
        
        // 设置价格输入框的frame
        let dishPriceTextFieldBottomLineX = dishPriceTextFieldX;
        let dishPriceTextFieldBottomLineY = dishPriceTextField.frame.maxY + realValue(value: 1/2);
        let dishPriceTextFieldBottomLineW = dishPriceTextFieldW;
        let dishPriceTextFieldBottomLineH = realValue(value: 1/2);
        dishPriceTextFieldBottomLine.frame = CGRect(x: dishPriceTextFieldBottomLineX, y: dishPriceTextFieldBottomLineY, width: dishPriceTextFieldBottomLineW, height: dishPriceTextFieldBottomLineH);
        
        // 设置提示价格的frame
        let hintPriceW = hintImageW;
        let hintPriceH = hintImageH;
        let hintPriceX = hintImageX;
        let hintPriceY = dishPriceTextFieldBottomLine.frame.maxY + realValue(value: 15/2);
        hintPrice.frame = CGRect(x: hintPriceX, y: hintPriceY, width: hintPriceW, height: hintPriceH);
        
        // 设置标签的frame
        let recommendLabelX = dishPriceLabelX;
        let recommendLabelY = dishPriceLabel.frame.maxY + realValue(value: 60/2);
        let recommendLabelW = dishPriceLabelW;
        let recommendLabelH = dishPriceLabelH;
        recommendLabel.frame = CGRect(x: recommendLabelX, y: recommendLabelY, width: recommendLabelW, height: recommendLabelH);
        
        // 设置复选框的frame
        let checkBoxBtnX = dishPriceTextFieldX;
        let checkBoxBtnY = dishPriceTextField.frame.maxY + realValue(value: 54/2);
        let checkBoxBtnW = realValue(value: 52/2);
        let checkBoxBtnH = realValue(value: 42/2);
        checkBoxBtn.frame = CGRect(x: checkBoxBtnX, y: checkBoxBtnY, width: checkBoxBtnW, height: checkBoxBtnH);
        
        
        // 设置markLabel 的frame
        let markLabelX = checkBoxBtn.frame.maxX + realValue(value: 15/2);
        let markLabelY = checkBoxBtnY + realValue(value: 7/2);
        let markLabelW = dishPriceTextFieldW - checkBoxBtnW - realValue(value: 15/2);
        let markLabelH = realValue(value: 28/2);
        markLabel.frame = CGRect(x: markLabelX, y: markLabelY, width: markLabelW, height: markLabelH);
        
        
        // 设置dishDesLabel 的frame
        let dishDesLabelX = dishNameLabelX;
        let dishDesLabelY = recommendLabel.frame.maxY + realValue(value: 60/2);
        let dishDesLabelW = dishNameLabelW;
        let dishDesLabelH = dishNameLabelH;
        dishDesLabel.frame = CGRect(x: dishDesLabelX, y: dishDesLabelY, width: dishDesLabelW, height: dishDesLabelH);
        
        // 设置dishDesTextField 的frame
        let textViewBackgroundX = dishNameTextFieldX;
        let textViewBackgroundY = dishDesLabel.frame.minY;
        let textViewBackgroundW = dishNameTextFieldW;
        let textViewBackgroundH = realValue(value: 100/2);
        textViewBackground.frame = CGRect(x: textViewBackgroundX, y: textViewBackgroundY, width: textViewBackgroundW, height: textViewBackgroundH);
        let dishDesTextViewX = realValue(value: 2);
        let dishDesTextViewY = realValue(value: 2);
        let dishDesTextViewW = textViewBackgroundW - realValue(value: 4);
        let dishDesTextViewH = textViewBackgroundH - realValue(value: 4);
        dishDesTextView.frame = CGRect(x: dishDesTextViewX, y: dishDesTextViewY, width: dishDesTextViewW, height: dishDesTextViewH);
        
        
        // 设置cancellBtn 的frame
        let cancellBtnX = realValue(value: 288/2);
        let cancellBtnY = textViewBackground.frame.maxY + realValue(value: 60/2);
        let cancellBtnW = calculateWidth(title: "取消", fontSize: 36/2);
        let cancellBtnH = realValue(value: 36/2);
        cancellBtn.frame = CGRect(x: cancellBtnX, y: cancellBtnY, width: cancellBtnW, height: cancellBtnH);
        
        // 设置确定按钮的frame
        let submitBtnX = cancellBtn.frame.maxX + realValue(value: 170/2);
        let submitBtnY = cancellBtnY;
        let submitBtnW = calculateWidth(title: "确定", fontSize: 36/2);
        let submitBtnH = cancellBtnH;
        submitBtn.frame = CGRect(x: submitBtnX, y: submitBtnY, width: submitBtnW, height: submitBtnH);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UIImagePickerController {
    
    open override var shouldAutorotate: Bool {
        return true;
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all;
    }
}
