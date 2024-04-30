//package oracle.test;

import java.util.Queue;

/**
 * Provides waiting thread-safe access to a java.util.Queue instance.
 *
 * Requirements:
 * - Usage of API from java.util.concurrent packageis prohibited.
 * - Limit the amount of additional consumed memory to O(1).
 * - The implementation is supposed to be acceptable for usage in a highly
 * multi-thread environment.
 *
 * Useful tips a.k.a. common pitfalls:
 * - Please note that you do not need to implement java.util.Queue.
 * - Readiness to accept or provide elements is solely dependent on the
 * underlying queue. Any additional queue capacity limitations break contract
 * defined in the javadoc.
 */
import java.util.LinkedList;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

class BlockingQueue<T> {
    private Queue<T> queue;
    private int capacity;
    private ReentrantLock lock;
    private Condition notEmpty;
    private Condition notFull;

    public BlockingQueue(int capacity) {
        this.capacity = capacity;
        queue = new LinkedList<>();
        lock = new ReentrantLock();
        notEmpty = lock.newCondition();
        notFull = lock.newCondition();
    }

    public void enqueue(T item) throws InterruptedException {
        lock.lock();
        try {
            while (queue.size() == capacity) {
                notFull.await();
            }
            queue.offer(item);
            notEmpty.signal();
        } finally {
            lock.unlock();
        }
    }

    public T dequeue() throws InterruptedException {
        lock.lock();
        try {
            while (queue.isEmpty()) {
                notEmpty.await();
            }
            T item = queue.poll();
            notFull.signal();
            return item;
        } finally {
            lock.unlock();
        }
    }

    public int size() {
        lock.lock();
        try {
            return queue.size();
        } finally {
            lock.unlock();
        }
    }

    public static void main(String[] args) {
        BlockingQueue<Integer> blockingQueue = new BlockingQueue<>(5);

        Thread producerThread = new Thread(() -> {
            try {
                for (int i = 1; i <= 10; i++) {
                    blockingQueue.enqueue(i);
                    System.out.println("Producer enqueued: " + i);
                    Thread.sleep(500); // Simulate some processing time
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });

        Thread consumerThread = new Thread(() -> {
            try {
                for (int i = 1; i <= 10; i++) {
                    int item = blockingQueue.dequeue();
                    System.out.println("Consumer dequeued: " + item);
                    Thread.sleep(1000); // Simulate some processing time
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });

        producerThread.start();
        consumerThread.start();

        try {
            producerThread.join();
            consumerThread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    
}
}