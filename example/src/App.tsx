import * as React from 'react';
import { StyleSheet, View, Text, Alert, Button } from 'react-native';
import {
  reloadAllTimelines,
  // reloadTimelines,
  getItem,
  setItem,
} from 'react-native-widgetkit';

const myAppData = {
  c_name: 'Namexxxx',
  c_age: '239',
  c_email: 'guide@intern.jitta.com',
};

const totalAsset = {
  title: 'มูลค่าสินทรัพย์สุทธิ',
  currency: '฿',
  amount: '105,690',
  today: 'วันนี้',
  trend: 'up',
  trendPercentage: '0.58',
};

export default function App() {
  const appGroupIdentifier = 'group.com.guid3d';

  const setAndloadDataButton = async () => {
    try {
      reloadAllTimelines();
      // reloadTimelines('test2');
      await setItem('title', totalAsset.title, appGroupIdentifier);
      await setItem('currency', totalAsset.currency, appGroupIdentifier);
      await setItem('amount', totalAsset.amount, appGroupIdentifier);
      await setItem('today', totalAsset.today, appGroupIdentifier);
      await setItem('trend', totalAsset.trend, appGroupIdentifier);
      await setItem(
        'trendPercentage',
        totalAsset.trendPercentage,
        appGroupIdentifier
      );
      const title = await getItem('title', appGroupIdentifier);
      const currency = await getItem('currency', appGroupIdentifier);
      const amount = await getItem('amount', appGroupIdentifier);
      const today = await getItem('today', appGroupIdentifier);
      const trend = await getItem('trend', appGroupIdentifier);
      const trendPercentage = await getItem(
        'trendPercentage',
        appGroupIdentifier
      );
      Alert.alert(
        `setAndloadData ${title} ${currency} ${amount} ${today} ${trend} ${trendPercentage}`
      );

      // await SharedGroupPreferences.setItem(
      //   'myAppData',
      //   myAppData,
      //   appGroupIdentifier
      // );
      // const getData = await getItem('myAppData', appGroupIdentifier);

      // Alert.alert('checks passed: ', getData);
    } catch (error) {
      Alert.alert('error code: ' + error);
    }
  };

  return (
    <View style={styles.container}>
      <Text>{myAppData.c_name}</Text>
      <Text>{myAppData.c_age}</Text>
      <Text>{myAppData.c_email}</Text>
      <Button title={'SetAndLoadData'} onPress={setAndloadDataButton} />
      {/* <Button title={'LoadData'} onPress={loadDataButton} /> */}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
