//
//  NecropcyReportCalculations.swift
//  Zoetis -Feathers
//
//  Created by Pradeep Dahiya on 19/06/18.
//  Copyright © 2018 Alok Yadav. All rights reserved.
//

import Foundation
import UIKit

@objc protocol NecropcyReportCalculationsDelegates {
    func didFinishWithParsing(finishedArray: NSArray)
    @objc optional func didFinishParsingWithAllSummaryData(_ finishedArray: NSArray)
}

class NecropcyReportCalculations: NSObject {

    var delegate: NecropcyReportCalculationsDelegates?

    let NOT_EXIST: Float = -1

    func setupData(_ aArray: NSArray, birdsCount: Float, catName: NSString) {
        if catName == "Microscopy" {
            self.forMicroscopySummuary(aArray, birdsCount: birdsCount)
        } else {
            self.allSummaryPDF(aArray, birdsCount: birdsCount)}
    }

    func forMicroscopySummuary(_ aArray: NSArray, birdsCount: Float) {

        let preparedArray = NSMutableArray()
        let preparedArrayForMean = NSMutableArray()

        var coccidia: Float = 0
        var bacteriaMotile: Float = 0
        var bacteriaNonMotile: Float = 0
        var pepto: Float = 0

        var coccidia_Mean: Float = 0
        var bacteriaMotile_Mean: Float = 0
        var bacteriaNonMotile_Mean: Float = 0
        var pepto_Mean: Float = 0

        var isUpdatedCoccidia: Float = 0
        var isUpdatedBacteriaMotile: Float = 0
        var isUpdatedbacteriaNonMotile: Float = 0
        var isUpdatedPepto: Float = 0

        var observationSet: Float = 0

        for  j in 0..<aArray.count {
            if ((aArray.object(at: j) as AnyObject).value(forKey: "catName")) as! NSString == "Coccidiosis" && ((aArray.object(at: j) as AnyObject).value(forKey: "lngId")) as! Int == Regions.languageID {

                if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 607 {
                    let value = (aArray.object(at: j) as AnyObject).value(forKey: "obsPoint") as! NSNumber
                    observationSet += 1
                    coccidia_Mean=coccidia_Mean+value.floatValue
                    coccidia=coccidia+(value.floatValue > 0 ? 1 : 0)
                    if value.floatValue > 0 {
                        isUpdatedCoccidia += 1
                    }
                }
                if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 612 {
                    let value = (aArray.object(at: j) as AnyObject).value(forKey: "obsPoint") as! NSNumber
                    observationSet += 1
                    bacteriaMotile_Mean=bacteriaMotile_Mean+value.floatValue
                    bacteriaMotile=bacteriaMotile+(value.floatValue > 0 ? 1 : 0)
                    if value.floatValue > 0 {
                        isUpdatedBacteriaMotile += 1
                    }
                }
                if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 613 {
                    let value = (aArray.object(at: j) as AnyObject).value(forKey: "obsPoint") as! NSNumber
                    observationSet += 1
                    bacteriaNonMotile_Mean=bacteriaNonMotile_Mean+value.floatValue
                    bacteriaNonMotile=bacteriaNonMotile+(value.floatValue > 0 ? 1 : 0)
                    if value.floatValue > 0 {
                        isUpdatedbacteriaNonMotile += 1
                    }
                }
                if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 611 {
                    let value = (aArray.object(at: j) as AnyObject).value(forKey: "obsPoint") as! NSNumber
                    observationSet += 1
                    pepto_Mean=pepto_Mean+value.floatValue
                    pepto=pepto+(value.floatValue > 0 ? 1 : 0)
                    if value.floatValue > 0 {
                        isUpdatedPepto += 1
                    }
                }
            }
        }

        coccidia = (coccidia/birdsCount)*100
        preparedArray.add(coccidia)

        bacteriaMotile = (bacteriaMotile/birdsCount)*100
        preparedArray.add(bacteriaMotile)

        bacteriaNonMotile = (bacteriaNonMotile/birdsCount)*100
        preparedArray.add(bacteriaNonMotile)

        pepto = (pepto/birdsCount)*100
        preparedArray.add(pepto)

        preparedArrayForMean.add((coccidia_Mean/isUpdatedCoccidia).isNaN ? 0 : coccidia_Mean/isUpdatedCoccidia)
        preparedArrayForMean.add((bacteriaMotile_Mean/isUpdatedBacteriaMotile).isNaN ? 0 : bacteriaMotile_Mean/isUpdatedBacteriaMotile)
        preparedArrayForMean.add((bacteriaNonMotile_Mean/isUpdatedbacteriaNonMotile).isNaN ? 0 : bacteriaNonMotile_Mean/isUpdatedbacteriaNonMotile)
        preparedArrayForMean.add((pepto_Mean/isUpdatedPepto).isNaN ? 0 : pepto_Mean/isUpdatedPepto)

        AllValidSessions.sharedInstance.meanValues.add(preparedArrayForMean)

        UserDefaults.standard.set(AllValidSessions.sharedInstance.meanValues, forKey: "meanArray")

        delegate?.didFinishWithParsing(finishedArray: preparedArray)
    }

