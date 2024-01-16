//
//  ContentView.swift
//  SmartCode
//
//  Created by 堀野康輔 on 2023/12/31.
//

import SwiftUI

struct ContentView: View {
    let userDefaults = UserDefaults.standard
    let playSound = PlaySound()
    let playSound2 = PlaySound()
    let btn_co_w = 70.0
    let btn_co_h = 50.0
    let btn_si_w = 70.0
    let btn_si_h = 50.0
    let btn_clr = Color.blue
    let sgn_clr = Color.orange
    let pres_dur = 0.01
    @State var msg_savedMemo = "保存しました"
    @State var show_savedAlert = false
    @State var show_delAlert = false
    @State var memo_txt = ""
    @State var memo_title = ""
    @State var memo_title_pic = ""
    @State var memo_dic = ["タイトル":""]
    @State var memo_title_arr = ["タイトル"]
    @State var snd_data:Data?
    @State var chord_name:String = ""
    @State var chord_idx = 2
    @State var taped_chord:String = ""
    @State var sgn_name:String = ""
    @State var isOn_memo:Bool = false
    @State var isHid_tap:Bool = true
    let chord_ary = ["A#","B","C","C#","D","D#","E","F","F#","G","G#","A","A#","B","C","C#","D","D#","E","F","F#","G","G#","A","A#","B"]
    let capo_ary = ["+2","+1","0","-1","-2","-3","-4","-5","-6","-7","-8","-9"]
    let capo_ary_int:[Int] = [-2,-1,0,1,2,3,4,5,6,7,8,9]
    @State var slctedCapo = 0
    @GestureState var isDetectingLongPress = false
    @FocusState var isFocused:Bool
    let tapFeadback = UIImpactFeedbackGenerator(style: .heavy)
    var body: some View {
        let press = LongPressGesture(minimumDuration: 1)
                    .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                        gestureState = currentState
                    }.onChanged { _ in
                        snd_data = playSound.SetSound(code_name: chord_name, sgn_name: sgn_name)
                        playSound.PlaySound(snd_data: snd_data)
                        print("\(chord_name+sgn_name)")
                    }
        
