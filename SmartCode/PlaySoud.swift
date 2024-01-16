//
//  PlaySoud.swift
//  SmartCode
//
//  Created by 堀野康輔 on 2024/01/01.
//

import Foundation
import SwiftUI
import AVFoundation

class PlaySound{
    var music_player:AVAudioPlayer!
    
    func SetSound(code_name:String,sgn_name:String)->Data?{
        return NSDataAsset(name:"\(code_name+sgn_name)")?.data
    }
    
    func PlaySound(snd_data:Data!){
        if var _data = snd_data{
            do{
                music_player=try AVAudioPlayer(data:_data)
                music_player.play()
            }catch{
                print("エラー発生.音を流せません")
            }
        }else{
            return
        }
        
    }
}
