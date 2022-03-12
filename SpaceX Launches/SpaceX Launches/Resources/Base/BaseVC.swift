//
//  BaseVC.swift
//  SpaceX Launches
//
//  Created by Andre Dias on 12/03/22.
//


import UIKit

open class BaseVC<VM>: UIViewController {
    // MARK: - Properties

    private var logEnabled: Bool = true
    public var viewModel: VM
    
    internal let standard: UINavigationBarAppearance = {
        let app = UINavigationBarAppearance()
        app.configureWithOpaqueBackground()
        return app
    }()
    
    private var activityLoadIndicator: UIActivityIndicatorView = {
        let load = UIActivityIndicatorView()
        load.style = .medium
        load.translatesAutoresizingMaskIntoConstraints = false
        load.hidesWhenStopped = true
        load.contentMode = .scaleToFill
        return load
    }()
    
    public let backBarBtn: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        return button
    }()

    // MARK: - Init

    /// Base VC init
    /// - Parameters:
    ///   - vm: The View Model that the controller should use
    ///   - log: Variable to enable or disable view's init and deinit logs
    public init(viewModel vm: VM, logEnabled log: Bool = true) {
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)

    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View Life Cycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        self.bind(to: viewModel)
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateView()
    }

    // MARK: - Private Methods

    /// Method called in `viewDidLoad`, used to add subviews or make any UI modifications.
    open func setupView() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.clipsToBounds = false
        navigationItem.backBarButtonItem = backBarBtn
        self.setupAppearence()
    }
    /// Method called in `viewDidLoad`, used to setup the constraints, it is called after `setupView`.
    open func setupConstraints() {}
    /// Method called in `viewDidLoad` after `setupConstraints`, used to make the main bind logic of the view with the view model.
    open func bind(to vm: VM) {}
    /// Method called in `viewWillAppear`, used to make any view update modifications.
    open func updateView() {}

    // MARK: - View customization
    
    open func setupAppearence() {
        // TITLE STYLING
        standard.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        // NAV BUTTON STYLING
        let button = UIBarButtonItemAppearance(style: .plain)
        button.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        button.highlighted.titleTextAttributes = [.foregroundColor: UIColor.black]
        standard.buttonAppearance = button
        
        let done = UIBarButtonItemAppearance(style: .done)
        done.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
        standard.doneButtonAppearance = done
        
        navigationItem.standardAppearance = standard
        navigationItem.scrollEdgeAppearance = standard
        navigationItem.compactAppearance = standard// For iPhone small navigation bar in landscape.
    }
    
    open func setNavColor(_ color: UIColor?) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    open func setNavColorForPresentedVC(_ color: UIColor?) {
        standard.backgroundColor = color
        navigationItem.standardAppearance = standard
        navigationItem.scrollEdgeAppearance = standard
        navigationItem.compactAppearance = standard
    }
    
}

