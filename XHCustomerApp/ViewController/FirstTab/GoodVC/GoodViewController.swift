//
//  GoodViewController.swift
//  XHCustomerApp
//
//  Created by jidanyu on 2017/1/18.
//  Copyright © 2017年 mybook. All rights reserved.
//

import UIKit

class GoodViewController: UIViewController {
    
    var tableView:UITableView!
    
    var good = Good() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var imageCellId = "GoodImageCell"
    
    var projectsCellId = "GoodDetailCell"
    
    var notesCellId = "GoodNoteCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "项目详情"
        view.backgroundColor = UIColor.ddViewBackGroundColor()
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        
        let cellIds = [imageCellId,
                       projectsCellId,
                       notesCellId]
        
        for id in cellIds {
            
            let nib = UINib(nibName: id, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: id)
        }
        
        makeData()
        
    }
    
    func makeData() {
        
        var noteTitles = ["有效期","不可用日期","温馨提示","预约信息","适用人群"]
        
        let notesDesc = ["2016-12-28至2017-03-31",
                         "2016年12月30日至2017年1月2日、2017年3月2日，元旦,春节不可用",
                         "1.本团购只适用于初次到店非商户会员凭身份证使用（同一团购项目只可体验一次，包含所有其他渠道)\r2.如需团购券发票，请您在消费时向商户咨询\r3.为了保障您的权益，建议使用美团、点评网线上支付。若使用其他支付方式导致纠纷，美团、点评网不承担任何责任，感谢您的理解和支持！",
                         "请您提前1天预约，请您提前12小时改约",
                         "女宾专享\r只适用于初次到店非商户会员使用"]
        
        var notes = [GoodNote]()

        for i in 0..<noteTitles.count {
            
            let n = GoodNote(title: noteTitles[i], content: notesDesc[i])
            notes.append(n)
            
        }
        
        var projects = [Project]()
        
        for _ in 0..<3 {
            
            let p = Project(id: "4343", title: "皮脂膜修护（90分钟)", price: 335, amount: 2, spec: "次")
            projects.append(p)
        }
        
        let p = Project(id: "", title: "", price: 335*3, amount: 0, spec: "总价值")
        projects.append(p)
        
        let p2 = Project(id: "", title: "", price: 580, amount: 0, spec: "优惠价")
        projects.append(p2)
        
        let profile = "德国NEOVITA（妮薇塔）科技有机护肤，健康美肌的选择\r源自德国的科技有机护肤品牌NEOVITA自1968年创立以来，始终坚守，＂健康源自有机，美丽自然天成＂的美肤哲学，通过天然有机草本臻萃和现代美容科技的完美融合，持续为全球女性提供高科技的有机护理产品。NEOVITA创新草本慕斯，创领SPA护肤新感受，为您开启奢宠美丽的愉悦护理。天然有机臻萃，24小时沁养，健康美肌日趋所见。今天的NEOVlTA化妆品，已经成为创新SPA&护肤的代名词。\r全系产品均为天然有机草本原料\r先进的的全株植物活性成分萃取技术\r独有的原材料种植基地\r强大的科研背景（与德国著名的海德堡大学紧密合作)\r严谨科学的无添加配方体系(无添加防腐剂、填充剂、着色剂、矿物油、硅油等)\r独特的“超渗透，倍舒适”慕斯载体系统\r六大技术GMP国际生产标准\r严守三项技术指标：天然性，科学性，成效性\r督脉经络调理\r精选意大利有机绿茶＋维生素E按摩油＋蛇麻草，有机植物萃取物，含有有机化合物450多种，无机矿物质15中以上，可以帮助细胞修护再生，形成保护屏障，提高机体免疫功能。结合意大利3D变频技术～数控负气压、远红wai线、3D射频热能，集刮痧、拔罐、淋巴疏通、脂肪管理为一体"
        
        let good = Good(id: "0004", title: "套餐111",desc:profile,summary: "仅售298元，价值915元德国NEOVITA（妮薇塔）皮脂膜修护+督脉经络调理", type: ["",""], retailPrice: 335*3, imageUrls: ["http://p1.meituan.net/dpdeal/7f08778ce45057d7cb2d8248f5e08a111227966.png@460w_280h_1e_1c","http://p0.meituan.net/dpdeal/93fbe3735109b752b1808bc8d73726e6144454.jpg@460w_280h_1e_1c"], notes: notes, projects: projects)
        
        self.good = good
        
    }
    
}

extension GoodViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: imageCellId, for: indexPath) as! GoodImageCell
            
            cell.imageUrls = good.imageUrls
            
            cell.descLabel.text = good.summary
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 1 {
            return UITableViewCell()
        }
        else if indexPath.section == 2 {
            if indexPath.row + 1 <= good.projects.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: projectsCellId, for: indexPath) as! GoodDetailCell
                let p = good.projects[indexPath.row]
                cell.nameLabel.text = p.title
                cell.countLabel.text = String(p.amount) + p.spec
                cell.priceLaebl.text = String(p.price) + "元"
                
                if p.amount == 0 {
                    cell.countLabel.text = p.spec
                }
                cell.selectionStyle = .none
                return cell
            }
            else {
                
                let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
                cell.selectionStyle = .none
                cell.textLabel?.text = "查看图文详情"
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.textColor = UIColor.init(hexString: "21D3AB")
                
                return cell
            }
            
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: notesCellId, for: indexPath) as! GoodNoteCell
            
            let n = good.notes[indexPath.row]
            cell.titleLabel.text = n.title
            cell.descLabel.text = n.content
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
            view.backgroundColor = UIColor.white
            let priceNowLabel = UILabel()
            view.addSubview(priceNowLabel)
            priceNowLabel.text = "¥ 580"
            priceNowLabel.font = UIFont.systemFont(ofSize: 20)
            priceNowLabel.textColor = UIColor.init(hexString: "21D3AB")
            priceNowLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(view.snp.top).offset(8)
                make.left.equalTo(view.snp.left).offset(8)
                make.width.equalTo(150)
            })
            
            let priceOldLabel = UILabel()
            view.addSubview(priceOldLabel)
            priceOldLabel.text = "门市价 ¥\(String(good.retailPrice))"
            priceOldLabel.font = UIFont.systemFont(ofSize: 14)
            priceOldLabel.textColor = UIColor.init(hexString: "9E9E9E")
            priceOldLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(priceNowLabel.snp.bottom).offset(8)
                make.left.equalTo(view.snp.left).offset(8)
                make.width.equalTo(150)
                
            })
            
            
            let button = UIButton()
            view.addSubview(button)
            button.setTitle("立即预约", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor.init(hexString: "FF8214")
            button.snp.makeConstraints({ (make) in
                make.centerY.equalTo(view.snp.centerY)
                make.right.equalTo(view.snp.right).offset(-8)
                make.width.equalTo(100)
            })
            
            
            return view
        }
        else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "套餐"
        }
        else if section == 3 {
            return "购买须知"
        }
        else {
            return nil
        }
    }
    
}


extension GoodViewController:UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 150
        }
        else if indexPath.section == 2 {
            return 25
        }
        else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        }
        else if section == 1 {
            return 60
        }
        else {
            return 8
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return 0
        }
        else if section == 2 {
            return good.projects.count + 1
        }
        else {
            return good.notes.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            
            if indexPath.row == good.projects.count {
                //图文详情.
                let vc = GoodDetailViewController()
                vc.good = good
                navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
}

