//
//  ViewController.swift
//  LessonTwoUIKitApp
//
//  Created by Mikhail on 09.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var hideSwitch: UISwitch!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() { // Учтанавливаем первоначальные параметры, как мы хотим видить элементы интерфейса.
        super.viewDidLoad()
        
        setupSegmentedControl()
        setupSlider()
        setupLabel()
        setupDatePicker()
        setupSwitch()
        
    }
    
    //MARK: - setupElements
    
    private func setupLabel() {
        mainLabel.text = String(slider.value)
        mainLabel.font = mainLabel.font.withSize(35)
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 2
    }
    
    private func setupSegmentedControl() {
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: false) // Так как работаем в методе  viewDidLoad,  то пользователь не увидит анимацию. Настройка будет происходить до отображения.
    }
    
    private func setupSlider() {
        slider.value = 1
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = .cyan
        slider.maximumTrackTintColor = .gray
        slider.thumbTintColor = .cyan
    }
    
    private func setupDatePicker() {
        datePicker.locale = Locale(identifier: "ru_RU")
    }
    
    private func setupSwitch() {
        hideSwitch.onTintColor = .cyan
    }
    
    //MARK: - Elemets methods
    
    @IBAction func chooseSegment() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mainLabel.text = "The first segment is selected"
            mainLabel.textColor = .red
        case 1:
            mainLabel.text = "The second segment is selected"
            mainLabel.textColor = .yellow
        case 2:
            mainLabel.text = "The third segment is selected"
            mainLabel.textColor = .green
        default:
            break
        }
    }
    
    @IBAction func sliderAction() {
        mainLabel.text = String(slider.value)
        let sliderValue = CGFloat(slider.value)
        view.backgroundColor = view.backgroundColor?.withAlphaComponent(sliderValue)
    }
    
    @IBAction func doneButtonTapped() {
        guard let inputText = userNameTextField.text, !inputText.isEmpty else {
            showAlert(with: "Text field is empty", and: "Please, enter your name")
            return }
        
        if let _ = Double(inputText) {
            showAlert(with: "Error data format", and: "Please, enter your name")
            return
        }
        
        mainLabel.text = inputText
        userNameTextField.text = nil
    }
    
    @IBAction func chooseDate() {
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .long
        dateFormater.locale = Locale(identifier: "ru_RU")
        mainLabel.text = dateFormater.string(from: datePicker.date)
    }
    
    @IBAction func hideAllElementBySwitch() {
        stackView.isHidden.toggle()
        switchLabel.text = hideSwitch.isOn ? "Show all elements" : "Hide all elements"
    }
    
}

//MARK: - Extension

extension ViewController {
    private func showAlert(with title: String, and message: String ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.userNameTextField.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

