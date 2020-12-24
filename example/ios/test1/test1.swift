  //
  //  test1.swift
  //  test1
  //
  //  Created by Guid3d on 12/21/20.
  //  Copyright © 2020 Facebook. All rights reserved.
  //
  
  import WidgetKit
  import SwiftUI
  import Intents
  
  struct Shared:Decodable {
    let title: String,
        currency: String,
        amount: String,
        today: String,
        trend: String,
        trendPercentage: String
  }
  
  struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
      SimpleEntry(date: Date(), title: "title", currency: "฿", amount: "999,999", today: "วันนี้", trend: "Trend", trendPercentage: "XX%", configuration: ConfigurationIntent() )
    }
    
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
      let entry = SimpleEntry(date: Date(), title: "snapshotTitle", currency: "฿", amount: "999,999", today: "วันนี้", trend: "Trend", trendPercentage: "XX%", configuration: ConfigurationIntent() )
      completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
      var entries: [SimpleEntry] = []
      //      var title = "title"
      //      var currency = "currency"
      //      var amount = "amount"
      //      var today = "today"
      //      var trend = "trend"
      //      var trendPercentage = "trendPercentage"
      let sharedDefaults = UserDefaults.init(suiteName: "group.com.guid3d")
      //      if sharedDefaults != nil {
      var title = sharedDefaults?.string(forKey: "title") ?? "no title"
      var currency = sharedDefaults?.string(forKey: "currency") ?? "no currency"
      var amount = sharedDefaults?.string(forKey: "amount") ?? "no amount"
      var today = sharedDefaults?.string(forKey: "today") ?? "no today"
      var trend = sharedDefaults?.string(forKey: "trend") ?? "no trend"
      var trendPercentage = sharedDefaults?.string(forKey: "trendPercentage") ?? "no trendPercentage"
      
      //      }
      print("Get Timeline!!")
      //       Generate a timeline consisting of five entries an hour apart, starting from the current date.
      let currentDate = Date()
      for hourOffset in 0 ..< 5 {
        let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
        let entry = SimpleEntry(date: Date(), title: title, currency: currency, amount: amount, today: today, trend: trend, trendPercentage: trendPercentage, configuration: ConfigurationIntent() )
        entries.append(entry)
      }
      
      let timeline = Timeline(entries: entries, policy: .atEnd)
      completion(timeline)
    }
  }
  
  
  struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let currency: String
    let amount: String
    let today: String
    let trend: String
    let trendPercentage: String
    let configuration: ConfigurationIntent
  }
  
  struct test1EntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
      ZStack{
        Color(red: 1, green: 1, blue: 1)
        VStack(alignment: .leading) {
          Spacer()
          
          Text(entry.title)
            .font(.system(size:10))
            .bold()
          
          Text("\(entry.currency)" + " \(entry.amount)")
            .font(.system(size:10))
            .bold()
          Spacer()
          
          Text("\(entry.today)" + " \(entry.trend)" + "\(entry.trendPercentage)")
            .font(.system(size:10))
          Spacer()
          
        }
        .padding(.all)
      }
      
    }
  }
  
  @main
  struct test1: Widget {
    let kind: String = "test1"
    
    var body: some WidgetConfiguration {
      IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
        test1EntryView(entry: entry)
      }
      .configurationDisplayName("My Widget")
      .description("This is an example widget.")
    }
  }
  
  struct test1_Previews: PreviewProvider {
    static var previews: some View {
      test1EntryView(entry: SimpleEntry(date: Date(), title: "title", currency: "฿", amount: "999,999", today: "วันนี้", trend: "Trend", trendPercentage: "XX%", configuration: ConfigurationIntent() ))
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
  }
