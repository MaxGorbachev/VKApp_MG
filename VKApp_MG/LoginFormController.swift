//
//  ViewController.swift
//  VKApp_MG
//
//  Created by Максим on 10.08.2022.
//

import UIKit

class LoginFormController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBAction func logInButtonPressed(_ sender: Any) {
        guard let login = loginTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        if login == "root" && password == "12345" {
            print("Success")
        } else {
            let loginAlert = UIAlertController(title: "Введён неверный логин или пароль", message: "Проверьте введённые данные или обратитесь к техническому специалисту.", preferredStyle: .alert)
            let loginAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
            loginAlert.addAction(loginAction)
            present(loginAlert, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        recognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(recognizer)
    }

    @objc func keyboardDidShow(_ notification: Notification) {

        guard let keyboardHeight = ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue)?.height else {return}
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }

    @objc func keyboardWillHide() {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc func onTap() {
        self.view.endEditing(true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

