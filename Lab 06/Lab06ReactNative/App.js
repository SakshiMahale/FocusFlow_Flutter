import React, { useState } from 'react';
import {
  View,
  Text,
  Pressable,
  StyleSheet
} from 'react-native';

export default function App() {
  const [count, setCount] = useState(0);

  const increaseCount = () => {
    setCount(count + 1);
  };

  return (
    <View style={styles.container}>

      <Text style={styles.title}>
        React Native Application
      </Text>

      <Text style={styles.subtitle}>
        Welcome to Cross-Platform App Development
      </Text>

      <Text style={styles.count}>
        Count: {count}
      </Text>

      <Pressable
        style={styles.button}
        onPress={increaseCount}
      >
        <Text style={styles.buttonText}>
          Increase Count
        </Text>
      </Pressable>

    </View>
  );
}

const styles = StyleSheet.create({

  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },

  title: {
    fontSize: 26,
    fontWeight: 'bold',
    marginBottom: 15,
  },

  subtitle: {
    fontSize: 16,
    textAlign: 'center',
    marginBottom: 30,
  },

  count: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 25,
  },

  button: {
    paddingVertical: 12,
    paddingHorizontal: 25,
    borderRadius: 8,
    backgroundColor: '#2196F3',
  },

  buttonText: {
    color: 'white',
    fontSize: 17,
    fontWeight: 'bold',
  },

});