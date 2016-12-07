//
//  JCOrderDetailCell.swift
//  JingChengDiningHall
//
//  Created by zhangxu on 2016/10/17.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class JCOrderDetailCell: UITableViewCell {
    
    // 菜名
    private lazy var dishNameLabel: UILabel = {
        let label = UILabel();
        label.text = "黑椒牛排";
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        label.textAlignment = .left;
        label.adjustsFontSizeToFitWidth = true;
        label.font = Font(size: 32/2);
        return label;
    }();
    
    // 份数
    private lazy var dishNumberLabel: UILabel = {
        let label = UILabel();
        label.text = "10";
        label.textAlignment = .center;
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return label;
    }();
    
    // 价格
    private lazy var dishPriceLabel: UILabel = {
        let label = UILabel();
        label.text = "￥98.00";
        label.textAlignment = .right;
        label.font = Font(size: 32/2);
        label.textColor = RGBWithHexColor(hexColor: 0x1a1a1a);
        return label;
    }();
    
    // 复选框
    lazy var checkBox: UIButton = {
        let button = UIButton(type: .custom);
        button.setImage(UIImage.imageWithName(name: "orderDetail_checkBox_normal"), for: .normal);
        button.setImage(UIImage.imageWithName(name: "orderDetail_checkBox_selected"), for: .selected);
        return button;
    }();
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        // 取消选中状态
        selectionStyle = .none;
        
        // 添加dishNameLabel
        addSubview(dishNameLabel);
        
        // 添加dishNumberLabel
        addSubview(dishNumberLabel);
        
        // 添加dishPriceLabel
        addSubview(dishPriceLabel);
        
        // 添加checkBox
        addSubview(checkBox);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        
        let height = bounds.size.height;
        
        // 设置dishNameLabel 的frame
        let dishNameLabelX = realValue(value: 30/2);
        let dishNameLabelY = realValue(value: 25/2);
        let dishNameLabelW = realValue(value: 200/2);
        let dishNameLabelH = realValue(value: 32/2);
        dishNameLabel.frame = CGRect(x: dishNameLabelX, y: dishNameLabelY, width: dishNameLabelW, height: dishNameLabelH);
        
        // 设置dishNumberLabel
        let dishNumberLabelX = dishNameLabel.frame.maxX + realValue(value: 9/2);
        let dishNumberLabelY = dishNameLabelY;
        let dishNumberLabelW = realValue(value: 30);
        let dishNumberLabelH = dishNameLabelH;
        dishNumberLabel.frame = CGRect(x: dishNumberLabelX, y: dishNumberLabelY, width: dishNumberLabelW, height: dishNumberLabelH);
        
        // 设置dishPriceLabel  的frame
        let dishPriceLabelX = dishNumberLabel.frame.maxX + realValue(value: 32/2);
        let dishPriceLabelY = dishNameLabelY;
        let dishPriceLabelW = calculateWidth(title: dishPriceLabel.text!, fontSize: 32/2);
        let dishPriceLabelH = dishNameLabelH;
        dishPriceLabel.frame = CGRect(x: dishPriceLabelX, y: dishPriceLabelY, width: dishPriceLabelW, height: dishPriceLabelH);
        
        // 设置checkBox 的frame
        let checkBoxX = dishPriceLabel.frame.maxX + realValue(value: 38/2);
        let checkBoxY = (height - realValue(value: 36/2))/2;
        let checkBoxW = realValue(value: 40/2);
        let checkBoxH = realValue(value: 36/2);
        checkBox.frame = CGRect(x: checkBoxX, y: checkBoxY, width: checkBoxW, height: checkBoxH);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
