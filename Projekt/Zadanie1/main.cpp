#include <iostream>
#include <thread>
#include <chrono>
#include <mutex>
#include <random>
#include <ncurses.h>


// Constants to configure the simulation
const int NUM_PHILOSOPHERS = 5; // Number of philosophers
const int MAX_EATING_TIME = 3;  // Maximum time in seconds that a philosopher can eat
const int MAX_THINKING_TIME = 5;    // Maximum time in seconds that a philosopher can think
const int SAMPLE_TIME = 10;     // Time in seconds between each sample of the statistics

// Set up the chopsticks and output mutex
std::mutex chopsticks[NUM_PHILOSOPHERS];
std::mutex outputMutex;

// Arrays to keep track of how long each philosopher has been eating and thinking in seconds
int eatingDuration[NUM_PHILOSOPHERS] = {0};
int thinkingDuration[NUM_PHILOSOPHERS] = {0};

// Array with philosopher names to humanize the output :)
std::string philosopherNames[NUM_PHILOSOPHERS] = {"Aristotle",
                                                  "Plato",
                                                  "Socrates",
                                                  "Descartes",
                                                  "Kant"};


// Custom print function to ensure that only one thread can print at a time
void print(const std::string &message, int line) {
    std::lock_guard<std::mutex> lock(outputMutex);
    move(line, 0);
    clrtoeol();
    printw("%s", message.c_str());
    refresh();
}


// Function to print the statistics of the simulation, updated as the simulation progresses
void printStatistics() {
    int startLine = NUM_PHILOSOPHERS + 1;
    print("Philosopher statistics:", startLine);
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        std::string stats = philosopherNames[i] + " ate for " +
                            std::to_string(eatingDuration[i]) + " seconds and thought for " +
                            std::to_string(thinkingDuration[i]) + " seconds.";
        print(stats, startLine + i + 1);
    }
}


// Function that represents a philosopher's behavior in the problem
void philosopher(int id, bool &stop) {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<int> eatingTimeDist(1, MAX_EATING_TIME);
    std::uniform_int_distribution<int> thinkingTimeDist(1, MAX_THINKING_TIME);

    // Simulation loop
    while (!stop) {
        // Think
        print(philosopherNames[id] + " is thinking", id);
        std::this_thread::sleep_for(std::chrono::seconds(thinkingTimeDist(gen)));
        thinkingDuration[id]++;

        // Pick up chopsticks
        chopsticks[id].lock();
        print(philosopherNames[id] + " picked up chopstick " + std::to_string(id), id);
        chopsticks[(id + 1) % NUM_PHILOSOPHERS].lock();
        print(philosopherNames[id] + " picked up chopstick " + std::to_string((id + 1) % NUM_PHILOSOPHERS), id);

        // Eat
        print(philosopherNames[id] + " is eating", id);
        std::this_thread::sleep_for(std::chrono::seconds(eatingTimeDist(gen)));
        eatingDuration[id]++;

        // Put down chopsticks
        chopsticks[id].unlock();
        chopsticks[(id + 1) % NUM_PHILOSOPHERS].unlock();
    }
}


// Program entry point
int main() {
    // ncurses setup
    initscr();
    cbreak();
    noecho();

    bool stop = false;

    // Create threads for each philosopher
    std::thread philosophers[NUM_PHILOSOPHERS];
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        philosophers[i] = std::thread(philosopher, i, std::ref(stop));
    }

    // Wait for the simulation to run for a set amount of time
    int sampleCount = SAMPLE_TIME;
    while (sampleCount > 0) {
        std::this_thread::sleep_for(std::chrono::seconds(1));
        sampleCount--;
    }

    // Stop the simulation
    stop = true;

    // Kill all threads
    for (int i = 0; i < NUM_PHILOSOPHERS; i++) {
        philosophers[i].detach();
    }

    // Print the final statistics
    printStatistics();

    // Print exit messages
    print("Sample time [" + std::to_string(SAMPLE_TIME) + "] seconds have passed.", 2 * NUM_PHILOSOPHERS + 3);
    print("Simulation complete! Press any key to exit...", 2 * NUM_PHILOSOPHERS + 4);
    std::cin.get();

    // ncurses cleanup
    endwin();

    return 0;
}
