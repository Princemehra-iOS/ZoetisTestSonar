//
//  VideoPlayerView.swift
//  YouTubePlayer
//
//  Created by Giles Van Gruisen on 12/21/14.
//  Copyright (c) 2014 Giles Van Gruisen. All rights reserved.
//

import UIKit

public enum YouTubePlayerState: String {
    case Unstarted = "-1"
    case Ended = "0"
    case Playing = "1"
    case Paused = "2"
    case Buffering = "3"
    case Queued = "4"
}

public enum YouTubePlayerEvents: String {
    case YouTubeIframeAPIReady = "onYouTubeIframeAPIReady"
    case Ready = "onReady"
    case StateChange = "onStateChange"
    case PlaybackQualityChange = "onPlaybackQualityChange"
}

public enum YouTubePlaybackQuality: String {
    case Small = "small"
    case Medium = "medium"
    case Large = "large"
    case HD720 = "hd720"
    case HD1080 = "hd1080"
    case HighResolution = "highres"
}

public protocol YouTubePlayerDelegate {
    
    func playerReady(_ videoPlayer: YouTubePlayerView)
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState)
    func playerQualityChanged(_ videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality)
}

// Make delegate methods optional by providing default implementations
public extension YouTubePlayerDelegate {
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {}
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {}
    func playerQualityChanged(_ videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {}
    
}

private extension URL {
    func queryStringComponents() -> [String: AnyObject] {
        
        var dict = [String: AnyObject]()
        
        // Check for query string
        if let query = self.query {
            
            // Loop through pairings (separated by &)
            for pair in query.components(separatedBy: "&") {
                
                // Pull key, val from from pair parts (separated by =) and set dict[key] = value
                let components = pair.components(separatedBy: "=")
                if (components.count > 1) {
                    dict[components[0]] = components[1] as AnyObject?
                }
            }
            
        }
        
        return dict
    }
}

public func videoIDFromYouTubeURL(_ videoURL: URL) -> String? {
    if videoURL.pathComponents.count > 1 && (videoURL.host?.hasSuffix("youtu.be"))! {
        return videoURL.pathComponents[1]
    }
    return videoURL.queryStringComponents()["v"] as? String
}

/** Embed and control YouTube videos */
open class YouTubePlayerView: UIView, UIWebViewDelegate {
    
     typealias YouTubePlayerParameters = [String: AnyObject]
    
    // var webView: UIWebView!
    
    /** The readiness of the player */
     var ready = false
    
    /** The current state of the video player */
      var playerState = YouTubePlayerState.Unstarted
    
    /** The current playback quality of the video player */
     var playbackQuality = YouTubePlaybackQuality.Small
    
    /** Used to configure the player */
     var playerVars = YouTubePlayerParameters()
    
    /** Used to respond to player events */
    var delegate: YouTubePlayerDelegate?
    
    
    // MARK: Various methods for initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildWebView(playerParameters())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildWebView(playerParameters())
    }
    
    override  open func layoutSubviews() {
        super.layoutSubviews()
        
        // Remove web view in case it's within view hierarchy, reset frame, add as subview
//        webView.removeFromSuperview()
//        webView.frame = bounds
//        addSubview(webView)
    }
    
    
    // MARK: Web view initialization
    
     func buildWebView(_ parameters: [String: AnyObject]) {
//        webView = UIWebView()
//        webView.isOpaque = false
//        webView.backgroundColor = UIColor.clear
//        webView.allowsInlineMediaPlayback = true
//        webView.mediaPlaybackRequiresUserAction = false
//        webView.delegate = self
//        webView.scrollView.isScrollEnabled = false
    }
    
    
    // MARK: Load player
    
     func loadVideoURL(_ videoURL: URL) {
        if let videoID = videoIDFromYouTubeURL(videoURL) {
            loadVideoID(videoID)
        }
    }
    
     func loadVideoID(_ videoID: String) {
        var playerParams = playerParameters()
        playerParams["videoId"] = videoID as AnyObject?
        
        loadWebViewWithParameters(playerParams)
    }
    
     func loadPlaylistID(_ playlistID: String) {
        // No videoId necessary when listType = playlist, list = [playlist Id]
        playerVars["listType"] = "playlist" as AnyObject?
        playerVars["list"] = playlistID as AnyObject?
        
        loadWebViewWithParameters(playerParameters())
    }
    
    
    // MARK: Player controls
    
     func mute() {
      //  evaluatePlayerCommand("mute()")
    }
    
     func unMute() {
      //  evaluatePlayerCommand("unMute()")
    }
    
     func play() {
     //   evaluatePlayerCommand("playVideo()")
    }
    
     func pause() {
     //   evaluatePlayerCommand("pauseVideo()")
    }
    
     func stop() {
      //  evaluatePlayerCommand("stopVideo()")
    }
    
