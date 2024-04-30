//package oracle.test;

/**
 * Provides sufficient test coverage for oracle.test.BlockingQueue class.
 */
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class BlockingQueueTest {

    @Test
    void testEnqueueDequeue() throws InterruptedException {
        BlockingQueue<Integer> blockingQueue = new BlockingQueue<>(5);

        // Test enqueue and dequeue with multiple elements
        for (int i = 1; i <= 5; i++) {
            blockingQueue.enqueue(i);
        }

        Assertions.assertEquals(5, blockingQueue.size());

        for (int i = 1; i <= 5; i++) {
            int item = blockingQueue.dequeue();
            Assertions.assertEquals(i, item);
        }

        Assertions.assertEquals(0, blockingQueue.size());

        // Test enqueue and dequeue with multiple threads
        Thread producerThread = new Thread(() -> {
            try {
                for (int i = 1; i <= 10; i++) {
                    blockingQueue.enqueue(i);
                    Thread.sleep(100);
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });

        Thread consumerThread = new Thread(() -> {
            try {
                for (int i = 1; i <= 10; i++) {
                    int item = blockingQueue.dequeue();
                    Assertions.assertEquals(i, item);
                    Thread.sleep(200);
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });

        producerThread.start();
        consumerThread.start();

        producerThread.join();
        consumerThread.join();

        Assertions.assertEquals(0, blockingQueue.size());
    }

    @Test
    void testBlocking() throws InterruptedException {
        BlockingQueue<Integer> blockingQueue = new BlockingQueue<>(3);

        // Try to dequeue when the queue is empty
        Thread consumerThread = new Thread(() -> {
            try {
                int item = blockingQueue.dequeue();
                Assertions.fail("Should not reach this line.");
            } catch (InterruptedException e) {
                // This exception is expected since the queue is empty and dequeue is blocked.
            }
        });

        consumerThread.start();
        Thread.sleep(500); // Allow some time for the consumer thread to start and block.

        Assertions.assertEquals(0, blockingQueue.size());

        // Enqueue three elements to fill the queue.
        blockingQueue.enqueue(1);
        blockingQueue.enqueue(2);
        blockingQueue.enqueue(3);

        Assertions.assertEquals(3, blockingQueue.size());

        // Try to enqueue when the queue is full
        Thread producerThread = new Thread(() -> {
            try {
                blockingQueue.enqueue(4);
                Assertions.fail("Should not reach this line.");
            } catch (InterruptedException e) {
                // This exception is expected since the queue is full and enqueue is blocked.
            }
        });

        producerThread.start();
        Thread.sleep(500); // Allow some time for the producer thread to start and block.

        Assertions.assertEquals(3, blockingQueue.size());

        // Dequeue three elements to empty the queue.
        blockingQueue.dequeue();
        blockingQueue.dequeue();
        blockingQueue.dequeue();

        Assertions.assertEquals(0, blockingQueue.size());

        // After dequeuing, the producer thread should be able to enqueue without blocking.
        producerThread.join();
        Assertions.assertEquals(1, blockingQueue.size());
    }
}