        ZStack{
            Color.brown
                .ignoresSafeArea()
                .onTapGesture {
                    isFocused = false
                    print("aa")
            }
            VStack{
                Spacer()
                HStack{
                    VStack(alignment: .leading){
                        ZStack{
                            Rectangle()
                                .fill(Color.white)
                                .frame(width:120,height:30)
                                .cornerRadius(12)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(lineWidth: 1)
                                        .fill(Color.black)
                                }
                            HStack{
                                Text("カポ")
                                Picker(selection: $slctedCapo, label: Text(""), content: {
                                    ForEach(capo_ary_int, id:\.self) { elem in
                                        Text("\(capo_ary[elem+2])")
                                    }
                                }).onChange(of: slctedCapo) { newValue in
                                    print(newValue)
                                    chord_name=chord_ary[chord_idx+newValue]
                                    print(chord_name)
                                    // Do with selected value
                                }
                                .pickerStyle(.menu)
                                
                            }
                        }
                        HStack{
                            Picker(selection: $memo_title_pic, label: Text(""), content: {
                                ForEach(memo_title_arr, id:\.self) { elem in
                                    Text("\(elem)")
                                }
                            }).onChange(of: memo_title_pic) { newValue in
                                print(newValue)
                                memo_txt = memo_dic[newValue] ?? ""
                                memo_title = newValue
                                userDefaults.setValue(newValue, forKey: "memo_title")
                            }
                            .padding(5)
                            .frame(width:200)
                            .foregroundColor(.black)
                        }
                        .pickerStyle(.menu)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 1)
                                .fill(Color.black)
                        }
                    }
                    VStack{
                        HStack{
                            Spacer()
                            Text("F")
                                .modifier(ButtonStyle(color:btn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapChord(btn_id:7, btn_name:"F")
                                }
                            Text("G")
                                .modifier(ButtonStyle(color:btn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapChord(btn_id:9, btn_name:"G")
                                }
                            Text("A")
                                .modifier(ButtonStyle(color:btn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapChord(btn_id:11, btn_name:"A")
                                }
                            Text("B")
                                .modifier(ButtonStyle(color:btn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapChord(btn_id:13, btn_name:"B")
                                }
                            Text("C#")
                                .modifier(ButtonStyle(color:btn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapChord(btn_id:3, btn_name:"C#")
                                }
                            Text("D#")
                                .modifier(ButtonStyle(color:btn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapChord(btn_id:5, btn_name:"D#")
                                }                        }
                        HStack{
                            Spacer()
                            Text("A#")
                                .modifier(ButtonStyle(color:btn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapChord(btn_id:12, btn_name:"A#")
                                }
                            Text("C")
                                .modifier(ButtonStyle(color:btn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapChord(btn_id:2, btn_name:"C")
                                }
                            Text("D")
                                .modifier(ButtonStyle(color:btn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapChord(btn_id:4, btn_name:"D")
                                }
                            Text("E")
                                .modifier(ButtonStyle(color:btn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapChord(btn_id:6, btn_name:"E")
                                }
                            Text("F#")
                                .modifier(ButtonStyle(color:btn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapChord(btn_id:8, btn_name:"F#")
                                }
                            Text("G#")
                                .modifier(ButtonStyle(color:btn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapChord(btn_id:10, btn_name:"G#")
                                }
                            Spacer()
                                .frame(width:btn_co_w/2, height:btn_co_h)
                        }
                    }
                }
                HStack{
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 200)
                            .cornerRadius(25)
                        VStack{
                            HStack{
                                Text("タイトル")
                                TextField("",text: $memo_title)
                                    .padding(5)
                                    .cornerRadius(10.0)
                                    .focused(self.$isFocused)
                                    .overlay(alignment: .topLeading) {
                                        RoundedRectangle(cornerRadius: 20)
                                                            .stroke(lineWidth: 2)
                                                            .fill(Color.black)
                                    }
                            }
                            
                            TextEditor(text: self.$memo_txt)
                                .frame(height:100)
                                .cornerRadius(20.0)
                                .focused(self.$isFocused)
                                .overlay(alignment: .topLeading) {
                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(lineWidth: 2)
                                                        .fill(Color.black)
                                    if memo_txt.isEmpty {
                                        Text("コードメモ")
                                            .allowsHitTesting(false) // タップ判定を無効化
                                            .foregroundColor(Color(uiColor: .placeholderText))
                                            .padding(10)
                                    }
                                }
                            HStack{
                                Toggle(isOn: $isOn_memo){
                                    Text("メモ")
                                        .font(.caption)
                                }
                                .tint(.green)
                                Button("Space"){
                                    memo_txt = memo_txt+" "
                                }
                                Button("Delete"){
                                    if memo_txt.count > 0{
                                        memo_txt.removeLast(1)
                                    }
                                }
                                Button("保存"){
                                    if memo_txt == ""{
                                        msg_savedMemo = "メモの内容がありません"
                                    }else if memo_title == ""{
                                        msg_savedMemo = "タイトルがありません"
                                    }else if memo_title_arr.contains(memo_title) && memo_title != memo_title_pic{
                                        msg_savedMemo = "タイトルが重複しています"
                                    }else{
                                        memo_dic.updateValue(memo_txt, forKey: memo_title)
                                        memo_title_arr=Array(memo_dic.keys)
                                        userDefaults.set(memo_dic, forKey: "メモリスト")
                                        msg_savedMemo = "保存しました"
                                    }
                                    show_savedAlert = true
                                }
                                .alert(isPresented: $show_savedAlert){
                                    Alert(title: Text(msg_savedMemo))
                                }
                                Button("削除"){
                                    show_delAlert = true
                                }
                                .alert(isPresented:$show_delAlert) {
                                    Alert(title: Text("削除"),
                                          message: Text("現在のメモを削除します"),
                                          primaryButton: .default(Text("キャンセル")),
                                          secondaryButton: .destructive(Text("削除"),action: {
                                        print(memo_title_pic)
                                        memo_dic.removeValue(forKey: memo_title_pic)
                                        memo_title_arr = Array(memo_dic.keys)
                                        memo_title_pic = ""
                                        memo_title = memo_title_pic
                                        memo_txt = ""
                                    }))
                                }
                            }
                        }
                        .padding()
                    }
                    VStack{
                        Text("コード：\(taped_chord+sgn_name)")
                            .padding()
                            .frame(width:220,height:30, alignment:.leading)
                            .border(Color.black)
                            .background(Color.white)
                            .cornerRadius(12.0)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(lineWidth: 1)
                                    .fill(Color.black)
                            }
                        HStack{
                            Text("M")
                                .modifier(ButtonStyle(color:sgn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapSign(btn_name: "maj")
                                }
                            Text("7")
                                .modifier(ButtonStyle(color:sgn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapSign(btn_name: "7")
                                }
                            Text("M7")
                                .modifier(ButtonStyle(color:sgn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapSign(btn_name: "maj7")
                                }
                            Text("9")
                                .modifier(ButtonStyle(color:sgn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapSign(btn_name: "9")
                                }
                        }
                        HStack{
                            Text("m")
                                .modifier(ButtonStyle(color:sgn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapSign(btn_name: "m")
                                }
                            Text("m7")
                                .modifier(ButtonStyle(color:sgn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapSign(btn_name: "m7")
                                }
                            Text("mM7")
                                .modifier(ButtonStyle(color:sgn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapSign(btn_name: "mmaj7")
                                }
                            Text("m7-5")
                                .modifier(ButtonStyle(color:sgn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapSign(btn_name: "m7-5")
                                }
                        }
                        HStack{
                            Text("sus4")
                                .modifier(ButtonStyle(color:sgn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapSign(btn_name: "sus4")
                                }
                            Text("add9")
                                .modifier(ButtonStyle(color:sgn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapSign(btn_name: "add9")
                                }
                            Text("dim")
                                .modifier(ButtonStyle(color:sgn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapSign(btn_name: "dim")
                                }
                            Text("aug")
                                .modifier(ButtonStyle(color:sgn_clr))
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    TapSign(btn_name: "aug")
                                }
                        }
                    }
                    Spacer()
                        .frame(width:10)
                    ZStack{
                        Text("Tap")
                            .foregroundColor(Color.white)
                            .frame(width:70, height:180)
                            .background(Color.green)
                            .cornerRadius(15)
                            .onLongPressGesture(minimumDuration: pres_dur){
                                snd_data =
                                    playSound2.SetSound(code_name: chord_name, sgn_name: sgn_name)
                                playSound2.PlaySound(snd_data: snd_data)
                                isHid_tap = true
                                print("\(chord_name+sgn_name)")
                            }
                        if isHid_tap{
                            Text("Tap")
                                .foregroundColor(Color.white)
                                .frame(width:70, height:180)
                                .background(Color.green)
                                .cornerRadius(15)
                                .onLongPressGesture(minimumDuration: pres_dur){
                                    snd_data = playSound.SetSound(code_name: chord_name, sgn_name: sgn_name)
                                    playSound.PlaySound(snd_data: snd_data)
                                    isHid_tap = false
                                    print("\(chord_name+sgn_name)")
                                }
                        }
                    }
                }
                Spacer()
            }
        }.onAppear(){
            memo_dic = userDefaults.object(forKey: "メモリスト") as? Dictionary ?? memo_dic
            memo_title_arr = Array(memo_dic.keys)
            memo_title_pic = userDefaults.string(forKey: "memo_title") ?? ""
            memo_title = memo_title_pic
        }
    }
    func TapChord(btn_id:Int,btn_name:String){
        if isOn_memo{
            memo_txt = memo_txt + btn_name
        }else{
            chord_idx=btn_id+slctedCapo
            taped_chord=chord_ary[btn_id]
            chord_name=chord_ary[chord_idx]
            tapFeadback.impactOccurred()
        }
    }
    func TapSign(btn_name:String){
        if isOn_memo{
            memo_txt = memo_txt + btn_name
        }else{
            sgn_name=btn_name
            tapFeadback.impactOccurred()
        }
    }
}


struct ButtonStyle: ViewModifier {
    let color: Color
    let btn_w = 70.0
    let btn_h = 50.0
    func body(content: Content) -> some View {
        content
            .frame(width:btn_w, height:btn_h)
            .foregroundColor(Color.white)
            .background(color)
            .cornerRadius(15)
    }
}

#Preview {
    ContentView()
}