    func allSummaryPDF(_ aArray: NSArray, birdsCount: Float) {

        let preparedArray = NSMutableArray()
        let preparedArrayForMean = NSMutableArray()

         var feed_Passage: Float = 0

        var Foot_Pad_Lesions: Float = 0
        var Ammonia_Burns: Float = 0
        var tracheitis: Float = 0
        var Femoral_Head_Necrosis: Float = 0
        var wallThikness: Float = 0
        var gizzard_Erosions: Float = 0
        var enterties: Float = 0
        var litter_Eater: Float = 0
        var mouth_Lesions: Float = 0
        var proventriculitis: Float = 0
        var roundworms: Float = 0
        var tapeworms: Float = 0
        var Tibial_Dyschondroplasia: Float = 0
        var Rickets: Float = 0
        var Bone_Strength: Float = 0
        var Bursa_Size: Float = 0.0
        var IP: Float = 0.0
        var Synovitis: Float = 0
        var retained_Yolk: Float = 0
        var air_Sac: Float = 0
        var Intestinal_Content: Float = 0
        var Thin_Intestine: Float = 0
        var Muscular_Hemorrhages: Float = 0
        var Bursa_Lesion_Score: Float = 0

        var air_Sac_Mean: Float = 0
        var Foot_Pad_Lesions_Mean: Float = 0
        var Tracheitis_Mean: Float = 0
        var Tibial_Dyschondroplasia_Mean: Float = 0
        var gizzard_Erosions_Mean: Float = 0
        var proventriculitis_Mean: Float = 0
        var enterties_Mean: Float = 0
        var Bone_Strength_Mean: Float = 0
        var Bursa_Lesion_Score_Mean: Float = 0

        var air_Sac_Updated: Float = 0
        var Foot_Pad_Lesions_Updated: Float = 0
        var Tracheitis_Updated: Float = 0
        var Tibial_Dyschondroplasia_Updated: Float = 0
        var gizzard_Erosions_Updated: Float = 0
        var proventriculitis_Updated: Float = 0
        var enterties_Updated: Float = 0
        var Bone_Strength_Updated: Float = 0
        var Bursa_Lesion_Score_Updated: Float = 0

        for  j in 0..<aArray.count {
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 596 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "obsPoint") as! NSNumber
                Foot_Pad_Lesions=Foot_Pad_Lesions+(value.floatValue > 0 ? 1 : 0)
                Foot_Pad_Lesions_Mean = Foot_Pad_Lesions_Mean + value.floatValue
                if value.floatValue > 0 {
                    Foot_Pad_Lesions_Updated += 1
                }
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 635 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "objsVisibilty") as! NSNumber
                Ammonia_Burns=Ammonia_Burns+(value.floatValue > 0 ? 1 : 0)
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 617 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "objsVisibilty") as! NSNumber
                mouth_Lesions=mouth_Lesions+(value.floatValue > 0 ? 1 : 0)
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 636 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "obsPoint") as! NSNumber
                tracheitis=tracheitis+(value.floatValue > 0 ? 1 : 0)
                Tracheitis_Mean = Tracheitis_Mean + value.floatValue
                if value.floatValue > 0 {
                    Tracheitis_Updated += 1
                }
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 597 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "objsVisibilty") as! NSNumber
                Femoral_Head_Necrosis=Femoral_Head_Necrosis+(value.floatValue > 0 ? 1 : 0)
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 599 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "obsPoint") as! NSNumber
                Tibial_Dyschondroplasia=Tibial_Dyschondroplasia+(value.floatValue > 0 ? 1 : 0)
                Tibial_Dyschondroplasia_Mean = Tibial_Dyschondroplasia_Mean + value.floatValue
                if value.floatValue > 0 {
                    Tibial_Dyschondroplasia_Updated += 1
                }
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 600 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "objsVisibilty") as! NSNumber
                Rickets=Rickets+(value.floatValue > 0 ? 1 : 0)
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 601 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "obsPoint") as! NSNumber
                Bone_Strength=Bone_Strength+(value.floatValue > 0 ? 1 : 0)
                Bone_Strength_Mean = Bone_Strength_Mean + value.floatValue
                if value.floatValue > 0 {
                    Bone_Strength_Updated += 1
                }
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 602 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "objsVisibilty") as! NSNumber
                Synovitis=Synovitis+(value.floatValue > 0 ? 1 : 0)
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 641 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "objsVisibilty") as! NSNumber
                Bursa_Size=Bursa_Size+(value.floatValue > 0 ? 1 : 0)
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 603 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "objsVisibilty") as! NSNumber
                IP=IP+value.floatValue
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 637 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "obsPoint") as! NSNumber
                air_Sac=air_Sac+(value.floatValue > 0 ? 1 : 0)
                air_Sac_Mean = air_Sac_Mean + value.floatValue
                if value.floatValue > 0 {
                    air_Sac_Updated += 1
                }
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 643 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "objsVisibilty") as! NSNumber
                retained_Yolk=retained_Yolk+(value.floatValue > 0 ? 1 : 0)
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 675 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "objsVisibilty") as! NSNumber
                wallThikness=wallThikness+(value.floatValue > 0 ? 1 : 0)
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 619 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "obsPoint") as! NSNumber
                gizzard_Erosions=gizzard_Erosions+(value.floatValue > 0 ? 1 : 0)
                gizzard_Erosions_Mean = gizzard_Erosions_Mean + value.floatValue
                if value.floatValue > 0 {
                    gizzard_Erosions_Updated += 1
                }
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 622 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "obsPoint") as! NSNumber
                enterties=enterties+(value.floatValue > 0 ? 1 : 0)
                enterties_Mean = enterties_Mean + value.floatValue
                if value.floatValue > 0 {
                    enterties_Updated += 1
                }
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 621 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "objsVisibilty") as! NSNumber
                litter_Eater=litter_Eater+(value.floatValue > 0 ? 1 : 0)
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 624 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "objsVisibilty") as! NSNumber
                feed_Passage=feed_Passage+(value.floatValue > 0 ? 1 : 0)
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 633 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "obsPoint") as! NSNumber
                proventriculitis=proventriculitis+(value.floatValue > 0 ? 1 : 0)
                proventriculitis_Mean = proventriculitis_Mean + value.floatValue
                if value.floatValue > 0 {
                    proventriculitis_Updated += 1
                }
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 632 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "objsVisibilty") as! NSNumber
                roundworms=roundworms+(value.floatValue > 0 ? 1 : 0)
            }
            if (aArray.object(at: j) as AnyObject).value(forKey: "refId") as! NSNumber == 623 {
                let value = (aArray.object(at: j) as AnyObject).value(forKey: "objsVisibilty") as! NSNumber
                tapeworms=tapeworms+(value.floatValue > 0 ? 1 : 0)
            }
        }
        Foot_Pad_Lesions = (Foot_Pad_Lesions/birdsCount)*100
        preparedArray.add(Foot_Pad_Lesions)
    //1
        Ammonia_Burns = (Ammonia_Burns/birdsCount)*100
        preparedArray.add(Ammonia_Burns)
    //2
        mouth_Lesions = (mouth_Lesions/birdsCount)*100
        preparedArray.add(mouth_Lesions)
     //3
        tracheitis = (tracheitis/birdsCount)*100
        preparedArray.add(tracheitis)
     //4
        Femoral_Head_Necrosis = (Femoral_Head_Necrosis/birdsCount)*100
        preparedArray.add(Femoral_Head_Necrosis)
      //5
        Tibial_Dyschondroplasia = (Tibial_Dyschondroplasia/birdsCount)*100
        preparedArray.add(Tibial_Dyschondroplasia)
      //6
        Rickets = (Rickets/birdsCount)*100
        preparedArray.add(Rickets)
       //7
        Bone_Strength = (Bone_Strength/birdsCount)*100
        preparedArray.add(Bone_Strength)
        //8
        Synovitis = (Synovitis/birdsCount)*100
        preparedArray.add(Synovitis)
        //9
        Bursa_Size = (Bursa_Size/birdsCount)*100
        preparedArray.add(Bursa_Size)
        //10
        IP = (IP/birdsCount)*100
        preparedArray.add(IP)
        //11
        air_Sac = (air_Sac/birdsCount)*100
        preparedArray.add(air_Sac)
        //12
        retained_Yolk = (retained_Yolk/birdsCount)*100
        preparedArray.add(retained_Yolk)
        //13
        litter_Eater = (litter_Eater/birdsCount)*100
        preparedArray.add(litter_Eater)
        //14
        gizzard_Erosions = (gizzard_Erosions/birdsCount)*100
        preparedArray.add(gizzard_Erosions)
        //15
        proventriculitis = (proventriculitis/birdsCount)*100
        preparedArray.add(proventriculitis)
        //16
        tapeworms = (tapeworms/birdsCount)*100
        preparedArray.add(tapeworms)
        //17
        roundworms = (roundworms/birdsCount)*100
        preparedArray.add(roundworms)
        //18
        wallThikness = (wallThikness/birdsCount)*100
        preparedArray.add(wallThikness)
        //19
        enterties = (enterties/birdsCount)*100
        preparedArray.add(enterties)
        //20
        Intestinal_Content = (Intestinal_Content/birdsCount)*100
        preparedArray.add(Intestinal_Content)
        //21
        Thin_Intestine = (Thin_Intestine/birdsCount)*100
        preparedArray.add(Thin_Intestine)
        //22
        Muscular_Hemorrhages = (Muscular_Hemorrhages/birdsCount)*100
        preparedArray.add(Muscular_Hemorrhages)
        //23
        Bursa_Lesion_Score = (Bursa_Lesion_Score/birdsCount)*100
        preparedArray.add(Bursa_Lesion_Score)
        //24
        feed_Passage = (feed_Passage/birdsCount)*100
        preparedArray.add(feed_Passage)
        //25
        preparedArrayForMean.add((Foot_Pad_Lesions_Mean/Foot_Pad_Lesions_Updated).isNaN ? 0 : Foot_Pad_Lesions_Mean/Foot_Pad_Lesions_Updated)
        preparedArrayForMean.add((Tracheitis_Mean/Tracheitis_Updated).isNaN ? 0 : Tracheitis_Mean/Tracheitis_Updated)
        preparedArrayForMean.add((Tibial_Dyschondroplasia_Mean/Tibial_Dyschondroplasia_Updated).isNaN ? 0 : Tibial_Dyschondroplasia_Mean/Tibial_Dyschondroplasia_Updated)
        preparedArrayForMean.add((Bone_Strength_Mean/Bone_Strength_Updated).isNaN ? 0 : Bone_Strength_Mean/Bone_Strength_Updated)
        preparedArrayForMean.add((air_Sac_Mean/air_Sac_Updated).isNaN ? 0 : air_Sac_Mean/air_Sac_Updated)
        preparedArrayForMean.add((gizzard_Erosions_Mean/gizzard_Erosions_Updated).isNaN ? 0 : gizzard_Erosions_Mean/gizzard_Erosions_Updated)
        preparedArrayForMean.add((proventriculitis_Mean/proventriculitis_Updated).isNaN ? 0 : proventriculitis_Mean/proventriculitis_Updated)
        preparedArrayForMean.add((enterties_Mean/enterties_Updated).isNaN ? 0 : enterties_Mean/enterties_Updated)
        preparedArrayForMean.add((Bursa_Lesion_Score_Mean/Bursa_Lesion_Score_Updated).isNaN ? 0 : Bursa_Lesion_Score_Mean/Bursa_Lesion_Score_Updated)

        AllValidSessions.sharedInstance.meanValues.add(preparedArrayForMean)

        delegate?.didFinishParsingWithAllSummaryData!(preparedArray)
    }
}
