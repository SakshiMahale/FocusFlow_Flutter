import React, { useState } from 'react';
import {
  SafeAreaView,
  View,
  Text,
  TextInput,
  TouchableOpacity,
  FlatList,
  StyleSheet,
  Alert,
} from 'react-native';

// --------------------------------------------------
// SummaryCard Widget
// --------------------------------------------------
const SummaryCard = ({ balance, income, expense }) => {
  return (
    <View style={styles.summaryCard}>
      <Text style={styles.summaryTitle}>Expense Manager</Text>

      <Text style={styles.balanceLabel}>Current Balance</Text>
      <Text
        style={[
          styles.balanceAmount,
          { color: balance >= 0 ? '#2E7D32' : '#C62828' },
        ]}
      >
        ₹{balance.toFixed(2)}
      </Text>

      <View style={styles.summaryRow}>
        <View style={styles.summaryBox}>
          <Text style={styles.incomeLabel}>Income</Text>
          <Text style={styles.incomeAmount}>
            ₹{income.toFixed(2)}
          </Text>
        </View>

        <View style={styles.summaryBox}>
          <Text style={styles.expenseLabel}>Expense</Text>
          <Text style={styles.expenseAmount}>
            ₹{expense.toFixed(2)}
          </Text>
        </View>
      </View>
    </View>
  );
};

// --------------------------------------------------
// CategoryChip Widget
// --------------------------------------------------
const CategoryChip = ({ category, selected, onPress }) => {
  return (
    <TouchableOpacity
      style={[
        styles.categoryChip,
        selected && styles.selectedCategoryChip,
      ]}
      onPress={onPress}
    >
      <Text
        style={[
          styles.categoryText,
          selected && styles.selectedCategoryText,
        ]}
      >
        {category}
      </Text>
    </TouchableOpacity>
  );
};

// --------------------------------------------------
// AddForm Widget
// --------------------------------------------------
const AddForm = ({ addTransaction }) => {
  const [title, setTitle] = useState('');
  const [amount, setAmount] = useState('');
  const [type, setType] = useState('Expense');
  const [category, setCategory] = useState('Food');

  const categories = [
    'Food',
    'Travel',
    'Shopping',
    'Bills',
    'Salary',
    'Other',
  ];

  const handleSubmit = () => {
    const numericAmount = parseFloat(amount);

    if (
      title.trim() === '' ||
      amount.trim() === '' ||
      isNaN(numericAmount) ||
      numericAmount <= 0
    ) {
      Alert.alert('Invalid input', 'Please enter a valid title and positive amount.');
      return;
    }

    const transaction = {
      id: Date.now().toString(),
      title: title.trim(),
      amount: numericAmount,
      type,
      category,
    };

    addTransaction(transaction);

    setTitle('');
    setAmount('');
  };

  return (
    <View style={styles.formCard}>
      <Text style={styles.formTitle}>Add Transaction</Text>

      {/* Income / Expense Selection */}
      <Text style={styles.inputLabel}>Transaction Type</Text>

      <View style={styles.typeRow}>
        <TouchableOpacity
          style={[
            styles.typeButton,
            type === 'Income' && styles.incomeSelected,
          ]}
          onPress={() => setType('Income')}
        >
          <Text
            style={[
              styles.typeButtonText,
              type === 'Income' && styles.selectedButtonText,
            ]}
          >
            Income
          </Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={[
            styles.typeButton,
            type === 'Expense' && styles.expenseSelected,
          ]}
          onPress={() => setType('Expense')}
        >
          <Text
            style={[
              styles.typeButtonText,
              type === 'Expense' && styles.selectedButtonText,
            ]}
          >
            Expense
          </Text>
        </TouchableOpacity>
      </View>

      {/* Title */}
      <Text style={styles.inputLabel}>Title</Text>

      <TextInput
        style={styles.input}
        placeholder="Enter title"
        value={title}
        onChangeText={setTitle}
      />

      {/* Amount */}
      <Text style={styles.inputLabel}>Amount</Text>

      <TextInput
        style={styles.input}
        placeholder="Enter amount"
        value={amount}
        onChangeText={setAmount}
        keyboardType="numeric"
      />

      {/* Category */}
      <Text style={styles.inputLabel}>Category</Text>

      <View style={styles.categoryContainer}>
        {categories.map((item) => (
          <CategoryChip
            key={item}
            category={item}
            selected={category === item}
            onPress={() => setCategory(item)}
          />
        ))}
      </View>

      {/* Add Button */}
      <TouchableOpacity
        style={styles.addButton}
        onPress={handleSubmit}
      >
        <Text style={styles.addButtonText}>
          Add Transaction
        </Text>
      </TouchableOpacity>
    </View>
  );
};