     func clear() {
      //  evaluatePlayerCommand("clearVideo()")
    }
    
     func seekTo(_ seconds: Float, seekAhead: Bool) {
      //  evaluatePlayerCommand("seekTo(\(seconds), \(seekAhead))")
    }
    
     func getDuration() -> String? {
       // return evaluatePlayerCommand("getDuration()")
         return ""
    }
    
     func getCurrentTime() -> String? {
     //   return evaluatePlayerCommand("getCurrentTime()")
         return ""
    }
    
    // MARK: Playlist controls
    
     func previousVideo() {
      //  evaluatePlayerCommand("previousVideo()")
    }
    
     func nextVideo() {
        //evaluatePlayerCommand("nextVideo()")
    }
    
//     func evaluatePlayerCommand(_ command: String) -> String? {
//        let fullCommand = "player." + command + ";"
//        return webView.stringByEvaluatingJavaScript(from: fullCommand)
//    }
    
    
    // MARK: Player setup
    
     func loadWebViewWithParameters(_ parameters: YouTubePlayerParameters) {
        
        // Get HTML from player file in bundle
        let rawHTMLString = htmlStringWithFilePath(playerHTMLPath())!
        
        // Get JSON serialized parameters string
        let jsonParameters = serializedJSON(parameters as AnyObject)!
        
        // Replace %@ in rawHTMLString with jsonParameters string
        let htmlString = rawHTMLString.replacingOccurrences(of: "%@", with: jsonParameters)
        
        // Load HTML in web view
       // webView.loadHTMLString(htmlString, baseURL: URL(string: "about:blank"))
    }
    
     func playerHTMLPath() -> String {
        return Bundle (for: YouTubePlayerView.self).path(forResource: "YTPlayer", ofType: "html")!
        //(forClass: YouTubePlayerView.self).path(forResource: "YTPlayer", ofType: "html")!
    }
    
     func htmlStringWithFilePath(_ path: String) -> String? {
        
        do {
            
            // Get HTML string from path
            let htmlString = try NSString (contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
            
            return htmlString as String
            
        } catch _ {
            
            // Error fetching HTML
            printLog("Lookup error: no HTML file found for path")
            
            return nil
        }
    }
    
    
    // MARK: Player parameters and defaults
    
     func playerParameters() -> YouTubePlayerParameters {
        
        return [
            "height": "100%" as AnyObject,
            "width": "100%" as AnyObject,
            "events": playerCallbacks() as AnyObject,
            "playerVars": playerVars as AnyObject
        ]
    }
    
     func playerCallbacks() -> YouTubePlayerParameters {
        return [
            "onReady": "onReady" as AnyObject,
            "onStateChange": "onStateChange" as AnyObject,
            "onPlaybackQualityChange": "onPlaybackQualityChange" as AnyObject,
            "onError": "onPlayerError" as AnyObject
        ]
    }
    
     func serializedJSON(_ object: AnyObject) -> String? {
        
        do {
            // Serialize to JSON string
            
            let jsonData = try JSONSerialization.data(withJSONObject: object, options:[])
            
            // Succeeded
            
            return NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            
        } catch let jsonError {
            
            // JSON serialization failed
            print(jsonError)
            printLog("Error parsing JSON")
            
            return nil
        }
    }
    
    
    // MARK: JS Event Handling
    
     func handleJSEvent(_ eventURL: URL) {
        
        // Grab the last component of the queryString as string
        let data: String? = eventURL.queryStringComponents()["data"] as? String
        
        if let host = eventURL.host, let event = YouTubePlayerEvents(rawValue: host) {
            
            // Check event type and handle accordingly
            switch event {
            case .YouTubeIframeAPIReady:
                ready = true
                break
                
            case .Ready:
                delegate?.playerReady(self)
                
                break
                
            case .StateChange:
                if let newState = YouTubePlayerState(rawValue: data!) {
                    playerState = newState
                    delegate?.playerStateChanged(self, playerState: newState)
                }
                
                break
                
            case .PlaybackQualityChange:
                if let newQuality = YouTubePlaybackQuality(rawValue: data!) {
                    playbackQuality = newQuality
                    delegate?.playerQualityChanged(self, playbackQuality: newQuality)
                }
                
                break
            }
        }
    }
    
    
    // MARK: UIWebViewDelegate
    
     public func webView(_ webView: UIWebView,shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        let url = request.url
        
        // Check if ytplayer event and, if so, pass to handleJSEvent
        if let url = url, url.scheme == "ytplayer" { handleJSEvent(url) }
        
        return true
    }
}

private func printLog(_ strings: CustomStringConvertible...) {
    let toPrint = ["[YouTubePlayer]"] + strings
    print(toPrint, separator: " ", terminator: "\n")
}
