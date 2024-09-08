import UIKit
import SnapKit

class MainViewCell: UITableViewCell {
    
    static let Identifier = "CustomCell"
    
    private var isModeSwitched: Bool = false
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String, type: MiniAppType, mode: Bool) {
        titleLabel.text = title
        
        switch type {
        case .weather:
            backgroundImageView.image = .weather
        case .crossword:
            backgroundImageView.image = .сrossword
        }
        
        if mode != isModeSwitched {
            isModeSwitched = mode
            updateConstraints(animated: true)
        }
    }
}

//MARK: - private methods
private extension MainViewCell {
    func setupUI() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(titleLabel)
        
        backgroundImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(titleLabel.snp.leading).inset(-16)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
    }
    
    func updateConstraints(animated: Bool) {
        backgroundImageView.snp.removeConstraints()
        titleLabel.snp.removeConstraints()
        
        if isModeSwitched {
            backgroundImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().inset(16)
            }
        } else {
            backgroundImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().inset(16)
                make.trailing.equalTo(titleLabel.snp.leading).inset(-16)
                make.width.equalTo(80)
                make.height.equalTo(80)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(20)
                make.centerY.equalToSuperview()
            }
        }
    }
}
