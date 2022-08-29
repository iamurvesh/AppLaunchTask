//
//  LaunchesTCell.swift
//  UrveshMishraTask
//
//  Created by Urvesh Mishra on 26/08/22.
//

import UIKit
import SDWebImage

class LaunchesTCell: UITableViewCell {

    @IBOutlet var imgMission: UIImageView!
    @IBOutlet var lblMissionName: UILabel!
    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var lblRocket: UILabel!
    @IBOutlet var lblDays: UILabel!
    @IBOutlet var imgSuccessStatus: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dataBind(obj: launches) {
        if let url = URL(string: obj.links.patch.small) {
            self.imgMission.sd_setImage(with: url)
        }
        else {
            self.imgMission.image = nil
        }
        self.lblMissionName.text = "Mission: \(obj.name)"
        self.lblDateTime.text = "Date/Time: \(obj.dateUtc.getUTCToLocalDateFromString(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", conevertString: "MMM d yyyy, 'at' h:mm a"))"
        self.lblRocket.text = "Rocket: \(obj.rocket)"
        self.lblDays.text = "Days: \(Calendar.current.dateComponents([.day], from: obj.dateUtc.getDateFromString(format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").removeTimeStampFromDate(), to: Date()).day ?? 0)"
        if obj.success {
            self.imgSuccessStatus.image = UIImage(named: "ic_Success")
        }else {
            self.imgSuccessStatus.image = UIImage(named: "ic_Unsuccess")
        }
    }
}
