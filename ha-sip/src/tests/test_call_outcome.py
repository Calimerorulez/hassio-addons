import unittest

from call_outcome import classify_call_outcome


class CallOutcomeTest(unittest.TestCase):
    def test_established_call_is_completed(self):
        self.assertEqual(classify_call_outcome(True, 200), 'completed')

    def test_busy_codes(self):
        self.assertEqual(classify_call_outcome(False, 486), 'busy')
        self.assertEqual(classify_call_outcome(False, 600), 'busy')

    def test_rejected_codes(self):
        self.assertEqual(classify_call_outcome(False, 403), 'rejected')
        self.assertEqual(classify_call_outcome(False, 603), 'rejected')

    def test_no_answer_codes(self):
        self.assertEqual(classify_call_outcome(False, 408), 'no_answer')
        self.assertEqual(classify_call_outcome(False, 480), 'no_answer')
        self.assertEqual(classify_call_outcome(False, 487), 'no_answer')

    def test_other_code_is_failed(self):
        self.assertEqual(classify_call_outcome(False, 500), 'failed')


if __name__ == '__main__':
    unittest.main()
