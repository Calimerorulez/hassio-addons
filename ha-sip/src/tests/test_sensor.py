import unittest

from sensor import SensorConfig, SensorUpdater


class SensorPrefixTest(unittest.TestCase):
    def make_updater(self, prefix: str) -> SensorUpdater:
        return SensorUpdater(None, SensorConfig(enabled=True, entity_prefix=prefix), [])  # type: ignore[arg-type]

    def test_sanitizes_invalid_characters(self):
        updater = self.make_updater("My SIP-Phone 1!")
        self.assertEqual(updater._get_sanitized_prefix(), "my_sip_phone_1")

    def test_collapses_separators(self):
        updater = self.make_updater("ha---sip___test")
        self.assertEqual(updater._get_sanitized_prefix(), "ha_sip_test")

    def test_empty_prefix_falls_back(self):
        updater = self.make_updater(" !!! ")
        self.assertEqual(updater._get_sanitized_prefix(), "ha_sip")


if __name__ == "__main__":
    unittest.main()
