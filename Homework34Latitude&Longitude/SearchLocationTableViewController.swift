//
//  SearchLocationTableViewController.swift
//  Homework34Latitude&Longitude
//
//  Created by 黃柏嘉 on 2021/12/7.
//

import UIKit
import MapKit
enum ConvertMode:Int{
    case DD
    case DMM
    case DMS
}

class SearchLocationTableViewController: UITableViewController {
    //map
    @IBOutlet weak var mapView: MKMapView!
    //annotation
    @IBOutlet weak var annotationTextField: UITextField!
    
    //經緯度
    @IBOutlet weak var DDLatitudeTextField: UITextField!
    @IBOutlet weak var DDLongitudeTextField: UITextField!
    
    //經緯度分
    @IBOutlet weak var DMMLatitudeTextField: UITextField!
    @IBOutlet weak var MMLatitudeTextField: UITextField!
    @IBOutlet weak var DMMLongitudeTextField: UITextField!
    @IBOutlet weak var MMLongitudeTextField: UITextField!
    
    //經緯度分秒
    @IBOutlet weak var DMSLatitudeTextField: UITextField!
    @IBOutlet weak var MLatitudeTextField: UITextField!
    @IBOutlet weak var SLatitudeTextField: UITextField!
    @IBOutlet weak var DMSLongitudeTextField: UITextField!
    @IBOutlet weak var MLongitudeTextField: UITextField!
    @IBOutlet weak var SLongitudeTextField: UITextField!
    //OutletCollection
    @IBOutlet var allTextField: [UITextField]!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //加入標記
    @IBAction func addAnnotation(_ sender: UIButton) {
        if annotationTextField.text != ""{
            let annotation = MKPointAnnotation()
            annotation.coordinate = mapView.region.center
            annotation.title = annotationTextField.text
            mapView.addAnnotation(annotation)
        }
        view.endEditing(true)
    }
    //轉換
    @IBAction func converter(_ sender: UIButton) {
        view.endEditing(true)
        let selectConverter = ConvertMode(rawValue: sender.tag)
        switch selectConverter {
        case .DD:
            print("DD")
            DDConverter()
        case .DMM:
            print("DMM")
            DMMConverter()
        case .DMS:
            print("DMS")
            DMSConverter()
        default:
            print("none")
        }
        showLocation()
    }
    //全部清空
    @IBAction func clear(_ sender: UIButton) {
        for i in allTextField{
            i.text = ""
        }
        showLocation()
    }
    
    //跳出經緯度地點
    func showLocation(){
        if let latitudeText = DDLatitudeTextField.text,let longitudeText = DDLongitudeTextField.text{
            if latitudeText != "" && longitudeText != ""{
                mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(latitudeText)!, longitude: CLLocationDegrees(longitudeText)!), latitudinalMeters: 1000, longitudinalMeters: 1000)
            }
        }
    }
    
    //度轉換器
    func DDConverter(){
        //取出輸入框文字轉換成Float
        let FloatDDLat = Float(DDLatitudeTextField.text!) ?? 0
        let FloatDDLong = Float(DDLongitudeTextField.text!) ?? 0
        
        //先轉換成整數給度分、度分秒的度顯示
        let IntDDLat = Int(FloatDDLat)
        let IntDDLong = Int(FloatDDLong)
        DMMLatitudeTextField.text = "\(IntDDLat)"
        DMMLongitudeTextField.text = "\(IntDDLong)"
        DMSLatitudeTextField.text = "\(IntDDLat)"
        DMSLongitudeTextField.text = "\(IntDDLong)"
        
        //再做計算轉換成Float給度分的分顯示
        let FloatMMLat = (FloatDDLat-Float(IntDDLat))*60
        let FloatMMLong = (FloatDDLong-Float(IntDDLong))*60
        MMLatitudeTextField.text = String(format: "%.5f", FloatMMLat)
        MMLongitudeTextField.text = String(format: "%.5f", FloatMMLong)
        
        //將分轉成整數給度分秒的分
        let IntMLat = Int(FloatMMLat)
        let IntMLong = Int(FloatMMLong)
        MLatitudeTextField.text = "\(IntMLat)"
        MLongitudeTextField.text = "\(IntMLong)"
        
        //計算度分秒的秒
        let FloatSLat = (FloatMMLat-Float(IntMLat))*60
        let FloatSLong = (FloatMMLong-Float(IntMLong))*60
        SLatitudeTextField.text = String(format: "%.5f", FloatSLat)
        SLongitudeTextField.text = String(format: "%.5f", FloatSLong)
    }
    
    //度分轉換器
    func DMMConverter(){
        //取出所有輸入框的文字轉成Float
        let FloatDMMLat = Float(DMMLatitudeTextField.text!) ?? 0
        let FloatMMLat = Float(MMLatitudeTextField.text!) ?? 0
        let FloatDMMLong = Float(DMMLongitudeTextField.text!) ?? 0
        let FloatMMLong = Float(MMLongitudeTextField.text!) ?? 0
        
        //計算回度
        let DDLat = FloatDMMLat + (FloatMMLat/60)
        let DDLong = FloatDMMLong + (FloatMMLong/60)
        DDLatitudeTextField.text = String(format: "%.5f", DDLat)
        DDLongitudeTextField.text = String(format: "%.5f", DDLong)
        
        //在將度分的分計算成度分秒的分
        let IntMLat = Int(FloatMMLat)
        let IntMLong = Int(FloatMMLong)
        MLatitudeTextField.text = "\(IntMLat)"
        MLongitudeTextField.text = "\(IntMLong)"
        
        //計算度分秒的秒
        let FloatSLat = (FloatMMLat-Float(IntMLat))*60
        let FloatSLong = (FloatMMLong-Float(IntMLong))*60
        SLatitudeTextField.text = String(format: "%.5f", FloatSLat)
        SLongitudeTextField.text = String(format: "%.5f", FloatSLong)
    }
    
    //度分秒轉換器
    func DMSConverter(){
        let FloatDMSLat = Float(DMSLatitudeTextField.text!) ?? 0
        let FloatMLat = Float(MLatitudeTextField.text!) ?? 0
        let FloatSLat = Float(SLatitudeTextField.text!) ?? 0
        let FloatDMSLong = Float(DMSLongitudeTextField.text!) ?? 0
        let FloatMLong = Float(MLongitudeTextField.text!) ?? 0
        let FloatSLong = Float(SLongitudeTextField.text!) ?? 0
        
        //度分秒轉換回度
        let FloatDDLat = FloatDMSLat + (FloatMLat/60) + (FloatSLat/3600)
        let FloatDDLong = FloatDMSLong + (FloatMLong/60) + (FloatSLong/3600)
        DDLatitudeTextField.text = String(format: "%.5f", FloatDDLat)
        DDLongitudeTextField.text = String(format: "%.5f", FloatDDLong)
        
        //度分秒的分轉換回度分的分以及度
        let FloatMMLat = FloatMLat + (FloatSLat/60)
        let FloatMMLong = FloatMLong + (FloatSLong/60)
        MMLatitudeTextField.text = String(format: "%.5f", FloatMMLat)
        MMLongitudeTextField.text = String(format: "%.5f", FloatMMLong)
        DMMLatitudeTextField.text = DMSLatitudeTextField.text
        DMMLongitudeTextField.text = DMSLongitudeTextField.text
        
    }
}
