//
//  SettingsViewController.swift
//  IBI Assignment
//
//  Created by Pierre Janineh on 15/07/2024.
//

import UIKit

class SettingsViewController: UITableViewController {
    private static let title: LocalizedStringResource = "settings"
    
    private let viewModel: SettingsViewModel = .init()
    
    private var languagePicker: UIPickerView?
    private var schemePicker: UIPickerView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        tabBarItem.title = Self.title.localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.allowsSelection = false
        
        parent?.title = Self.title.localized
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        languagePicker?.selectRow(viewModel.selectedLanguage.rawValue, inComponent: 0, animated: true)
        schemePicker?.selectRow(viewModel.selectedScheme.rawValue, inComponent: 0, animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let string = viewModel.items[safe: section]?.title
        else { return "" }
        
        return string.localized
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items[section].settings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.section].settings[indexPath.row]
        let cell: ConfigurableCell?
        switch item.kind {
        case .logout(_):
            cell = tableView.dequeueReusableCell(withIdentifier: SettingsButtonTableViewCell.identifier,
                                                 for: indexPath) as? SettingsButtonTableViewCell
        case .coloScheme(_),
                .language(_):
            if let pickerCell = tableView
                .dequeueReusableCell(withIdentifier: SettingsPickerTableViewCell.identifier,
                                     for: indexPath) as? SettingsPickerTableViewCell {
                assignPickerValue(item.kind, picker: pickerCell.pickerView)
                cell = pickerCell
            } else {
                cell = nil
            }
        }
        cell?.configure(kind: item.kind)
        
        guard let cell else { return UITableViewCell() }
        return cell
    }
    
    private func assignPickerValue(_ kind: SettingKind, picker: UIPickerView) {
        switch kind {
        case .language(let onSelect):
            languagePicker = picker
        case .coloScheme(let onSelect):
            schemePicker = picker
        default: break
        }
    }
}
