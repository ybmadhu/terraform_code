//package oracle.test;




class MyHashMap {
    private static final int INITIAL_CAPACITY = 16;
    private static final double LOAD_FACTOR = 0.75;

    private int size;
    private int capacity;
    private Entry[] buckets;

    private static class Entry {
        int key;
        int value;
        Entry next;

        Entry(int key, int value) {
            this.key = key;
            this.value = value;
        }
    }

    public MyHashMap() {
        capacity = INITIAL_CAPACITY;
        size = 0;
        buckets = new Entry[capacity];
    }

    private int hash(int key) {
        return key % capacity;
    }

    public void put(int key, int value) {
        int index = hash(key);
        Entry entry = new Entry(key, value);

        if (buckets[index] == null) {
            buckets[index] = entry;
            size++;
        } else {
            Entry current = buckets[index];
            while (current != null) {
                if (current.key == key) {
                    current.value = value;
                    return;
                }
                current = current.next;
            }
            entry.next = buckets[index];
            buckets[index] = entry;
            size++;
        }

        if ((double) size / capacity >= LOAD_FACTOR) {
            rehash();
        }
    }

    public int get(int key) {
        int index = hash(key);
        Entry current = buckets[index];

        while (current != null) {
            if (current.key == key) {
                return current.value;
            }
            current = current.next;
        }

        return -1; // Key not found
    }

    public void remove(int key) {
        int index = hash(key);
        Entry prev = null;
        Entry current = buckets[index];

        while (current != null) {
            if (current.key == key) {
                if (prev == null) {
                    buckets[index] = current.next;
                } else {
                    prev.next = current.next;
                }
                size--;
                return;
            }
            prev = current;
            current = current.next;
        }
    }

    private void rehash() {
        capacity *= 2;
        Entry[] newBuckets = new Entry[capacity];

        for (Entry entry : buckets) {
            while (entry != null) {
                Entry next = entry.next;
                int newIndex = hash(entry.key);
                entry.next = newBuckets[newIndex];
                newBuckets[newIndex] = entry;
                entry = next;
            }
        }

        buckets = newBuckets;
    }



    public static void main(String[] args) {
        MyHashMap hashMap = new MyHashMap();

        hashMap.put(1, 100);
        hashMap.put(2, 200);
        hashMap.put(3, 300);

        System.out.println("Value at key 1: " + hashMap.get(1)); // Output: 100
        System.out.println("Value at key 2: " + hashMap.get(2)); // Output: 200
        System.out.println("Value at key 3: " + hashMap.get(3)); // Output: 300

        hashMap.remove(2);
        System.out.println("Value at key 2 after removal: " + hashMap.get(2)); // Output: -1 (not found)
    }
}
