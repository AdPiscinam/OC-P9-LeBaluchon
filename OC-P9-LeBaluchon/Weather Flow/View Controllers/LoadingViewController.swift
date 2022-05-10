//
//  LoadingViewController.swift
//  OC-P9-LeBaluchon
//
//  Created by Walim Aloui on 09/05/2022.
//

import UIKit

class LoadingViewController: UIViewController {
	weak var coordinator: WeatherCoordinator?
	
	var loadingActivityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.style = .large
		indicator.color = .white
		indicator.startAnimating()
		indicator.autoresizingMask = [
			.flexibleLeftMargin, .flexibleRightMargin,
			.flexibleTopMargin, .flexibleBottomMargin
		]
		return indicator
	}()
	
	let loadingLabel: UILabel = {
		let label = UILabel()
		label.text = "Loading..."
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	var blurEffectView: UIVisualEffectView = {
		let blurEffect = UIBlurEffect(style: .dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.alpha = 0.8
		blurEffectView.autoresizingMask = [
			.flexibleWidth, .flexibleHeight
		]
		return blurEffectView
	}()
	
	override func viewDidLoad() {
		view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
		blurEffectView.frame = self.view.bounds
		view.insertSubview(blurEffectView, at: 0)
		loadingActivityIndicator.center = CGPoint(
			x: view.bounds.midX,
			y: view.bounds.midY
		)
		view.addSubview(loadingActivityIndicator)
		view.addSubview(loadingLabel)
		
		loadingLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
		loadingLabel.topAnchor.constraint(equalTo: loadingActivityIndicator.bottomAnchor, constant: 25).isActive = true
	}
}
