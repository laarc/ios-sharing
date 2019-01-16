//
//  ShareViewController.swift
//  LaarcSubmitShareExtension
//
//  Created by Emily Kolar on 1/5/19.
//  Copyright © 2019 Emily Kolar. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

let LAARC_GREEN = UIColor(red: 154/255, green: 186/255, blue: 170/255, alpha: 1.0)

class ShareViewController: SLComposeServiceViewController {
    private var _url = ""
    private var _postTags = "news"
    private var _postComment = ""
    private var _postTitle = ""
    private let _appContainer = "group.com.emilykolar.LaarcSubmitShareExtension"
    private let _configName = "com.emilykolar.LaarcSubmitShareExtension.BackgroundSessionConfig"
    private let _baseUrl = "https://laarc.io"

    override func viewDidLoad() {
        super.viewDidLoad()
        getUrl()
        styleUi()
    }

    func getUrl() {
        if let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
            let itemProvider = extensionItem.attachments?.first {
            let propertyList = String(kUTTypePropertyList)
            if itemProvider.hasItemConformingToTypeIdentifier(propertyList) {
                itemProvider.loadItem(forTypeIdentifier: propertyList, options: nil) { item, error in
                    guard let dictionary = item as? NSDictionary else { return }
                    OperationQueue.main.addOperation {
                        if let results = dictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary,
                            let titleString = results["String"] as? String,
                            let urlString = results["URL"] as? String {
                            self._url = urlString
                            self._postTitle = titleString
                            print(results.debugDescription)
                        }
                    }
                }
            }
        } else {
            print("some error happened")
        }
    }

    func styleUi() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = LAARC_GREEN
    }

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    func makeSession() -> URLSession {
        let sessionConfig = URLSessionConfiguration.background(withIdentifier: self._configName)
        sessionConfig.sharedContainerIdentifier = self._appContainer
        return URLSession(configuration: sessionConfig)
    }

    func makeRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        return request
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        if let url = URL(string: "\(self._baseUrl)?url=\(self._url)") {
            let session = makeSession()
            let request = makeRequest(url: url)
            let task = session.dataTask(with: request)
            task.resume()
        }

        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        if let tagsItem = SLComposeSheetConfigurationItem(),
            let titleItem = SLComposeSheetConfigurationItem(),
            let urlItem = SLComposeSheetConfigurationItem() {
            tagsItem.title = "Tags"
            tagsItem.value = "news"
            tagsItem.tapHandler = {

            }

            titleItem.title = "Title"
            titleItem.value = self._postTitle
            titleItem.tapHandler = {
                
            }

            urlItem.title = "Url"
            urlItem.value = self._url
            urlItem.tapHandler = {
                
            }
            return [titleItem, urlItem, tagsItem]
        }
        return nil
    }

}

//extension ShareViewController: ShareSelectViewControllerDelegate {
//    func enteredTags(deck: Deck) {
//        selectedDeck = deck
//        reloadConfigurationItems()
//        popConfigurationViewController()
//    }
//}

