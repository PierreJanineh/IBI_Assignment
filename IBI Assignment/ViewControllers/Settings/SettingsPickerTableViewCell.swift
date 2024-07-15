//
//  SettingsPickerTableViewCell.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import UIKit

class SettingsPickerTableViewCell: UITableViewCell, ConfigurableCell {
    static let identifier = "pickerReuseIdentifier"
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var onSelect: ((Int) -> Void)?
    private var kind: SettingKind?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func pick(selectedScheme: ColorScheme, selectedLanguage: Language) {
        pickerView.selectRow(isScheme ? selectedScheme.rawValue : selectedLanguage.rawValue,
                             inComponent: 0,
                             animated: false)
    }
    
    func configure(kind: SettingKind) {
        self.onSelect = kind.pickerAction
        self.kind = kind
        
        pickerView.tag = kind.rawValue
        pickerView.delegate = self
        pickerView.dataSource = self
        
        titleTextView.text = kind.description
        titleTextView.textAlignment = AppManager.shared.language == .hebrew ? .right : .left
    }
}

extension SettingsPickerTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kind?
            .enumType?
            .allCases
            .count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        onSelect?(row)
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        var view = view
        if view == nil {
            view = UIView()
        }
        guard let view else { return UIView() }
        
        setupRow(view, i: row)
        return view
    }
    
    func setupRow(_ view: UIView, i: Int) {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.text = isScheme ?
        ColorScheme(rawValue: i)?.description :
        Language(rawValue: i)?.description
        
        view.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private var isScheme: Bool {
        kind?.rawValue == 2
    }
}