// --------------------------------------------------
// TransactionItem Widget
// --------------------------------------------------
const TransactionItem = ({ transaction, deleteTransaction }) => {
  const isIncome = transaction.type === 'Income';

  return (
    <View style={styles.transactionItem}>
      <View style={styles.transactionInfo}>
        <Text style={styles.transactionTitle}>
          {transaction.title}
        </Text>

        <Text style={styles.transactionCategory}>
          {transaction.category}
        </Text>
      </View>

      <View style={styles.transactionRight}>
        <Text
          style={[
            styles.transactionAmount,
            {
              color: isIncome ? '#2E7D32' : '#C62828',
            },
          ]}
        >
          {isIncome ? '+' : '-'}₹{transaction.amount.toFixed(2)}
        </Text>

        <TouchableOpacity
          style={styles.deleteButton}
          onPress={() => deleteTransaction(transaction.id)}
        >
          <Text style={styles.deleteButtonText}>✕</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

// --------------------------------------------------
// App Root Widget
// --------------------------------------------------
export default function App() {
  const [transactions, setTransactions] = useState([]);

  const addTransaction = (transaction) => {
    setTransactions((previousTransactions) => [
      transaction,
      ...previousTransactions,
    ]);
  };

  const deleteTransaction = (id) => {
    setTransactions((previousTransactions) =>
      previousTransactions.filter(
        (transaction) => transaction.id !== id
      )
    );
  };

  // Calculate total income
  const income = transactions
    .filter((transaction) => transaction.type === 'Income')
    .reduce((total, transaction) => total + transaction.amount, 0);

  // Calculate total expense
  const expense = transactions
    .filter((transaction) => transaction.type === 'Expense')
    .reduce((total, transaction) => total + transaction.amount, 0);

  // Calculate balance
  const balance = income - expense;

  return (
    <SafeAreaView style={styles.safeArea}>
      <FlatList
        data={transactions}
        keyExtractor={(item) => item.id}
        renderItem={({ item }) => (
          <TransactionItem
            transaction={item}
            deleteTransaction={deleteTransaction}
          />
        )}
        ListHeaderComponent={
          <View>
            <SummaryCard
              balance={balance}
              income={income}
              expense={expense}
            />

            <AddForm
              addTransaction={addTransaction}
            />

            <Text style={styles.transactionsTitle}>
              Transactions
            </Text>
          </View>
        }
        ListEmptyComponent={
          <Text style={styles.emptyText}>
            No transactions yet.
          </Text>
        }
        contentContainerStyle={styles.listContainer}
      />
    </SafeAreaView>
  );
}

// --------------------------------------------------
// Styles
// --------------------------------------------------
const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
    backgroundColor: '#F5F5F5',
  },

  listContainer: {
    padding: 16,
    paddingBottom: 30,
  },

  summaryCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 20,
    marginBottom: 16,
    elevation: 3,
  },

  summaryTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#222222',
    marginBottom: 15,
  },

  balanceLabel: {
    fontSize: 14,
    color: '#666666',
  },

  balanceAmount: {
    fontSize: 32,
    fontWeight: 'bold',
    marginBottom: 20,
  },

  summaryRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },

  summaryBox: {
    width: '48%',
    backgroundColor: '#F7F7F7',
    borderRadius: 8,
    padding: 12,
  },

  incomeLabel: {
    color: '#2E7D32',
    fontSize: 14,
  },

  incomeAmount: {
    color: '#2E7D32',
    fontSize: 20,
    fontWeight: 'bold',
    marginTop: 4,
  },

  expenseLabel: {
    color: '#C62828',
    fontSize: 14,
  },

  expenseAmount: {
    color: '#C62828',
    fontSize: 20,
    fontWeight: 'bold',
    marginTop: 4,
  },

  formCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 20,
    marginBottom: 16,
    elevation: 3,
  },

  formTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 15,
  },

  inputLabel: {
    fontSize: 14,
    fontWeight: '600',
    color: '#444444',
    marginBottom: 6,
    marginTop: 8,
  },

  input: {
    borderWidth: 1,
    borderColor: '#CCCCCC',
    borderRadius: 8,
    paddingHorizontal: 12,
    paddingVertical: 10,
    fontSize: 16,
    backgroundColor: '#FFFFFF',
  },

  typeRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },

  typeButton: {
    width: '48%',
    paddingVertical: 12,
    borderWidth: 1,
    borderColor: '#CCCCCC',
    borderRadius: 8,
    alignItems: 'center',
  },

  incomeSelected: {
    backgroundColor: '#2E7D32',
    borderColor: '#2E7D32',
  },

  expenseSelected: {
    backgroundColor: '#C62828',
    borderColor: '#C62828',
  },

  typeButtonText: {
    fontSize: 15,
    fontWeight: '600',
    color: '#444444',
  },

  selectedButtonText: {
    color: '#FFFFFF',
  },

  categoryContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    marginTop: 4,
  },

  categoryChip: {
    paddingHorizontal: 14,
    paddingVertical: 9,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: '#BBBBBB',
    marginRight: 8,
    marginBottom: 8,
  },

  selectedCategoryChip: {
    backgroundColor: '#333333',
    borderColor: '#333333',
  },

  categoryText: {
    color: '#444444',
    fontSize: 14,
  },

  selectedCategoryText: {
    color: '#FFFFFF',
    fontWeight: 'bold',
  },

  addButton: {
    backgroundColor: '#1976D2',
    paddingVertical: 13,
    borderRadius: 8,
    alignItems: 'center',
    marginTop: 12,
  },

  addButtonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: 'bold',
  },

  transactionsTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 10,
    marginTop: 5,
  },

  transactionItem: {
    backgroundColor: '#FFFFFF',
    borderRadius: 10,
    padding: 15,
    marginBottom: 10,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    elevation: 2,
  },

  transactionInfo: {
    flex: 1,
  },

  transactionTitle: {
    fontSize: 17,
    fontWeight: 'bold',
    color: '#222222',
  },

  transactionCategory: {
    fontSize: 13,
    color: '#777777',
    marginTop: 4,
  },

  transactionRight: {
    alignItems: 'flex-end',
  },

  transactionAmount: {
    fontSize: 16,
    fontWeight: 'bold',
  },

  deleteButton: {
    marginTop: 6,
    width: 28,
    height: 28,
    borderRadius: 14,
    backgroundColor: '#EEEEEE',
    justifyContent: 'center',
    alignItems: 'center',
  },

  deleteButtonText: {
    color: '#C62828',
    fontSize: 15,
    fontWeight: 'bold',
  },

  emptyText: {
    textAlign: 'center',
    color: '#777777',
    fontSize: 15,
    marginTop: 10,
    marginBottom: 20,
  },
});