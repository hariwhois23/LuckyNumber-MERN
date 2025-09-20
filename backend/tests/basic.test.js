// This tests that Jest is working correctly
describe('Basic Tests', () => {
    test('Should pass basic math test', () => {
        expect(1 + 1).toBe(2);
    });

    test('Should test string equality', () => {
        expect('hello').toBe('hello');
    });

    test('Should test array contents', () => {
        const fruits = ['apple', 'banana'];
        expect(fruits).toContain('apple');
        expect(fruits).toHaveLength(2);
    });
});