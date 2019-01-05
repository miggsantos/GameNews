//
//  Constants.swift
//  GameNews
//
//  Created by Miguel Santos on 27/10/2017.
//  Copyright © 2017 Miguel Santos. All rights reserved.
//

import Foundation

//Realm
let REALM_QUEUE = DispatchQueue(label: "realmQueue")
let REALM_RUN_CONFIG = "realmRunConfig"

// Storyboard
let MAIN_STORYBOARD = "Main"

// ViewControllers
let VC_LEFT_MENU_PANEL = "LeftSideMenuVC"
let VC_NEWS = "NewsVC"
let VC_FAVORITES = "FavoriteVC"
let VC_ABOUT = "AboutVC"

// SEGUES
let SEGUE_TO_ARTICLE_VC = "segue_ArticleVC"
let SEGUE_TO_WEB_VC = "segue_WebVC"

// TableViewCells
let CELL_LEFT_MENU = "LeftMenuCell"
let CELL_NEWS = "NewsCell"
let CELL_ARTICLE = "ArticleCell"
let CELL_NEWS_LOADING = "LoadingCellNews"
let CELL_ARTICLE_LOADING = "LoadingCellArticle"

// IGDB URLS
//let IGDB_API_GET_PULSES = "/pulses/?fields=id,title,image,pulse_source,published_at,summary&order=published_at:desc&limit=20&offset={OFFSET}"
let IGDB_API_GET_PULSES = "/pulses/?fields=id,title,image,pulse_source,published_at,summary&limit=10&&order=published_at:desc&offset={OFFSET}"

let PULSE_SOURCES = ["1":"Kotaku","2":"Polygon","3":"GameInformer","6":"Escapist","7":"PC Gamer","8":"IGN","9":"Indie Games","10":"Destructoid","11":"Niche Gamer","12":"Shoryuken","13":"Tech Raptor","14":"Siliconera","15":"Gematsu","16":"GameIndustry.biz","17":"GameSpot","18":"GamingBolt","19":"IGDB Blog","20":"Thunderbolt","21":"Gaming Nexus","22":"Softpedia","24":"Xbox Live's Major Nelson","25":"Playstation.blog","27":"Killa Penguin","28":"EuroGamer","29":"Gamezebo","30":"Critical Hit","32":"VideoGamer.com","38":"VG247","39":"PushSquare","40":"Gamepur","41":"The Koalition","42":"MonsterVine","43":"Rolling Stone","44":"SimHQ","45":"NeptuneGames","54":"Computer Gaming News"]

// Colors

let COLOR_GN_ORANGE: UIColor = UIColor(red: 255/255, green: 132/255, blue: 0/255, alpha: 1)
let COLOR_GN_DARK_GRAY: UIColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)


// Image Sizes
let IMAGE_SIZE_PULSE_NEWS = CGSize(width: 414, height: 190)
let IMAGE_SIZE_PULSE_ARTICLE = CGSize(width: 414, height: 300)

