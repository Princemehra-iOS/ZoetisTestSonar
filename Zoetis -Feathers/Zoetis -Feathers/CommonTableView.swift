//
//  CommonTableView.swift
//  CommonTableView
//
//  Created by "" on 02/09/16.
//  Copyright © 2016 "". All rights reserved.
//

import UIKit
protocol CommonTableViewDelegate {

    func leftController(_ leftController: CommonTableView, didSelectTableView tableView: UITableView, idenitifier: String, indexValue: String)

    func SwitchButton(_ butonTag: Int)

}

class CommonTableView: NSObject, UITableViewDataSource, UITableViewDelegate {

    var items: [AnyObject] = []
    var cellIdentifier: String = ""
    var tblTag: Int

    //var delegate:AnyObject
    var delegate: CommonTableViewDelegate?

    init(items: [AnyObject]!, cellIdentifier: String!, tableViewTag: Int) {
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.tblTag = tableViewTag

        super.init()
    }

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if (cellIdentifier == "Cell") {

            return items.count
        } else {
            return items.count
        }

    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell

        let cell: StartNecropsyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! StartNecropsyTableViewCell

        //    if indexPath.section == 0 && indexPath.row == 0 {
        //
        //       cell.bgView.backgroundColor = UIColor(red: 0.0039, green: 0.7569, blue: 0.8392, alpha: 1.0)
        //
        //
        //    }
        // cell.bgView.backgroundColor = UIColor.lightGrayColor()

        //    if(cell.selected){
        //        cell.backgroundColor = UIColor.redColor()
        //    }else{
        //        cell.backgroundColor = UIColor.clearColor()
        //    }

        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.dataLabel.text = items[indexPath.row] as? String

        // cell.datala!.text = items[indexPath.row] as? String

        return cell
    }

    func switchValueDidChange(_ sender: UISwitch!) {

        let  value: Int = sender.tag

        self.delegate?.SwitchButton(value)

    }

    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = items[indexPath.row] as! String

        let cell: StartNecropsyTableViewCell = tableView.cellForRow(at: indexPath) as! StartNecropsyTableViewCell

        cell.bgView.backgroundColor = UIColor.lightGray
        cell.bgView.backgroundColor = UIColor(red: 0.0039, green: 0.7569, blue: 0.8392, alpha: 1.0)

        //cell.backgroundColor =

        self.delegate?.leftController(self, didSelectTableView: tableView, idenitifier: cellIdentifier, indexValue: str)
        //print( str)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell: StartNecropsyTableViewCell = tableView.cellForRow(at: indexPath) as! StartNecropsyTableViewCell
        cell.bgView.backgroundColor = UIColor.lightGray
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 60
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()

        return view
    }

}
